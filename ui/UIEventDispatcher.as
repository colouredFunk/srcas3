package ui {
	import flash.events.EventDispatcher;
	import flash.events.Event;

	import akdcl.manager.LoggerManager;
	import akdcl.manager.EventManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class UIEventDispatcher extends EventDispatcher {
		protected static const lM:LoggerManager = LoggerManager.getInstance();
		protected static const evtM:EventManager = EventManager.getInstance();
		public var userData:Object;

		public function UIEventDispatcher(){
			init();
		}

		public function remove():void {
			lM.info(this, "remove");
			evtM.removeTargetEvents(this);
			userData = null;
		}

		protected function init():void {
			lM.info(this, "init");
		}

		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, false);
			evtM.addEvent(_type, _listener, this);
		}

		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			evtM.removeEvent(_type, _listener, this);
		}
	}

}