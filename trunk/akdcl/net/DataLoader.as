package akdcl.net 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import com.adobe.serialization.json.JSON;
	import akdcl.utils.objectToURLVariables;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class DataLoader extends URLLoader {
		private static var request:URLRequest = new URLRequest();
		private static var listReady:Vector.<DataLoader> = new Vector.<DataLoader>();
		//private static var listLoading:Vector.<DataLoader> = new Vector.<DataLoader>();
		public static function load(_url:*, _onProgressHandler:Function = null, _onCompleteHandler:Function = null, _onIOErrorHandler:Function = null, _data:Object = null):void {
			//
			var _dataLoader:DataLoader;
			if (listReady.length > 0) {
				_dataLoader = listReady.pop();
			}else {
				_dataLoader = new DataLoader();
			}
			//
			if (_onProgressHandler != null) {
				_dataLoader.onProgressHandler = _onProgressHandler;
				_dataLoader.addEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
			}
			if (_onCompleteHandler != null) {
				_dataLoader.onCompleteHandler = _onCompleteHandler;
				_dataLoader.addEventListener(Event.COMPLETE, _onCompleteHandler);
			}
			if (_onIOErrorHandler != null) {
				_dataLoader.onIOErrorHandler = _onIOErrorHandler;
				_dataLoader.addEventListener(IOErrorEvent.IO_ERROR, _onIOErrorHandler);
			}
			_dataLoader.addEventListener(Event.COMPLETE, onCompleteOrIOErrorHandler);
			_dataLoader.addEventListener(IOErrorEvent.IO_ERROR, onCompleteOrIOErrorHandler);
			//
			request.url = _url;
			if (_data) {
				if (_data is URLVariables) {
					request.data = _data;
				}else {
					request.data = objectToURLVariables(_data);
				}
				request.method = URLRequestMethod.POST;
			}else {
				request.data = null;
				request.method = URLRequestMethod.GET;
			}
			//
			_dataLoader.load(request);
		}
		private static function onCompleteOrIOErrorHandler(_evt:Event):void {
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			if (_dataLoader.onProgressHandler!=null) {
				_dataLoader.removeEventListener(ProgressEvent.PROGRESS, _dataLoader.onProgressHandler);
			}
			if (_dataLoader.onCompleteHandler!=null) {
				_dataLoader.removeEventListener(Event.COMPLETE, _dataLoader.onCompleteHandler);
			}
			if (_dataLoader.onIOErrorHandler!=null) {
				_dataLoader.removeEventListener(IOErrorEvent.IO_ERROR, _dataLoader.onIOErrorHandler);
			}
			_dataLoader.onProgressHandler = null;
			_dataLoader.onCompleteHandler = null;
			_dataLoader.onIOErrorHandler = null;
			_dataLoader.removeEventListener(Event.COMPLETE, onCompleteOrIOErrorHandler);
			_dataLoader.removeEventListener(IOErrorEvent.IO_ERROR, onCompleteOrIOErrorHandler);
			_dataLoader.data = null;
			listReady.push(_dataLoader);
		}
		//
		public function get dataToURLVariables():URLVariables {
			var _data:URLVariables = new URLVariables();
			try {
				_data.decode(data);
			}catch (_error:*) {
				_data = null;
			}
			return _data;
		}
		public function get dataToJSON():Object {
			var _data:Object;
			try {
				_data = JSON.decode(data);
			}catch (_error:*) {
				_data = null;
			}
			return _data;
		}
		private var onProgressHandler:Function;
		private var onCompleteHandler:Function;
		private var onIOErrorHandler:Function;
	}
}