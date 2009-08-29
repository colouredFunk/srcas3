package ui_2{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.events.Event;
	public class Alert extends Sprite {
		public var txt_title:*;
		public var txt_show:*;
		public var btn_y:*;
		public var btn_n:*;
		public var btn_x:*;
		public var bar:*;
		protected var barWidth:int;
		protected var barHeight:int;
		protected var dx_show:int;
		protected var dy_show:int;
		protected var dy_showyn:int;
		protected var dy_yn:int;
		//__bar,__btn_y,__btn_n,__btn_x,__txt_title,__txt_show
		protected var isYN:Boolean;
		protected var isDrag:Boolean;
		protected var isMask:Boolean;
		public var callBack:Function;
		public function Alert() {
			init();
		}
		protected function init():void {
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			//txt_title.text = aStr[0];
			
		}
		protected function added(_evt:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			//btn_y.autoSize="center";
			//btn_n.autoSize="center";
			//btn_y.label="确定";
			//btn_n.label="取消";
			btn_y.release = function():void {
				if((callBack!=null)?(callBack(true)!= false):true){
					remove();
				}
			};
			if (btn_n) {
				btn_n.release=function ():void {
					if((callBack!=null)?(callBack(false)!= false):true){
					remove();
					}
				};
			}
			getStyleParams();
		}
		protected function removed(_evt:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			
		}
		public function alert(_alert:String):void{
			txt_show.text=_alert;
			setStyle();
			setBar();
		}
		protected function getStyleParams():void {
			barWidth=int(bar.width);
			dx_show=int(txt_show.x-bar.x);
			dy_show=int(txt_show.y-bar.y);
			dy_yn=int(bar.y+bar.height-btn_y.y);
			dy_showyn=int(btn_y.y-txt_show.y-txt_show.height);
		}
		public function setStyle():void {
			barHeight=int(txt_show.height+dy_showyn+dy_show+dy_yn);
			bar.height=barHeight;
			bar.y=- int(barHeight*0.5);
			txt_show.y=bar.y+dy_show;
			if (isYN) {
				btn_y.x=- btn_n.x;
				btn_n.visible=true;
			} else {
				btn_y.x=0;
				btn_n.visible=false;
			}
			btn_n.y=btn_y.y=bar.y+bar.height-dy_yn;
			adjustXY();
		}
		public function setBar(_isDrag:Boolean=true,_isMask:Boolean=true):void {
			if (_isDrag) {
				txt_show.mouseEnabled=false;
				bar.buttonMode=false;
				bar.press = function():void  {
					parent.addChild(this.parent);
					startDrag(false);
				};
				bar.release =function ():void {
					stopDrag();
					adjustXY();
				};
			} else {
				delete bar.press;
				delete bar.release;
			}
			if(_isMask){
				//bar.hitArea=(parent as Sprite);
			}else{
				bar.hitArea=null;
			}
			isMask=_isMask;
			isDrag=_isDrag;
		}
		protected var rect:Rectangle;
		protected function adjustXY():void {
			rect=getRect(this);
			if (- x>rect.left) {
				x=- rect.left;
			} else if (x>stage.stageWidth-rect.right) {
				x=stage.stageWidth-rect.right;
			}
			if (- y>rect.top) {
				y=- rect.top;
			} else if (y>stage.stageHeight-rect.bottom) {
				y=stage.stageHeight-rect.bottom;
			}
			x=int(x);
			y=int(y);
		}
		public function remove():void {
			callBack=null;
			visible=false;
			if (parent) {
				parent.removeChild(this);
			}
		}
	}
}