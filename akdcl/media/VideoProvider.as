package akdcl.media {

	import com.greensock.loading.VideoLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;

	import akdcl.interfaces.IVolume;

	import akdcl.manager.SourceManager;

	/**
	 * ...
	 * @author akdcl
	 */
	public class VideoProvider extends MediaProvider implements IVolume {
		private static const DEFAULT_PARAMS:Object = {autoPlay: false, scaleMode: ScaleMode.PROPORTIONAL_INSIDE, bgColor: 0x000000};
		private static const VIDEOLOADER_GROUP:String = "VideoLoader";

		private static var sM:SourceManager = SourceManager.getInstance();

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
			if (playContent){
				playContent.volume = __volume;
			}
		}

		override public function remove():void {
			removeContentListener();
			super.remove();
		}

		override public function load(_source:String):void {
			super.load(_source);
			removeContentListener();
			playContent = sM.getSource(VIDEOLOADER_GROUP, _source);
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
				playContent = new VideoLoader(_source, _params || DEFAULT_PARAMS);
				sM.addSource(VIDEOLOADER_GROUP, _source, playContent);
				playContent.addEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				playContent.load();
			}
			if (loadProgress >= 1){
				//playContent已经加载完毕
				onLoadProgressHandler();
				onLoadCompleteHandler();
			} else {
				playContent.addEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				playContent.addEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
			}
			playContent.addEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
		}

		override public function play(_startTime:int = -1):void {
			if (playContent){
				if (_startTime < 0){
					playContent.playVideo();
				} else {
					playContent.videoTime = _startTime * 0.001;
				}
				playContent.volume = volume;
				super.play(_startTime);
			}
		}

		override public function pause():void {
			if (playContent){
				playContent.pauseVideo();
			}
			super.pause();
		}

		override public function stop():void {
			if (playContent){
				playContent.videoTime = 0;
				playContent.pauseVideo();
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
			if (bufferProgress < 1 && playContent){
				onBufferProgressHandler();
			}
			super.onLoadProgressHandler(_evt);
		}

		private function removeContentListener():void {
			if (playContent){
				//卸载playContent
				playContent.removeEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				playContent.removeEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				playContent.removeEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
				playContent.removeEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			}
		}
	}

}