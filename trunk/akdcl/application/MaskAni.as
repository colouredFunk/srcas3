package akdcl.application
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import ui.UIMovieClip;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MaskAni extends UIMovieClip
	{
		public static var maskAniLayer:DisplayObjectContainer;
		public var speed:uint = 1;
		public var delay:uint = 0;
		public var onUpdate:Function;
		public var onComplete:Function;
		public var autoRemove:Boolean = true;
		public var playBack:Boolean;
		private var isTempAsBmp:Boolean;
		private var masked:DisplayObject;
		
		
		
		
		override protected function init():void {
			super.init();
			stop();
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			if (masked) {
				masked.mask = null;
				if (isTempAsBmp) {
					masked.cacheAsBitmap = false;
				}
			}
			masked = null;
			onComplete = null;
			onUpdate = null;
		}
		private var __enabledMask:Boolean;
		public function get enabledMask():Boolean {
			return __enabledMask;
		}
		public function set enabledMask(_enabledMask:Boolean):void {
			__enabledMask = _enabledMask;
			if (masked) {
				if (__enabledMask) {
					masked.mask = this;
				}else {
					masked.mask = null;
				}
			}
		}
		public function toMask(_masked:DisplayObject, _isMask:Boolean = true, _isCacheAsBitmap:Boolean = true ,_rect:Rectangle=null):void {
			masked = _masked;
			if (_isCacheAsBitmap&&!masked.cacheAsBitmap) {
				isTempAsBmp = true;
			}
			cacheAsBitmap = _isCacheAsBitmap;
			masked.cacheAsBitmap = _isCacheAsBitmap;
			if (_isMask) {
				_masked.mask = this;
			}
			if (playBack) {
				gotoAndStop(totalFrames);
			}
			maskAniLayer = maskAniLayer?maskAniLayer:_masked.parent;
			maskAniLayer.addChild(this);
			
			_rect = _rect?_rect:masked.getRect(maskAniLayer);
			x = _rect.x;
			y = _rect.y;
			width = _rect.width;
			height = _rect.height;
			addEventListener(Event.ENTER_FRAME, runStep);
		}
		private function runStep(_evt:Event):void {
			if (delay>0) {
				delay--;
				return;
			}
			for (var _i:uint; _i<speed; _i++) {
				if (playBack) {
					prevFrame();
				}else {
					nextFrame();
				}
			}
			if (onUpdate!=null) {
				onUpdate();
			}
			if (playBack?(currentFrame == 1):(currentFrame == totalFrames)) {
				if (autoRemove) {
					remove();
				}else {
					removeEventListener(Event.ENTER_FRAME, runStep);
				}
				if (onComplete != null) {
					onComplete(masked);
				}
			}
		}
	}
	
}