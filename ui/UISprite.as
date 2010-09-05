package ui{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class UISprite extends Sprite {
		public var userData:Object;
		private var __isRemoved:Boolean;
		public function get isRemoved():Boolean {
			return __isRemoved;
		}
		public function UISprite() {
			init();
		}
		protected function init():void {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		protected function onAddedToStageHandler(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
		}
		private function onRemoveToStageDelayHandler(_evt:Event):void {
			addEventListener(Event.ENTER_FRAME, onRemoveToStageHandler);
		}
		protected function onRemoveToStageHandler(_evt:Event):void {
			removeEventListener(Event.ENTER_FRAME, onRemoveToStageHandler);
			if (stage) {
				return;
			}
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			userData = null;
			__isRemoved = true;
		}
		public function removeChildren():void {
			var _length:uint = numChildren;
			var _children:*;
			for (var _i:int = _length; _i >= 0; _i-- ) {
				try {
					_children = getChildAt(0);
				}catch (_ero:*) {
					
				}
				if (_children && contains(_children)) {
					removeChild(_children);
				}
			}
		}
	}
}