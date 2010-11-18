package akdcl.application{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import ui.ImageLoader;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ImagePlayer extends MediaPlayer {
		override public function get loadProgress():Number {
			return content?content.loadProgress:0; 
		}
		protected var __totalTime:uint = 5000;
		override public function get totalTime():uint { 
			return __totalTime;
		}
		public function set totalTime(_totalTime:uint):void {
			__totalTime = _totalTime;
		}
		override public function get position():uint {
			return timer.currentCount * timer.delay;
		}
		override public function set contentWidth(value:uint):void {
			super.contentWidth = value;
			content.areaWidth = contentWidth;
		}
		override public function set contentHeight(value:uint):void {
			super.contentHeight = value;
			content.areaHeight = contentHeight;
		}
		override protected function init():void {
			super.init();
			content = new ImageLoader();
		}
		override public function remove():void {
			super.remove();
			content.remove();
			content = null;
		}
		override public function hideContent():void {
			super.hideContent();
			content.visible = false;
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
			
			super.onPlayIDChangeHandler(_playID);
			
			var _imageSource:String = getMediaByID(_playID);
			content.load(_imageSource);
			if (container) {
				content.visible = true;
				container.addChild(content);
			}
			//content.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
			content.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHander);
			content.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			play();
		}
		override protected function onLoadCompleteHandler(_evt:* = null):void {
			super.onLoadCompleteHandler(_evt);
			timer.start();
		}
		override protected function onPlayProgressHander(_evt:* = null):void {
			super.onPlayProgressHander(_evt);
			var _play:uint = timer.currentCount * timer.delay;
			if (_play > totalTime * loadProgress) {
				timer.stop();
			}
			if ( _play >= totalTime) {
				onPlayCompleteHandler();
			}
		}
	}
	
}