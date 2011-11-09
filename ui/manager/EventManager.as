package ui.manager {
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class EventManager {

		private static var listenerDic:Dictionary = new Dictionary();

		public static function addTargetEvent(_type:String, _listener:Function, _target:*):void {
			if (!listenerDic[_target]){
				listenerDic[_target] = new Dictionary();
			}
			if (!listenerDic[_target][_type]){
				listenerDic[_target][_type] = new Dictionary();
			}
			listenerDic[_target][_type][_listener] = _listener;
		}

		public static function removeTargetEvent(_type:String, _listener:Function, _target:*):void {
			if (listenerDic[_target] && listenerDic[_target][_type]){
				delete listenerDic[_target][_type][_listener];
			}
		}

		public static function removeTargetEventByType(_type:String, _target:*):void {
			if (!listenerDic[_target] || !listenerDic[_target][_type]){
				return;
			}

			for (var _listener:*in listenerDic[_target][_type]){
				_target.removeEventListener(_type, _listener);
			}
			delete listenerDic[_target][_type];
		}

		public static function removeTargetAllEvent(_target:*):void {
			for (var _type:String in listenerDic[_target]){
				removeTargetEventByType(_type, _target);
			}
			delete listenerDic[_target];
		}

		public static function removeAllEvent():void {

		}
	}

}