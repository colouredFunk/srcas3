package com.amf.cairngorm.business
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class StaticData extends URLLoaderEvent {
		private var targetFunc:Function;
		private var errorFunc:Function;
		private var file:String;
		public function StaticData (url:String,Func:Function,eFunc:Function=null) {
			file = url;
			targetFunc=Func;
			errorFunc = eFunc;
			//trace("file : "+file);
			var loader:URLLoader = new URLLoader();
			super (loader);
			var request:URLRequest = new URLRequest(url);
			loader.load (request);
		}
		override protected function completeHandler (event:Event):void {
			targetFunc (event.target.data);
		}
		override protected function ioErrorHandler (event:IOErrorEvent):void {
			if(errorFunc != null){
				errorFunc();
			}
		}
		override protected function httpStatusHandler (event:HTTPStatusEvent):void {
			trace("httpStatusHandler:"+event.status);
			if(event.status>=400||event.status==300){
				if(errorFunc != null){
					errorFunc();
				}
			}
		}
		override protected function securityErrorHandler (event:SecurityErrorEvent):void {
			if(errorFunc != null){
				errorFunc();
			}
		}
	}
}