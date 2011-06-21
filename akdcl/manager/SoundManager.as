package akdcl.manager {
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;

	import akdcl.media.SoundItem;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class SoundManager {
		private static var instance:SoundManager;

		public static function getInstance():SoundManager {
			if (instance){
			} else {
				instance = new SoundManager();
			}
			return instance;
		}

		public function SoundManager(){
			if (instance){
				throw new Error("ERROR:SoundManager Singleton already constructed!");
			}
			instance = this;
			//
			soundItemsGroup = {};
		}

		private var soundItemsGroup:Object;
		private static const DEFAULT_GROUP:String = "EFS";

		public function registerSound(_asID:String, _keyID:String = null, _groupID:String = null, _maxVolume:Number = 1):void {
			var _SoundClass:* = getDefinitionByName(_asID);
			var _sound:SoundItem;
			if (_SoundClass){
				_sound = new SoundItem(new _SoundClass() as Sound, _maxVolume);
			}
			if (!_sound){
				return;
			}
			_groupID = _groupID || DEFAULT_GROUP;
			var _soundItems:SoundItems = soundItemsGroup[_groupID];
			if (!_soundItems){
				_soundItems = new SoundItems();
				soundItemsGroup[_groupID] = _soundItems;
			}
			_soundItems.registerSound(_sound, _asID || _keyID);
		}

		public function getVolume(_groupID:String = null):Number {
			_groupID = _groupID || DEFAULT_GROUP;
			var _soundItems:SoundItems = soundItemsGroup[_groupID];
			if (_soundItems){
				return _soundItems.getVolume();
			}
			return 1;
		}

		public function setVolume(_volume:Number, _groupID:String = null):void {
			_groupID = _groupID || DEFAULT_GROUP;
			var _soundItems:SoundItems = soundItemsGroup[_groupID];
			if (_soundItems){
				_soundItems.setVolume(_volume);
			}
		}

		public function playSound(_keyID:String, _groupID:String = null, _startTime:Number = 0, _loops:uint = 0, _tempVolume:Number = 1, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundItem {
			_groupID = _groupID || DEFAULT_GROUP;
			var _soundItems:SoundItems = soundItemsGroup[_groupID];
			if (_soundItems){
				var _sound:SoundItem = _soundItems.getSound(_keyID);
				if (_sound){
					_sound.play(_startTime, _loops, _tempVolume, _tweenIn, _tweenOut);
					return _sound;
				}
			}
			return null;
		}
	}

}

import akdcl.media.SoundItem;

class SoundItems extends Object {
	private var volume:Number = 1;
	private var soundDic:Object = {};

	public function registerSound(_sound:SoundItem, _keyID:String):void {
		soundDic[_keyID] = _sound;
		_sound.volume = volume;
	}

	public function getSound(_keyID:String):SoundItem {
		var _sound:SoundItem = soundDic[_keyID];
		return _sound;
	}

	public function getVolume():Number {
		return volume;
	}

	public function setVolume(_volume:Number):void {
		volume = _volume;
		for each (var _sound:SoundItem in soundDic){
			_sound.volume = volume;
		}

	}
}