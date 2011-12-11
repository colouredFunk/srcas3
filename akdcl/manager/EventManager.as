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
			lM.info(_target, "addEvent(type:{0})", null, _type);
			_listeners[_listener] = _listener;
		}

		public function removeEvent(_type:String, _listener:Function, _target:EventDispatcher):void {
			if (targetMap[_target]) {
				var _listeners:Dictionary = targetMap[_target][_type];
				if (_listeners != null) {
					delete _listeners[_listener];
				}
			}
		}

		public function removeTargetEventType(_type:String, _target:EventDispatcher):Boolean {
			if (targetMap[_target] != null) {
				var _listeners:Dictionary = targetMap[_target][_type];
			}
			if (_listeners == null) {
				return false;
			}
			var _removed:Boolean;
			for each(var _listener:Function in _listeners) {
				_removed = true;
				_target.removeEventListener(_type, _listener);
			}
			//destroy _listeners
			delete targetMap[_target][_type];
			return _removed;
		}

		public function removeTargetEvents(_target:EventDispatcher):void {
			var _targetTypes:Object = targetMap[_target];
			if (_targetTypes != null) {
				var _typeNames:String = "";
				for (var _type:String in _targetTypes) {
					if (removeTargetEventType(_type, _target)) {
						_typeNames += _type + "\n";
					}
				}
				delete targetMap[_target];
				lM.info(_target, "removeAllEvents====>>>>\n" + _typeNames);
			}
		}
	}

}