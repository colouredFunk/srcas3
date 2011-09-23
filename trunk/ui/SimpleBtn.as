package ui{
	import flash.events.Event;
	
	import ui.UISprite;
	import ui.manager.ButtonManager;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class SimpleBtn extends UISprite {
		private static const bM:ButtonManager = ButtonManager.getInstance();
		public var rollOver:Function;
		public var rollOut:Function;
		public var press:Function;
		public var release:Function;
		
		override public function set enabled(_enabled:Boolean):void{
			super.enabled = _enabled;
			if (_enabled) {
				bM.addButton(this);
			}else {
				bM.removeButton(this);
			}
		}
		override protected function init():void {
			super.init();
			enabled = true;
		}
		override protected function onRemoveToStageHandler():void {
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
			enabled = false;
			super.onRemoveToStageHandler();
		}
	}
	
}