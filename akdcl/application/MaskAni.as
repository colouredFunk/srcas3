package akdcl.application
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MaskAni extends MovieClip
	{
		public static var maskAniLayer:DisplayObjectContainer;
		public var speed:uint = 1;
		public var delay:uint = 0;
		private var isTempAsBmp:Boolean;
		private var masked:DisplayObject;
		public var onComplete:Function;
		public var onUpdate:Function;
		public function MaskAni() {
			stop();
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		private function removed(_evt:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removed);
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
			this.cacheAsBitmap = _isCacheAsBitmap;
			masked.cacheAsBitmap = _isCacheAsBitmap;
			if (_isMask) {
				_masked.mask = this;
			}
			
			maskAniLayer = maskAniLayer?maskAniLayer:_masked.parent;
			maskAniLayer.addChild(this);
			
			_rect = _rect?_rect:masked.getRect(maskAniLayer);
			x = _rect.x;
			y = _rect.y;
			width = _rect.width;
			height = _rect.height;
			this.addEventListener(Event.ENTER_FRAME, runStep);
		}
		private function runStep(_evt:Event):void {
			if (delay>0) {
				delay--;
				return;
			}
			for (var _i:uint; _i<speed; _i++) {
				nextFrame();
			}
			if (onUpdate!=null) {
				onUpdate();
			}
		}
		public function remove():void {
			masked.mask=null;
			if (isTempAsBmp) {
				masked.cacheAsBitmap = false;
			}
			if (onComplete != null) {
				onComplete(masked);
			}
			maskAniLayer.removeChild(this);
		}
	}
	
}