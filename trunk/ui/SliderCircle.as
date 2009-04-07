package ui{
	import flash.display.*;
	import flash.events.*;
	import ui.Btn;
	import ui.Slider;
	public class SliderCircle extends Slider {
		public var radius:Number = 50;
		public var radianOffset:Number = 0;
		public var isRotThumb:Boolean=true;
		private var radian:Number = 0;
		override protected function init():void {
			thumbName="__thumb_0";
			trackName="__track_0";
			nextName="__next_0";
			backName="__back_0";
			super.init();
		}
		override public function set value(_value:Number):void {
			if (_value<minimum || _value>maximum) {
				if (value<minimum+(maximum-minimum)/2) {
					_value = minimum;
				} else {
					_value = maximum;
				}
			}
			if (__value == _value || isNaN(_value)) {
				return;
			}
			__value = _value;
			setThumb();
			if (__isCtrlByUser&&change!=null) {
				change(value,minimum,maximum);
			}
		}
		override protected function dirHold(evt:Event=null):void {
			radian = Math.atan2(mouseY, mouseX);
			if (radian<-radianOffset/180*Math.PI) {
				radian += 2*Math.PI;
			}
			value = Math.round((radian*180/Math.PI+radianOffset)/offset)+minimum;
		}
		override public function setStyle():void {
			offset = size*snapInterval/(maximum-minimum);
			setThumb();
		}
		override protected function setThumb():void {
			var angle:Number = offset*(value-minimum)-radianOffset;
			if(isRotThumb){
				thumb.rotation = angle;
			}
			thumb.x = Math.cos(angle/180*Math.PI)*radius;
			thumb.y = Math.sin(angle/180*Math.PI)*radius;
		}
	}
}