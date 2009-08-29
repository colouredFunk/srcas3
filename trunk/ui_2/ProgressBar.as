package ui_2{
	import flash.display.Sprite;
	public class ProgressBar extends Sprite {
		public var change:Function;
		public var bar:*;
		public function ProgressBar():void {
			if (length==0) {
				length=bar.width;
			}
			value=0;
		}
		protected var __length:uint;
		public function get length():uint {
			return __length;
		}
		public function set length(_length:uint):void {
			__length=_length;
		}
		protected var __value:Number;
		public function get value():Number {
			return __value;
		}
		public function set value(_value:Number):void {
			if (_value>1) {
				_value=1;
			}
			if (__value==_value) {
				return;
			}
			__value=_value;
			setValue();
			if (change!=null) {
				change(__value);
			}
		}
		protected function setValue():void {
			bar.width=Math.round(value*length);
		}
	}
}