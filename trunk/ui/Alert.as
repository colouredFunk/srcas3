package ui{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	public class Alert extends SimpleBtn {
		public static var AlertLayer:Sprite;
		public static var AlertClass:Class;
		public static var AlertAppear:Function;
		public static var TxtMouseEnabled:Boolean;
		public static var AlertPoint:Point;
		
		public var callBack:Function;
		
		public var barWidth:int;
		private var barHeight:int;
		private var dx_show:int;
		private var dy_show:int;
		private var dy_showyn:int;
		private var dy_yn:int;
		private var dy_x:int;
		
		public var txt_title:*;
		public var txt_show:*;
		public var btn_y:*;
		public var btnN:*;
		public var btnX:*;
		public var bar:*;
		
		protected var item:DisplayObject;
		protected var maskArea:SimpleBtn;
		protected var isYN:Boolean;
		protected var dragEnabled:Boolean;
		protected var isMask:Boolean;
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
			btnN.release=function ():void {
				if((callBack!=null)?(callBack(false)!= false):true){
					remove();
				}
			};
			if (btnX) {
				btnX.release = btnN.release;
			}
			mouseEnabled = false;
			txt_show.mouseEnabled = TxtMouseEnabled;
			txt_show.mouseChildren = TxtMouseEnabled;
			txt_show.setTxtMouse(TxtMouseEnabled);
			txt_show.html = true;
			btnN.autoSize="center";
			btn_y.autoSize="center";
			bar.rollOver = function():void {
				this.buttonMode = false;
				this.rollOver = null;
			}
			bar.press = function():void  {
				parent.addChild(this.parent);
				startDrag();
			};
			bar.release =function ():void {
				stopDrag();
				adjustXY();
			};
			maskArea = new SimpleBtn();
			addChildAt(maskArea,0);
			maskArea.buttonMode = false;
			maskArea.release = winkBar;
			getStyleParams();
			if (AlertAppear != null) {
				AlertAppear(this);
			}
		}
		private var isWinking:Boolean;
		protected function winkBar():void {
			if (isWinking) {
				return;
			}
			isWinking = true;
			TweenMax.to(bar, 0.1, { colorMatrixFilter: { contrast:1.5, brightness:1.5 }, yoyo:true, repeat:3 ,ease:Cubic.easeInOut, onComplete:onWinkBarEndHandle } );
		}
		protected function onWinkBarEndHandle():void {
			isWinking = false;
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			removeChild(maskArea);
			if (item && contains(item)) {
				removeChild(item);
				item = null;
			}
			callBack = null;
			
			//txt_titletxt_showbtn_ybtnNbtnXbarmaskAreaitem
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
					if (AlertPoint) {
						x = AlertPoint.x;
						y = AlertPoint.y;
					}else {
						x=int(AlertLayer.stage.stageWidth*0.5);
						y=int(AlertLayer.stage.stageHeight*0.5);
					}
				}else{
					trace("AlertLayer is undefined!" );
					return;
				}
			}
			text=_alert.split("\r\n").join("\r");
			showBtns(true, _isYN, _yes, _no);
			setBar(true,true);
		}
		public function addItem(_item:DisplayObject, _itemHeight:uint = 0):void {
			if (item && contains(item)) {
				removeChild(item);
			}
			if (itemHeight!=0) {
				itemHeight = _itemHeight;
			}else {
				itemHeight = _item.height;
			}
			item = _item;
			addChild(item);
			setStyle();
		}
		public function showBtns(_b:Boolean, _isYN:Boolean = false, _yes:String = null, _no:String = null):void {
			btn_y.visible = btnN.visible = _b;
			if (btnX) {
				btnX.visible = _b;
			}
			if(_yes){
				btn_y.label = _yes;
			}
			if(_no){
				btnN.label = _no;
			}
			if (_isYN) {
				btn_y.x = - btnN.x;
				btnN.visible = true;
			} else {
				btn_y.x = 0;
				btnN.visible = false;
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
			dragEnabled = _isDrag;
		}
		public function remove():void {
			callBack = null;
			if (parent) {
				parent.removeChild(this);
			}
		}
		private var dy_item:uint = 10;
		private var itemHeight:uint;
		public function setStyle():void {
			barHeight = int(txt_show.height + dy_showyn + dy_show + dy_yn);
			if (item) {
				barHeight += (itemHeight?itemHeight:txt_show.height) + dy_item;
			}
			bar.height = barHeight;
			bar.y = - int(barHeight * 0.5);
			txt_show.y = bar.y + dy_show;
			if (item) {
				item.y = txt_show.y + txt_show.height + dy_item;
			}
			btnN.y = btn_y.y = bar.y + barHeight - dy_yn;
			if (btnX) {
				btnX.y = dy_x - barHeight * 0.5;
			}
			adjustXY();
		}
		protected function getStyleParams():void {
			barWidth = int(bar.width);
			dx_show = int(txt_show.x - bar.x);
			dy_show = int(txt_show.y - bar.y);
			dy_yn = int(bar.y + bar.height - btn_y.y);
			if (btnX) {
				dy_x = int(btnX.y - bar.y);
			}
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
	}
}