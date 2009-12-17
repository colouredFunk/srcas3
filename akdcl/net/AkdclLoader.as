package akdcl.net 
{
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import com.adobe.serialization.json.JSON;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class AkdclLoader extends EventDispatcher
	{
		public var content:*;
		private var urlLoader:URLLoader;
		private var request:URLRequest;
		public function AkdclLoader() 
		{
			urlLoader = new URLLoader();
			request = new URLRequest();
		}
		public function load(_url:String, _data:Object = null):void {
			retuestURL(_url,_data);
			//urlLoader.addEventListener(ProgressEvent.PROGRESS, onURLProgressHandler);
			urlLoader.addEventListener(Event.COMPLETE,onURLCompleteHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onURLErrorHandler);
			urlLoader.load(request);
		}
		public function getURL(_url:String, _target:String = "_self", _data:Object = null):void {
			retuestURL(_url,_data);
			navigateToURL(request,_target);
		}
		private function retuestURL(_url:String, _data:Object=null):void {
			request.url = _url;
			if (_data) {
				request.data = obToURLVar(_data);
				request.method = URLRequestMethod.POST;
			}else {
				request.data = null;
				request.method = URLRequestMethod.GET;
			}
		}
		private function onURLCompleteHandler(_evt:Event):void {
			urlLoader.removeEventListener(Event.COMPLETE,onURLCompleteHandler);
			var _result:URLVariables = new URLVariables();
			try {
				_result.decode(_evt.currentTarget.data);
				content = _result;
			}catch (_error:*) {
				try {
					content = JSON.decode(_evt.currentTarget.data);
				}catch (_error:*) {
					content = _evt.currentTarget.data;
				}
			}
			dispatchEvent(new Event(_evt.type));
		}
		private function onURLErrorHandler(_evt:IOErrorEvent):void {
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,onURLErrorHandler);
			dispatchEvent(new IOErrorEvent(_evt.type));
		}
		private static function obToURLVar(_data:Object):URLVariables {
			var _urlVariables:URLVariables=new URLVariables();
			for(var _i:String in _data){
				_urlVariables[_i] = _data[_i];
			}
			return _urlVariables;
		}
	}

}