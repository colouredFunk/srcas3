package akdcl.manager {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.ObjectEncoding;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;

	import com.adobe.serialization.json.JSON;

	import zero.net.FormVariables;

	/**
	 * ...
	 * @author ...
	 */
	public class RequestManager {
		private static var instance:RequestManager;

		public static function getInstance():RequestManager {
			if (instance){
			} else {
				instance = new RequestManager();
			}
			return instance;
		}

		public function RequestManager(){
			if (instance){
				throw new Error("ERROR:RequestManager Singleton already constructed!");
			}
			instance = this;
			eM = ElementManager.getInstance();
			eM.register(REQUESTLOADER, RequestLoader);
			eM.register(REQUESTURLLOADER, RequestURLLoader);
			sM = SourceManager.getInstance();

			request = new URLRequest();
			urlVariables = new URLVariables();

			loaderDic = {};
			urlLoaderDic = {};
		}

		public static const DATAFORMAT_XML:String = "xml";
		public static const DATAFORMAT_JSON:String = "json";
		public static const DATAFORMAT_FORM:String = "form";
		public static const DATAFORMAT_AMF3:String = "amf3";

		private static const REQUESTLOADER:String = "RequestLoader";
		private static const REQUESTURLLOADER:String = "RequestURLLoader";
		
		private static const CONTENT_TYPE_STREAM:String = "application/octet-stream";

		private var eM:ElementManager;
		private var sM:SourceManager;

		private var request:URLRequest;
		private var urlVariables:URLVariables;

		private var loaderDic:Object;
		private var urlLoaderDic:Object;

		private var dataFormat:String;

		public function loadDisplay(_url:String, _onCompleteHandler:Function = null, _onErrorHandler:Function = null, _onProgressHandler:Function = null, ... args):void {
			resetRequest(_url);
			_url = request.url;
			if (!_url){
				trace("WARNNING:RequestManager.loadImage(_url), _url is null!!!");
				return;
			}
			//
			var _bmd:BitmapData = sM.getSource(SourceManager.BITMAPDATA_GROUP, _url);
			if (_bmd){
				if (_onProgressHandler != null){
					_onProgressHandler(null);
				}
				if (_onCompleteHandler != null){
					switch (_onCompleteHandler.length){
						case 0:
							_onCompleteHandler();
							break;
						case 2:
							_onCompleteHandler(_bmd, _url);
							break;
						case 1:
						default:
							_onCompleteHandler(_bmd);
							break;
					}
				}
				return;
			}
			//
			var _loader:RequestLoader = loaderDic[_url];
			if (_loader){
			} else {
				_loader = eM.getElement(REQUESTLOADER);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderCompleteOrErrorHandler);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderCompleteOrErrorHandler);
				_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderCompleteOrErrorHandler);
				loaderDic[_url] = _loader;
				_loader.params = args;
			}
			//
			_loader.addEvents(_onProgressHandler, _onErrorHandler, _onCompleteHandler);
			_loader.load(request);
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
			var _loader:RequestLoader = loaderDic[_url];
			if (_loader){
				_loader.removeEvents(_onProgressHandler, _onErrorHandler, _onCompleteHandler);
			} else {
				return;
			}
		}

		private function onLoaderCompleteOrErrorHandler(_evt:Event):void {
			var _loaderInfo:LoaderInfo = (_evt.currentTarget as LoaderInfo);
			var _loader:RequestLoader = _loaderInfo.loader as RequestLoader;
			_loaderInfo.removeEventListener(Event.COMPLETE, onLoaderCompleteOrErrorHandler);
			_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderCompleteOrErrorHandler);
			_loaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderCompleteOrErrorHandler);

			if (_evt is IOErrorEvent || _evt is SecurityError){
				_loader.onErrorHandler(_evt);
			} else {
				if (_loader.content is Bitmap){
					sM.addSource(SourceManager.BITMAPDATA_GROUP, _loader.url, (_loader.content as Bitmap).bitmapData);
				} else {
					//swf
				}
				_loader.onCompleteHandler();
			}
			delete loaderDic[_loader.url];
			if (_loader.clear()){
				eM.recycle(_loader);
			}
		}

		public function load(_url:*, _onCompleteHandler:Function = null, _onErrorHandler:Function = null, _onProgressHandler:Function = null, ... args):void {
			resetRequest(_url);
			_url = request.url;
			if (!_url){
				trace("WARNNING:RequestManager.load(_url), _url is null!!!");
				return;
			}
			//
			var _loader:RequestURLLoader = urlLoaderDic[_url];
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
			var _loader:RequestURLLoader = _evt.currentTarget as RequestURLLoader;
			_loader.removeEventListener(Event.COMPLETE, onURLLoaderCompleteOrErrorHandler);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onURLLoaderCompleteOrErrorHandler);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onURLLoaderCompleteOrErrorHandler);
			if (_evt is IOErrorEvent || _evt is SecurityError){
				_loader.onErrorHandler(_evt);
			} else {
				_loader.onCompleteHandler();
			}
			delete urlLoaderDic[_loader.url];
			_loader.clear();
			eM.recycle(_loader);
		}

		//url,data,contentType,method,sendFormat,loadFormat,charSet,random
		private function resetRequest(_url:*):void {
			//重置request
			if (_url is String || _url is XML || _url is XMLList) {
				request.url = String(_url);
				request.data = null;
				request.contentType = null;
				request.method = URLRequestMethod.GET;
				dataFormat = null;
			} else if (_url is URLRequest || _url is Object){
				request.url = _url.url;
				if (_url.data){
					request.contentType = _url.contentType;
					request.method = _url.method || URLRequestMethod.POST;
					_url.data.random = Math.random();
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
		}
	}

}

import flash.display.AVM1Movie;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.system.LoaderContext;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLLoaderDataFormat;

import com.adobe.serialization.json.JSON;

import akdcl.manager.RequestManager;

class RequestLoader extends Loader {
	public var url:String;
	public var params:Array;
	
	private var errorHandlers:Dictionary;
	private var progressHandlers:Dictionary;
	private var completeHandlers:Dictionary;

	public function RequestLoader(){
		errorHandlers = new Dictionary();
		progressHandlers = new Dictionary();
		completeHandlers = new Dictionary();
	}

	override public function load(request:URLRequest, context:LoaderContext = null):void {
		url = request.url;
		super.load(request, context);
	}

	public function clear():Boolean {
		var _fun:Function;
		for each (_fun in errorHandlers){
			delete errorHandlers[_fun];
		}
		for each (_fun in progressHandlers){
			contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _fun);
			delete progressHandlers[_fun];
		}
		for each (_fun in completeHandlers){
			delete completeHandlers[_fun];
		}
		if (content is DisplayObject){
			return false;
		}
		url = null;
		params = null;
		unload();
		unloadAndStop();
		return true;
	}

	public function addEvents(_onProgressHandler:Function, _onErrorHandler:Function, _onCompleteHandler:Function):void {
		if (_onErrorHandler != null){
			errorHandlers[_onErrorHandler] = _onErrorHandler;
		}
		if (_onProgressHandler != null){
			progressHandlers[_onProgressHandler] = _onProgressHandler;
			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
		}
		if (_onCompleteHandler != null){
			completeHandlers[_onCompleteHandler] = _onCompleteHandler;
		}
	}

	public function removeEvents(_onProgressHandler:Function, _onErrorHandler:Function, _onCompleteHandler:Function):void {
		if (_onErrorHandler != null){
			delete errorHandlers[_onErrorHandler];
		}
		if (_onProgressHandler != null){
			contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
			delete progressHandlers[_onProgressHandler];
		}
		if (_onCompleteHandler != null){
			delete completeHandlers[_onCompleteHandler];
		}
	}

	public function onErrorHandler(_evt:Event):void {
		trace(_evt);
		for each (var _onError:Function in errorHandlers){
			switch (_onError.length){
				case 0:
					_onError();
					break;
				case 2:
					_onError(_evt, url);
					break;
				case 3:
					_onError(_evt, url, params);
					break;
				case 1:
				default:
					_onError(_evt);
					break;
			}
		}
	}

	public function onCompleteHandler():void {
		var _content:*;
		if (content is Bitmap){
			_content = (content as Bitmap).bitmapData;
		} else {
			_content = this;
		}
		for each (var _onComplete:Function in completeHandlers){
			switch (_onComplete.length){
				case 0:
					_onComplete();
					break;
				case 2:
					_onComplete(_content, url);
					break;
				case 3:
					_onComplete(_content, url, params);
					break;
				case 1:
				default:
					_onComplete(_content);
					break;
			}
		}
	}
}

class RequestURLLoader extends URLLoader {
	public var url:String;
	public var params:Array;
	
	private var errorHandlers:Dictionary;
	private var progressHandlers:Dictionary;
	private var completeHandlers:Dictionary;

	public function RequestURLLoader(){
		errorHandlers = new Dictionary();
		progressHandlers = new Dictionary();
		completeHandlers = new Dictionary();
	}

	override public function load(request:URLRequest):void {
		url = request.url;
		var _type:String = url.split(".").pop().toLowerCase();
		if (dataFormat){
		} else {
			switch (_type){
				case "jpg":
				case "png":
				case "gif":
				case "swf":
					dataFormat = URLLoaderDataFormat.BINARY;
					break;
				case "xml":
					dataFormat = RequestManager.DATAFORMAT_XML;
					break;
			}
		}
		super.load(request);
	}

	public function clear():void {
		var _fun:Function;
		for each (_fun in errorHandlers){
			delete errorHandlers[_fun];
		}
		for each (_fun in progressHandlers){
			removeEventListener(ProgressEvent.PROGRESS, _fun);
			delete progressHandlers[_fun];
		}
		for each (_fun in completeHandlers){
			delete completeHandlers[_fun];
		}
		url = null;
		params = null;
		data = null;
		dataFormat = null;
	}

	public function getFormatData():* {
		switch (dataFormat){
			case RequestManager.DATAFORMAT_XML:
				try {
					return XML(data);
				} catch (_e:*){
				}
				return null;
			case RequestManager.DATAFORMAT_JSON:
				try {
					//去掉json不支持的字符串
					var _dataFotmat:String = data.replace(/[\x00-\x1f]/g, "");
					return com.adobe.serialization.json.JSON.decode(_dataFotmat);
				} catch (_e:*){
				}
				return null;
			case RequestManager.DATAFORMAT_AMF3:
				try {
					var _bytes:ByteArray = data as ByteArray;
					//if (_compressed){
					//_bytes.uncompress();
					//}
					return _bytes.readObject();
				} catch (_e:*){
				}
				return null;
			case URLLoaderDataFormat.BINARY:
			case URLLoaderDataFormat.VARIABLES:
				return data;
			case URLLoaderDataFormat.TEXT:
			default:
				data = String(data).replace(/^\s*|\s*$/g, "");
				return data;
		}
	}

	public function addEvents(_onProgressHandler:Function, _onErrorHandler:Function, _onCompleteHandler:Function):void {
		if (_onErrorHandler != null){
			errorHandlers[_onErrorHandler] = _onErrorHandler;
		}
		if (_onProgressHandler != null){
			progressHandlers[_onProgressHandler] = _onProgressHandler;
			addEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
		}
		if (_onCompleteHandler != null){
			completeHandlers[_onCompleteHandler] = _onCompleteHandler;
		}
	}

	public function removeEvents(_onProgressHandler:Function, _onErrorHandler:Function, _onCompleteHandler:Function):void {
		if (_onErrorHandler != null){
			delete errorHandlers[_onErrorHandler];
		}
		if (_onProgressHandler != null){
			removeEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
			delete progressHandlers[_onProgressHandler];
		}
		if (_onCompleteHandler != null){
			delete completeHandlers[_onCompleteHandler];
		}
	}

	public function onErrorHandler(_evt:Event):void {
		trace(_evt);
		for each (var _onError:Function in errorHandlers){
			switch (_onError.length){
				case 0:
					_onError();
					break;
				case 2:
					_onError(_evt, url);
					break;
				case 3:
					_onError(_evt, url, params);
					break;
				case 1:
				default:
					_onError(_evt);
					break;
			}
		}
	}

	public function onCompleteHandler():void {
		var _data:* = getFormatData();
		for each (var _onComplete:Function in completeHandlers){
			switch (_onComplete.length){
				case 0:
					_onComplete();
					break;
				case 2:
					_onComplete(_data, url);
					break;
				case 3:
					_onComplete(_data, url, params);
					break;
				case 1:
				default:
					_onComplete(_data);
					break;
			}
		}
	}
}