package ui {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Slider extends Btn {
		public var change:Function;

		public var thumb:*;
		public var bar:*;
		public var maskClip:*;
		public var track:*;
		
		protected var timeHolded:uint;
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
		override internal function $press():void {
			super.$press();
			timeHolded = 0;
			onHoldingHandler(null);
			addEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}
		override internal function $release():void {
			super.$release();
			timeHolded = 0;
			removeEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}
		private var __length:uint;
		public function get length():uint {
			return __length;
		}
		public function set length(_length:uint):void {
			__length = _length;
			setValue(value);
		}
		private var __maximum:Number = 100;
		public function get maximum():Number {
			return __maximum;
		}
		public function set maximum(_maximum:Number):void {
			__maximum = _maximum;
			setStyle();
		}
		private var __minimum:Number = 0;
		public function get minimum():Number {
			return __minimum;
		}
		public function set minimum(_minimum:Number):void {
			__minimum = _minimum;
			setStyle();
		}
		private var __snapInterval:Number = 1;
		public function get snapInterval():Number {
			return __snapInterval;
		}
		public function set snapInterval(_snapInterval:Number):void {
			__snapInterval = _snapInterval;
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
		protected var scale:Number;
		protected var mouseXOff:int;
		protected function onHoldingHandler(_evt:Event):void {
			value = Math.round((mouseX - mouseXOff) / scale / snapInterval) * snapInterval + minimum;
			timeHolded++;
		}
		public function setStyle():void {
			thumb.x = Math.round(value * length);
			if (bar) {
				bar.width = Math.round(value * length);
			}
			if (thumb) {
				thumb.x = bar.width + bar.x + offXThumb;
			}
			
			/*scale = length/(maximum-minimum);
			var _x:uint = Math.round((value-minimum)*scale);
			thumb.x=_x;
			if (bar) {
				bar.width=_x;
			}*/
		}
	}
}