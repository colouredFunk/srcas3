package ui_2{
	import flash.events.Event;
	import ui_2.Btn;
	public class ProgressBar extends Btn {
		public var change:Function;
		protected var bar:*;
		protected var barName:String="__bar";
		override protected function added(_evt:Event):void {
			isEnabled=false;
			super.added(_evt);
			bar=getChildByName(barName);
			if (! bar) {
				bar=this;
			}
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
			if(_value>1){
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