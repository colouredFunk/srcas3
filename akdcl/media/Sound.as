package akdcl.media
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Sound extends flash.media.Sound 
	{
		public static var soundDic:Object = { };
		public static function loadSound(_source:String):akdcl.media.Sound {
			var _sound:akdcl.media.Sound = soundDic[_source];
			if (!_sound) {
				_sound = new akdcl.media.Sound(_source);
			}
			return _sound;
		}
		public static function playSound(_source:String, _position:uint = 0, _soundTransform:SoundTransform = null):void {
			var _sound:akdcl.media.Sound = loadSound(_source);
			_sound.play(_position, 0, _soundTransform);
		}
		public var userData:Object;
		protected var soundChannel:SoundChannel;
		public function Sound(_source:String = null) {
			if (_source) {
				this.loadSound(_source);
			}
		}
		public function get loaded():Number {
			var _loaded:Number = bytesLoaded / bytesTotal;
			if (isNaN(_loaded)) {
				_loaded = 0;
			}
			return _loaded;
		}
		public function get played():Number {
			var _played:Number = position / totalTime;
			if (isNaN(_played)) {
				_played = 0;
			}
			return _played;
		}
		public function get totalTime():uint {
			return length / loaded;
		}
		public function get position():uint {
			if (soundChannel) {
				return soundChannel.position;
			}else {
				return 0;
			}
		}
		private var __volume:Number;
		public function get volume():Number{
			return __volume;
		}
		public function set volume(_volume:Number):void {
			if (_volume<0) {
				_volume = 0;
			}else if (_volume>1) {
				_volume=1
			}else if (_volume==__volume) {
				return;
			}
			__volume = _volume;
			setVolume(__volume);
		}
		protected function setVolume(_volume:Number):void  {
			if(soundChannel) {
				var _trans:SoundTransform = soundChannel.soundTransform;
				_trans.volume = _volume;
				soundChannel.soundTransform = _trans;
			}
		}
		public function stop(_isClose:Boolean = true):void {
			removeChannel();
			if (_isClose) {
				try {
					close();
				}catch (_ero:*) {
					//return;
				}
				//removeFrom?
			}
		}
		public function loadSound(_source:String):akdcl.media.Sound {
			soundDic[_source] = this;
			load(new URLRequest(_source), new SoundLoaderContext(1000, true));
			return this;
		}
		override public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel 
		{
			var _soundChannel:SoundChannel = super.play(startTime, loops, sndTransform);
			addChannel(_soundChannel);
			return _soundChannel;
		}
		protected function addChannel(_soundChannel:SoundChannel):void {
			removeChannel();
			soundChannel = _soundChannel;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundPlayCompleteHandle);
		}
		protected function removeChannel():void {
			if (soundChannel) {
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundPlayCompleteHandle);
			}
		}
		protected function onSoundPlayCompleteHandle(_evt:Event):void {
			dispatchEvent(new Event(_evt.type));
		}
	}
}