package akdcl.manager {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

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
			__isAvailable = ExternalInterface.available && ExternalInterface.objectID;
			if (isAvailable){
				ExternalInterface.addCallback(SWF_INTERFACE, swfInterface);
			}
		}
		
		public static const SWF_INTERFACE:String = "call";

		public static const EXTERNAL_LISTENER:String = "swfEventHandler";

		public var data:*;
		private var __isAvailable:Boolean = false;

		public function get isAvailable():Boolean {
			return __isAvailable;
		}
		
		public function hasInterface(_funName:String):Boolean {
			if (isAvailable){
				return ExternalInterface.call("eval", _funName + "!=" + "null");
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
			var _event:Event = new Event(SWF_INTERFACE);
			if (args) {
				data = [_type].concat(args);
			}else {
				data = [_type];
			}
			//addEventListener(ExternalInterfaceManager.SWF_INTERFACE);
			//_type:eiM.data[0], ...args:eiM.data[1...]
			dispatchEvent(_event);
			//
			_event = new Event(_type);
			if (args) {
				data = args;
			}else {
				data = null;
			}
			//addEventListener(_type);
			//...args:eiM.data
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