package akdcl.manager {
	import flash.utils.Dictionary;
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class EventManager extends EventDispatcher{
		private static const ERROR:String = "EventManager Singleton already constructed!";
		private static var instance:EventManager;

		public static function getInstance():EventManager {
			if (instance){
			} else {
				instance = new EventManager();
			}
			return instance;
		}

		public function EventManager(){
			lM = LoggerManager.getInstance();
			if (instance){
				lM.fatal(EventManager, ERROR);
				throw new Error("[ERROR]:" + ERROR);
			}
			instance = this;
			lM.info(EventManager, "init");
			targetMap = new Dictionary();
		}

		private var lM:LoggerManager;

		private var targetMap:Dictionary;

		public function addEvent(_type:String, _listener:Function, _target:EventDispatcher):void {
			if (targetMap[_target] == null) {
				targetMap[_target] = new Object();
			}
			var _listeners:Dictionary = targetMap[_target][_type];
			if (_listeners == null) {
				_listeners = targetMap[_target][_type] = new Dictionary();
			}
			_listeners[_listener] = _listener;
		}

		public function removeEvent(_type:String, _listener:Function, _target:EventDispatcher):void {
			if (targetMap[_target]) {
				var _listeners:Dictionary = targetMap[_target][_type];
				if (_listeners != null) {
					trace("remove", _type,_target);
					delete _listeners[_listener];
				}
			}
		}

		public function removeTargetEventType(_type:String, _target:EventDispatcher):void {
			if (targetMap[_target] != null) {
				var _listeners:Dictionary = targetMap[_target][_type];
			}
			if (_listeners == null) {
				return;
			}
			for each(var _listener:Function in _listeners) {
				_target.removeEventListener(_type, _listener);
			}
			//destroy _listeners
			delete targetMap[_target][_type];
		}

		public function removeTargetEvents(_target:EventDispatcher):void {
			var _targetTypes:Object = targetMap[_target];
			if (_targetTypes != null) {
				var _typeNames:String = "";
				for (var _type:String in _targetTypes) {
					_typeNames += _type + "\n";
					removeTargetEventType(_type, _target);
				}
				delete targetMap[_target];
				lM.info(EventManager, "removeTargetEvents(target:{0})====>>>>\n" + _typeNames, null, _target);
			}
		}
	}

}