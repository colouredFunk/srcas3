package ui_2{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.events.Event;
	public class Alert extends Sprite {
		public static var AlertLayer:Sprite;
		public static var AlertClass:Class;
		public static var AlertAppear:Function;
		public var callBack:Function;
		
		private var barWidth:int;
		private var barHeight:int;
		private var dx_show:int;
		private var dy_show:int;
		private var dy_showyn:int;
		private var dy_yn:int;
		
		public var txt_title:*;
		public var txt_show:*;
		public var btn_y:*;
		public var btn_n:*;
		public var btn_x:*;
		public var bar:*;
		
		protected var item:DisplayObject;
		protected var maskArea:Sprite;
		protected var isYN:Boolean;
		protected var isDrag:Boolean;
		protected var isMask:Boolean;
		public function Alert() {
			addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
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
			mouseEnabled = false;
			//txt_show.mouseEnabled = false;
			txt_show.setTxtMouse(true);
			txt_show.html = true;
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
			if (AlertAppear != null) {
				AlertAppear(this);
			}
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			removeChild(maskArea);
			if (item && contains(item)) {
				removeChild(item);
				item = null;
			}
			//txt_titletxt_showbtn_ybtn_nbtn_xbarmaskAreaitem
		}
		public function get text():String{
			return txt_show.text;
		}
		public function set text(_text:String):void{
			txt_show.text=_text;
			setStyle();
		}
		public function get autoSize():String{
			return txt_show.autoSize;
		}
		public function set autoSize(_autoSize:String):void{
			txt_show.autoSize=_autoSize;
			switch(txt_show.autoSize){
				case "left":
					txt_show.x=-int(barWidth*0.5-dx_show);
					break;
				case "right":
					txt_show.x=int(barWidth*0.5-dx_show);
					break;
				case "center":
					txt_show.x=0;
					break;
			}
		}
		public function alert(_alert:String,_isYN:Boolean=false,_yes:String=null,_no:String=null):void{
			if(!stage){
				if(AlertLayer){
					AlertLayer.addChild(this);
					x=int(AlertLayer.stage.stageWidth*0.5);
					y=int(AlertLayer.stage.stageHeight*0.5);
				}else{
					trace("AlertLayer is undefined!" );
					return;
				}
			}
			text=_alert.split("\r\n").join("\r");
			showBtns(true, _isYN, _yes, _no);
			setBar(true,true);
		}
		public function addItem(_item:DisplayObject):void {
			if (item && contains(item)) {
				removeChild(item);
			}
			item = _item;
			addChild(item);
			setStyle();
		}
		public function showBtns(_b:Boolean, _isYN:Boolean = false, _yes:String = null, _no:String = null):void {
			if(_b){
				btn_y.visible = btn_n.visible = _b;
			}else{
				btn_y.visible = btn_n.visible = _b;
			}
			if(_yes){
				btn_y.label = _yes;
			}
			if(_no){
				btn_n.label = _no;
			}
			if (_isYN) {
				btn_y.x = - btn_n.x;
				btn_n.visible = true;
			} else {
				btn_y.x = 0;
				btn_n.visible = false;
			}
			isYN = _isYN;
		}
		public function setBar(_isDrag:Boolean = false, _isMask:Boolean = false):void {
			if (_isDrag) {
				bar.enabled = true;
			} else {
				bar.enabled = false;
			}
			if(_isMask){
				maskArea.hitArea = (parent as Sprite);
			}else{
				maskArea.hitArea = null;
			}
			isMask = _isMask;
			isDrag = _isDrag;
		}
		public function remove():void {
			callBack = null;
			if (parent) {
				parent.removeChild(this);
			}
		}
		private var dy_item:uint = 10;
		public function setStyle():void {
			barHeight = int(txt_show.height + dy_showyn + dy_show + dy_yn);
			if (item) {
				barHeight += item.height + dy_item;
			}
			bar.height = barHeight;
			bar.y = - int(barHeight * 0.5);
			txt_show.y = bar.y + dy_show;
			if (item) {
				item.y = txt_show.y + txt_show.height + dy_item;
			}
			btn_n.y = btn_y.y = bar.y + bar.height - dy_yn;
			adjustXY();
		}
		protected function getStyleParams():void {
			barWidth = int(bar.width);
			dx_show = int(txt_show.x - bar.x);
			dy_show = int(txt_show.y - bar.y);
			dy_yn = int(bar.y + bar.height - btn_y.y);
			dy_showyn = int(btn_y.y - txt_show.y - txt_show.height);
			if (!txt_show.widthMax) {
				txt_show.widthMax = barWidth - dx_show * 2;
			}
		}
		private function adjustXY():void {
			var _rect:Rectangle = getRect(this);
			if ( - x > _rect.left) {
				x = - _rect.left;
			} else if (x > stage.stageWidth - _rect.right) {
				x = stage.stageWidth - _rect.right;
			}
			if ( - y > _rect.top) {
				y = - _rect.top;
			} else if (y > stage.stageHeight - _rect.bottom) {
				y = stage.stageHeight - _rect.bottom;
			}
			x = int(x);
			y = int(y);
		}
		public static function createAlert(_str:String,_isYN:Boolean=false,_yes:String=null,_no:String=null):Alert {
			var _alert:Alert;
			if (AlertClass) {
				_alert = new AlertClass();
			}else {
				_alert = new Alert();
			}
			_alert.alert(_str, _isYN, _yes, _no);
			return _alert;
		}
	}
}