package ui{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ProgressBar extends SimpleBtn {
		public var change:Function;
		
		public var txt:*;
		public var thumb:*;
		public var bar:*;
		public var maskClip:*;
		public var track:*;
		
		public var roundShow:Boolean = true;
		protected var isReferenceFromThumb:Boolean;
		protected var offXThumb:int;
		protected var offWidthMaskClip:int;
		protected var offWidthTrack:int;
		private var __length:uint;
		public function get length():uint {
			return __length;
		}
		public function set length(_length:uint):void {
			__length = _length;
			if (maskClip && bar) {
				maskClip.width = offWidthMaskClip +length;
			}
			if (track) {
				track.width = offWidthTrack +length;
			}
			setStyle();
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
			if (change != null) {
				change(__value);
			}
			setStyle();
		}
		override protected function init():void {
			super.init();
			if (bar && thumb) {
				offXThumb = thumb.x - bar.width - bar.x;
			}
			if (maskClip) {
				if (bar) {
					offWidthMaskClip = maskClip.width - bar.width;
					maskClip.cacheAsBitmap = true;
					bar.cacheAsBitmap = true;
					maskClip.mask = bar;
				}else {
					maskClip.cacheAsBitmap = true;
					bar.cacheAsBitmap = true;
					thumb.mask = maskClip;
				}
			}
			if (track) {
				if (bar) {
					offWidthTrack = track.width - bar.width;
				}else {
					offWidthTrack = track.width - thumb.x;
				}
			}
			if (isReferenceFromThumb?!thumb:bar) {
				length = bar.width * scaleX;
			}else {
				if (bar) {
					length = (thumb.x - bar.x)  * scaleX;
				}else {
					length = thumb.x  * scaleX;
				}
			}
			scaleX = 1;
		}
		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			enabled = false;
		}
		protected function formatValue(_value:Number):Number {
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
			if (isReferenceFromThumb?!thumb:bar) {
				bar.width = value * length;
				if (roundShow) {
					bar.width = Math.round(bar.width);
				}
				if (thumb) {
					thumb.x = bar.width + bar.x + offXThumb;
				}
			}else {
				thumb.x = value * length;
				if (roundShow) {
					thumb.x = Math.round(thumb.x);
				}
				if (bar) {
					var _width:int = Math.round(thumb.x - bar.x - offXThumb);
					if (_width<0) {
						_width = 0;
					}
					bar.width = _width;
				}
			}
			if (txt) {
				txt.text = Math.round(value * 100) + " %";
			}
		}
	}
	
}