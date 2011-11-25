package akdcl.manager {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	import flash.events.Event;
	import flash.events.DataEvent;
	import flash.events.StatusEvent;
	import flash.events.EventDispatcher;

	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

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

			id = "instance(@" + int(Math.random() * 10000) + ")";

			targetDic = new Dictionary(true);
			logList = [];

			localConnection = new LocalConnection();
			localConnection.addEventListener(StatusEvent.STATUS, connectStatusHandler);
			logEvent = new DataEvent(LOG);
			logConnectEvent = new DataEvent(LOG_CONNECT);
		}
		public static const LOG:String = "log";
		public static const LOG_CONNECT:String = "logConnect";

		public static const LOCAL_CONNECTION_NAME:String = "_loggerManagerConnection";
		public static const CONNECTION_METHOD_NAME:String = "connectionHandler";

		public static const E_CLASS:String = "class";
		public static const E_TARGET:String = "target";
		public static const E_LEVEL:String = "level";
		public static const E_LOG:String = "log";

		public static const A_ID:String = "id";
		public static const A_TIME:String = "time";

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

		public var id:String;
		public var clientSource:Object;
		
		public var lastLogSource:XML;
		public var lastLogNode:XML;
		
		public var lastManager:String;
		public var lastClass:String;
		public var lastTarget:String;
		public var lastLevel:int;

		private var targetDic:Dictionary;
		private var logList:Array;
		private var targetID:uint;

		private var lastLog:Log;
		private var localConnection:LocalConnection;

		private var logEvent:DataEvent;
		private var logConnectEvent:DataEvent;


		public function getLastLog():Log {
			return lastLog;
		}

		public function log(_target:Object, _level:int, _msg:String, _id:String = null, ... _args):void {
			if (!_target){
				return;
			}
			if (hasEventListener(LOG)){
				var _class:String = getQualifiedClassName(_target);
				var _targetLogDic:Object = targetDic[_target];
				if (!_targetLogDic){
					_targetLogDic = targetDic[_target] = {};
					if (!_id){
						_id = _class + "(@" + targetID + ")";
						targetID++;
					}
					_targetLogDic.name = _id;
				}

				_id = _targetLogDic.name;

				var _i:uint = 0;
				while (_i < _args.length){
					_msg = _msg.replace(new RegExp("\\{" + _i + "\\}", "g"), _args[_i]);
					_i++;
				}

				lastLog = new Log(_class, _id, _level, _msg);

				logList.unshift(lastLog);
				if (logList.length > 2000){
					logList.pop();
				}
				logEvent.data = String(lastLog);
				dispatchEvent(logEvent);
			}
		}

		public function debug(_target:Object, _msg:String, _id:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, DEBUG, _msg, _id);
				log.apply(this, _args);
			}
		}

		public function info(_target:Object, _msg:String, _id:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, INFO, _msg, _id);
				log.apply(this, _args);
			}
		}

		public function warn(_target:Object, _msg:String, _id:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, WARN, _msg, _id);
				log.apply(this, _args);
			}
		}

		public function error(_target:Object, _msg:String, _id:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, ERROR, _msg, _id);
				log.apply(this, _args);
			}
		}

		public function fatal(_target:Object, _msg:String, _id:String = null, ... _args):void {
			if (hasEventListener(LOG)){
				_args.unshift(_target, FATAL, _msg, _id);
				log.apply(this, _args);
			}
		}

		public function startConnect():void {
			addEventListener(LoggerManager.LOG, onLogHandler);
		}

		public function stopConnect():void {
			removeEventListener(LoggerManager.LOG, onLogHandler);
		}

		public function setClient():void {
			localConnection.allowDomain("*");
			clientSource = {};
			localConnection.client = {};
			localConnection.client[CONNECTION_METHOD_NAME] = onConnecthandler;
			localConnection.connect(LOCAL_CONNECTION_NAME);
		}

		private function onLogHandler(_e:DataEvent):void {
			localConnection.send(LOCAL_CONNECTION_NAME, CONNECTION_METHOD_NAME, id, lastLog.classID, lastLog.targetID, lastLog.level, lastLog.time, lastLog.message);
		}

		private function onConnecthandler(_managerID:String, _class:String, _id:String, _level:int, _time:uint, _msg:String, ... args):void {
			if (hasEventListener(LOG_CONNECT)) {
				lastManager = _managerID;
				lastClass = _class;
				lastTarget = _id;
				lastLevel = _level;
				
				var _classXML:XML;
				var _targetXML:XML;
				var _levelXML:XML;
				
				lastLogSource = clientSource[_managerID];

				if (!lastLogSource){
					lastLogSource = clientSource[_managerID] =  <root/>;
					lastLogSource["@" + A_ID] = _managerID;
				}
				_classXML = lastLogSource.elements(E_CLASS).(attribute(A_ID) == _class)[0];
				if (!_classXML){
					_classXML =  <{E_CLASS}/>;
					_classXML["@" + A_ID] = _class;
					lastLogSource.appendChild(_classXML);
				}
				_targetXML = _classXML.elements(E_TARGET).(attribute(A_ID) == _id)[0];
				if (!_targetXML){
					_targetXML =  <{E_TARGET}/>;
					_targetXML["@" + A_ID] = _id;
					_classXML.appendChild(_targetXML);
				}
				_levelXML = _targetXML.elements(E_LEVEL).(attribute(A_ID) == _level)[0];
				if (!_levelXML){
					_levelXML =  <{E_LEVEL}/>;
					_levelXML["@" + A_ID] = _level;
					_targetXML.appendChild(_levelXML);
				}
				lastLogNode =  <{E_LOG}/>;
				lastLogNode["@" + A_TIME] = _time;
				lastLogNode.appendChild(_msg);
				_levelXML.appendChild(lastLogNode);
				logConnectEvent.data = lastLogSource.toXMLString();
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
	public var classID:String;
	public var targetID:String;
	public var level:int;
	public var time:uint;
	public var message:String;

	public function Log(_class:String, _id:String, _level:int, _msg:String){
		classID = _class;
		targetID = _id;
		level = _level;
		message = _msg;
		time = getTimer();
	}

	public function toString():String {
		var _levelName:String = LoggerManager.LEVEL_NAMES[level];
		var _str:String = targetID + "\n	" + message;
		if (_levelName){
			_str = "[" + _levelName + "] " + _str;
		}
		return _str;
	}
}