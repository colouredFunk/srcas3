package ui{
	import ui.UISprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class SimpleBtn extends UISprite {
		public var rollOver:Function;
		public var rollOut:Function;
		public var press:Function;
		public var release:Function;
		private var __buttonEnabled:Boolean;
		public function get buttonEnabled():Boolean{
			return __buttonEnabled;
		}
		public function set buttonEnabled(_buttonEnabled:Boolean):void{
			__buttonEnabled = _buttonEnabled;
			if (__buttonEnabled) {
				ButtonManager.addButton(this);
			}else {
				ButtonManager.removeButton(this);
			}
		}
		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			buttonEnabled = true;
		}
		override protected function onRemoveToStageHandler():void {
			buttonEnabled = false;
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
			super.onRemoveToStageHandler();
		}
	}
	
}