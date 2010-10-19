package ui{
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	import flash.geom.Point;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	public class Alert extends UISprite {
		public static var AlertLayer:Sprite;
		public static var AlertClass:Class;
		public static var AlertAppear:Function;
		public static var TxtMouseEnabled:Boolean;
		public static var AlertPoint:Point;
		
		public static function show(_str:String, _ctrlLabel:* = "确定|取消", _callBack:Function = null):Alert {
			var _alert:Alert;
			if (AlertClass) {
				_alert = new AlertClass();
			}else {
				_alert = new Alert();
			}
			//_alert.alert(_str, _ctrlLabel);
			_alert.label = _ctrlLabel;
			_alert.callBack = _callBack;
			return _alert;
		}
		
		public var callBack:Function;
		
		public var txtTitle:*;
		public var txtText:*;
		public var btnY:*;
		public var btnX:*;
		public var bar:*;
		
		protected var maskArea:SimpleBtn;
		
		protected var item:DisplayObject;
		
		protected var widthAddText:int;
		protected var offXLabel:int;
		protected var dYBtnTopToBarBottom:uint;
		protected var dYTextBottomToBarBottom:uint;
		protected var btnList:Array;
		
		//
		private var __barWidth:uint;
		public function get barWidth():uint{
			return __barWidth;
		}
		public function set barWidth(_barWidth:uint):void{
			__barWidth = _barWidth;
			bar.width = __barWidth;
			txtText.width = __barWidth - widthAddText;
			barHeight = 0;
		}
		//
		private var __barHeight:uint;
		public function get barHeight():uint{
			return __barHeight;
		}
		public function set barHeight(_barHeight:uint):void {
			__barHeight = Math.max(_barHeight, txtText.y + txtText.height + dYTextBottomToBarBottom);
			bar.height = __barHeight;
			if (!btnY.visible) {
				bar.height -= int(btnY.height);
			}
			setStyle();
		}
		//
		public function get autoSize():String{
			return "";
		}
		public function set autoSize(_autoSize:String):void {
			"";
		}
		//
		public function get text():String{
			return txtText.text;
		}
		public function set text(_text:String):void{
			txtText.htmlText = _text;
			barHeight = 0;
		}
		//
		private var __labelWidth:uint;
		public function get labelWidth():uint{
			return __labelWidth;
		}
		public function set labelWidth(_labelWidth:uint):void{
			__labelWidth = _labelWidth;
		}
		//
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
			if (labelList[0] == "") {
				labelList.pop();
			}
			Common.copyInstanceToArray(btnY, Math.max(labelList.length, btnList.length), btnList, setBtn);
		}
		//
		private var __labelsAutoSize:String = TextFieldAutoSize.CENTER;
		public function get labelsAutoSize():String{
			return __labelsAutoSize;
		}
		public function set labelsAutoSize(_labelsAutoSize:String):void{
			__labelsAutoSize = _labelsAutoSize;
			setStyle();
		}
		//
		private var __dragEnabled:Boolean;
		public function get dragEnabled():Boolean{
			return __dragEnabled;
		}
		public function set dragEnabled(_dragEnabled:Boolean):void{
			__dragEnabled = _dragEnabled;
			if (__dragEnabled) {
				bar.enabled = true;
			} else {
				bar.enabled = false;
			}
		}
		//
		private var __maskEnabled:Boolean;
		public function get maskEnabled():Boolean{
			return __maskEnabled;
		}
		public function set maskEnabled(_maskEnabled:Boolean):void{
			__maskEnabled = _maskEnabled;
			if (__maskEnabled) {
				maskArea.enabled = true;
			} else {
				maskArea.enabled = false;
			}
		}
		//
		override protected function init():void {
			super.init();
			__barWidth = int(bar.width);
			widthAddText = __barWidth - txtText.width;
			offXLabel = int(btnY.x);
			__labelWidth = int(btnY.width);
			dYBtnTopToBarBottom = bar.height - btnY.y;
			dYTextBottomToBarBottom = bar.height - (txtText.y + txtText.height);
			
			
			txtText.autoSize = "left";
			txtText.mouseWheelEnabled = false;
			btnList = [btnY];
			bar.press = pressBar;
			bar.release = releaseBar;
			bar.useHandCursor = false;
			maskArea = new SimpleBtn();
			addChildAt(maskArea, 0);
			maskArea.useHandCursor = false;
			maskArea.release = winkBar;
			mouseEnabled = false;
			dragEnabled = true;
			maskEnabled = true;
			label = 1;
			/*if(!stage){
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
			setBar(true,true);*/
		}
		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			setStyle();
			maskArea.hitArea = parent as Sprite;
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
		}
		protected function pressBar():void {
			parent.addChild(this);
			startDrag();
		}
		protected function releaseBar():void {
			stopDrag();
			adjustXY();
		}
		private var isWinking:Boolean;
		protected function winkBar():void {
			if (isWinking) {
				return;
			}
			isWinking = true;
			//TweenMax.to(bar, 0.1, { colorMatrixFilter: { contrast:1.5, brightness:1.5 }, yoyo:true, repeat:3 ,ease:Cubic.easeInOut, onComplete:onWinkBarEndHandle } );
		}
		protected function onWinkBarEndHandle():void {
			isWinking = false;
		}
		protected function setBtn(_btn:*, _id:uint, ...args):void {
			if (args[1]) {
				addChildAt(_btn, getChildIndex(btnY));
			}
			if (_id >= labelList.length) {
				_btn.visible = false;
			}else {
				_btn.visible = true;
				_btn.widthMax = labelWidth;
				_btn.label = labelList[_id];
				_btn.autoSize = labelsAutoSize;
				if (!_btn.userData) {
					_btn.userData = { };
				}
				switch(labelList.length) {
					case 0:
					break;
					case 1:
						_btn.userData.btnFlag = true;
					break;
					case 2:
						_btn.userData.btnFlag = (_id == 0);
					break;
					default:
						_btn.userData.btnFlag = _id;
				}
				_btn.release=function ():void {
					btnRelease(this.userData.btnFlag);
				}
			}
		}
		protected function btnRelease(_flag:*):void {
			if ((callBack != null)?(callBack(_flag) != false):true) {
				remove();
			}
		}
		protected function setBtnStyle(_btn:*, _id:uint, ...args):void {
			var _perWidth:uint = (barWidth - offXLabel * 2) / (labelList.length);
			switch(labelsAutoSize) {
				case TextFieldAutoSize.CENTER:
					_btn.x = barWidth * 0.5 + _perWidth * (_id - (labelList.length - 1) * 0.5);
				break;
				case TextFieldAutoSize.RIGHT:
					_btn.x = barWidth - offXLabel - _perWidth * (labelList.length - _id - 1);
				break;
				case TextFieldAutoSize.LEFT:
				default:
					_btn.x = offXLabel + _perWidth * _id;
				break;
			}
			_btn.y = barHeight - dYBtnTopToBarBottom;
		}
		public function setStyle():void {
			btnList.forEach(setBtnStyle);
			adjustXY();
		}
		protected function adjustXY():void {
			/*var _rect:Rectangle = getRect(stage);
			if ( - x > _rect.left) {
				x = - _rect.left;
			} else if (x > stage.stageWidth - _rect.right) {
				x = stage.stageWidth - _rect.right;
			}
			if ( - y > _rect.top) {
				y = - _rect.top;
			} else if (y > stage.stageHeight - _rect.bottom) {
				y = stage.stageHeight - _rect.bottom;
			}*/
			if (!stage) {
				return;
			}
			if ( x < 0) {
				x = 0;
			} else if (x > stage.stageWidth - barWidth) {
				x = stage.stageWidth - barWidth;
			}
			if ( y < 0) {
				y = 0;
			} else if (y > stage.stageHeight - barHeight) {
				y = stage.stageHeight - barHeight;
			}
			x = int(x);
			y = int(y);
		}
	}
}