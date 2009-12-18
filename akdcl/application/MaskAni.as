package akdcl.application
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MaskAni extends MovieClip
	{
		private var isTempAsBmp:Boolean;
		private var masked:DisplayObject;
		private var speed:uint = 1;
		public function MaskAni() {
			stop();
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
		public function toMask(_masked:DisplayObject, _isCacheAsBitmap:Boolean = true, _isMask:Boolean = true ):void {
			masked = _masked;
			this.cacheAsBitmap = _isCacheAsBitmap;
			
			if (!masked.cacheAsBitmap) {
				isTempAsBmp = true;
				masked.cacheAsBitmap = true;
			}
			masked.cacheAsBitmap = _isCacheAsBitmap;
			if (_isMask) {
				_masked.mask = this;
			}
		}
	}
	
}