package akdcl.manager {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import flash.utils.ByteArray;

	import zero.FileTypes;

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
			loaderDic = {};
			urlLoaderDic = {};
		}

		public static const DATAFORMAT_XML:String = "xml";
		public static const DATAFORMAT_JSON:String = "json";

		private static const REQUESTLOADER:String = "RequestLoader";
		private static const REQUESTURLLOADER:String = "RequestURLLoader";

		private var eM:ElementManager;
		private var sM:SourceManager;
		private var request:URLRequest;
		private var loaderDic:Object;
		private var urlLoaderDic:Object;

		public function loadImage(_url:String, _onCompleteHandler:Function = null, _onErrorHandler:Function = null, _onProgressHandler:Function = null, ... args):void {
			if (!_url){
				trace("[WARNNING]:RequestManager.loadImage(_url), _url is null!!!");
				return;
			}
			//
			var _bmd:BitmapData = sM.getSource(SourceManager.BITMAPDATA_GROUP, _url);
			if (_bmd){
				if (_onProgressHandler != null){
					_onProgressHandler(null);
				}
				if (_onCompleteHandler != null){
					_onCompleteHandler(_bmd);
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
				loaderDic[_url] = _loader;
			}
			//
			resetRequest(_url);
			_loader.addEvents(_onProgressHandler, _onErrorHandler, _onCompleteHandler);
			_loader.load(request);
		}

		private function onLoaderCompleteOrErrorHandler(_evt:Event):void {
			var _loaderInfo:LoaderInfo = (_evt.currentTarget as LoaderInfo);
			var _loader:RequestLoader = _loaderInfo.loader as RequestLoader;
			_loaderInfo.removeEventListener(Event.COMPLETE, onLoaderCompleteOrErrorHandler);
			_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderCompleteOrErrorHandler);
			if (_evt is IOErrorEvent){
				_loader.onErrorHandler(_evt);
			} else {
				var _bmd:BitmapData = (_loader.content as Bitmap).bitmapData;
				if (_bmd){
					sM.addSource(SourceManager.BITMAPDATA_GROUP, _loader.url, _bmd);
				}
				_loader.onCompleteHandler(_bmd);
			}
			delete loaderDic[_loader.url];
			_loader.clear();
			eM.recycle(_loader);
		}

		public function load(_url:*, _onCompleteHandler:Function = null, _onErrorHandler:Function = null, _onProgressHandler:Function = null, ... args):void {
			var _realURL:String;
			if (_url is URLRequest || _url is Object) {
				_realURL = _url.url;
			}else {
				_realURL = _url;
			}
			if (!_realURL){
				trace("[WARNNING]:RequestManager.load(_url), _url is null!!!");
				return;
			}
			//
			var _loader:RequestURLLoader = urlLoaderDic[_realURL];
			if (_loader){
			} else {
				_loader = eM.getElement(REQUESTURLLOADER);
				_loader.addEventListener(Event.COMPLETE, onURLLoaderCompleteOrErrorHandler);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, onURLLoaderCompleteOrErrorHandler);
				urlLoaderDic[_realURL] = _loader;
			}
			//
			resetRequest(_url);
			_loader.addEvents(_onProgressHandler, _onErrorHandler, _onCompleteHandler);
			_loader.load(request);
		}

		private function onURLLoaderCompleteOrErrorHandler(_evt:Event):void {
			var _loader:RequestURLLoader = _evt.currentTarget as RequestURLLoader;
			_loader.removeEventListener(Event.COMPLETE, onURLLoaderCompleteOrErrorHandler);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onURLLoaderCompleteOrErrorHandler);
			if (_evt is IOErrorEvent){
				_loader.onErrorHandler(_evt);
			} else {
				var _data:* = _loader.getFormatData();
				_loader.onCompleteHandler(_data);
			}
			delete urlLoaderDic[_loader.url];
			_loader.clear();
			eM.recycle(_loader);
		}

		private function resetRequest(_url:*):void {
			//重置request
			if (_url is String){
				request.url = _url;
				request.contentType = null;
				request.data = null;
				request.method = URLRequestMethod.GET;
			} else if (_url is URLRequest || _url is Object){
				request.url = _url.url;
				request.contentType = _url.contentType;
				request.data = _url.data;
				request.method = _url.method;
			}
		}
	}

}

import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.system.LoaderContext;
import flash.utils.Dictionary;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLLoaderDataFormat;

import akdcl.manager.RequestManager;

class RequestLoader extends Loader {
	public var url:String;
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

	public function clear():void {
		url = null;
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
		unload();
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
		for each (var _onError:Function in errorHandlers){
			switch (_onError.length){
				case 0:
					_onError();
					break;
				case 2:
					_onError(_evt, url);
					break;
				case 1:
				default:
					_onError(_evt);
					break;
			}
		}
	}

	public function onCompleteHandler(_bmd:BitmapData):void {
		for each (var _onComplete:Function in completeHandlers){
			switch (_onComplete.length){
				case 0:
					_onComplete();
					break;
				case 2:
					_onComplete(_bmd, url);
					break;
				case 1:
				default:
					_onComplete(_bmd);
					break;
			}
		}
	}
}

class RequestURLLoader extends URLLoader {
	public var url:String;
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
		if (!dataFormat && (_type == "jpg" || _type == "png" || _type == "gif" || _type == "swf")){
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		super.load(request);
	}

	public function clear():void {
		url = null;
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
		data = null;
		dataFormat = null;
	}

	public function getFormatData():* {
		switch (dataFormat){
			case RequestManager.DATAFORMAT_XML:
				return XML(data);
			case RequestManager.DATAFORMAT_JSON:
				return null;
			case URLLoaderDataFormat.BINARY:
			case URLLoaderDataFormat.TEXT:
			case URLLoaderDataFormat.VARIABLES:
			default:
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
		for each (var _onError:Function in errorHandlers){
			switch (_onError.length){
				case 0:
					_onError();
					break;
				case 2:
					_onError(_evt, url);
					break;
				case 1:
				default:
					_onError(_evt);
					break;
			}
		}
	}

	public function onCompleteHandler(_data:*):void {
		for each (var _onComplete:Function in completeHandlers){
			switch (_onComplete.length){
				case 0:
					_onComplete();
					break;
				case 2:
					_onComplete(_data, url);
					break;
				case 1:
				default:
					_onComplete(_data);
					break;
			}
		}
	}
}