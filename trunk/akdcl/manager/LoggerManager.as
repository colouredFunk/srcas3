package akdcl.manager {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author ...
	 */
	final public class LoggerManager {
		private static var instance:LoggerManager;

		public static function getInstance():LoggerManager {
			if (instance){
			} else {
				instance = new LoggerManager();
			}
			return instance;
		}

		public function LoggerManager(){
			if (instance){
				throw new Error("ERROR:LoggerManager Singleton already constructed!");
			}
			instance = this;

			classGroup = new Dictionary();
		}

		private static const FATAL:int = 999;
		private static const ERROR:int = 9;
		private static const WARN:int = 7;
		private static const INFO:int = 5;
		private static const DEBUG:int = 3;

		private var classGroup:Dictionary;

		public function log(_target:Object, _level:int, _msg:String, ... _args):void {
			if (!_target) {
				return;
			}
			var _i:uint = 0;
			while (_i < _args.length){
				_msg = _msg.replace(new RegExp("\\{" + _i + "\\}", "g"), _args[_i]);
				_i++;
			}
			var _class:Class = _target.constructor as Class;
			if (!classGroup[_class]) {
				classGroup[_class] = new Dictionary();
			}
			if (!classGroup[_class][_target]) {
				
			}
		}

		public function debug(_target:Object, _msg:String, ... _args):void {
			_args.unshift(_target, DEBUG, _msg);
			log.apply(this, _args);
		}

		public function info(_target:Object, _msg:String, ... _args):void {
			_args.unshift(_target, INFO, _msg);
			log.apply(this, _args);
		}

		public function warn(_target:Object, _msg:String, ... _args):void {
			_args.unshift(_target, WARN, _msg);
			log.apply(this, _args);
		}

		public function error(_target:Object, _msg:String, ... _args):void {
			_args.unshift(_target, ERROR, _msg);
			log.apply(this, _args);
		}

		public function fatal(_target:Object, _msg:String, ... _args):void {
			_args.unshift(_target, FATAL, _msg);
			log.apply(this, _args);
		}
	}
}