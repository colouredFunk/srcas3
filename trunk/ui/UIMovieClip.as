package ui{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import ui.manager.EventManager;
	import akdcl.utils.destroyObject;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class UIMovieClip extends MovieClip {
		public var userData:Object;
		private var __isPlaying:Boolean = true;
		public function get isPlaying():Boolean {
			return __isPlaying;
		}
		override public function set enabled(_enabled:Boolean):void{
			super.enabled = _enabled;
			mouseEnabled = mouseChildren = _enabled;
		}
		private var __autoRemove:Boolean = true;
		public function get autoRemove():Boolean{
			return __autoRemove;
		}
		public function set autoRemove(_autoRemove:Boolean):void{
			__autoRemove = _autoRemove;
			if (__autoRemove) {
				addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			}else {
				removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			}
		}
		public function UIMovieClip() {
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
			scrollRect = null;
			mask = null;
			hitArea = null;
			contextMenu = null;
			EventManager.removeTargetAllEvent(this);
			UISprite.removeChildren(this);
			destroyObject(userData);
			userData = null;
		}
		public function remove():void {
			if (parent) {
				autoRemove = true;
				parent.removeChild(this);
			}else {
				onRemoveToStageHandler();
			}
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
			EventManager.addTargetEvent(_type, _listener, this);
		}
		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			EventManager.removeTargetEvent(_type, _listener, this);
		}
	}
}