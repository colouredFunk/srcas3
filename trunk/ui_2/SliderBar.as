package ui_2{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	public class SliderBar extends Sprite {
		private var content:DisplayObject;
		private var offY:int;
		private var offX:int;
		private var maximum:int;
		public var slider:*;
		public var btn_up:*;
		public var btn_down:*;
		public var rectMask:*;
		public var perWheel:uint=40;
		public var perBtn:uint=80;
		public var autoSize:Boolean=true;
		public function SliderBar() {
			addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
			if (btn_up) {
				//btn_up.press=goUp;
			}
			if (btn_down) {
				//btn_down.press=goDown;
			}
			slider.change=function(_value:Number,_min:Number,_max:Number):void{
				setValue();
			};
			rectMask.visible=false;
			enabled=true;
		}
		protected function removed(event:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			content=null;
		}
		public function set scrollContent(_scrollContent:String):void {
			content=parent.getChildByName(_scrollContent);
			if (content&&content.height>rectMask.height) {
				var _rect:Rectangle=content.getBounds(parent);
				offX=int(x+content.x-_rect.x);
				offY=int(y+content.y-_rect.y)+20;
				content.x=offX;
				rectMask.width=content.width+10;
				maximum=content.height-rectMask.height+40;
				if (autoSize) {
					slider.x=rectMask.width+10;
				}
				slider.maximum=maximum;
				slider.length=rectMask.height-slider.y*2;
				setValue();
				content.cacheAsBitmap=true;
				rectMask.cacheAsBitmap=true;
				content.mask=rectMask;
				enabled=true;
			} else {
				enabled=false;
			}
		}
		public function setHeight(_h:Number):void{
			rectMask.height=_h;
			scrollContent=content.name;
		}
		private var __enabled:Boolean;
		public function get enabled():Boolean {
			return __enabled;
		}
		public function set enabled(_enabled:Boolean):void {
			if (__enabled==_enabled) {
				return;
			}
			__enabled=_enabled;
			if (__enabled) {
				stage.addEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			} else {
				stage.removeEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			}
			slider.enabled=__enabled;
			//btn_up.enabled=__enabled;
			//btn_down.enabled=__enabled;
			slider.visible = __enabled;
		}
		public function get value():Number {
			return slider.value;
		}
		public function set value(_value:Number):void {
			slider.value=_value;
		}
		protected function setValue():void {
			if (! content) {
				return;
			}
			content.y=offY-value;
		}
		protected function wheel(event:MouseEvent):void {
			slider.value+=(event.delta>0?-1:1)*perWheel;
		}/*
		public function setStyle() : void
		        {
		        }
		private function goUp():void {
		}
		private function goDown():void {
		}*/
	}
}