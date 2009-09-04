package ui_2{
	import flash.events.Event;
	import ui_2.Slider;
	public class SliderCircle extends Slider {
		public var radius:uint = 50;
		public var radianOffset:int = 0;
		public var isRotThumb:Boolean=true;
		protected const RTA:Number=180/Math.PI;
		
		override protected function added(_evt:Event):void {
			radius=Math.abs(thumb.x);
			super.added(_evt);
		}
		override protected function formatValue(_value:Number):Number{
			if(_value>maximum){
				if(timeHold==0){
					if((_value-maximum)/maximum/360*(360-length)>0.5){
						_value = minimum;
					}else{
						_value = maximum;
					}
				}else{
					if (value<minimum+(maximum-minimum)/2) {
						_value = minimum;
					} else {
						_value = maximum;
					}
				}
			}
			return _value;
		}
		override protected function dirHold(_evt:Event=null):void {
			var _radian:Number = Math.atan2(mouseY, mouseX);
			if (_radian<-radianOffset/RTA) {
				_radian += 2*Math.PI;
			}
			value = Math.round((_radian*RTA+radianOffset)/scale)*snapInterval+minimum;
			timeHold++;
		}
		override public function setStyle():void {
			scale = length*snapInterval/(maximum-minimum);
			setValue();
		}
		override protected function setValue():void {
			var angle:Number = scale*(value-minimum)/snapInterval-radianOffset;
			if(isRotThumb){
				thumb.rotation = angle;
			}
			thumb.x = Math.cos(angle/RTA)*radius;
			thumb.y = Math.sin(angle/RTA)*radius;
		}
	}
}