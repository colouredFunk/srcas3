package akdcl.media {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.Event;

	import com.greensock.TweenLite;
	import com.greensock.easing.Sine

	/**
	 * ...
	 * @author ...
	 */

	public class SoundItem {
		private static function setChannelVolume(_channel:SoundChannel, _volume:Number):void {
			var _soundTransform:SoundTransform = _channel.soundTransform;
			_soundTransform.volume = _volume;
			_channel.soundTransform = _soundTransform;
		}

		public var isMultiplePlay:Boolean = false;
		public var maxVolume:Number = 1;
		
		private var positionLast:uint = 0;
		private var sound:Sound;
		private var soundTransform:SoundTransform;
		private var channelNow:SoundChannel;
		private var channelList:Array;

		public var tweenVolume:Number = 1;

		private var tweenVarsIn:Object;
		private var tweenVarsOut:Object;

		public function get totalTime():uint {
			var _totalTime:uint;
			if (sound){
				_totalTime = sound.length / loadProgress;
			} else {
				_totalTime = 0;
			}
			return _totalTime;
		}

		public function get loadProgress():Number {
			var _loadProgress:Number;
			if (sound){
				_loadProgress = sound.bytesLoaded / sound.bytesTotal;
			} else {
				_loadProgress = 0;
			}
			return _loadProgress;
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
			if (channelNow && sound.length > 0){
				return channelNow.position;
			} else {
				return positionLast;
			}
		}

		public function set position(_position:uint):void {
			if (channelNow && sound.length > 0){
				//removeChannel(_channel);
				//channelNow
				play(_position);
			} else {
				positionLast = _position;
			}
		}
		private var __volume:Number = 1;

		public function get volume():Number {
			return __volume * maxVolume;
		}

		public function set volume(_volume:Number):void {
			if (_volume < 0){
				_volume = 0;
			} else if (_volume > 1){
				_volume = 1;
			}
			__volume = _volume;
			//isMultiplePlay
			if (channelNow){
				setChannelVolume(channelNow, __volume * maxVolume);
			}

		}

		public function SoundItem(_sound:Sound, _isMultiplePlay:Boolean = false){
			isMultiplePlay = _isMultiplePlay;
			tweenVarsIn = {onUpdate: onTweenVolume, onUpdateParams: [], tweenVolume: 1, overwrite: 0, ease: Sine.easeInOut};
			tweenVarsOut = {onUpdate: onTweenVolume, onUpdateParams: [], tweenVolume: 0, overwrite: 0, ease: Sine.easeInOut};
			channelList = [];
			sound = _sound;
			soundTransform = new SoundTransform(volume, 0);
		}

		public function play(_startTime:Number = -1, _loops:uint = 0, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundChannel {
			if (_startTime < 0){
				_startTime = 0;
			} else if (_startTime <= 1){
				//0~1（playProgress）
				if (_startTime > loadProgress){
					_startTime = loadProgress * 0.999;
				}
				_startTime = totalTime * _startTime;
			} else {
				//1~XX（playTime毫秒为单位）
				var _loadTime:uint = totalTime * loadProgress;
				if (_startTime > _loadTime){
					_startTime = _loadTime * 0.999;
				}
			}

			if (positionLast > 0){
				_startTime = positionLast;
			}
			positionLast = 0;

			try {
				//soundTransform.volume = volume * _tempVolume;
				var _channel:SoundChannel = sound.play(_startTime, _loops, soundTransform);
				if (isMultiplePlay){
					_channel.addEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
					channelList.push(_channel);
					channelNow = _channel;
				} else {
					if (channelNow){
						channelNow.stop();
					}
					channelNow = _channel;
				}
				//
				if (_tweenIn == 0){
					tweenVolume = 1;
				} else if (_tweenIn <= 1){
					tweenVolume = 0;
					tweenVarsIn.onUpdateParams[0] = channelNow;
					TweenLite.to(this, totalTime * _tweenIn * 0.001, tweenVarsIn);
					onTweenVolume(_channel);
				} else {
					tweenVolume = 0;
					tweenVarsIn.onUpdateParams[0] = channelNow;
					TweenLite.to(this, _tweenIn * 0.001, tweenVarsIn);
					onTweenVolume(_channel);
				}
				//
				if (_tweenOut == 0){

				} else if (_tweenOut <= 1){
					tweenVarsOut.delay = totalTime * (1 - _tweenOut) * 0.001;
					tweenVarsOut.onUpdateParams[0] = channelNow;
					TweenLite.to(this, totalTime * _tweenOut * 0.001, tweenVarsOut);
				} else {
					tweenVarsOut.delay = (totalTime - _tweenOut) * 0.001;
					tweenVarsOut.onUpdateParams[0] = channelNow;
					TweenLite.to(this, _tweenOut * 0.001, tweenVarsOut);
				}
			} catch (_error:*){

			}
			return _channel;
		}

		public function pause():void {
			positionLast = position;
			removeAllChannel();
		}

		public function stop():void {
			positionLast = 0;
			removeAllChannel();
		}

		private function onTweenVolume(_channel:SoundChannel):void {
			setChannelVolume(_channel, volume * tweenVolume);
		}

		private function removeAllChannel():void {
			for each (var _channel:SoundChannel in channelList){
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
			}
			channelList = [];
			if (channelNow){
				channelNow.stop();
			}
		}

		private function onChannelCompleteHandler(_evt:Event):void {
			var _channel:SoundChannel = _evt.currentTarget as SoundChannel;
			_channel.removeEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
			var _id:int = channelList.indexOf(_channel);
			if (_id >= 0){
				channelList.splice(_id, 1);
			}
		}
	}

}