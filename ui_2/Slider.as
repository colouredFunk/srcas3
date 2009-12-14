package ui_2{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import ui_2.Btn;
	public class Slider extends Sprite {
		public static var CHANGE:String="change";
		public static var PRESS:String="press";
		public static var RELEASE:String="release";
		public var change:Function;
		public var press:Function;
		public var release:Function;

		public var thumb:*;
		public var bar:*;
		public var track:*;
		public var tick:*;
		private var TickClass:Class;
		private var tickList:Array;
		protected var scale:Number;
		protected var mouseXOff:int;
		protected var isAutoLength:Boolean=true;
		protected var timeHold:uint;
		public function Slider() {
			addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
			if(!thumb){
				thumb=new Btn();
				addChild(thumb);
			}
			thumb.hitArea=this;
			thumb.press=function ():void {
				//mouseXOff= !bar ? thumb.mouseX : 0;
				timeHold=0;
				dirHold();
				addEventListener(Event.ENTER_FRAME,dirHold);
				if(press!=null){
					press(value);
				}
				dispatchEvent(new Event(PRESS));
			};
			thumb.release =function ():void {
				timeHold=0;
				removeEventListener(Event.ENTER_FRAME,dirHold);
				if(release!=null){
					release(value);
				}
				dispatchEvent(new Event(RELEASE));
			};
			enabled=true;
			value=0;
			if(track){
				length = (track.width * scaleX + track.x * 2);
				track.mouseEnabled=false;
				track.mouseChildren=false;
				if(track is MovieClip&&track.totalFrames>1){
					thumb.setAni(track);
				}
			}
			scaleX = 1;
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			removeEventListener(Event.ENTER_FRAME,dirHold);
			change=null;
			press=null;
			release=null;
		}
		public function get isHold():Boolean{
			return timeHold>0;
		}
		private var __enabled:Boolean;
		public function get enabled():Boolean{
			return __enabled;
		}
		public function set enabled(_enabled:Boolean):void{
			if(__enabled==_enabled){
				return;
			}
			__enabled=_enabled;
			thumb.enabled=__enabled;
			if (__enabled) {
			} else {
			}
		}
		private var __valueLast:Number;
		private var __value:Number;
		public function get valueLast():Number {
			return __valueLast;
		}
		public function get value():Number {
			return __value;
		}
		[Inspectable(defaultValue=0,type="Number",name="初始值")]
		public function set value(_value:Number):void {
			_value=formatValue(_value);
			if (__value==_value) {
				return;
			}
			__valueLast = __value;
			__value=_value;
			setValue();
			if (change!=null) {
				change(value,minimum,maximum);
			}
			dispatchEvent(new Event(CHANGE));
		}
		protected function formatValue(_value:Number):Number{
			if (_value<minimum) {
				_value=minimum;
			} else if (_value>maximum) {
				_value=maximum;
			}
			return _value;
		}
		private var __length:uint;
		public function get length():uint {
			return __length;
		}
		[Inspectable(defaultValue=0,type="uint",name="长度")]
		public function set length(_length:uint):void {
			if(_length==0){
				return;
			}
			__length=_length;
			if(isAutoLength&&track){
				track.width = __length-track.x*2;
			}
			setStyle();
		}
		private var __maximum:Number=100;
		public function get maximum():Number {
			return __maximum;
		}
		[Inspectable(defaultValue=100,type="Number",name="最大值")]
		public function set maximum(_maximum:Number):void {
			__maximum=_maximum;
			setStyle();
		}
		private var __minimum:Number=0;
		public function get minimum():Number {
			return __minimum;
		}
		[Inspectable(defaultValue=0,type="Number",name="最小值")]
		public function set minimum(_minimum:Number):void {
			__minimum=_minimum;
			setStyle();
		}
		private var __snapInterval:Number=1;
		public function get snapInterval():Number {
			return __snapInterval;
		}
		[Inspectable(defaultValue=1,type="Number",name="精度")]
		public function set snapInterval(_snapInterval:Number):void {
			__snapInterval=_snapInterval;
			setStyle();
		}
		private var __tickInterval:Number = 0;
		public function getTick(_id:uint):DisplayObject {
			if (_id>=tickList.length) {
				var _tick:*= new TickClass();
				tickList.push(_tick);
			}
			return tickList[_id];
		}
		public function get tickInterval():Number {
			return __tickInterval;
		}
		//[Inspectable(defaultValue=0,type="Number",name="刻度")]
		public function set tickInterval(_tickInterval:Number):void {
			if (_tickInterval == 0) {
				return;
			}
			if (TickClass == null && tick) {
				
				tickList = [tick];
				TickClass = tick.constructor as Class;
			}
			for each (var _tick:* in tickList) {
				removeChild(_tick);
			}
			__tickInterval = _tickInterval;
			for (var _i:Number = minimum, _id:uint = 0; _i <=maximum; _i += __tickInterval, _id++ ) {
				_tick = getTick(_id);
				_tick.x = (_i - minimum) * scale;
				addChildAt(_tick,0);
			}
			//setStyle();
		}
		public function intValue():void {
			value=Math.round(thumb.x/scale)+minimum;
		}
		protected function dirHold(_evt:Event=null):void {
			value = Math.round((mouseX-mouseXOff)/scale/snapInterval)*snapInterval+minimum;
			timeHold++;
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