package akdcl.media {
	import akdcl.manager.ElementManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.media.Video;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.events.ContextMenuEvent;

	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	import com.greensock.TweenNano;

	import ui.UISprite;

	import akdcl.utils.addContextMenu;

	/**
	 * ...
	 * @author ...
	 */

	/// @eventType	flash.events.Event.CHANGE
	[Event(name="change",type="flash.events.Event")]
	/// @eventType	flash.events.Event.RESIZE
	[Event(name="resize",type="flash.events.Event")]
	public class DisplayRect extends UISprite {
		protected static const TWEEN_FRAME:uint = 10;
		private static var sourceLabel:String;
		private static var contextMenuStatic:ContextMenu;
		private static var contextMenuItem:ContextMenuItem;

		private static function createMenu(_target:Object):ContextMenu {
			if (!contextMenuStatic){
				contextMenuItem = addContextMenu(_target, "", onMenuItemSelectHandler);
				contextMenuStatic = _target.contextMenu;
				if (contextMenuStatic){
					contextMenuStatic.addEventListener(ContextMenuEvent.MENU_SELECT, onMenuSelectHandler);
				}
			}
			return contextMenuStatic;
		}

		private static function onMenuSelectHandler(_evt:ContextMenuEvent):void {
			var _rect:Object = _evt.contextMenuOwner;
			sourceLabel = _rect.label;
			var _source:String = _rect.label.split("/").pop();
			_source = _source + ": " + _rect.rectWidth + " x " + _rect.rectHeight;
			contextMenuItem.caption = _source;
		}

		private static function onMenuItemSelectHandler(_evt:ContextMenuEvent):void {
			System.setClipboard(sourceLabel);
		}

		protected var tweenOutVar:Object;
		protected var tweenInVar:Object;

		protected var eventChange:Event = new Event(Event.CHANGE);
		protected var eventResize:Event = new Event(Event.RESIZE);

		public var label:String = "Size";
		public var autoUpdate:Boolean = true;
		public var moveRect:Boolean;

		public function get rectWidth():uint {
			return rect.width;
		}

		public function set rectWidth(_w:uint):void {
			if (rect.width == _w){
				return;
			}
			rect.width = _w;
			if (autoUpdate){
				updateRect();
			}
		}

		public function get rectHeight():uint {
			return rect.height;
		}

		public function set rectHeight(_h:uint):void {
			if (rect.height == _h){
				return;
			}
			rect.height = _h;
			if (autoUpdate){
				updateRect();
			}
		}

		private var __scrollX:int = 0;

		public function get scrollX():int {
			return __scrollX;
		}

		public function set scrollX(_value:int):void {
			var _display:Object = displayContent;
			if (_display){
				var _width:Number = rect.width;
				var _dW:Number = originalWidth * _display.scaleX;
				if (_value < -_dW){
					_value = -_dW;
				} else if (_value > _width){
					_value = _width;
				}
				if (_width <= _dW){
					if (_value < _width - _dW){
						__scrollX = (_value + _width - _dW) * 0.5;
					} else if (_value < 0){
						__scrollX = _value;
					} else {
						__scrollX = _value * 0.5;
					}
				} else {
					if (_value < 0){
						__scrollX = _value * 0.5;
					} else if (_value < _width - _dW){
						__scrollX = _value;
					} else {
						__scrollX = (_value + _width - _dW) * 0.5;
					}
				}
				alignX = __scrollX / (_width - _dW);
			}
		}

		private var __scrollY:int = 0;

		public function get scrollY():int {
			return __scrollY;
		}

		public function set scrollY(_value:int):void {
			var _display:Object = displayContent;
			if (_display){
				var _height:Number = rect.height;
				var _dH:Number = originalHeight * _display.scaleY;
				if (_value < -_dH){
					_value = -_dH;
				} else if (_value > _height){
					_value = _height;
				}
				if (_height <= _dH){
					if (_value < _height - _dH){
						__scrollY = (_value + _height - _dH) * 0.5;
					} else if (_value < 0){
						__scrollY = _value;
					} else {
						__scrollY = _value * 0.5;
					}
				} else {
					if (_value < 0){
						__scrollY = _value * 0.5;
					} else if (_value < _height - _dH){
						__scrollY = _value;
					} else {
						__scrollY = (_value + _height - _dH) * 0.5;
					}
				}
				alignY = __scrollY / (_height - _dH);
			}
		}

		private var __alignX:Number = 0;

		public function get alignX():Number {
			return __alignX;
		}

		public function set alignX(_value:Number):void {
			if (__alignX == _value){
				return;
			}
			__alignX = _value;
			updateScrollXY();
		}

		private var __alignY:Number = 0;

		public function get alignY():Number {
			return __alignY;
		}

		public function set alignY(_value:Number):void {
			if (__alignY == _value){
				return;
			}
			__alignY = _value;
			updateScrollXY();
		}

		//-1:outside,0:noscale,1:inside;
		//>1||<-1:scale
		//NaN:stretch,10:onlywidth,-10:onlyheight;
		private var __scaleMode:Number = 1;

		public function get scaleMode():Number {
			return __scaleMode;
		}

		public function set scaleMode(_value:Number):void {
			if (__scaleMode == _value){
				return;
			}
			__scaleMode = _value;
			if (autoUpdate){
				updateRect();
			}
		}

		public function get displayContent():DisplayObject {
			return (content is BitmapData ? bitmap : content) as DisplayObject;
		}

		protected var rect:Rectangle;
		protected var bitmap:Bitmap;
		protected var content:Object;
		protected var contentReady:Object;

		protected var isHidding:Boolean = false;

		protected var tweenMode:int;
		protected var alignXReady:Number;
		protected var alignYReady:Number;
		protected var scaleModeReady:Number;

		private var originalWidth:int;
		private var originalHeight:int;
		private var aspectRatio:Number;
		private var offX:int;
		private var offY:int;

		public function DisplayRect(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = 0):void {
			rect = new Rectangle();
			if (_rectWidth + _rectHeight > 0){
				rect = new Rectangle();
				rect.width = _rectWidth;
				rect.height = _rectHeight;
			} else {
				rect = getRect(this);
				rect.y = rect.x = 0;
			}
			if (_bgColor >= 0){
				opaqueBackground = _bgColor;
			}
			super();
		}

		override protected function init():void {
			super.init();
			tweenOutVar = {alpha: 0, useFrames: true, onComplete: onHideCompleteHandler};
			tweenInVar = {alpha: 1, useFrames: true};
			bitmap = new Bitmap();
			addChild(bitmap);
			contextMenu = createMenu(this);
			mouseChildren = false;
		}

		override protected function onRemoveToStageHandler():void {
			TweenNano.killTweensOf(bitmap);
			bitmap.bitmapData = null;
			super.onRemoveToStageHandler();
			rect = null;
			bitmap = null;
			content = null;
			contentReady = null;

			tweenOutVar = null;
			tweenInVar = null;
			eventChange = null;
			eventResize = null;
		}

		public function updateRect():void {
			var _display:Object = displayContent;
			if (_display){
				var _width:Number = rect.width;
				var _height:Number = rect.height;
				var _scaleABS:Number = Math.abs(__scaleMode);
				switch (_scaleABS){
					case NaN:
						_display.scaleX = _width / originalWidth;
						_display.scaleY = _height / originalHeight;
						break;
					case 10:
						if (__scaleMode > 0){
							_display.scaleX = _width / originalWidth;
						} else {
							_display.scaleY = _height / originalHeight;
						}
						break;
					default:
						var _scale:Number;
						if (__scaleMode < 0 ? (_width / _height > aspectRatio) : (_width / _height < aspectRatio)){
							_scale = _width / originalWidth;
						} else {
							_scale = _height / originalHeight;
						}
						if (_scaleABS <= 1){
							_scale = 1 + (_scale - 1) * _scaleABS;
						} else {
							_scale = (1 + (_scale - 1)) * _scaleABS;
						}
						_display.scaleY = _display.scaleX = _scale;
						break;
				}
				updateScrollXY();
			}
			scrollRect = rect;
			if (hasEventListener(Event.RESIZE)){
				if (!eventResize){
					eventResize = new Event(Event.RESIZE);
					dispatchEvent(eventResize);
				}
			}

			protected function updateScrollXY():void {
				var _display:Object = displayContent;
				if (_display){
					var _width:Number = rect.width;
					var _height:Number = rect.height;
					var _dW:Number = originalWidth * _display.scaleX;
					var _dH:Number = originalHeight * _display.scaleY;
					var _x:Number = -offX * _display.scaleX;
					var _y:Number = -offY * _display.scaleY;

					__scrollX = (_width - _dW) * __alignX;
					__scrollY = (_height - _dH) * __alignY;

					if (moveRect){
						_display.x = _x;
						_display.y = _y;
						rect.x = -__scrollX;
						rect.y = -__scrollY;
					} else {
						_display.x = __scrollX + _x;
						_display.y = __scrollY + _y;
						rect.x = 0;
						rect.y = 0;
					}
						//_width / _dW, _height / _dH
				}
			}

			public function setContent(_content:Object = null, _tweenMode:int = 2, _alignX:Number = 0.5, _alignY:Number = 0.5, _scaleMode:Number = 1):void {
				contentReady = _content;
				if (isHidding){
					return;
				}
				alignXReady = _alignX;
				alignYReady = _alignY;
				scaleModeReady = _scaleMode;
				tweenMode = _tweenMode;
				isHidding = true;
				if (content && tweenMode == 2 ? true : false){
					TweenNano.killTweensOf(displayContent);
					TweenNano.to(displayContent, tweenMode > 2 ? tweenMode : TWEEN_FRAME, tweenOutVar);
				} else {
					onHideCompleteHandler();
				}
			}

			protected function onHideCompleteHandler():void {
				if (content){
					TweenNano.killTweensOf(displayContent);
					if (content is BitmapData){
						bitmap.bitmapData = null;
					} else {
						removeChild(content as DisplayObject);
					}
				}
				isHidding = false;
				showContent();
			}

			protected function showContent():void {
				content = contentReady;
				contentReady = null;
				var _display:Object;
				if (content is BitmapData){
					bitmap.bitmapData = content as BitmapData;
					bitmap.smoothing = true;
					_display = bitmap;
				} else if (content){
					addChildAt(content as DisplayObject, getChildIndex(bitmap));
					_display = content;
				}
				if (_display){
					//
					if (tweenMode > 0){
						_display.alpha = 0;
						TweenNano.to(_display, tweenMode > 2 ? tweenMode : TWEEN_FRAME, tweenInVar);
					}
					//
					offX = offY = 0;
					if (_display is Bitmap){
						originalWidth = _display.width / _display.scaleX;
						originalHeight = _display.height / _display.scaleY;
					} else if (_display is Loader){
						originalWidth = _display.contentLoaderInfo.width;
						originalHeight = _display.contentLoaderInfo.height;
					} else if (_display is Video){
						originalWidth = _display.videoWidth || _display.width / _display.scaleX;
						originalHeight = _display.videoHeight || _display.height / _display.scaleY;
					} else if (_display is DisplayObject){
						var _rect:Rectangle = _display.getRect(_display);
						offX = _rect.x;
						offY = _rect.y;
						originalWidth = _display.width / _display.scaleX;
						originalHeight = _display.height / _display.scaleY;
					} else {

					}
					aspectRatio = originalWidth / originalHeight;
					__alignX = alignXReady;
					__alignY = alignYReady;
					__scaleMode = scaleModeReady;
					updateRect();
					if (hasEventListener(Event.CHANGE)){
						if (!eventChange){
							eventChange = new Event(Event.CHANGE);
						}
						dispatchEvent(eventChange);
					}
				}
			}
		}
	}
