package akdcl.media
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/// @eventType	flash.events.Event.SOUND_COMPLETE
	[Event(name="soundComplete", type="flash.events.Event")] 
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Sound extends flash.media.Sound 
	{
		protected static var soundDic:Object = { };
		public static function loadSound(_source:String):akdcl.media.Sound {
			var _sound:akdcl.media.Sound = soundDic[_source];
			if (!_sound) {
				_sound = new akdcl.media.Sound(_source);
			}
			return _sound;
		}
		protected static function removeSound(_sound:akdcl.media.Sound):void {
			for (var _source:String in soundDic) {
				if (soundDic[_source]==_sound) {
					delete soundDic[_source];
					break;
				}
			}
		}
		protected var soundChannel:SoundChannel;
		public function Sound(_source:String = null) {
			if (_source) {
				this.loadSound(_source);
			}
		}
		public function get loadProgress():Number {
			var _loadProgress:Number = bytesLoaded / bytesTotal;
			if (isNaN(_loadProgress)) {
				_loadProgress = 0;
			}
			return _loadProgress;
		}
		public function get playProgress():Number {
			var _playProgress:Number = position / totalTime;
			if (isNaN(_playProgress)) {
				_playProgress = 0;
			}
			return _playProgress;
		}
		public function set playProgress(_playProgress:Number):void {
			position = _playProgress * totalTime;
		}
		public function get totalTime():uint {
			return length / loadProgress;
		}
		public function get position():uint {
			if (soundChannel) {
				return soundChannel.position;
			}else {
				return 0;
			}
		}
		public function set position(_position:uint):void {
			if (soundChannel) {
				stop();
			}
			play(_position);
		}
		private var __volume:Number = 0.8;
		public function get volume():Number{
			return __volume;
		}
		public function set volume(_volume:Number):void {
			if (_volume<0) {
				_volume = 0;
			}else if (_volume>1) {
				_volume=1
			}
			__volume = _volume;
			if(soundChannel) {
				var _trans:SoundTransform = soundChannel.soundTransform;
				_trans.volume = _volume;
				soundChannel.soundTransform = _trans;
			}
		}
		public function loadSound(_source:String):akdcl.media.Sound {
			soundDic[_source] = this;
			addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
			load(new URLRequest(_source), new SoundLoaderContext(1000, true));
			return this;
		}
		override public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel {
			if (startTime > totalTime * loadProgress) {
				startTime = totalTime * loadProgress * 0.99;
			}
			if (positionPause > 0 && startTime == 0) {
				startTime = positionPause;
			}
			positionPause = 0;
			try {
				var _soundChannel:SoundChannel = super.play(startTime, loops, sndTransform);
			}catch (_error:*) {
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				return null;
			}
			addChannel(_soundChannel);
			return _soundChannel;
		}
		protected var positionPause:uint;
		public function pause():void {
			positionPause = positionPause?positionPause:position;
			removeChannel(soundChannel);
		}
		public function stop(_isClose:Boolean = false):void {
			positionPause = 0;
			removeChannel(soundChannel);
			soundChannel = null;
			if (_isClose) {
				try {
					close();
					removeSound(this);
				}catch (_ero:*) {
				}
			}
		}
		protected function addChannel(_soundChannel:SoundChannel):void {
			removeChannel(soundChannel);
			soundChannel = _soundChannel;
			volume = volume;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandle);
		}
		protected function removeChannel(_soundChannel:SoundChannel):void {
			if (_soundChannel) {
				_soundChannel.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandle);
			}
		}
		protected function onLoadErrorHandler(_evt:IOErrorEvent):void {
			removeSound(this);
		}
		protected function onPlayCompleteHandle(_evt:Event):void {
			dispatchEvent(new Event(_evt.type));
		}
	}
}