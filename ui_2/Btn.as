package ui_2{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Btn extends MovieClip {
		protected var __isIn:Boolean;
		protected var __isDown:Boolean;
		public var isSelect:Boolean;
		public var aniClip:MovieClip;
		protected var aniClipName:String="__aniClip";
		public var press:Function;
		public var release:Function;
		public var rollOver:Function;
		public var rollOut:Function;
		public var onOpen:Function;
		public var onAddTo:Function;
		public var obTemp:Object;
		public function Btn() {
			init();
		}
		protected function init():void {
			stop();
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(_evt:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			if (totalFrames>8) {
				aniClip=this;
			}
			setEnabled(true);
			setStyle();
			if (onAddTo!=null) {
				onAddTo(this);
			}
		}
		protected function removed(_evt:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			setEnabled(false);
			if (aniClip) {
				aniClip.removeEventListener(Event.ENTER_FRAME,aniRun);
			}
			for each (var _e:* in obTemp) {
				_e=null;
			}
			press=null;
			release=null;
			rollOver=null;
			rollOut=null;
			onAddTo=null;
			onOpen=null;
			aniClip=null;
			obTemp=null;
			if (stage.focus==this) {
				//否则会引起一些按键不能动作
				stage.focus=null;
			}
		}
		public function get isDown():Boolean {
			return __isDown;
		}
		public function get isIn():Boolean {
			return __isIn;
		}
		//protected var enabled
		public function setEnabled(_b:Boolean):void {
			if (_b) {
				buttonMode=true;
				this.addEventListener(MouseEvent.MOUSE_DOWN,$onPress);
				stage.addEventListener(MouseEvent.MOUSE_UP,$onRelease);
				this.addEventListener(MouseEvent.ROLL_OVER,$onRollOver);
				this.addEventListener(MouseEvent.ROLL_OUT,$onRollOut);
			} else {
				buttonMode=false;
				this.removeEventListener(MouseEvent.MOUSE_DOWN,$onPress);
				stage.removeEventListener(MouseEvent.MOUSE_UP,$onRelease);
				this.removeEventListener(MouseEvent.ROLL_OVER,$onRollOver);
				this.removeEventListener(MouseEvent.ROLL_OUT,$onRollOut);
			}
		}
		private function $onPress(_evt:MouseEvent):void {
			if (! __isDown) {
				__isDown=true;
				if (press!=null) {
					press();
				}
				setStyle();
			}
		}
		private function $onRelease(_evt:MouseEvent):void {
			if (__isDown) {
				__isDown=false;
				if (release!=null) {
					release();
				}
				setStyle();
			}
		}
		private function $onRollOver(_evt:MouseEvent):void {
			if (! __isIn) {
				__isIn=true;
				if (rollOver!=null) {
					rollOver();
				}
				setStyle();
			}
		}
		private function $onRollOut(_evt:MouseEvent):void {
			if (__isIn) {
				__isIn=false;
				if (rollOut!=null) {
					rollOut();
				}
				setStyle();
			}
		}
		public function setStyle():void {
			if (aniClip==this) {
				setAni(aniClip);
				aniClip.buttonMode=true;
				return;
			}
			if (aniClip&&aniClip.hasEventListener(Event.ENTER_FRAME)) {
				aniClip.removeEventListener(Event.ENTER_FRAME,aniRun);
			}
			var frame:int;
			if (__isIn) {
				if (__isDown) {
					frame=4;
				} else {
					frame=2;
				}
			} else {
				if (__isDown) {
					frame=3;
				} else {
					frame=1;
				}
			}
			frame+=isSelect?4:0;
			gotoAndStop(frame);
			setAni(getChildByName(aniClipName) as MovieClip);
		}
		protected var delayTime:int=1;
		public var delayMax:int=0;
		private function aniRun(_evt:Event):void {
			if (__isIn) {
				if (_evt.target.currentFrame==_evt.target.totalFrames) {
					delayTime=delayMax;
					_evt.target.removeEventListener(Event.ENTER_FRAME,aniRun);
					if (onOpen!=null) {
						onOpen(true);
					}
				} else {
					_evt.target.nextFrame();
				}
			} else if (delayTime<=0) {
				if (_evt.target.currentFrame==1) {
					_evt.target.removeEventListener(Event.ENTER_FRAME,aniRun);
					delayTime=1;
					if (onOpen!=null) {
						onOpen(false);
					}
				} else {
					_evt.target.prevFrame();
				}
			} else {
				delayTime--;
			}
		}
		public function select(_b:Boolean):void {
			if (isSelect==_b) {
				return;
			}
			isSelect=_b;
			setStyle();
		}
		public function setAni(_clip:MovieClip):void {
			if (! _clip) {
				return;
			}
			aniClip=_clip;
			aniClip.buttonMode=false;
			if (! aniClip.hasEventListener(Event.ENTER_FRAME)) {
				aniClip.addEventListener(Event.ENTER_FRAME,aniRun);
			}
		}
	}
}