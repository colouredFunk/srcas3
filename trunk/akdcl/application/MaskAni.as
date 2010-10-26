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
		private var isTempAsBmp:Boolean;
		private var masked:DisplayObject;
		override protected function init():void {
			super.init();
			stop();
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
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
		override public function remove():void {
			super.remove();
			masked.mask = null;
			if (isTempAsBmp) {
				masked.cacheAsBitmap = false;
			}
			if (onComplete != null) {
				onComplete(masked);
			}
		}
	}
	
}