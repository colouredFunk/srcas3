package ui{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	import akdcl.utils.destroyObject;
	
	import ui.manager.EventManager;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class UIEventDispatcher extends EventDispatcher {
		public var userData:Object;
		public function UIEventDispatcher() {
			init();
		}
		public function remove():void {
			EventManager.removeTargetAllEvent(this);
			destroyObject(userData);
			userData = null;
		}
		protected function init():void {
			
		}
		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, false);
			EventManager.addTargetEvent(_type, _listener, this);
		}
		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			EventManager.removeTargetEvent(_type, _listener, this);
		}
	}
	
}