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
		private var __isPlaying:Boolean = true;
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
			stop();
			mask = null;
			hitArea = null;
			EventManager.removeTargetAllEvent(this);
			UISprite.removeChildren(this);
			for each (var _i:* in userData) {
				delete userData[_i];
			}
			userData = null;
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
		override public function gotoAndPlay(frame:Object, scene:String = null):void {
			super.gotoAndPlay(frame, scene);
			__isPlaying = true;
		}
		override public function gotoAndStop(frame:Object, scene:String = null):void {
			super.gotoAndStop(frame, scene);
			__isPlaying = false;
		}
		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, false);
			EventManager.removeTargetAllEvent(this);
		}
		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			EventManager.removeTargetEvent(_type, _listener, this);
		}
	}
}