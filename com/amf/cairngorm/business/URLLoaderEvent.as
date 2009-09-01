package com.amf.cairngorm.business
{
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	
	public class URLLoaderEvent
	{
		public function URLLoaderEvent(loader:URLLoader){
			configureListeners(loader);
		}
		protected function completeHandler (event:Event):void {
			//trace ("completeHandler: " + event);
		}
		protected function openHandler (event:Event):void {
			//trace ("openHandler: " + event);
		} 
		protected function progressHandler (event:ProgressEvent):void {
			//trace ("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		} 
		protected function securityErrorHandler (event:SecurityErrorEvent):void {
			//trace ("securityErrorHandler: " + event);
		}
		protected function httpStatusHandler (event:HTTPStatusEvent):void {
			trace ("httpStatusHandler: " + event);
		} 
		protected function ioErrorHandler (event:IOErrorEvent):void {
			trace ("ioErrorHandler: " + event.text);
		}
		private function configureListeners (dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
	}
}