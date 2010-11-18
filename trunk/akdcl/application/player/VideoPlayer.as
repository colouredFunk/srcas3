package akdcl.application.player{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.VideoLoader;
	import com.greensock.layout.ScaleMode;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class VideoPlayer extends MediaPlayer {
		protected static const defaultParams:Object = { autoPlay:false, scaleMode:ScaleMode.PROPORTIONAL_INSIDE };
		protected static var videoDic:Object = { };
		protected static function loadVideo(_source:String, _params:Object = null):VideoLoader {
			var _video:VideoLoader = videoDic[_source];
			if (!_video) {
				if (_params) {
					for (var _i:String in defaultParams) {
						if (!_params.hasOwnProperty(_i)) {
							_params[_i] = defaultParams[_i];
						}
					}
				}
				_video = new VideoLoader(_source, _params || defaultParams);
			}
			return _video;
		}
		protected static function removeVideo(_video:VideoLoader):void {
			for (var _source:String in videoDic) {
				if (videoDic[_source]==_video) {
					delete videoDic[_source];
					break;
				}
			}
		}
		
		override public function get loadProgress():Number {
			return video?video.progress:0; 
		}
		override public function get totalTime():uint { 
			return video?(video.duration * 1000):0;
		}
		override public function get position():uint {
			return video?(video.videoTime * 1000):0;
		}
		override public function set position(value:uint):void {
			if (video) {
				video.videoTime = Math.min(value, totalTime * video.progress * 0.99) * 0.001;
				play();
			}
		}
		override public function set volume(value:Number):void {
			super.volume = value;
			if (video) {
				video.volume = volume;
			}
		}
		override public function set contentWidth(value:uint):void {
			super.contentWidth = value;
			if (content) {
				content.fitWidth = contentWidth;
			}
		}
		override public function set contentHeight(value:uint):void {
			super.contentHeight = value;
			if (content) {
				content.fitHeight = contentWidth;
			}
		}
		override public function get content():* {
			return video?video.content:null;
		}
		protected var video:VideoLoader;
		protected var videoParams:Object;
		override protected function init():void {
			super.init();
		}
		override public function remove():void {
			super.remove();
			hideContent();
			video = null;
			videoParams = null;
		}
		override public function play():Boolean {
			var _isPlay:Boolean = super.play();
			if (_isPlay && video) {
				video.playVideo();
			}
			return _isPlay;
		}
		override public function pause():void {
			super.pause();
			video&&video.pauseVideo();
		}
		override public function stop():void {
			if (video) {
				video.videoTime = 0;
				video.pauseVideo();
			}
			super.stop();
		}
		override public function hideContent():void {
			super.hideContent();
			if (container && content && container.contains(content)) {
				container.removeChild(content);
			}
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
			if (video) {
				video.removeEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				video.removeEventListener(LoaderEvent.PROGRESS, onLoadProgressHander);
				video.removeEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
				video.removeEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			}
			hideContent();
			
			super.onPlayIDChangeHandler(_playID);
			
			var _videoSource:String = getMediaByID(_playID);
			video = loadVideo(_videoSource, videoParams);
			video.addEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
			video.addEventListener(LoaderEvent.PROGRESS, onLoadProgressHander);
			video.addEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
			video.addEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			video.load();
			if (container && content) {
				container.addChild(content);
				content.fitWidth = contentWidth;
				content.fitHeight = contentHeight;
			}
			play();
		}
		override protected function onLoadErrorHandler(_evt:* = null):void {
			super.onLoadErrorHandler(_evt);
			removeVideo(video);
		}
	}
}