package akdcl.media {

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import com.greensock.loading.VideoLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;

	import akdcl.manager.SourceManager;

	/**
	 * ...
	 * @author akdcl
	 */
	/// @eventType	akdcl.media.MediaEvent.DISPLAY_CHANGE
	[Event(name="displayChange",type="akdcl.media.MediaEvent")]
	final public class VideoProvider extends MediaProvider {
		private static const DEFAULT_PARAMS:Object = {autoPlay: false, scaleMode: ScaleMode.PROPORTIONAL_INSIDE, bgColor: 0x000000};
		private static const VIDEOLOADER_GROUP:String = "VideoLoader";

		private static var sM:SourceManager = SourceManager.getInstance();
		
		public var displayContent:DisplayObject;
		
		private var isBuffering:Boolean = false;

		override public function get loadProgress():Number {
			return playContent ? playContent.progress : 0;
		}

		override public function get totalTime():uint {
			return playContent ? (playContent.duration * 1000) : 0;
		}

		override public function get bufferProgress():Number {
			return playContent ? playContent.bufferProgress : 0;
		}

		override public function get position():uint {
			return playContent ? (playContent.videoTime * 1000) : 0;
		}
		
		override public function set volume(value:Number):void {
			super.volume = value;
			if (playContent){
				playContent.volume = volume;
			}
		}

		override public function remove():void {
			removeContentListener();
			super.remove();
		}

		override public function load(_item:*):void {
			super.load(_item);
			removeContentListener();
			playContent = sM.getSource(VIDEOLOADER_GROUP, playItem.source);
			if (playContent){
			} else {
				var _params:Object = null;
				if (_params){
					for (var _i:String in DEFAULT_PARAMS){
						if (!_params.hasOwnProperty(_i)){
							_params[_i] = DEFAULT_PARAMS[_i];
						}
					}
				}
				playContent = new VideoLoader(playItem.source, _params || DEFAULT_PARAMS);
				sM.addSource(VIDEOLOADER_GROUP, playItem.source, playContent);
				playContent.addEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				playContent.load();
			}
			if (loadProgress >= 1){
				onDisplayChange();
				//playContent已经加载完毕
				onLoadCompleteHandler();
			} else {
				playContent.addEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				playContent.addEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
				playContent.addEventListener(LoaderEvent.INIT, onVideoInitHandler);
			}
			playContent.addEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
		}
		
		override public function play(_startTime:int = -1):void {
			if (playContent){
				if (_startTime < 0){
					playContent.playVideo();
				} else {
					playContent.videoTime = _startTime * 0.001;
					playContent.playVideo();
				}
				playContent.volume = volume;
			}
			super.play(_startTime);
		}

		override public function pause():void {
			if (playContent){
				playContent.pauseVideo();
			}
			super.pause();
		}

		override public function stop():void {
			if (playContent){
				playContent.pauseVideo();
				playContent.videoTime = 0;
			}
			super.stop();
		}

		override protected function onLoadErrorHandler(_evt:* = null):void {
			removeContentListener();
			sM.removeSource(VIDEOLOADER_GROUP, playContent);
			playContent.dispose();
			playContent = null;
			super.onLoadErrorHandler(_evt);
		}

		override protected function onLoadProgressHandler(_evt:* = null):void {
			if (!(_evt === false)) {
				if (bufferProgress < 1) {
					isBuffering = true;
					onBufferProgressHandler();
				}else if(isBuffering){
					isBuffering = false;
					onBufferProgressHandler();
				}
			}
			super.onLoadProgressHandler(_evt);
		}

		override protected function onPlayCompleteHandler(_evt:* = null):void {
			removeContentListener();
			super.onPlayCompleteHandler(_evt);
		}

		private function removeContentListener():void {
			if (playContent){
				//卸载playContent
				playContent.removeEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				playContent.removeEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				playContent.removeEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
				playContent.removeEventListener(LoaderEvent.INIT, onVideoInitHandler);
				playContent.removeEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			}
		}

		private function onVideoInitHandler(_e:LoaderEvent):void {
			playContent.removeEventListener(LoaderEvent.INIT, onVideoInitHandler);
			//
			onDisplayChange();
		}
		
		private function onDisplayChange():void {
			//加载显示对象
			displayContent = playContent.content;
			if (hasEventListener(MediaEvent.DISPLAY_CHANGE)){
				dispatchEvent(new MediaEvent(MediaEvent.DISPLAY_CHANGE));
			}
		}
	}

}