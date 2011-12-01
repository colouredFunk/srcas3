package akdcl.manager {
	import flash.events.DataEvent;
	import flash.events.StatusEvent;
	import flash.events.EventDispatcher;

	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	import flash.utils.describeType;

	/**
	 * ...
	 * @author ...
	 */

	/// @eventType	akdcl.manager.LoggerManager.LOG
	[Event(name="log",type="akdcl.manager.LoggerManager")]

	final public class LoggerManager extends EventDispatcher {
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

			id = String(int(Math.random() * 999999));

			targetDic = new Dictionary(true);

			logEvent = new DataEvent(LOG);

			localConnection = new LocalConnection();
			localConnection.addEventListener(StatusEvent.STATUS, connectStatusHandler);
		}
		
		public static const LOCAL_CONNECTION_NAME:String = "_LoggerConnectManager";
		public static const CONNECTION_METHOD_NAME:String = "connectionHandler";
		
		public static const LOG:String = "log";

		private static const FATAL:int = 99;
		private static const ERROR:int = 9;
		private static const WARN:int = 7;
		private static const INFO:int = 5;
		private static const DEBUG:int = 3;

		public static const LEVEL_NAMES:Object = {};
		LEVEL_NAMES[FATAL] = "FATAL";
		LEVEL_NAMES[ERROR] = "ERROR";
		LEVEL_NAMES[WARN] = "WARN";
		LEVEL_NAMES[INFO] = "INFO";
		LEVEL_NAMES[DEBUG] = "DEBUG";

		private static const E_EXTENDS_CLASS:String = "extendsClass";
		private static const A_TYPE:String = "type";
		private static const A_NAME:String = "name";

		public var id:String;

		private var targetDic:Dictionary;
		private var localConnection:LocalConnection;
		private var logEvent:DataEvent;
		private var lastLog:LogVO;

		private var targetCount:uint;
		private var logConnectCount:uint;

		private var __isConnected:Boolean;
		public function get isConnected():Boolean {
			return __isConnected;
		}

		private function log(_target:Object, _level:int, _msg:String, _name:String = null, ... _args):void {
			if (!_target || !hasEventListener(LOG)){
				return;
			}
			var _extendsClass:String;
			var _name:String;
			var _id:String;
			var _describeTypeXML:XML = describeType(_target);

			if (_target is Class){
				_describeTypeXML.factory[0].insertChildBefore(_describeTypeXML.factory.elements(E_EXTENDS_CLASS)[0],<{E_EXTENDS_CLASS} {A_TYPE}={_describeTypeXML.attribute(A_NAME)}/>);
				_extendsClass = _describeTypeXML.factory.elements(E_EXTENDS_CLASS).toXMLString();
				_extendsClass = _extendsClass.split(E_EXTENDS_CLASS).join("class");
				_extendsClass = _extendsClass.split(A_TYPE).join("id");
			} else if (_describeTypeXML.@name == "global"){
				_describeTypeXML.insertChildBefore(_describeTypeXML.elements(E_EXTENDS_CLASS)[0],<{E_EXTENDS_CLASS} {A_TYPE}={_describeTypeXML.attribute(A_NAME)}/>);
				_describeTypeXML.insertChildBefore(_describeTypeXML.elements(E_EXTENDS_CLASS)[0],<{E_EXTENDS_CLASS} {A_TYPE}={_describeTypeXML.method[0].@uri+"."+_describeTypeXML.method[0].attribute(A_NAME)}/>);
				_extendsClass = _describeTypeXML.elements(E_EXTENDS_CLASS).toXMLString();
				_extendsClass = _extendsClass.split(E_EXTENDS_CLASS).join("class");
				_extendsClass = _extendsClass.split(A_TYPE).join("id");
			} else {
				var _targetLogDic:Object = targetDic[_target];
				if (!_targetLogDic){
					_targetLogDic = targetDic[_target] = {};
					_describeTypeXML.insertChildBefore(_describeTypeXML.elements(E_EXTENDS_CLASS)[0],<{E_EXTENDS_CLASS} {A_TYPE}={_describeTypeXML.attribute(A_NAME)}/>);

					_extendsClass = _describeTypeXML.elements(E_EXTENDS_CLASS).toXMLString();
					_extendsClass = _extendsClass.split(E_EXTENDS_CLASS).join("class");
					_extendsClass = _extendsClass.split(A_TYPE).join("id");

					_targetLogDic.extendsClass = _extendsClass;
					_targetLogDic.id = String(targetCount++);
					if (_name){
						_targetLogDic.name = _name;
					} else if ("name" in _target){
						_targetLogDic.name = _target["name"];
					} else if ("id" in _target){
						_targetLogDic.name = _target["id"];
					} else {
						_targetLogDic.name = _targetLogDic.id;
					}
				}
				_extendsClass = _targetLogDic.extendsClass;
				_id = _targetLogDic.id;
				_name = _targetLogDic.name;
			}

			var _i:uint = 0;
			while (_i < _args.length){
				_msg = _msg.replace(new RegExp("\\{" + _i + "\\}", "g"), _args[_i]);
				_i++;
			}
			lastLog = new LogVO(_extendsClass, _id, _name, _level, _msg);
			
			logEvent.data = String(lastLog);
			dispatchEvent(logEvent);
		}

		public function debug(_target:Object, _msg:String, _name:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, DEBUG, _msg, _name);
				log.apply(this, _args);
			}
		}

		public function info(_target:Object, _msg:String, _name:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, INFO, _msg, _name);
				log.apply(this, _args);
			}
		}

		public function warn(_target:Object, _msg:String, _name:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, WARN, _msg, _name);
				log.apply(this, _args);
			}
		}

		public function error(_target:Object, _msg:String, _name:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, ERROR, _msg, _name);
				log.apply(this, _args);
			}
		}

		public function fatal(_target:Object, _msg:String, _name:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, FATAL, _msg, _name);
				log.apply(this, _args);
			}
		}

		public function startConnect():void {
			__isConnected = true;
			addEventListener(LoggerManager.LOG, onLogHandler);
		}

		public function stopConnect():void {
			__isConnected = false;
			removeEventListener(LoggerManager.LOG, onLogHandler);
		}

		private function onLogHandler(_e:DataEvent):void {
			logConnectCount++;
			localConnection.send(
				LOCAL_CONNECTION_NAME, 
				CONNECTION_METHOD_NAME, 
				id, 
				logConnectCount, 
				lastLog.extendsClass, 
				lastLog.id, 
				lastLog.name, 
				lastLog.level, 
				lastLog.time, 
				lastLog.message
			);
		}

		private function connectStatusHandler(_e:StatusEvent):void {
			if (_e.level == "status"){
			}
		}
	}
}

import flash.utils.getTimer;

import akdcl.manager.LoggerManager;

class LogVO {
	public var extendsClass:String;
	public var id:String;
	public var name:String;
	public var level:int;
	public var time:uint;
	public var message:String;

	public function LogVO(_extends:String, _id:String, _name:String, _level:int, _msg:String){
		extendsClass = _extends;
		id = _id;
		name = _name;
		level = _level;
		message = _msg;
		time = getTimer();
	}

	public function toString():String {
		var _levelName:String = LoggerManager.LEVEL_NAMES[level];
		var _str:String = name + "\n	" + message;
		if (_levelName){
			_str = "[" + _levelName + "] " + _str;
		}
		return _str;
	}
}