package akdcl.manager {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.ByteArray;

	import akdcl.net.DataLoader;

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

		private var request:URLRequest = new URLRequest();

		private var listReady:Vector.<DataLoader> = new Vector.<DataLoader>();
		private var listLoading:Vector.<DataLoader> = new Vector.<DataLoader>();

		public function RequestManager(){
			if (instance){
				throw new Error("ERROR:RequestManager Singleton already constructed!");
			}
			instance = this;
			request = new URLRequest();
			listReady = new Vector.<DataLoader>();
			listLoading = new Vector.<DataLoader>();
		}

		public function load(_url:*, _onProgressHandler:Function = null, _onCompleteHandler:Function = null, _onIOErrorHandler:Function = null):DataLoader {
			//
			var _dataLoader:DataLoader;
			if (listReady.length > 0){
				_dataLoader = listReady.pop();
			} else {
				_dataLoader = new DataLoader();
			}
			listLoading.push(_dataLoader);
			//
			_dataLoader.onProgressHandler = _onProgressHandler;
			_dataLoader.onCompleteHandler = _onCompleteHandler;
			_dataLoader.onIOErrorHandler = _onIOErrorHandler;
			if (_onProgressHandler != null){
				_dataLoader.addEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
			}
			_dataLoader.addEventListener(Event.COMPLETE, onCompleteOrIOErrorHandler);
			_dataLoader.addEventListener(IOErrorEvent.IO_ERROR, onCompleteOrIOErrorHandler);
			//
			request.contentType = null;
			request.data = null;
			request.method = URLRequestMethod.GET;
			request.url = _url;
			//
			_dataLoader.clear();
			_dataLoader.load(request);
		}

		private function onCompleteOrIOErrorHandler(_evt:Event):void {
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			_dataLoader.removeEventListener(ProgressEvent.PROGRESS, _dataLoader.onProgressHandler);
			_dataLoader.removeEventListener(Event.COMPLETE, onCompleteOrIOErrorHandler);
			_dataLoader.removeEventListener(IOErrorEvent.IO_ERROR, onCompleteOrIOErrorHandler);
			
			if (_evt is IOErrorEvent){
				if (_dataLoader.onIOErrorHandler != null){
					_dataLoader.onIOErrorHandler(_evt);
				}
			} else {
				if (_dataLoader.onProgressHandler != null){

				}
				if (_dataLoader.onCompleteHandler != null){
					_dataLoader.onCompleteHandler(_evt);
				}
			}
			_dataLoader.onProgressHandler = null;
			_dataLoader.onCompleteHandler = null;
			_dataLoader.onIOErrorHandler = null;
			//
			listReady.push(_dataLoader);
			var _index:int = listLoading.indexOf(_dataLoader);
			if (_index >= 0) {
				listLoading.splice(_index,1);
			}
		}
	}

}