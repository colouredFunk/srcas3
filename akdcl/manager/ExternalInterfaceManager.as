﻿package akdcl.manager {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	

	/**
	 * ...
	 * @author Akdcl
	 */

	/// @eventType	ExternalInterfaceManager.SWF_INTERFACE
	[Event(name = "call", type = "ExternalInterfaceManager")]
	
	final public class ExternalInterfaceManager extends EventDispatcher {
		public static var instance:ExternalInterfaceManager;

		public static function getInstance():ExternalInterfaceManager {
			if (instance){
			}else {
				instance = new ExternalInterfaceManager();
			}
			return instance;
		}

		public function ExternalInterfaceManager(){
			if (instance){
				throw new Error("ERROR:ExternalInterfaceManager Singleton already constructed!");
			}
			instance = this;
			
			if (Security.sandboxType == Security.LOCAL_WITH_FILE) {
				__isAvailable = false;
			}else {
				try {
					ExternalInterface.call("window.location.href.toString");
					__isAvailable = true;
				}catch (_e:Error) {
					__isAvailable = false;
				}
			}
			if (isAvailable){
				ExternalInterface.addCallback(SWF_INTERFACE, swfInterface);
			}
		}
		
		public static const SWF_INTERFACE:String = "call";

		public static const EXTERNAL_LISTENER:String = "swfEventHandler";
		
		public var eventParams:Array;
		
		private var swfInterFaceEvent:Event = new Event(SWF_INTERFACE);
		
		private var __isAvailable:Boolean = false;
		public function get isAvailable():Boolean {
			return __isAvailable;
		}
		
		private var __eventType:String = null;
		public function get eventType():String {
			return __eventType;
		}
		
		public function hasInterface(_funName:String):Boolean {
			if (isAvailable) {
				//ExternalInterface.call("eval", _funName + "!=" + "null");
				return true;
			}
			return false;
		}

		public function callInterface(_funName:String, ... args):* {
			if (isAvailable && hasInterface(_funName)){
				if (args){
					return ExternalInterface.call.apply(ExternalInterface, [_funName].concat(args));
				}
				return ExternalInterface.call(_funName);
			}
		}
		
		//广播js调用as的事件
		private function swfInterface(_type:String,...args):void {
			__eventType = _type;
			if (args) {
				eventParams = args;
			}else {
				eventParams = null;
			}
			
			//addEventListener(ExternalInterfaceManager.SWF_INTERFACE);
			dispatchEvent(swfInterFaceEvent);
			
			var _event:Event = new Event(__eventType);
			//addEventListener(__eventType);
			dispatchEvent(_event);
		}
		
		//广播as调用js的事件
		public function dispatchSWFEvent(_type:String, ... args):void {
			if (isAvailable){
				if (args){
					callInterface.apply(ExternalInterfaceManager, [EXTERNAL_LISTENER, ExternalInterface.objectID, _type].concat(args));
				} else {
					callInterface(EXTERNAL_LISTENER, ExternalInterface.objectID, _type);
				}
			}
		}

		public function debugMessage(...args):void {
			callInterface("alert", "[" + ExternalInterface.objectID + "]\r\n" + args);
		}
	}
}