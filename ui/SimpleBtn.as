package ui {
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

		override public function set enabled(_enabled:Boolean):void {
			super.enabled = _enabled;
			buttonMode = _enabled;
		}

		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			if (enabled) {
				buttonMode = true;
				bM.addButton(this);
			}
		}

		override protected function onRemoveToStageHandler():void {
			bM.removeButton(this);
			super.onRemoveToStageHandler();
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
		}
	}

}