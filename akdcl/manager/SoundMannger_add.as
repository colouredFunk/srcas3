package akdcl.manager {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.SoundLoaderContext;

	import flash.events.Event;
	import flash.net.URLRequest;

	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;

	import akdcl.manager.ElementManager;
	import akdcl.manager.SourceManager;

	import akdcl.interfaces.IPlaylistItem;
	import akdcl.interfaces.IVolume;

	/**
	 * ...
	 * @author ...
	 */

	public class SoundItem {
		private static const ELEMENT_ID:String = "TweenObject_SoundItem";

		private static var eM:ElementManager = ElementManager.getInstance();
		eM.register(ELEMENT_ID, TweenObject);

		public static function setChannelVolume(_channel:SoundChannel, _volume:Number):void {
			var _soundTransform:SoundTransform = _channel.soundTransform;
			_soundTransform.volume = _volume;
			_channel.soundTransform = _soundTransform;
		}

		private var maxVolume:Number = 1;

		private var channelList:Array;

		private var sound:Sound;
		private var channelNow:SoundChannel;

		public function get loadProgress():Number {
			var _loadProgress:Number;
			if (sound) {
				_loadProgress = sound.bytesLoaded / sound.bytesTotal;
			} else {
				_loadProgress = 0;
			}
			return _loadProgress;
		}

		public function get totalTime():uint {
			var _totalTime:uint;
			if (sound){
				_totalTime = sound.length / loadProgress;
			} else {
				_totalTime = 0;
			}
			return _totalTime;
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
				return 0;
			}
		}

		public function set position(_position:uint):void {
			if (channelNow && sound.length > 0){
				//channelNow
				play(_position);
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
			__volume = _volume;
			if (channelNow){
				setChannelVolume(channelNow, __volume * maxVolume);
			}

		}

		public function SoundItem(_sound:Sound, _maxVolume:Number = 1) {
			maxVolume = _maxVolume;
			channelList = [];
			if (_sound){
				sound = _sound;
			}
		}

		public function play(_startTime:Number = -1, _loops:uint = 0, _tempVolume:Number = 1, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundChannel {
			if (!sound){
				return;
			}
			if (_startTime < 0){
				_startTime = 0;
			} else if (_startTime <= 1){
				//0~1（playProgress）
				if (_startTime >= loadProgress){
					_startTime = loadProgress * 0.999;
				}
				_startTime = totalTime * _startTime;
			} else {
				//1~XX（playTime毫秒为单位）
				var _loadTime:uint = totalTime * loadProgress;
				if (_startTime >= _loadTime){
					_startTime = _loadTime * 0.999;
				}
			}

			try {
				var _channel:SoundChannel = sound.play(_startTime, _loops);
				setChannelVolume(_channel, volume * _tempVolume);

				_channel.addEventListener(Event.SOUND_COMPLETE, onSoundChannelEventHandler);
				channelList.push(_channel);
				channelNow = _channel;
				//volume淡入
				if (_tweenIn == 0){

				} else if (_tweenIn <= 1){
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, totalTime * _tweenIn * 0.001, 0, 1, _tempVolume);
				} else {
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, _tweenIn * 0.001, 0, 1, _tempVolume);
				}
				//volume淡出
				if (_tweenOut == 0){

				} else if (_tweenOut <= 1){
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, totalTime * _tweenOut * 0.001, totalTime * (1 - _tweenOut) * 0.001, 0, _tempVolume);
				} else {
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, _tweenOut * 0.001, (totalTime - _tweenOut) * 0.001, 0, _tempVolume);
				}
			} catch (_error:*){

			}
			return _channel;
		}

		public function stop():void {
			removeAllChannel();
		}

		public function remove():void {
			stop();
			sound = null;
			channelNow = null;
			channelList = null;
		}

		private function removeChannel(_channel:SoundChannel):void {
			if (_channel){
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelEventHandler);
				var _id:int = channelList.indexOf(_channel);
				if (_id >= 0){
					channelList.splice(_id, 1);
				}
			}
		}

		private function removeAllChannel():void {
			for each (var _channel:SoundChannel in channelList){
				removeChannel(_channel);
			}
			channelList = [];
			if (channelNow){
				channelNow.stop();
			}
		}

		private function onSoundChannelEventHandler(_evt:Event):void {
			var _channel:SoundChannel = _evt.currentTarget as SoundChannel;
			switch (_evt.type){
				case Event.SOUND_COMPLETE:
					removeChannel(_channel);
					break;
			}
		}
	}
}
import flash.media.SoundChannel;

import com.greensock.easing.Sine;
import com.greensock.TweenLite;

import akdcl.manager.ElementManager;

import akdcl.media.SoundItem;

class TweenObject {
	public var volume:Number = 1;

	private var soundItem:SoundItem;
	private var channel:SoundChannel;
	private var tempVolume:Number = 1;
	private var tweenVars:Object = {volume: 1, overwrite: 0, delay: 0, ease: Sine.easeInOut, onUpdate: onTweenUpdate, onComplete: onTweenComplete};

	public function tweenChannel(_soundItem:SoundItem, _channel:SoundChannel, _tween:Number, _delay:Number = 0, _tweenVolume:Number = 0, _tempVolume:Number = 1):void {
		soundItem = _soundItem;
		channel = _channel;
		tempVolume = _tempVolume;
		tweenVars.delay = _delay;
		tweenVars.volume = _tweenVolume;
		if (_tweenVolume == 1){
			volume = 0;
			onTweenUpdate();
		} else {
			volume = soundItem.volume;
		}

		TweenLite.to(this, _tween, tweenVars);
	}

	private function onTweenUpdate():void {
		SoundItem.setChannelVolume(channel, soundItem.volume * tempVolume * volume);
	}

	private function onTweenComplete():void {
		TweenLite.killTweensOf(this);
		ElementManager.getInstance().recycle(this);
	}
}