package ui_2{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class SimpleBtn extends MovieClip {
		private static var btnDown:MovieClip;
		private static var btnIn:MovieClip;
		public var press:Function;
		public var release:Function;
		public var rollOver:Function;
		public var rollOut:Function;
		public var obTemp:Object;
		public function SimpleBtn() {
			init();
		}
		protected function init():void {
			stop();
			addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
			enabled=true;
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			enabled=false;
			press=null;
			release=null;
			rollOver=null;
			rollOut=null;
			for each (var _e:* in obTemp) {
				_e=null;
			}
			obTemp=null;
			if (stage.focus==this) {
				//否则会引起一些按键不能动作
				stage.focus=null;
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
				buttonMode=true;
				addEventListener(MouseEvent.MOUSE_DOWN,$onPress);
				stage.addEventListener(MouseEvent.MOUSE_UP,$onRelease);
				addEventListener(MouseEvent.ROLL_OVER,$onRollOver);
				addEventListener(MouseEvent.ROLL_OUT,$onRollOut);
			} else {
				buttonMode=false;
				removeEventListener(MouseEvent.MOUSE_DOWN,$onPress);
				stage.removeEventListener(MouseEvent.MOUSE_UP,$onRelease);
				removeEventListener(MouseEvent.ROLL_OVER,$onRollOver);
				removeEventListener(MouseEvent.ROLL_OUT,$onRollOut);
			}
		}
		private var __select:Boolean;
		public function get select():Boolean{
			return __select;
		}
		public function set select(_select:Boolean):void{
			if (__select==_select) {
				return;
			}
			__select=_select;
			setStyle();
		}
		public function get isIn():Boolean{
			return Boolean(btnIn==this);
		}
		public function get isDown():Boolean{
			return Boolean(btnDown==this);
		}
		private function $onPress(_evt:MouseEvent):void {
			if(isDown){
				return;
			}
			btnDown=this;
			if (press!=null) {
				press();
			}
			setStyle();
		}
		private function $onRelease(_evt:MouseEvent):void {
			if(!isDown){
				return;
			}
			btnDown=null;
			if(btnIn&&!isIn){
				btnIn.$onRollOver(null);
			}
			if (release!=null) {
				release();
			}
			setStyle();
		}
		private function $onRollOver(_evt:MouseEvent):void {
			if(isIn&&_evt){
				return;
			}
			btnIn=this;
			if(btnDown&&!isDown){
				return;
			}
			if (rollOver!=null) {
				rollOver();
			}
			setStyle();
		}
		private function $onRollOut(_evt:MouseEvent):void {
			if (!isIn) {
				return;
			}
			btnIn=null;
			if (rollOut!=null) {
				rollOut();
			}
			setStyle();
		}
		private var frame:uint;
		public function setStyle():void {
			if (btnIn==this) {
				if (btnDown==this) {
					frame=4;
				} else {
					frame=2;
				}
			} else {
				if (btnDown==this) {
					frame=3;
				} else {
					frame=1;
				}
			}
			frame+=select?4:0;
			gotoAndStop(frame);
		}
	}
}