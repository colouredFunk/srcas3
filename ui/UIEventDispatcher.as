package ui{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	import ui.manager.EventManager;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class UIEventDispatcher extends EventDispatcher {
		public var userData:Object;
		private var __isRemoved:Boolean;
		public function get isRemoved():Boolean {
			return __isRemoved;
		}
		public function UIEventDispatcher() {
			init();
		}
		public function remove():void {
			EventManager.removeTargetAllEvent(this);
			for each (var _i:* in userData) {
				delete userData[_i];
			}
			userData = null;
			__isRemoved = true;
		}
		protected function init():void {
			
		}
		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, _useWeakReference);
			EventManager.removeTargetAllEvent(this);
		}
		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			EventManager.removeTargetEvent(_type, _listener, this);
		}
	}
	
}