package ui_2{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui_2.Btn;
	public class Slider extends Sprite {
		public var change:Function;
		public var press:Function;
		public var release:Function;

		protected var thumb:*;
		protected var thumbName:String="__thumb";
		protected var bar:*;
		protected var barName:String="__bar";
		protected var track:*;
		protected var trackName:String="__track";

		protected var scale:Number;
		protected var mouseXOff:int;
		public function Slider() {
			init();
		}
		protected function init():void {
			thumb=getChildByName(thumbName);
			bar=getChildByName(barName);
			track=getChildByName(trackName);
			//thumb["isThumb"] = true;
			track.press=function ():void {
				mouseXOff= (this==thumb && !bar) ? thumb.mouseX : 0;
				dirHold();
				addEventListener(Event.ENTER_FRAME,dirHold);
				if(press!=null){
					press(value);
				}
			};
			track.release =function ():void {
				removeEventListener(Event.ENTER_FRAME,dirHold);
				if(release!=null){
					release(value);
				}
			};
			if (thumb) {
				thumb.press=track.press;
				thumb.release=track.release;
			}
			if (bar) {
				bar.mouseEnabled=false;
				bar.mouseChildren=false;
			}
			value=0;
			length=track.width+track.x*2;
		}
		protected var __value:Number;
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
			if (change!=null) {
				change(value,minimum,maximum);
			}
		}
		protected var __length:uint;
		public function get length():uint {
			return __length;
		}
		[Inspectable(defaultValue=0,type="uint",name="长度")]
		public function set length(_length:uint):void {
			if(_length==0){
				return;
			}
			__length=_length;
			track.width = length-track.x*2;
			setStyle();
		}
		protected var __maximum:Number=100;
		public function get maximum():Number {
			return __maximum;
		}
		[Inspectable(defaultValue=100,type="Number",name="最大值")]
		public function set maximum(_maximum:Number):void {
			__maximum=_maximum;
			setStyle();
		}
		protected var __minimum:Number=0;
		public function get minimum():Number {
			return __minimum;
		}
		[Inspectable(defaultValue=0,type="Number",name="最小值")]
		public function set minimum(_minimum:Number):void {
			__minimum=_minimum;
			setStyle();
		}
		protected var __snapInterval:Number=1;
		public function get snapInterval():Number {
			return __snapInterval;
		}
		[Inspectable(defaultValue=1,type="Number",name="精度")]
		public function set snapInterval(_snapInterval:Number):void {
			__snapInterval=_snapInterval;
			setStyle();
		}
		public function formatValue():void {
			value=Math.round(thumb.x/scale)+minimum;
		}
		protected function dirHold(_evt:Event=null):void {
			value = Math.round((mouseX-mouseXOff)/scale/snapInterval)*snapInterval+minimum;
		}
		public function setStyle():void {
			scale = length/(maximum-minimum);
			setValue();
		}
		protected function setValue():void {
			var _x:uint = Math.round((value-minimum)*scale);
			if (thumb) {
				thumb.x=_x;
			}
			if (bar) {
				bar.width=_x;
			}
		}
	}
}