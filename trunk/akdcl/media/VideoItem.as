package akdcl.media {
	import flash.events.Event;
	import akdcl.manager.SourceManager;

	import akdcl.interfaces.IPlaylistItem;
	import akdcl.interfaces.IVolume;

	import com.greensock.loading.VideoLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;

	/**
	 * ...
	 * @author akdcl
	 */
	public class VideoItem implements IPlaylistItem, IVolume {
		private static const DEFAULT_PARAMS:Object = {autoPlay: false, scaleMode: ScaleMode.PROPORTIONAL_INSIDE, bgColor: 0x000000};
		private static const VIDEOLOADER_GROUP:String = "VideoLoader";
		
		private static var sM:SourceManager = SourceManager.getInstance();

		private var videoLoader:VideoLoader;

		public function get loadProgress():Number {
			return videoLoader ? videoLoader.progress : 0;
		}

		public function get bufferProgress():Number {
			return videoLoader ? videoLoader.bufferProgress : 0;
		}

		public function get totalTime():uint {
			return videoLoader ? (videoLoader.duration * 1000) : 0;
		}

		public function get playProgress():Number {
			var _playProgress:Number = position / totalTime;
			if (isNaN(_playProgress)){
				_playProgress = 0;
			}
			return _playProgress;
		}

		public function set playProgress(_playProgress:Number):void {
			position = _playProgress * totalTime;
		}

		public function get position():uint {
			return videoLoader ? (videoLoader.videoTime * 1000) : 0;
		}

		public function set position(_position:uint):void {
			if (videoLoader){
				videoLoader.videoTime = Math.min(_position, totalTime * videoLoader.progress * 0.99) * 0.001;
			}
		}

		private var __volume:Number = 1;

		public function get volume():Number {
			return __volume;
		}

		public function set volume(_volume:Number):void {
			if (_volume < 0){
				_volume = 0;
			} else if (_volume > 1){
				_volume = 1;
			}
			if (__volume == _volume){
				return;
			}
			__volume = _volume;
			if (videoLoader){
				videoLoader.volume = volume;
			}
		}

		public function VideoItem(_source:String=null, _params:Object = null){
			if (_source){
				load(_source, _params);
			}
		}

		public function load(_source:String, _params:Object = null):void {
			removeFixVideo(videoLoader);
			videoLoader = sM.getSource(VIDEOLOADER_GROUP, _source);
			if (!videoLoader){
				if (_params){
					for (var _i:String in DEFAULT_PARAMS){
						if (!_params.hasOwnProperty(_i)){
							_params[_i] = DEFAULT_PARAMS[_i];
						}
					}
				}
				videoLoader = new VideoLoader(_source, _params || DEFAULT_PARAMS);
				sM.addSource(VIDEOLOADER_GROUP, _source, videoLoader);
			}

			videoLoader.addEventListener(LoaderEvent.ERROR, onVideoLoaderHandler);
			videoLoader.addEventListener(LoaderEvent.PROGRESS, onVideoLoaderHandler);
			videoLoader.addEventListener(LoaderEvent.COMPLETE, onVideoLoaderHandler);
			videoLoader.addEventListener(VideoLoader.VIDEO_COMPLETE, onVideoLoaderHandler);
			videoLoader.load();
		}
		
		private function removeFixVideo(_video:VideoLoader):void {
			if (_video){
				_video.removeEventListener(LoaderEvent.ERROR, onVideoLoaderHandler);
				_video.removeEventListener(LoaderEvent.PROGRESS, onVideoLoaderHandler);
				_video.removeEventListener(LoaderEvent.COMPLETE, onVideoLoaderHandler);
				_video.removeEventListener(VideoLoader.VIDEO_COMPLETE, onVideoLoaderHandler);
			}
		}

		private function onVideoLoaderHandler(_e:LoaderEvent):void {
			switch(_e.type) {
				case LoaderEvent.ERROR:
					removeFixVideo(videoLoader);
					sM.removeSourceInstance(VIDEOLOADER_GROUP, videoLoader);
					videoLoader.dispose();
					videoLoader = null;
					break;
				case LoaderEvent.PROGRESS:
					break;
				case LoaderEvent.COMPLETE:
					break;
				case VideoLoader.VIDEO_COMPLETE:
					break;
			}
		}

		public function play():void {
			if (videoLoader && !videoLoader.paused){
				videoLoader.playVideo();
			}
		}

		public function stop():void {
			if (videoLoader){
				/*if (autoRewind && videoLoader.videoTime != 0){
					videoLoader.videoTime = 0;
				}*/
				videoLoader.pauseVideo();
			}
		}

		public function remove():void {
			videoLoader.cancel();
			videoLoader = null;
		}
	}

}