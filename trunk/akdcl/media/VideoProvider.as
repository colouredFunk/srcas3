package akdcl.media {

	import flash.geom.Rectangle;
	
	import com.greensock.loading.VideoLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;

	import akdcl.manager.SourceManager;

	/**
	 * ...
	 * @author akdcl
	 */
	final public class VideoProvider extends MediaProvider {
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
		
		override public function set volume(value:Number):void {
			super.volume = value;
			if (playContent){
				playContent.volume = volume;
			}
		}
		
		private var __container:DisplayRect;
		public function set container(_container:DisplayRect):void {
			if (_container){
				if (playContent && playContent.content){
					_container.setContent(playContent.content);
				}
			} else if (__container) {
				__container.setContent();
			}
			__container = _container;
		}

		override public function remove():void {
			removeContentListener();
			super.remove();
		}

		override public function load(_item:*):void {
			var _source:String;
			if (_item is PlayItem) {
				_source = _item.source;
			}else {
				_source = _item;
			}
			
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
				onLoadCompleteHandler();
				if (__container) {
					__container.setContent(playContent.content);
				}
			} else {
				playContent.addEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				playContent.addEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
				playContent.addEventListener(LoaderEvent.INIT, onVideoInitHandler);
				playContent.addEventListener(VideoLoader.VIDEO_BUFFER_EMPTY, onBufferProgressHandler);
				playContent.addEventListener(VideoLoader.VIDEO_BUFFER_FULL, onBufferProgressHandler);
			}
			playContent.addEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			super.load(_item);
		}

		private function onVideoInitHandler(_e:LoaderEvent):void {
			playContent.removeEventListener(LoaderEvent.INIT, onVideoInitHandler);
			if (__container) {
				__container.setContent(playContent.content);
			}
		}
		
		override public function play(_startTime:int = -1):void {
			if (playContent){
				if (_startTime < 0){
					playContent.playVideo();
				} else {
					playContent.videoTime = _startTime * 0.001;
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
			if (bufferProgress < 1 && playContent) {
				onBufferProgressHandler();
			}
			super.onLoadProgressHandler(_evt);
		}

		override protected function onPlayCompleteHandler(_evt:* = null):void {
			removeContentListener();
			playContent.videoTime = 0;
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
				playContent.removeEventListener(VideoLoader.VIDEO_BUFFER_EMPTY, onBufferProgressHandler);
				playContent.removeEventListener(VideoLoader.VIDEO_BUFFER_FULL, onBufferProgressHandler);
			}
		}
	}

}