package ui {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	import ui.manager.EventManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class UISprite extends Sprite {
		public var userData:Object;
		private var __enabled:Boolean = true;

		public function get enabled():Boolean {
			return __enabled;
		}

		public function set enabled(_enabled:Boolean):void {
			mouseEnabled = mouseChildren = _enabled;
			__enabled = _enabled;
		}
		private var __autoRemove:Boolean = true;

		public function get autoRemove():Boolean {
			return __autoRemove;
		}

		public function set autoRemove(_autoRemove:Boolean):void {
			__autoRemove = _autoRemove;
			if (__autoRemove){
				addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			} else {
				removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			}
		}

		public function UISprite(){
			init();
		}

		protected function init():void {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}

		protected function onAddedToStageHandler(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			if (autoRemove){
				addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			}
		}

		private function onRemoveToStageDelayHandler(_evt:Event):void {
			if (stage && stage.focus == this){
				stage.focus = null;
			}
			addEventListener(Event.ENTER_FRAME, onRemoveToStageDelayHandler);
			if (_evt.type == Event.ENTER_FRAME){
				removeEventListener(Event.ENTER_FRAME, onRemoveToStageDelayHandler);
				if (stage){
					return;
				}
				onRemoveToStageHandler();
			}
		}

		protected function onRemoveToStageHandler():void {
			scrollRect = null;
			mask = null;
			hitArea = null;
			contextMenu = null;
			EventManager.removeTargetAllEvent(this);
			removeChildren();
			userData = null;
		}

		public function remove():void {
			if (parent){
				autoRemove = true;
				parent.removeChild(this);
			} else {
				onRemoveToStageHandler();
			}
		}

		private function removeChildren():void {
			var _length:uint = numChildren;
			var _children:*;
			for (var _i:int = _length; _i >= 0; _i--){
				try {
					_children = getChildAt(_i);
				} catch (_ero:*){
				}
				if (_children && contains(_children)){
					if (_children is MovieClip){
						_children.stop();
					}
					removeChild(_children);
				}
			}
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