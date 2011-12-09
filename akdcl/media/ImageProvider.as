package akdcl.media {
	import flash.display.BitmapData;
	import flash.events.Event;

	import akdcl.manager.RequestManager;

	/**
	 * ...
	 * @author ...
	 */
	/// @eventType	akdcl.media.MediaEvent.DISPLAY_CHANGE
	[Event(name="displayChange",type="akdcl.media.MediaEvent")]
	final public class ImageProvider extends MediaProvider {
		private static const DEFAULT_TOTAL_TIME:uint = 5000;

		protected static var rM:RequestManager = RequestManager.getInstance();

		public var name:String = "imageProvider";

		public var displayContent:BitmapData;
		private var lastSource:String;
		private var __loadProgress:Number = 0;

		override public function get loadProgress():Number {
			return __loadProgress;
		}

		private var __totalTime:uint = 0;

		override public function get totalTime():uint {
			return __totalTime;
		}

		override public function get bufferProgress():Number {
			return __loadProgress;
		}

		override public function get position():uint {
			return timer.currentCount * timer.delay;
		}

		override public function remove():void {
			if (lastSource){
				rM.unloadDisplay(lastSource, onLoadCompleteHandler, onLoadErrorHandler, onLoadProgressHandler);
			}
			super.remove();
		}

		override protected function loadHandler():void {
			if (lastSource){
				rM.unloadDisplay(lastSource, onLoadCompleteHandler, onLoadErrorHandler, onLoadProgressHandler);
			}
			__loadProgress = 0;
			lastSource = playItem.source;
			//判断是否是bmd并加载完毕，将onLoadCompleteHandler移入waitHandler
			rM.loadDisplay(lastSource, onLoadCompleteHandler, onLoadErrorHandler, onLoadProgressHandler);
			timer.stop();
		}
		
		override protected function playHandler(_startTime:int = -1):void {
			if (position == totalTime) {
				timer.reset();
				timer.start();
			}
		}

		override protected function pauseHandler():void {
			timer.stop();
		}

		override protected function stopHandler():void {
			timer.reset();
			timer.stop();
		}

		override protected function onLoadProgressHandler(_evt:* = null):void {
			if (_evt is Event){
				__loadProgress = _evt.bytesLoaded / _evt.bytesTotal;
			} else if (_evt is Number) {
				__loadProgress = _evt;
			} else{
				__loadProgress = 0;
			}
			if (isNaN(__loadProgress)){
				__loadProgress = 0;
			}
			onBufferProgressHandler();
			super.onLoadProgressHandler(_evt);
		}

		override protected function onLoadCompleteHandler(_evt:* = null):void {
			__totalTime = DEFAULT_TOTAL_TIME;
			playContent = _evt;
			onDisplayChange();
			if (isPlaying) {
				timer.start();
			}
			super.onLoadCompleteHandler(null);
		}

		override protected function onPlayProgressHander(_evt:* = null):void {
			if (loadProgress == 1) {
				if (position >= totalTime && __playState != PlayState.COMPLETE) {
					onPlayCompleteHandler();
				} else {
					super.onPlayProgressHander(_evt);
				}
			} else {
				//loadProgress为1以前，都不播放
				timer.reset();
				timer.stop();
			}
		}

		private function onDisplayChange():void {
			//加载显示对象
			displayContent = playContent;
			if (hasEventListener(MediaEvent.DISPLAY_CHANGE)){
				dispatchEvent(new MediaEvent(MediaEvent.DISPLAY_CHANGE));
			}
		}
	}

}