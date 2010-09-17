package ui{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class UIMovieClip extends MovieClip {
		public var userData:Object;
		private var __isRemoved:Boolean;
		public function get isRemoved():Boolean {
			return __isRemoved;
		}
		private var __isPlaying:Boolean;
		public function get isPlaying():Boolean {
			return __isPlaying;
		}
		override public function set enabled(_enabled:Boolean):void{
			super.enabled = _enabled;
			mouseEnabled = mouseChildren = _enabled;
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
			stop();
			hitArea = null;
			removeAllEvent();
			removeChildren(this);
			for each (var _i:* in userData) {
				delete userData[_i];
			}
			userData = null;
			listenerDic = null;
			__isRemoved = true;
		}
		override public function play():void {
			super.play();
			__isPlaying = true;
		}
		override public function stop():void {
			super.stop();
			__isPlaying = false;
		}
		override public function gotoAndStop(frame:Object, scene:String = null):void {
			super.gotoAndStop(frame, scene);
			__isPlaying = false;
		}
		private var listenerDic:Object;
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
			for each(var _listener:* in listenerDic[_type]) {
				removeEventListener(_type, _listener);
			}
			delete listenerDic[_type];
		}
		public function removeAllEvent():void {
			for (var _type:String in listenerDic) {
				removeEventByType(_type);
			}
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
					_disObj.removeChild(_children);
				}
			}
		}
	}
}