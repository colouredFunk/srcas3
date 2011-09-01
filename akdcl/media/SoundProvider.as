package akdcl.media {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	import flash.net.URLRequest;

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	import akdcl.manager.SourceManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class SoundProvider extends MediaProvider {
		private static var sM:SourceManager = SourceManager.getInstance();
		private static var REQUEST:URLRequest = new URLRequest();

		private static function setChannelVolume(_channel:SoundChannel, _volume:Number):void {
			var _soundTransform:SoundTransform = _channel.soundTransform;
			_soundTransform.volume = _volume;
			_channel.soundTransform = _soundTransform;
		}

		private var channel:SoundChannel;

		private var pausePosition:uint = 0;

		override public function get loadProgress():Number {
			return (playContent && playContent.bytesTotal > 0) ? (playContent.bytesLoaded / playContent.bytesTotal) : 0;
		}

		override public function get totalTime():uint {
			return (playContent && loadProgress > 0) ? (playContent.length / loadProgress) : 0;
		}

		override public function get bufferProgress():Number {
			return Math.min((totalTime * loadProgress - position) / SoundMixer.bufferTime * 1000, 1);
		}

		override public function get position():uint {
			return channel ? channel.position : 0;
		}
		
		override public function set volume(value:Number):void {
			super.volume = value;
			if (channel){
				setChannelVolume(channel, volume);
			}
		}

		override public function remove():void {
			removeContentListener();
			super.remove();
		}

		override public function load(_source:String):void {
			super.load(_source);
			removeContentListener();
			playContent = sM.getSource(SourceManager.SOUND_GROUP, _source);
			if (playContent){
			} else {
				playContent = new Sound();
				sM.addSource(SourceManager.SOUND_GROUP, _source, playContent);
				REQUEST.url = _source;
				playContent.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
				playContent.load(REQUEST);
			}
			if (loadProgress >= 1){
				//playContent已经加载完毕
				onLoadProgressHandler();
				onLoadCompleteHandler();
			} else {
				playContent.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
				playContent.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			}
		}

		override public function play(_startTime:int = -1):void {
			if (playContent){
				removeChannel();
				if (_startTime < 0 && pausePosition > 0){
					_startTime = pausePosition;
				}
				pausePosition = 0;
				channel = playContent.play(Math.min(_startTime, 0));
				setChannelVolume(channel, volume);
				channel.addEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
				super.play(_startTime);
			}
		}

		override public function pause():void {
			pausePosition = position;
			removeChannel();
			super.pause();
		}

		override public function stop():void {
			pausePosition = 0;
			removeChannel();
			super.stop();
		}

		override protected function onLoadErrorHandler(_evt:* = null):void {
			removeContentListener();
			sM.removeSource(SourceManager.SOUND_GROUP, playContent);
			playContent = null;
			super.onLoadErrorHandler(_evt);
		}

		override protected function onLoadProgressHandler(_evt:* = null):void {
			//探测buffer
			super.onLoadProgressHandler(_evt);
		}

		private function removeContentListener():void {
			if (playContent){
				//卸载playContent
				playContent.removeEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
				playContent.removeEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
				playContent.removeEventListener(Event.COMPLETE, onLoadCompleteHandler);
			}
		}

		private function removeChannel():void {
			if (channel){
				channel.stop();
				channel.removeEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
			}
			channel = null;
		}
	}

}