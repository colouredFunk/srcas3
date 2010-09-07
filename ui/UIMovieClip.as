package ui{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class UIMovieClip extends MovieClip {
		private var listenerDic:Object;
		public var userData:Object;
		private var __isRemoved:Boolean;
		public function get isRemoved():Boolean {
			return __isRemoved;
		}
		public function UIMovieClip() {
			init();
		}
		protected function init():void {
			listenerDic = { };
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
			removeAllEvent();
			removeChildren();
			userData = null;
			__isRemoved = true;
		}
		public function removeChildren():void {
			var _length:uint = numChildren;
			var _children:*;
			for (var _i:int = _length; _i >= 0; _i-- ) {
				try {
					_children = getChildAt(_i);
				}catch (_ero:*) {
					
				}
				if (_children && contains(_children)) {
					removeChild(_children);
				}
			}
		}
		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, false);
			if (!listenerDic[_type]) {
				listenerDic[_type] = new Dictionary();
			}
			listenerDic[_type][_listener] = _listener;
		}
		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			if (listenerDic[_type]) {
				delete listenerDic[_type][_listener];
			}
		}
		public function removeEventByType(_type:String):void {
			if (!listenerDic[_type]) {
				return;
			}
			for (var _listener:* in listenerDic) {
				delete listenerDic[_type][_listener];
			}
			delete listenerDic[_type];
		}
		public function removeAllEvent():void {
			for (var _type:String in listenerDic) {
				removeEventByType(_type);
			}
		}
	}
}