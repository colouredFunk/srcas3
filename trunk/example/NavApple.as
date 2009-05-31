package {
	import flash.events.*;
	import flash.display.*;

	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;

	import ui.Btn;

	public class NavApple extends Btn {
		
		public var aBtn:Array;
		protected var isMove:Boolean;
		public var btnSelect:Btn;
		//protected var bar:Sprite;
		protected var isRun:Boolean=true;
		public var btnNum:int=7;
		public var dx:int=10;
		public var centerX:int=509;
		public var minScale:Number=1;
		public var maxScale:Number=2;
		public var disIn:int=200;
		public var barWidthOff:Number=80;
		public var moveSlow:Number=0.4;
		public var moveSpeed:int=10;
		public var onClick:Function;
		public var onMoveEnd:Function;
		override protected function added(evt:Event):void {
			super.added(evt);
			buttonMode=false;
			rollOver=function():void{
				isMove=true;
			};
			rollOut=function():void{
			};
			this.addEventListener(Event.ENTER_FRAME,runStep);
			stage.addEventListener(Event.MOUSE_LEAVE, cursorHide);
			aBtn=[];
			for (var i:int=0; i<btnNum; i++) {
				aBtn[i]=this.addChild(new BtnApple());
				aBtn[i].x=i*(aBtn[i].width+dx);
				aBtn[i].press=function():void{
					selectBtn(this);
				};
				aBtn[i].release=function():void{
					if(onClick!=null){
						onClick(this);
					}
				}
				aBtn[i].obTemp={id:i};
			}
			this.removeChild(bar);
			if (! centerX) {
				centerX=x+width*0.5;
			}
			this.addChildAt(bar,0);
		}
		override protected function removed(evt:Event):void {
			this.removeEventListener(Event.ENTER_FRAME,runStep);
			stage.removeEventListener(Event.MOUSE_LEAVE, cursorHide);
		}
		public var onChangeAll:Function;
		public function rollBtn(_nDid:int):void{
			var _isEnd:Boolean;
			if(btnSelect==null){
				selectBtn(0)
				return;
			}
			var _id:int=btnSelect.obTemp.id+_nDid;
			if(_id<0){
				_id=aBtn.length-1;
				_isEnd=true;
			}else if(_id>aBtn.length-1){
				_id=0;
				_isEnd=true;
			}
			selectBtn(_id);
			if(_isEnd&&onChangeAll!=null){
				onChangeAll(_nDid);
			}
		}
		public var onSelectBtn:Function;
		protected function selectBtn(_id:*):void{
			var _btn:*=(_id is Number)?aBtn[_id]:_id;
			if(btnSelect==_btn){
				return;
			}
			if(btnSelect){
				btnSelect.select(false);
			}
			btnSelect=_btn;
			btnSelect.select(true);
			if(onSelectBtn!=null){
				onSelectBtn(btnSelect);
			}
		}
		protected function cursorHide(evt:Event):void{
			isMove=false;
		}
		protected function runStep(evt:Event):void {
			if (! isRun) {
				return;
			}
			if (isMove) {
				isMove=this.hitTestPoint(parent.mouseX,parent.mouseY,false);
			}
			var _offX:Number;
			var _btnPrev:BtnApple;
			var _btn:BtnApple;
			for each (_btn in aBtn) {
				var _dis:Number;
				if(isMove){
					_dis=Math.abs(_btn.x+_btn.width*0.5-mouseX);
				}else if(btnSelect){
					_dis=Math.abs(_btn.x+_btn.width*0.5-btnSelect.x-btnSelect.width*0.5);
				}else{
					_dis=NaN;
				}
				if(isNaN(_dis)||_dis>disIn){
					_btn.scaleX+=(minScale-_btn.scaleX)*moveSlow;
					_btn.scaleY=_btn.scaleX;
				}else{
					_btn.scaleX+=(((isMove?1:0.8)*maxScale-minScale)*(1-_dis/disIn)+minScale-_btn.scaleX)*moveSlow;
					_btn.scaleY=_btn.scaleX;
				}
				if (_btnPrev) {
					_offX=_btnPrev.x+_btnPrev.width+dx;
				} else {
					_offX=0;
				}
				_btn.x=_offX;
				_btnPrev=_btn;
			}
			bar.width=0;
			bar.x=0;
			x=centerX-width*0.5;
			bar.width=width+barWidthOff;
			bar.x=aBtn[0].x-barWidthOff*0.5;
		}
		public function moveBtn(_nDir:int):BtnApple {
			if (! isRun) {
				return null;
			}
			isRun=false;
			var _btn:BtnApple;
			var _btnChange:BtnApple;
			var _width:Number;
			if (_nDir>0) {
				_width=aBtn[aBtn.length-1].width;
			} else {
				_width=aBtn[0].width;
			}
			for each (_btn in aBtn) {
				if (_nDir>0?(_btn==aBtn[aBtn.length-1]):(_btn==aBtn[0])) {
					if (_nDir>0) {
						_btn.x=aBtn[0].x-_btn.width-dx;
						_btnChange=_btn;
					} else {
						_btn.x=aBtn[aBtn.length-1].x+aBtn[aBtn.length-1].width+dx;
						_btnChange=_btn;
					}
				}
				_btn.obTemp.tw=new Tween(_btn, "x", Regular.easeInOut, _btn.x, _btn.x+_nDir*(_width+dx), moveSpeed, false);
				_btn.obTemp.tw.addEventListener(TweenEvent.MOTION_FINISH ,aniFinish);
			}
			if (_nDir>0) {
				aBtn.unshift(aBtn.splice(aBtn.length-1, 1)[0]);
			} else {
				aBtn.push(aBtn.splice(0, 1)[0]);
			}
			if (btnSelect==_btnChange) {
				if (_nDir>0) {
					btnSelect=aBtn[aBtn.length-1];
				} else {
					btnSelect=aBtn[0];
				}
				if (onMoveEnd!=null) {
					onMoveEnd(btnSelect);
				}
			}
			return _btnChange;
		}
		private function aniFinish(evt:TweenEvent):void {
			evt.currentTarget.removeEventListener(TweenEvent.MOTION_FINISH ,aniFinish);
			isRun=true;
		}
	}
}