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

		public function registerSound(_asID:String, _keyID:String = null, _groupID:String = null):void {
			var _SoundClass:* = getDefinitionByName(_asID);
			var _sound:SoundItem;
			if (_SoundClass){
				_sound = new SoundItem(new _SoundClass() as Sound, true);
			}
			if (!_sound){
				return;
			}
			_sound.volume
			_groupID = _groupID || DEFAULT_GROUP;
			var _soundItems:Object = soundItemsGroup[_groupID];
			if (!_soundItems){
				_soundItems = {};
				soundItemsGroup[_groupID] = _soundItems;
			}
			_soundItems[_asID || _keyID] = _sound;
		}

		public function playSound(_keyID:String, _groupID:String = null, _startTime:Number = 0, _loops:uint = 0, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundItem {
			_groupID = _groupID || DEFAULT_GROUP;
			var _soundItems:Object = soundItemsGroup[_groupID];
			if (_soundItems){
				var _sound:SoundItem = _soundItems[_keyID];
				if (_sound){
					_sound.play(_startTime, _loops, _tweenIn, _tweenOut);
					return _sound;
				}
			}
			return null;
		}
	}

} /*
   import akdcl.media.SoundItem;

   class SoundItems extends Object {
   private var soundDic:Object;
   public function SoundItems() {
   soundDic = { };
   }
   public function registerSound(_sound:SoundItem, _keyID:String):void {
   soundDic[_keyID] = _sound;
   }
   public function getSound(_keyID:String):SoundItem {
   var _sound:SoundItem = soundDic[_keyID];
   return _sound:SoundItem;
   }

 }*/