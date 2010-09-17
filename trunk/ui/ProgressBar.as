package ui{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ProgressBar extends UISprite {
		public var txt:*;
		public var thumb:*;
		public var bar:*;
		public var maskClip:*;
		public var track:*;
		protected var offXThumb:int;
		protected var offWidthMaskClip:int;
		protected var offWidthTrack:int;
		override protected function init():void {
			super.init();
			if (thumb) {
				offXThumb = thumb.x - bar.width - bar.x;
			}
			if (maskClip) {
				offWidthMaskClip = maskClip.width - bar.width;
				maskClip.cacheAsBitmap = true;
				bar.cacheAsBitmap = true;
				maskClip.mask = bar;
			}
			if (track) {
				offWidthTrack = track.width - bar.width;
			}
			length = bar.width * scaleX;
			scaleX = 1;
		}
		private var __length:uint;
		public function get length():uint {
			return __length;
		}
		public function set length(_length:uint):void {
			__length = _length;
			if (maskClip) {
				maskClip.width = offWidthMaskClip +length;
			}
			if (track) {
				track.width = offWidthTrack +length;
			}
			setValue(value);
		}
		private var __value:Number = 0;
		public function get value():Number {
			return __value;
		}
		public function set value(_value:Number):void {
			_value = formatValue(_value);
			if (__value == _value) {
				return;
			}
			__value = _value;
			setStyle();
		}
		public function setValue(_value:Number):void {
			__value = formatValue(_value);
			setStyle();
		}
		private function formatValue(_value:Number):Number {
			if (isNaN(_value)) {
				_value = 0;
			}
			if (_value < 0) {
				_value = 0;
			} else if (_value > 1) {
				_value = 1;
			}
			return _value;
		}
		protected function setStyle():void {
			bar.width = Math.round(value * length);
			if (thumb) {
				thumb.x = bar.width + bar.x + offXThumb;
			}
			if (txt) {
				txt.text = Math.round(value * 100) + " %";
			}
		}
	}
	
}