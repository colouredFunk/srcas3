package ui_2{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	public class SliderBar extends Sprite {
		private var content:DisplayObject;
		private var offY:int;
		private var dY:int;
		public var slider:*;
		public var btn_up:*;
		public var btn_down:*;
		public var rectMask:*;
		public var perWheel:uint=10;
		public var perBtn:uint=20;
		public function SliderBar() {
			addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
			addEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			if(btn_up){
				//btn_up.press=goUp;
			}
			if(btn_down){
				//btn_down.press=goDown;
			}
			slider.change=function(_value:Number):void{
				value=_value;
			};
		}
		protected function removed(event:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			removeEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			content=null;
			dragRect=null;
		}
		[Inspectable(defaultValue="")];
		public function set scrollContent(_scrollContent:String):void {
			content=parent.getChildByName(_scrollContent);
			if (content&&content.height<rectMask.height) {
				var _rect:Rectangle=content.getBounds(parent);
				offY=int(y+content.y-_rect.y);
				dY=rectMask.height-content.height;
				value=0;
				content.mask=rectMask;
				enabled=true;
			} else {
				enabled=false;
			}
		}
		private var __enabled:Boolean;
		override public function get enabled():Boolean{
			return __enabled;
		}
		override public function set enabled(_enabled:Boolean):void{
			if(__enabled==_enabled){
				return;
			}
			__enabled=_enabled;
			if (__enabled) {
				addEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			} else {
				removeEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			}
			slider.enabled=__enabled;
			btn_up.enabled=__enabled;
			btn_down.enabled=__enabled;
		}
		private var __value:Number;
		public function get value():Number {
			return __value;
		}
		[Inspectable(defaultValue=0,type="Number",name="初始值")]
		public function set value(_value:Number):void {
			if (_value<minimum) {
				_value=minimum;
			} else if (_value>maximum) {
				_value=maximum;
			}
			if (__value==_value) {
				return;
			}
			__value=_value;
			setValue();
		}
		protected function setValue():void {
			content.y=offY+dY*value;
		}
		protected function wheel(event:MouseEvent):void{
			value+=(event.delta>0?-1:1)*perWheel;
		}
		/*public function reset():void{
			btn.y=dragRect.y;
			dir=0;
			scrollContent=content.name;
		}
		public function setStyle() : void
        {
        }
		private function goUp():void {
			dir=-1;
			this.addEventListener(Event.ENTER_FRAME,updateCurrObj);
		}
		private function goDown():void {
			dir=1;
			this.addEventListener(Event.ENTER_FRAME,updateCurrObj);
		}*/
	}
}