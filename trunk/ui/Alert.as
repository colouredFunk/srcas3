package ui{
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	public class Alert extends UISprite {
		public static var AlertLayer:Sprite;
		public static var AlertClass:Class;
		public static var AlertAppear:Function;
		public static var TxtMouseEnabled:Boolean;
		public static var AlertPoint:Point;
		
		public static function show(_str:String, _ctrlLabel:* = "确定|取消", _callBack:Function):Alert {
			var _alert:Alert;
			if (AlertClass) {
				_alert = new AlertClass();
			}else {
				_alert = new Alert();
			}
			_alert.alert(_str, _ctrlLabel);
			_alert.callBack = _callBack;
			return _alert;
		}
		
		public var callBack:Function;
		
		public var barWidth:int;
		private var barHeight:int;
		private var dx_show:int;
		private var dy_show:int;
		private var dy_showyn:int;
		private var dy_yn:int;
		private var dy_x:int;
		
		protected var offXLabel:int;
		
		public var txtTitle:*;
		public var txtText:*;
		public var btnY:*;
		public var btnX:*;
		public var bar:*;
		protected var btnList:Array;
		
		protected var item:DisplayObject;
		
		//protected var maskArea:SimpleBtn;
		//protected var dragEnabled:Boolean;
		//protected var isMask:Boolean;
		
		public function get text():String{
			return txtText.text;
		}
		public function set text(_text:String):void{
			txtText.text=_text;
			setStyle();
		}
		public function get autoSize():String{
			return txtText.autoSize;
		}
		public function set autoSize(_autoSize:String):void{
			txtText.autoSize=_autoSize;
			switch(txtText.autoSize){
				case "left":
					txtText.x=-int(barWidth*0.5-dx_show);
					break;
				case "right":
					txtText.x=int(barWidth*0.5-dx_show);
					break;
				case "center":
					txtText.x=0;
					break;
			}
		}
		override protected function init():void {
			super.init();
			btnY.release = function():void {
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
			
			
			offXLabel = btnY.x;
			__labelWidth = int(btnY.width);
			
			btnList = [btnY];
			mouseEnabled = false;
			txtText.html = true;
			txtText.enabled = false;
			bar.press = pressBar;
			bar.release = releaseBar;
			
			
			
			
			
			
			
			
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
					trace("AlertLayer is undefined!");
					return;
				}
			}
			text=_alert.split("\r\n").join("\r");
			showBtns(true, _isYN, _yes, _no);
			setBar(true,true);
			
			
			
			
			
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
		}
		protected function pressBar():void {
			parent.addChild(this);
			startDrag();
		}
		protected function releaseBar():void {
			parent.addChild(this);
			startDrag();
		}
		private var __labelWidth:uint;
		public function get labelWidth():uint{
			return __labelWidth;
		}
		public function set labelWidth(_labelWidth:uint):void{
			__labelWidth = _labelWidth;
		}
		protected var labelList:Array;
		public function get label():* {
			return labelList;
		}
		public function set label(_label:*):void {
			if (_label is Number) {
				switch(_label) {
					case 0:
						_label = "";
					break;
					case 1:
						_label="确定"
					break;
					case 2:
						_label="确定|取消"
					break;
					default:
					_label = "确定|取消";
					for (var _i:uint = 2; _i < _label; _i++ ) {
						_label += "| ";
					}
				}
			}
			_label = String(_label);
			labelList = _label.split("|");
			Common.copyInstanceToArray(btnY, Math.max(labelList.length, btnList.length), btnList, setBtn);
		}
		protected function setBtn(_btn:*, _id:uint, ...args):void {
			addChildAt(_btn, getChildIndex(btnY));
			_btn.widthMax = labelWidth;
			_btn.label = labelList[_id];
			_btn.autoSize = labelAutoSize;
			switch(labelAutoSize) {
				case TextFieldAutoSize.LEFT:
					_btn.x = offXLabel + labelWidth * _id;
				break;
				case TextFieldAutoSize.CENTER:
				break;
				case TextFieldAutoSize.RIGHT;
					_btn.x = offXLabel + labelWidth * _id;
				break;
			}
		}
		
		/*
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
		}*/
		private var dy_item:uint = 10;
		private var itemHeight:uint;
		public function setStyle():void {
			barHeight = int(txtText.height + dy_showyn + dy_show + dy_yn);
			if (item) {
				barHeight += (itemHeight?itemHeight:txtText.height) + dy_item;
			}
			bar.height = barHeight;
			bar.y = - int(barHeight * 0.5);
			txtText.y = bar.y + dy_show;
			if (item) {
				item.y = txtText.y + txtText.height + dy_item;
			}
			btnN.y = btnY.y = bar.y + barHeight - dy_yn;
			if (btnX) {
				btnX.y = dy_x - barHeight * 0.5;
			}
			adjustXY();
		}
		protected function getStyleParams():void {
			barWidth = int(bar.width);
			dx_show = int(txtText.x - bar.x);
			dy_show = int(txtText.y - bar.y);
			dy_yn = int(bar.y + bar.height - btnY.y);
			if (btnX) {
				dy_x = int(btnX.y - bar.y);
			}
			dy_showyn = int(btnY.y - txtText.y - txtText.height);
			if (!txtText.widthMax) {
				txtText.widthMax = barWidth - dx_show * 2;
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