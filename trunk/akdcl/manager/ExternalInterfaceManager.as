package akdcl.manager {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	

	/**
	 * ...
	 * @author Akdcl
	 */

	/// @eventType	ExternalInterfaceManager.CALL
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
				ExternalInterface.addCallback(CALL, swfInterface);
			}
		}
		
		public static const CALL:String = "call";

		public static const EXTERNAL_LISTENER:String = "swfEventHandler";
		
		public var objectID:String;
		public var eventParams:Array;
		
		private var swfInterFaceEvent:Event = new Event(CALL);
		
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
				return ExternalInterface.objectID || objectID;
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
			
			if (hasEventListener(CALL)) {
				//addEventListener(ExternalInterfaceManager.CALL);
				dispatchEvent(swfInterFaceEvent);
			}
			if (hasEventListener(__eventType)) {
				var _event:Event = new Event(__eventType);
				//addEventListener(__eventType);
				dispatchEvent(_event);
			}
		}
		
		//广播as调用js的事件
		public function dispatchSWFEvent(_type:String, ... args):void {
			if (isAvailable){
				if (args){
					callInterface.apply(ExternalInterfaceManager, [EXTERNAL_LISTENER, ExternalInterface.objectID||objectID, _type].concat(args));
				} else {
					callInterface(EXTERNAL_LISTENER, ExternalInterface.objectID||objectID, _type);
				}
			}
		}

		public function debugMessage(...args):void {
			callInterface("alert", "[" + (ExternalInterface.objectID||objectID) + "]\r\n" + args);
		}
	}
}