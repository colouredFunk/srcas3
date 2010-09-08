package akdcl.application
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import com.greensock.TweenMax;
	import akdcl.application.PicPlayer;
	import flash.text.TextField;
	import ui_2.ProgressBar;
	import ui_2.SimpleBtn;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  PicPlayerSkin extends Sprite
	{
		public var bar_progress:ProgressBar;
		public var btn_0, btn_1, btn_2, btn_3, btn_4, btn_5, btn_6, btn_7, btn_8, btn_9:*;
		public var btn_info:*;
		public var btn_progress:*;
		public var btn_prev:*;
		public var btn_next:*;
		public var btnsContainer:Sprite;
		
		public var btn_select:*;
		public var btnList:Array;
		protected var picPlayer:PicPlayer;
		public var iconWidth:uint;
		public var iconHeight:uint;
		public var onSeted:Function;
		public function PicPlayerSkin() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		protected function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
			visible = false;
			alpha = 0;
			if (btn_0&&btn_0.icon) {
				iconWidth = btn_0.icon.width;
				iconHeight = btn_0.icon.height;
			}
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			picPlayer.removeEventListener(PicPlayer.LOADING, onPlayerLoadingHandle);
			picPlayer.removeEventListener(PicPlayer.STATE_CHANGE,onPlayerStateChangeHandle);
			picPlayer.removeEventListener(PicPlayer.LOADING,onPlayerLoadingHandle);
			picPlayer = null;
		}
		public function setPlayer(_picPlayer:PicPlayer):void {
			picPlayer = _picPlayer;
			picPlayer.addEventListener(PicPlayer.XML_LOADED, onPlayerXmlLoadedHandle);
			picPlayer.addEventListener(PicPlayer.STATE_CHANGE,onPlayerStateChangeHandle);
			picPlayer.addEventListener(PicPlayer.LOADING, onPlayerLoadingHandle);
			if (bar_progress) {
				bar_progress.mouseEnabled = false;
				bar_progress.mouseChildren = false;
			}
			if (btn_info && (btn_info is SimpleBtn)) {
				btn_info.release = picPlayer.clickPic;
			}
			if (btn_prev) {
				btn_prev.release = function():void {
					picPlayer.id_pic--;
				}
			}
			if (btn_next) {
				btn_next.release =function():void {
					picPlayer.id_pic++;
				}
			}
			if (btn_progress) {
				//btn_progress
			}
		}
		public function eachBtn(_fun:Function):void {
			if (!btnList) {
				return;
			}
			btnList.forEach(_fun);
		}
		private var __isRollOver:Boolean = false;
		public function get isRollOver():Boolean {
			return __isRollOver;
		}
		[Inspectable(defaultValue = false, type = "Boolean", name = "是否指向选择")]
		public function set isRollOver(_isRollOver:Boolean):void {
			__isRollOver = _isRollOver;
		}
		private var __against:Boolean = false;
		public function get against():Boolean {
			return __against;
		}
		[Inspectable(defaultValue = false, type = "Boolean", name = "标签是否逆向对齐")]
		public function set against(_against:Boolean):void {
			__against = _against;
		}
		private var __horizontal:Boolean = true;
		public function get horizontal():Boolean {
			return __horizontal;
		}
		[Inspectable(defaultValue = true, type = "Boolean", name = "标签是否水平排布")]
		public function set horizontal(_horizontal:Boolean):void {
			__horizontal = _horizontal;
		}
		private var __btnDistance:uint = 25;
		public function get btnDistance():uint {
			return __btnDistance;
		}
		[Inspectable(defaultValue = 25, type = "uint", name = "标签间距")]
		public function set btnDistance(_btnDistance:uint):void {
			__btnDistance = _btnDistance;
		}
		protected var startX:uint;
		protected var startY:uint;
		protected function onPlayerXmlLoadedHandle(_evt:Event):void {
			TweenMax.to(this, picPlayer.timeTween, { autoAlpha:1 } );
			if (!btn_0) {
				return;
			}
			btnList = [];
			var _btn:*;
			var _i:uint;
			for (_i = 0; _i < 10; _i++ ) {
				_btn = this["btn_" + _i];
				if (!_btn) {
					break;
				}
				_btn.visible=false;
				btnList[_i] = _btn;
			}
			var _isFrom:Boolean;
			if (btnList.length > 1) {
				_isFrom = true;
			}
			startX = btn_0.x;
			startY = btn_0.y;
			btnsContainer = new Sprite();
			addChild(btnsContainer);
			//Common.copyInstanceToArray();
			var _BtnClass:Class = btn_0.constructor as Class;
			for (_i = 0; _i < picPlayer.picLength; _i++ ) {
				_btn = btnList[_i];
				if (_isFrom) {
					setBtn(_btn, _i);
					continue;
				}
				if (!_btn) {
					_btn = new _BtnClass();
					addChild(_btn);
					btnList[_i] = _btn;
				}
				_btn.needReload = true;
				if (horizontal) {
					_btn.y = startY;
					if (against) {
						_btn.x = startX + (_i-picPlayer.picLength+1) * btnDistance;
					}else {
						_btn.x = startX + _i * btnDistance;
					}
				}else {
					_btn.x = startX;
					if (against) {
						_btn.y = startY + (_i-picPlayer.picLength+1) * btnDistance;
					}else {
						_btn.y = startY + _i * btnDistance;
					}
					_btn.y = startY + _i * (against? -btnDistance:btnDistance);
				}
				btnsContainer.addChild(_btn);
				setBtn(_btn, _i);
			}
			if (onSeted!=null) {
				onSeted();
			}
		}
		protected function setBtn(_btn:*, _id:uint):void {
			if (!_btn) {
				return;
			}
			try {
				_btn.visible=true;
				_btn.autoSize = "center";
				var _icon:String = String(picPlayer.getPicXML(_id).@icon);
				if (_icon.length>0) {
					if (!_btn.icon) {
						_btn.icon = new Sprite();
						_btn.addChild(_btn.icon);
					}
					_btn.icon.addChild(Common.loader(_icon,onIconLoadedHandle));
					_btn.label = "";
				}else {
					var _label:String = String(picPlayer.getPicXML(_id).@label);
					_btn.label = _label || String(_id + 1);
				}
			}catch (_ero:*) {
				
			}
			
			_btn.userData = { id:_id };
			_btn.release = function():void {
				picPlayer.id_pic = this.userData.id;
			}
			if (isRollOver) {
				_btn.rollOver = _btn.release;
			}
		}
		protected function onIconLoadedHandle(_evt:Event):void {
			var _loader:Loader = _evt.currentTarget.loader;
			_loader.width = iconWidth;
			_loader.height = iconHeight;
			(_loader.content as Bitmap).smoothing = true;
		}
		protected function onPlayerLoadingHandle(_evt:ProgressEvent):void{
			if (!bar_progress) {
				return;
			}
			var _value:Number = _evt.bytesLoaded / _evt.bytesTotal;
			bar_progress.value=_value;
			if(bar_progress.value==1){
				TweenMax.to(bar_progress,picPlayer.timeTween,{autoAlpha:0});
			}else if(!bar_progress.visible){
				TweenMax.to(bar_progress,picPlayer.timeTween,{autoAlpha:1});
			}
		}
		protected function onPlayerStateChangeHandle(_evt:Event):void {
			switch (picPlayer.state) {
				case PicPlayer.LOADED:
				case PicPlayer.RELOADED:
					if (btn_info) {
						if (btn_info is SimpleBtn) {
							btn_info.html = true;
							btn_info.label = Common.replaceStr(picPlayer.getPicXML(picPlayer.id_pic).info);
						}else if(btn_info is TextField){
							btn_info.htmlText = Common.replaceStr(picPlayer.getPicXML(picPlayer.id_pic).info);
						}
					}
					if (btn_progress) {
						btn_progress.label = (picPlayer.id_pic + 1) + " / " + picPlayer.picLength;
					}
					if (!btn_0) {
						return;
					}
					btn_select = btnList[picPlayer.id_pic];
					if (btn_select) {
						btn_select.select = true;
					}
					if (btnsContainer.mask) {
						var _x:int;
						if (btn_select.x < btnsContainer.mask.x) {
							_x = btnsContainer.mask.x - btn_select.x;
							TweenMax.to(btnsContainer, 0.3, { x:_x } );
						}else if (btn_select.x + btn_select.width > btnsContainer.mask.x + btnsContainer.mask.width) {
							_x = btnsContainer.mask.x + btnsContainer.mask.width - btn_select.width;
							_x = btn_select.x - _x;
							TweenMax.to(btnsContainer, 0.3, { x:-_x } );
						}
					}
					break;
				case PicPlayer.TWEENED:
					mouseChildren = true;
					mouseEnabled = true;
					picPlayer.mouseChildren = true;
					picPlayer.mouseEnabled = true;
					break;
				case PicPlayer.LOAD:
				case PicPlayer.RELOAD:
					mouseChildren = false;
					mouseEnabled = false;
					picPlayer.mouseChildren = false;
					picPlayer.mouseEnabled = false;
					if (btn_select) {
						btn_select.select = false;
					}
					break;
			}
		}
	}
}