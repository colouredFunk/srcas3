package akdcl.manager {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	flash.events.Event.RESIZE
	[Event(name="resize",type="flash.events.Event")]

	public class WHManager extends EventDispatcher {
		private static var instance:WHManager;

		public static function getInstance():WHManager {
			if (instance){
			} else {
				instance = new WHManager();
			}
			return instance;
		}

		public function WHManager(){
			if (instance){
				throw new Error("ERROR:WHManager Singleton already constructed!");
			}
			instance = this;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			event = new Event(Event.RESIZE);
		}

		private var timer:Timer;
		private var event:Event;

		private var __aspectRatio:Number;

		public function get aspectRatio():Number {
			return __aspectRatio;
		}

		private var __originalAspectRatio:Number;

		public function get originalAspectRatio():Number {
			return __originalAspectRatio;
		}

		private var __scaleStage:Number;

		public function get scaleStage():Number {
			return __scaleStage;
		}

		private var __stageWidth:Number;

		public function get stageWidth():Number {
			return __stageWidth;
		}

		private var __stageHeight:Number;

		public function get stageHeight():Number {
			return __stageHeight;
		}

		private var __originalWidth:Number;

		public function get originalWidth():Number {
			return __originalWidth;
		}

		private var __originalHeight:Number;

		public function get originalHeight():Number {
			return __originalHeight;
		}

		private var __stage:Stage;

		public function get stage():Stage {
			return __stage;
		}

		public function set stage(_stage:Stage):void {
			if (__stage == _stage) {
				return;
			}
			if (__stage) {
				__stage = _stage;
				__originalWidth = __stage.getChildAt(0).loaderInfo.width;
				__originalHeight = __stage.getChildAt(0).loaderInfo.height;
				__originalAspectRatio = __originalWidth / __originalHeight;

				timer.start();
				onTimerHandler(null);
			}else {
				timer.stop();
			}
		}

		private function onTimerHandler(e:TimerEvent):void {
			if (stage.scaleMode == StageScaleMode.SHOW_ALL){
				stage.scaleMode = StageScaleMode.NO_SCALE;
				
				var _sW:uint = stage.stageWidth;
				var _sH:uint = stage.stageHeight;
				__aspectRatio = _sW / _sH;
				if (aspectRatio > originalAspectRatio){
					__scaleStage = originalHeight / _sH;
				} else {
					__scaleStage = originalWidth / _sW;
				}
				_sW = _sW * __scaleStage;
				_sH = _sH * __scaleStage;
				if (_sW != stageWidth || _sH != stageHeight){
					__stageWidth = _sW;
					__stageHeight = _sH;
					dispatchEvent(event);
				}

				stage.scaleMode = StageScaleMode.SHOW_ALL;
			}
		}
	}

}