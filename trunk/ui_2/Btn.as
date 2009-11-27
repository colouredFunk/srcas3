package ui_2{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Btn extends SimpleBtn {
		public var isSelectPlay:Boolean;
		public var aniClip:MovieClip;
		public var onOpen:Function;
		override protected function added(_evt:Event):void {
			super.added(_evt);
			if (aniClip) {
				aniClip.stop();
			}
			if (totalFrames>8) {
				setAni(this);
			}
			setAni(aniClip);
		}
		override protected function removed(_evt:Event):void {
			super.removed(_evt);
			if (aniClip) {
				aniClip.removeEventListener(Event.ENTER_FRAME,aniRun);
			}
			onOpen=null;
		}
		override public function setStyle():void {
			if (totalFrames>8) {
				setAni(this);
			}else {
				super.setStyle();
			}
			setAni(aniClip);
		}
		protected var delayTime:int=1;
		public var delayMax:int=0;
		private function aniRun(_evt:Event):void {
			if (_evt.target==this?(isIn||isDown||select):(isIn||isDown||(isSelectPlay?select:false))) {
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
		public function setAni(_clip:MovieClip):void {
			if (! _clip) {
				return;
			}
			if (_clip!=this) {
				aniClip=_clip;
				_clip.buttonMode=false;
			}
			if (_clip&&_clip.hasEventListener(Event.ENTER_FRAME)) {
				_clip.removeEventListener(Event.ENTER_FRAME,aniRun);
			}
			if (! _clip.hasEventListener(Event.ENTER_FRAME)) {
				_clip.addEventListener(Event.ENTER_FRAME,aniRun);
			}
		}
	}
}