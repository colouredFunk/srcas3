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
		private var barWidth:int;
		private var barHeight:int;
		private var dx_show:int;
		private var dy_show:int;
		private var dy_showyn:int;
		private var dy_yn:int;
		
		protected var maskArea:Sprite;
		protected var isYN:Boolean;
		protected var isDrag:Boolean;
		protected var isMask:Boolean;
		public var callBack:Function;
		public function Alert() {
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(_evt:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			btn_y.release = function():void {
				if((callBack!=null)?(callBack(true)!= false):true){
					remove();
				}
			};
			btn_n.release=function ():void {
				if((callBack!=null)?(callBack(false)!= false):true){
					remove();
				}
			};
			txt_show.mouseEnabled=false;
			btn_n.autoSize="center";
			btn_y.autoSize="center";
			bar.buttonMode=false;
			bar.press = function():void  {
				parent.addChild(this.parent);
				startDrag();
			};
			bar.release =function ():void {
				stopDrag();
				adjustXY();
			};
			maskArea=new Sprite();
			addChildAt(maskArea,0);
			getStyleParams();
		}
		protected function removed(_evt:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			callBack=null;
			removeChild(maskArea);
		}
		public function alert(_alert:String,_yes:String=null,_no:String=null):void{
			txt_show.text=_alert;
			if(_yes){
				btn_y.label=_yes;
			}
			if(_no){
				btn_n.label=_no;
			}
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
				bar.enabled=true;
			} else {
				bar.enabled=false;
			}
			if(_isMask){
				maskArea.hitArea=(parent as Sprite);
			}else{
				maskArea.hitArea=null;
			}
			isMask=_isMask;
			isDrag=_isDrag;
		}
		private var rect:Rectangle;
		private function adjustXY():void {
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