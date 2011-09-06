package akdcl.media {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	
	import akdcl.manager.RequestManager;

	/**
	 * ...
	 * @author ...
	 */
	final public class ImageProvider extends MediaProvider {
		private static const DEFAULT_TOTAL_TIME:uint = 5000;
		
		protected static var rM:RequestManager = RequestManager.getInstance();
		
		private var __loadProgress:Number = 0;
		override public function get loadProgress():Number {
			return __loadProgress;
		}

		private var __totalTime:uint = DEFAULT_TOTAL_TIME;
		override public function get totalTime():uint {
			return __totalTime;
		}
		override public function get bufferProgress():Number {
			return __loadProgress;
		}

		override public function get position():uint {
			return timer.currentCount * timer.delay;
		}

		private var __container:DisplayRect;
		public function set container(_container:DisplayRect):void {
			if (_container){
				if (playContent){
					_container.setContent(playContent);
				}
			} else if (__container) {
				__container.setContent();
			}
			__container = _container;
		}

		override public function load(_item:*):void {
			__loadProgress = 0;
			var _source:String;
			if (_item is PlayItem) { 
				_source = _item.source;
			}else {
				_source = _item;
			}
			super.load(_item);
			timer.stop();
			rM.loadDisplay(_source, onLoadCompleteHandler, onLoadErrorHandler, onLoadProgressHandler);
		}

		override public function pause():void {
			timer.stop();
			super.pause();
		}

		override public function stop():void {
			timer.reset();
			timer.stop();
			super.stop();
		}
		
		override protected function onLoadProgressHandler(_evt:* = null):void {
			if (_evt) {
				__loadProgress = _evt.bytesLoaded / _evt.bytesTotal;
			}else {
				__loadProgress = 1;
			}
			if (isNaN(__loadProgress)){
				__loadProgress = 0;
			}
			onBufferProgressHandler();
			super.onLoadProgressHandler(_evt);
		}

		override protected function onLoadCompleteHandler(_evt:* = null):void {
			playContent = _evt;
			if (__container) {
				__container.setContent(playContent);
			}
			timer.start();
			super.onLoadCompleteHandler(null);
		}

		override protected function onPlayProgressHander(_evt:* = null):void {
			if (loadProgress == 1){
				if (position >= totalTime && !(_evt is String)) {
					onPlayCompleteHandler();
				} else {
					super.onPlayProgressHander(_evt);
				}
			} else {
				timer.reset();
				timer.stop();
			}
		}
	}

}