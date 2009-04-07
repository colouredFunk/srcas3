package ui{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui.Btn;
	public class Slider extends Sprite {
		protected var __isCtrlByUser:Boolean;
		protected var __size:Number=100;
		protected var __value:Number=0;
		protected var __maximum:Number=10;
		protected var __minimum:Number=0;
		protected var __snapInterval:Number=1;
		protected var autoSizeTrack:Boolean=true;
		protected var offset:Number;
		protected var thumb:Btn;
		protected var thumbName:String="__thumb";
		protected var track:Btn;
		protected var trackName:String="__track";
		protected var next:Btn;
		protected var nextName:String="__next";
		protected var back:Btn;
		protected var backName:String="__back";
		public var addSpeed:int=1;
		public var press:Function;
		public var release:Function;
		//protected var drag:Function;
		public var change:Function;

		public var obTemp:Object;

		public function Slider() {
			init();
		}
		protected function init():void {
			thumb=getChildByName(thumbName) as Btn;
			track=getChildByName(trackName) as Btn;
			track.press = thumb.press=function ():void {
				__isCtrlByUser=true;
				setMouseOff(this==thumb);
				dirHold();
				//MouseEvent.MOUSE_MOVE
				addEventListener(Event.ENTER_FRAME,dirHold)
				if(press!=null){
					press(this==thumb);
				}
			};
			track.release = thumb.release=function ():void {
				__isCtrlByUser=false;
				removeEventListener(Event.ENTER_FRAME,dirHold)
					if(release!=null){
					release(this==thumb);
				}
			};

			next=getChildByName(nextName) as Btn;
			back=getChildByName(backName) as Btn;
			if (next&&back) {
				next.press = back.press=function ():void {
					__isCtrlByUser=true;
					setValueAdd(this==next?1:-1);
					addValue();
					addEventListener(Event.ENTER_FRAME,addValue)
				};
				next.release = back.release=function ():void {
					__isCtrlByUser=false;
					removeEventListener(Event.ENTER_FRAME,addValue)
				};
			}

			setStyle();
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		protected function removed(evt:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.removeEventListener(Event.ENTER_FRAME,dirHold);
			press=null;
			release=null;
			change=null;
		}
		public function get isCtrlByUser():Boolean {
			return __isCtrlByUser;
		}

		public function get size():Number {
			return __size;
		}
		public function set size(_size:Number):void {
			_size=int(_size);
			if (__size==_size) {
				return;
			}
			__size=_size;
			setStyle();
		}
		public function get value():Number {
			return __value;
		}
		public function set value(_value:Number):void {
			if (_value<minimum) {
				_value=minimum;
			} else if (_value>maximum) {
				_value=maximum;
			}
			if (__value==_value||isNaN(_value)) {
				return;
			}
			__value=_value;
			setThumb();
			if (__isCtrlByUser&&change!=null) {
				change(value,minimum,maximum);
			}
		}
		public function get maximum():Number {
			return __maximum;
		}
		public function set maximum(_maximum:Number):void {
			if (__maximum==_maximum||isNaN(_maximum)) {
				return;
			}
			__maximum=_maximum;
			setStyle();
		}
		public function get minimum():Number {
			return __minimum;
		}
		public function set minimum(_minimum:Number):void {
			if (__minimum==_minimum||isNaN(_minimum)) {
				return;
			}
			__minimum=_minimum;
			setStyle();
		}
		public function get snapInterval():Number {
			return __snapInterval;
		}
		public function set snapInterval(_snapInterval:Number):void {
			if (__snapInterval==_snapInterval||isNaN(_snapInterval)) {
				return;
			}
			__snapInterval=_snapInterval;
			setStyle();
		}
		public function formatValue():void {
			value=Math.round(thumb.x/offset)+minimum;
		}
		protected var offset_mouse:Number;
		protected function setMouseOff(_b:Boolean):void {
			offset_mouse=_b?thumb.mouseX:0;
		}
		protected function dirHold(evt:Event=null):void {
			value = Math.round((mouseX-offset_mouse)/offset/snapInterval)*snapInterval+minimum;
		}
		protected var valueAdd:int;
		protected function setValueAdd(_valueAdd:int):void {
			if(addSpeed>(maximum-minimum)*0.5){
				addSpeed=(maximum-minimum)*0.5;
			}
			valueAdd=_valueAdd*addSpeed;
		}
		protected function addValue(evt:Event=null):void {
			value+=valueAdd*snapInterval;
		}
		public function setStyle():void {
			if (autoSizeTrack) {
				track.width=size;
			}
			offset = size/(maximum-minimum);
			setThumb();
		}
		protected function setThumb():void {
			thumb.x = (value-minimum)*offset;
		}
	}
}