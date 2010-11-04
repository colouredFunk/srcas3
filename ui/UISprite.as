package ui{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import ui.manager.EventManager;
	
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
		private var __enabled:Boolean = true;
		public function get enabled():Boolean {
			return __enabled;
		}
		public function set enabled(_enabled:Boolean):void{
			mouseEnabled = mouseChildren = _enabled;
			__enabled = _enabled;
		}
		public function UISprite() {
			init();
		}
		public function remove():void {
			if (parent) {
				parent.removeChild(this);
			}
		}
		protected function init():void {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		protected function onAddedToStageHandler(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
		}
		private function onRemoveToStageDelayHandler(_evt:Event):void {
			if (stage && stage.focus == this) {
				stage.focus = null;
			}
			addEventListener(Event.ENTER_FRAME, onRemoveToStageDelayHandler);
			if (_evt.type == Event.ENTER_FRAME) {
				removeEventListener(Event.ENTER_FRAME, onRemoveToStageDelayHandler);
				if (stage) {
					return;
				}
				onRemoveToStageHandler();
			}
		}
		protected function onRemoveToStageHandler():void {
			scrollRect = null;
			mask = null;
			hitArea = null;
			EventManager.removeTargetAllEvent(this);
			removeChildren(this);
			for each (var _i:* in userData) {
				delete userData[_i];
			}
			userData = null;
			__isRemoved = true;
		}
		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, false);
			EventManager.removeTargetAllEvent(this);
		}
		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			EventManager.removeTargetEvent(_type, _listener, this);
		}
		public static function removeChildren(_disObj:*):void {
			var _length:uint = _disObj.numChildren;
			var _children:*;
			for (var _i:int = _length; _i >= 0; _i-- ) {
				try {
					_children = _disObj.getChildAt(_i);
				}catch (_ero:*) {
				}
				if (_children && _disObj.contains(_children)) {
					if (_children is MovieClip) {
						_children.stop();
					}
					_disObj.removeChild(_children);
				}
			}
		}
	}
}