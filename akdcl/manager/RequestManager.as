package akdcl.manager {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.ObjectEncoding;
	//import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;

	import com.adobe.serialization.json.JSON;

	import zero.net.FormVariables;

	import akdcl.utils.objectToString;

	/**
	 * ...
	 * @author ...
	 */
	final public class RequestManager extends EventDispatcher {
		private static const ERROR:String = "RequestManager Singleton already constructed!";
		private static var instance:RequestManager;

		public static function getInstance():RequestManager {
			if (instance){
			} else {
				instance = new RequestManager();
			}
			return instance;
		}

		public function RequestManager(){
			lM = LoggerManager.getInstance();
			if (instance){
				lM.fatal(RequestManager, ERROR);
				throw new Error("[ERROR]:" + ERROR);
			}
			instance = this;
			lM.info(RequestManager, "init");

			eM = ElementManager.getInstance();
			eM.register(REQUESTLOADER, _RequestLoader);
			eM.register(REQUESTURLLOADER, _RequestURLLoader);

			sM = SourceManager.getInstance();

			request = new URLRequest();
			
			//eventProgressComplete = new ProgressEvent(ProgressEvent.PROGRESS, false, false, 1, 1);
			
			loaderDicForImage = {};
			loaderDicForSWF = {};
			urlLoaderDic = {};
		}

		public static const DATAFORMAT_XML:String = "xml";
		public static const DATAFORMAT_JSON:String = "json";
		public static const DATAFORMAT_FORM:String = "form";
		public static const DATAFORMAT_AMF3:String = "amf3";

		private static const REQUESTLOADER:String = "_RequestLoader";
		private static const REQUESTURLLOADER:String = "_RequestURLLoader";

		private static const CONTENT_TYPE_STREAM:String = "application/octet-stream";

		private var lM:LoggerManager;
		private var eM:ElementManager;
		private var sM:SourceManager;

		private var request:URLRequest;

		private var loaderDicForImage:Object;
		private var loaderDicForSWF:Object;
		private var urlLoaderDic:Object;

		private var dataFormat:String;
		//private var eventProgressComplete:ProgressEvent;

		public function loadDisplay(_url:String, _onCompleteHandler:Function = null, _onErrorHandler:Function = null, _onProgressHandler:Function = null, ... args):Loader {
			resetRequest(_url);
			_url = request.url;
			if (!_url){
				var _str:String = "RequestManager.loadDisplay(url), url is null!";
				lM.warn(RequestManager, _str);
				trace("[WARNNING]:" + _str);
			}
			lM.info(RequestManager, "loadDisplay(url:{0})", null, _url);
			//
			var _bmd:BitmapData = sM.getSource(SourceManager.BITMAPDATA_GROUP, _url);
			if (_bmd){
				if (_onProgressHandler != null){
					_onProgressHandler(1);
				}
				if (_onCompleteHandler != null){
					switch (_onCompleteHandler.length){
						case 0:
							_onCompleteHandler();
							break;
						case 1:
							_onCompleteHandler(_bmd);
							break;
						case 2:
							_onCompleteHandler(_bmd, _url);
							break;
						case 3:
							_onCompleteHandler(_bmd, _url, args);
							break;
					}
				}
				return null;
			}
			//
			var _loader:_RequestLoader = loaderDicForImage[_url];
			if (_loader){
			} else {
				_loader = eM.getElement(REQUESTLOADER);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderCompleteOrErrorHandler);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderCompleteOrErrorHandler);
				_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderCompleteOrErrorHandler);
				if (_url.indexOf(".swf") < 0) {
					loaderDicForImage[_url] = _loader;
				}else {
					//如果是swf，则队列里不能放置
					_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInitHandler);
				}
				_loader.params = args;
			}
			//
			_loader.addEvents(_onProgressHandler, _onErrorHandler, _onCompleteHandler);
			_loader.load(request);
			return _loader;
		}

		public function unloadDisplay(_url:String, _onCompleteHandler:Function = null, _onErrorHandler:Function = null, _onProgressHandler:Function = null):void {
			if (!_url){
				return;
			}
			//
			var _bmd:BitmapData = sM.getSource(SourceManager.BITMAPDATA_GROUP, _url);
			if (_bmd){
				return;
			}
			//
			var _loader:_RequestLoader = loaderDicForImage[_url];
			if (_loader){
				_loader.removeEvents(_onProgressHandler, _onErrorHandler, _onCompleteHandler);
			} else {
				return;
			}
		}

		private function onLoaderInitHandler(_evt:Event):void {
			var _loaderInfo:LoaderInfo = (_evt.currentTarget as LoaderInfo);
			var _loader:_RequestLoader = _loaderInfo.loader as _RequestLoader;
			if (_loader.params && _loader.content && ("flashVars" in _loader.content)){
				lM.info(RequestManager, "设置{0}flashVars{1}", null, _loader.content, _loader.params[0]);
				_loader.content["flashVars"] = _loader.params[0];
			}
		}

		private function onLoaderCompleteOrErrorHandler(_evt:Event):void {
			var _loaderInfo:LoaderInfo = (_evt.currentTarget as LoaderInfo);
			var _loader:_RequestLoader = _loaderInfo.loader as _RequestLoader;
			_loaderInfo.removeEventListener(Event.INIT, onLoaderInitHandler);
			_loaderInfo.removeEventListener(Event.COMPLETE, onLoaderCompleteOrErrorHandler);
			_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderCompleteOrErrorHandler);
			_loaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderCompleteOrErrorHandler);

			if (_evt is IOErrorEvent || _evt is SecurityError){
				lM.error(RequestManager, _evt.toString());
				trace("[ERROR:]" + _evt);
				_loader.onErrorHandler(_evt);
			} else {
				lM.info(RequestManager, "loadDisplayComplete:" + _loader.url);
				if (_loader.content is Bitmap){
					sM.addSource(SourceManager.BITMAPDATA_GROUP, _loader.url, (_loader.content as Bitmap).bitmapData);
				} else {
					//swf
				}
				_loader.onCompleteHandler();
			}
			delete loaderDicForImage[_loader.url];
			if (_loader.clear()){
				eM.recycle(_loader);
			}
		}

		public function load(_url:*, _onCompleteHandler:Function = null, _onErrorHandler:Function = null, _onProgressHandler:Function = null, ... args):void {
			resetRequest(_url);
			_url = request.url;
			if (!_url){
				var _str:String = "RequestManager.load(url), url is null!";
				lM.warn(RequestManager, _str);
				trace("[WARNNING]:" + _str);
				return;
			}
			lM.info(RequestManager, "load(url:{0})", null, _url);
			//
			var _loader:_RequestURLLoader = urlLoaderDic[_url];
			if (_loader){
			} else {
				_loader = eM.getElement(REQUESTURLLOADER);
				_loader.addEventListener(Event.COMPLETE, onURLLoaderCompleteOrErrorHandler);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, onURLLoaderCompleteOrErrorHandler);
				_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onURLLoaderCompleteOrErrorHandler);
				urlLoaderDic[_url] = _loader;
				_loader.dataFormat = dataFormat;
				_loader.params = args;
			}
			//
			_loader.addEvents(_onProgressHandler, _onErrorHandler, _onCompleteHandler);
			_loader.load(request);
		}

		private function onURLLoaderCompleteOrErrorHandler(_evt:Event):void {
			var _loader:_RequestURLLoader = _evt.currentTarget as _RequestURLLoader;
			_loader.removeEventListener(Event.COMPLETE, onURLLoaderCompleteOrErrorHandler);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onURLLoaderCompleteOrErrorHandler);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onURLLoaderCompleteOrErrorHandler);
			if (_evt is IOErrorEvent || _evt is SecurityError){
				lM.error(RequestManager, _evt.toString());
				trace("[ERROR:]" + _evt);
				_loader.onErrorHandler(_evt);
			} else {
				lM.info(RequestManager, "loadComplete:{0}====>>>>\n" + _loader.data, null, _loader.url);
				_loader.onCompleteHandler();
			}
			delete urlLoaderDic[_loader.url];
			_loader.clear();
			eM.recycle(_loader);
		}

		//url,data,contentType,method,sendFormat,loadFormat,charSet,random
		private function resetRequest(_url:Object):void {
			//重置request
			if (_url is String || _url is XML || _url is XMLList){
				request.url = String(_url);
				request.data = null;
				request.contentType = null;
				request.method = URLRequestMethod.GET;
				dataFormat = null;
			} else if (_url is URLRequest || _url is Object){
				request.url = _url.url;
				if (_url.data){
					_url.data.random = Math.random();
					request.contentType = _url.contentType;
					request.method = _url.method || URLRequestMethod.POST;
					switch (_url.sendFormat){
						case DATAFORMAT_FORM:
							var _formVars:FormVariables = new FormVariables(_url.data);
							if (_url.charSet){
								_formVars.charSet = _url.charSet;
							}
							request.contentType = _formVars.contentType;
							request.data = _formVars.data;
							break;
						case DATAFORMAT_JSON:
							request.data = com.adobe.serialization.json.JSON.encode(_url.data);
							break;
						case RequestManager.DATAFORMAT_AMF3:
							var _bytes:ByteArray = new ByteArray();
							_bytes.writeObject(_url.data);
							_bytes.objectEncoding = ObjectEncoding.AMF3;
							//if(_compressed) {
							//_bytes.compress();
							//}
							request.contentType = CONTENT_TYPE_STREAM;
							request.data = _bytes;
							break;
						default:
							if (_url.data.constructor === Object){
								var _urlVariables:URLVariables = new URLVariables();
								for (var _i:String in _url.data){
									_urlVariables[_i] = _url.data[_i];
								}
								request.data = _urlVariables;
							} else {
								if (_url.data is ByteArray){
									request.contentType = CONTENT_TYPE_STREAM;
								}
								request.data = _url.data;
							}
							break;
					}
				} else {
					request.url += "?random=" + Math.random();
					request.data = null;
					request.contentType = null;
					request.method = URLRequestMethod.GET;
				}

				if (_url.loadFormat){
					dataFormat = _url.loadFormat;
				} else {
					dataFormat = null;
				}
			} else {
				request.url = null;
			}
			lM.info(RequestManager, "resetRequest====>>>>\n" + objectToString(request));
		}
	}
}