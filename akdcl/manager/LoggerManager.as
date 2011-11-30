package akdcl.manager {
	import flash.events.Event;
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

	/// @eventType	akdcl.manager.LoggerManager.LOG_CONNECT
	[Event(name="logConnect",type="akdcl.manager.LoggerManager")]

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

			id = String(int(Math.random() * 10000));

			treeDic = {};
			targetDic = new Dictionary(true);

			localConnection = new LocalConnection();
			localConnection.addEventListener(StatusEvent.STATUS, connectStatusHandler);
			logEvent = new DataEvent(LOG);
			logConnectEvent = new DataEvent(LOG_CONNECT);
		}
		public static const LOG:String = "log";
		public static const LOG_CONNECT:String = "logConnect";

		public static const E_CLASSES:String = "classes";
		public static const E_CLASS:String = "class";
		public static const E_TARGET:String = "target";
		public static const E_LOGS:String = "logs";
		public static const E_LOG:String = "log";

		public static const A_PATH:String = "path";
		public static const A_ID:String = "id";
		public static const A_LEVEL:String = "level";
		public static const A_TIME:String = "time";
		public static const A_MSG:String = "msg";

		private static const LOCAL_CONNECTION_NAME:String = "_loggerManagerConnection";
		private static const CONNECTION_METHOD_NAME:String = "connectionHandler";

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
		
		private static function getClassNode(_xml:XML,_id:String):XML {
			var _result:XML;
			//_xml.elements(E_CLASS).(attribute(A_ID) == _id)[0];
			for each(var _node:XML in _xml.elements(E_CLASS)) {
				if (_node.attribute(A_ID) == _id) {
					_result = _node;
					break;
				}else {
					_result = getClassNode(_node, _id);
					if (_result) {
						break;
					}
				}
			}
			return _result;
		}

		public var id:String;
		
		public var lastTree:XML;
		private var lastTarget:XML;

		private var treeDic:Object;
		private var targetDic:Dictionary;
		private var targetID:uint;
		private var logConnectEvent:DataEvent;

		private var lastLog:Log;
		private var localConnection:LocalConnection;

		private var logEvent:DataEvent;

		private function log(_target:Object, _level:int, _msg:String, _name:String = null, ... _args):void {
			if (!_target || !hasEventListener(LOG)) {
				return;
			}
			var _extendsClass:String;
			var _name:String;
			var _id:String;
			var _describeTypeXML:XML = describeType(_target);
			
			if (_target is Class) {
				_describeTypeXML.factory[0].insertChildBefore(_describeTypeXML.factory.extendsClass[0],<extendsClass type={_describeTypeXML.@name}/>);
				_extendsClass = _describeTypeXML.factory.extendsClass.toXMLString();
				_extendsClass = _extendsClass.split("extendsClass").join(E_CLASS);
				_extendsClass = _extendsClass.split("type").join(A_ID);
			}else if (_describeTypeXML.@name == "global") {
				_describeTypeXML.insertChildBefore(_describeTypeXML.extendsClass[0],<extendsClass type={_describeTypeXML.@name}/>);
				_describeTypeXML.insertChildBefore(_describeTypeXML.extendsClass[0],<extendsClass type={_describeTypeXML.method[0].@uri+"."+_describeTypeXML.method[0].@name}/>);
				_extendsClass = _describeTypeXML.extendsClass.toXMLString();
				_extendsClass = _extendsClass.split("extendsClass").join(E_CLASS);
				_extendsClass = _extendsClass.split("type").join(A_ID);
			}else{
				var _targetLogDic:Object = targetDic[_target];
				if (!_targetLogDic){
					_targetLogDic = targetDic[_target] = { };
					_describeTypeXML.insertChildBefore(_describeTypeXML.extendsClass[0],<extendsClass type={_describeTypeXML.@name}/>);
					
					_extendsClass = _describeTypeXML.extendsClass.toXMLString();
					_extendsClass = _extendsClass.split("extendsClass").join(E_CLASS);
					_extendsClass = _extendsClass.split("type").join(A_ID);
					
					_targetLogDic.extendsClass = _extendsClass;
					_targetLogDic.id = String(targetID++);
					if (_name) {
						_targetLogDic.name = _name;
					}else if ("name" in _target) {
						_targetLogDic.name = _target["name"];
					}else if ("id" in _target) {
						_targetLogDic.name = _target["id"];
					}else {
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

			lastLog = new Log(_extendsClass, _id, _name, _level, _msg);
			
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
			addEventListener(LoggerManager.LOG, onLogHandler);
		}

		public function stopConnect():void {
			removeEventListener(LoggerManager.LOG, onLogHandler);
		}
		
		public function isConnected():Boolean {
			return hasEventListener(LoggerManager.LOG);
		}

		public function startClient():void {
			localConnection.allowDomain("*");
			localConnection.client = {};
			localConnection.client[CONNECTION_METHOD_NAME] = onConnecthandler;
			localConnection.connect(LOCAL_CONNECTION_NAME);
		}
		
		public function stopClient():void {
			localConnection.client[CONNECTION_METHOD_NAME] = null;
			localConnection.client = null;
			localConnection.close();
		}

		private function onLogHandler(_e:DataEvent):void {
			localConnection.send(
				LOCAL_CONNECTION_NAME, 
				CONNECTION_METHOD_NAME, 
				id, 
				lastLog.extendsClass, 
				lastLog.id, 
				lastLog.name, 
				lastLog.level, 
				lastLog.time, 
				lastLog.message
			);
		}

		private function onConnecthandler(_managerID:String, _extends:String, _id:String, _name:String, _level:int, _time:uint, _msg:String, ... args):void {
			if (hasEventListener(LOG_CONNECT)) {
				
				lastTree = treeDic[_managerID];

				if (!lastTree){
					lastTree = treeDic[_managerID] =  <root {A_ID}={_managerID}/>;
					lastTree.appendChild(<{E_CLASSES} {A_ID}={_managerID} {A_PATH}="0"/>);
					lastTree.appendChild(<{E_LOGS}/>);
					lastTree["@" + A_ID] = _managerID;
				}
				
				var _extendsXMLList:XMLList = new XMLList(_extends);
				
				var _length:uint = _extendsXMLList.length();
				var _classRoot:XML = lastTree.elements(E_CLASSES)[0];
				var _classCheck:XML;
				var _eachClass:XML;
				var _path:String;
				
				var _logXML:XML;
				
				for (var _i:int = _length - 1; _i >= 0; _i--) {
					_path = _classRoot["@" + A_PATH];
					_eachClass = _extendsXMLList[_i];
					_classCheck = getClassNode(_classRoot, _eachClass.attribute(A_ID));
					if (_classCheck) {
						_classRoot = _classCheck;
					}else {
						_classRoot.appendChild(_eachClass);
						_classRoot = _eachClass;
						_classRoot["@" + A_PATH] = _path + "|" + _classRoot.childIndex();
					}
				}
				_path = _classRoot["@" + A_PATH];
				
				if (_id) {
					lastTarget = _classRoot.elements(E_TARGET).(attribute("_id") == _id)[0];
					if (!lastTarget){
						lastTarget =  <{E_TARGET}/>;
						lastTarget["@" + A_ID] = _name;
						lastTarget["@" + "_id"] = _id;
						_classRoot.appendChild(lastTarget);
					}
					_path += "|" + lastTarget.childIndex();
				}else {
					_name = _classRoot.attribute(A_ID);
				}
				
				_logXML =  <{E_LOG}/>;
				_logXML["@" + A_PATH] = _path;
				_logXML["@" + A_ID] = _name;
				_logXML["@" + A_LEVEL] = _level;
				_logXML["@" + A_TIME] = _time;
				_logXML["@" + A_MSG] = _msg;
				lastTree.elements(E_LOGS)[0].appendChild(_logXML);
				
				logConnectEvent.data = lastTree.toXMLString();
				dispatchEvent(logConnectEvent);
			}
		}

		private function connectStatusHandler(_e:Event):void {
			
		}
	}
}

import flash.utils.getTimer;

import akdcl.manager.LoggerManager;

class Log {
	public var extendsClass:String;
	public var id:String;
	public var name:String;
	public var level:int;
	public var time:uint;
	public var message:String;

	public function Log(_extends:String, _id:String, _name:String, _level:int, _msg:String){
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