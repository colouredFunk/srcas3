package ui_2{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class SimpleBtn extends MovieClip {
		private static var btnDown:MovieClip;
		private static var btnIn:MovieClip;
		public var needReload:Boolean;
		public var onSelect:Function;
		public var press:Function;
		public var release:Function;
		public var rollOver:Function;
		public var rollOut:Function;
		public var userData:Object;
		public var area:*;
		public function SimpleBtn() {
			stop();
			addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
			enabled=true;
			if(area){
				hitArea=area;
				area.visible = false;
				mouseChildren = false;
			}
		}
		protected function removed(_evt:Event):void {
			stop();
			if (stage.focus==this) {
				stage.focus=null;
			}
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			enabled=false;
			if (needReload) {
				addEventListener(Event.ADDED_TO_STAGE,added);
				return;
			}
			press=null;
			release=null;
			rollOver=null;
			rollOut=null;
			for each (var _e:* in userData) {
				_e=null;
			}
			userData=null;
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
				buttonMode = true;
				addEventListener(MouseEvent.MOUSE_DOWN,$onPress);
				addEventListener(MouseEvent.ROLL_OVER,$onRollOver);
				addEventListener(MouseEvent.ROLL_OUT,$onRollOut);
			} else {
				buttonMode = false;
				removeEventListener(MouseEvent.MOUSE_DOWN,$onPress);
				stage.removeEventListener(MouseEvent.MOUSE_UP,$onRelease);
				removeEventListener(MouseEvent.ROLL_OVER,$onRollOver);
				removeEventListener(MouseEvent.ROLL_OUT,$onRollOut);
			}
		}
		private var __groupName:String;
		public function set group(_groupName:String):void {
			if (__groupName) {
				RadioAndCheck.removeFromGroup(__groupName, this);
			}
			__groupName = _groupName;
			RadioAndCheck.addToGroup(__groupName, this);
		}
		private var __select:Boolean;
		public function get select():Boolean{
			return __select;
		}
		public function set select(_select:Boolean):void{
			if (__select==_select) {
				return;
			}
			__select = _select;
			if (__groupName) {
				if (__select) {
					if (RadioAndCheck.selectItem(__groupName, this)) {
					}else {
						return;
					}
				}else {
					RadioAndCheck.unselectItem(__groupName, this);
				}
			}else {
			}
			if (onSelect!=null) {
				onSelect(__select);
			}
			setStyle();
		}
		private var __isIn:Boolean;
		private var __isDown:Boolean;
		public function get isIn():Boolean{
			return __isIn;
		}
		public function get isDown():Boolean{
			return __isDown;
		}
		public function $onPress(_evt:MouseEvent):void {
			if(isDown){
				return;
			}
			stage.addEventListener(MouseEvent.MOUSE_UP,$onRelease);
			btnDown=this;
			__isDown=true;
			if (press!=null) {
				press();
			}
			setStyle();
		}
		public function $onRelease(_evt:MouseEvent):void {
			if(!isDown){
				return;
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP,$onRelease);
			btnDown=null;
			//if(btnIn&&btnIn!=this){
				//btnIn.$onRollOver(null);
			//}
			__isDown=false;
			if (release != null) {
				release();
			}
			setStyle();
		}
		public function $onRollOver(_evt:MouseEvent):void {
			if(isIn){
				return;
			}
			//btnIn=this;
			//if(btnDown&&btnDown!=this){
				//return;
			//}
			__isIn=true;
			if (rollOver!=null) {
				rollOver();
			}
			setStyle();
		}
		public function $onRollOut(_evt:MouseEvent):void {
			if (!isIn) {
				return;
			}
			btnIn=null;
			__isIn=false;
			if (rollOut!=null) {
				rollOut();
			}
			setStyle();
		}
		private var frame:uint;
		public function setStyle():void {
			if (isIn) {
				if (isDown) {
					frame=4;
				} else {
					frame=2;
				}
			} else {
				if (isDown) {
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