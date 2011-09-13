package akdcl.media {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
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
	public class DisplayRect extends UISprite {
		protected static const TWEEN_FRAME:uint = 10;
		private static var sourceLabel:String;
		private static var contextMenuStatic:ContextMenu;
		private static var contextMenuItem:ContextMenuItem;
		private static function createMenu(_target:Object):ContextMenu {
			if (!contextMenuStatic){
				contextMenuItem = addContextMenu(_target, "", onMenuItemSelectHandler);
				contextMenuStatic = _target.contextMenu;
				contextMenuStatic.addEventListener(ContextMenuEvent.MENU_SELECT, onMenuSelectHandler);
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
		
		public var autoUpdate:Boolean = true;
		public var label:String = "Size";
		
		protected var rect:Rectangle;
		protected var bitmap:Bitmap;
		protected var content:Object;
		protected var contentReady:Object;
		protected var contentWidth:uint;
		protected var contentHeight:uint;
		protected var offX:Number;
		protected var offY:Number;
		
		protected var isHidding:Boolean = false;
		protected var tweenMode:int;
		protected var useScrollRect:Boolean = true;
		
		protected var tweenOutVar:Object;
		protected var tweenInVar:Object;

		public function get rectWidth():uint {
			return rect.width;
		}
		public function set rectWidth(_w:uint):void {
			if (rect.width == _w) {
				return;
			}
			rect.width = _w;
			__heightOnly = false;
			if (autoUpdate) {
				updateRect();
			}
		}

		public function get rectHeight():uint {
			return rect.height;
		}
		public function set rectHeight(_h:uint):void {
			if (rect.height == _h) {
				return;
			}
			rect.height = _h;
			__widthOnly = false;
			if (autoUpdate) {
				updateRect();
			}
		}

		private var __widthOnly:Boolean;
		public function get widthOnly():Boolean {
			return __widthOnly;
		}
		public function set widthOnly(_widthOnly:Boolean):void {
			__widthOnly = _widthOnly;
			updateRect();
		}

		private var __heightOnly:Boolean;
		public function get heightOnly():Boolean {
			return __heightOnly;
		}
		public function set heightOnly(_heightOnly:Boolean):void {
			__heightOnly = _heightOnly;
			updateRect();
		}
		
		//0:等比内部填充,(0~1]:限制缩放比，-1:等比外部填充
		private var __scaleMode:Number = 3;
		public function get scaleMode():Number {
			return __scaleMode;
		}
		public function set scaleMode(_scaleMode:Number):void {
			__scaleMode = _scaleMode;
			updateRect();
		}
		
		public function DisplayRect(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = 0):void {
			rect = new Rectangle();
			var _rect:Rectangle = getRect(this);
			if (_rect.width > 16 || _rectWidth > 0) {
				rect.width = _rectWidth || _rect.width;
				__heightOnly = false;
			} else {
				__heightOnly = true;
			}
			if (_rect.height > 16 || _rectHeight > 0) {
				rect.height = _rectHeight || _rect.height;
				__widthOnly = false;
			} else {
				__widthOnly = true;
			}
			if (_bgColor>=0) {
				opaqueBackground = _bgColor;
			}
			tweenOutVar = { alpha: 0, useFrames: true, onComplete: onHideCompleteHandler };
			tweenInVar = { alpha: 1, useFrames: true };
			bitmap = new Bitmap();
			addChild(bitmap);
			contextMenu = createMenu(this);
			super();
			mouseChildren = false;
		}
		
		override public function remove():void {
			if (content) {
				TweenNano.killTweensOf(content);
			}
			TweenNano.killTweensOf(bitmap);
			bitmap.bitmapData = null;
			super.remove();
			rect = null;
			bitmap = null;
			content = null;
			contentReady = null;
			tweenOutVar = null;
			tweenInVar = null;
		}

		public function setContent(_content:Object = null, _tweenMode:int = 2):void {
			contentReady = _content;
			if (isHidding){
				return;
			}
			tweenMode = _tweenMode;
			isHidding = true;
			if (content && tweenMode == 2 ? true : false) {
				var _display:Object = content is BitmapData ? bitmap : content;
				TweenNano.killTweensOf(_display);
				TweenNano.to(_display, TWEEN_FRAME, tweenOutVar);
			}else {
				onHideCompleteHandler();
			}
		}

		public function updateRect(_useScrollRect:Boolean = true):void {
			useScrollRect = _useScrollRect;
			if (content) {
				var _display:Object = content is BitmapData ? bitmap : content;
				_display.y = _display.x = 0;
				if (__widthOnly && __heightOnly) {
					rect.width = contentWidth;
					setDisplayScale(_display, true);
				} else if (__widthOnly){
					setDisplayScale(_display, true);
				} else if (__heightOnly){
					setDisplayScale(_display, false);
				} else {
					var _rectAspectRatio:Number = rect.width / rect.height;
					var _contentAspectRatio:Number = contentWidth / contentHeight;
					if (__scaleMode >= 0 ? (_rectAspectRatio > _contentAspectRatio) : (_rectAspectRatio < _contentAspectRatio)){
						setDisplayScale(_display, false);
					} else {
						setDisplayScale(_display, true);
					}
				}
			}
			if (useScrollRect) {
				scrollRect = rect;
			}
		}
		
		protected function onHideCompleteHandler():void {
			isHidding = false;
			showContent();
		}

		protected function showContent():void {
			if (content is BitmapData) {
				TweenNano.killTweensOf(bitmap);
				bitmap.bitmapData = null;
			}else if (content) {
				TweenNano.killTweensOf(content);
				if (contains(content as DisplayObject)) {
					removeChild(content as DisplayObject);
				}
			}
			
			content = contentReady;
			
			var _display:Object = content is BitmapData ? bitmap : content;
			if (_display) {
				_display.scaleX = _display.scaleY = 1;
			}
			offX = offY = 0;
			if (_display is Bitmap) {
				_display.bitmapData = content as BitmapData;
				_display.smoothing = true;
				contentWidth = _display.width;
				contentHeight = _display.height;
			} else if (_display is Loader){
				contentWidth = _display.contentLoaderInfo.width;
				contentHeight = _display.contentLoaderInfo.height;
				addChildAt(_display as DisplayObject, getChildIndex(bitmap));
			}else if (_display is Video) {
				contentWidth = _display.videoWidth || _display.width;
				contentHeight = _display.videoHeight || _display.height;
				addChildAt(_display as DisplayObject, getChildIndex(bitmap));
			}else if (_display is DisplayObject) {
				var _rect:Rectangle = _display.getRect(content);
				offX = _rect.x;
				offY = _rect.y;
				contentWidth = _display.width;
				contentHeight = _display.height;
				addChildAt(_display as DisplayObject, getChildIndex(bitmap));
			}else {
				
			}
			if (_display && tweenMode > 0) {
				_display.alpha = 0;
				TweenNano.to(_display, TWEEN_FRAME, tweenInVar);
			}
			updateRect(useScrollRect);
		}

		protected function setDisplayScale(_display:Object, _isWidth:Boolean):void {
			var _move:Object;
			var _dir:int;
			//useScrollRect
			if (false) {
				_move = rect;
				_dir = 1;
			}else {
				_move = _display;
				_dir = -1;
			}
			if (_isWidth) {
				if (__scaleMode > 0) {
					_display.scaleY = _display.scaleX = Math.min(rect.width / contentWidth, __scaleMode);
				}else {
					_display.scaleY = _display.scaleX = rect.width / contentWidth;
				}
				if (__widthOnly){
					_move.y = offY;
					rect.height = contentHeight * _display.scaleY;
				} else {
					_move.y = (contentHeight * _display.scaleY - rect.height) * 0.5 + offY * _display.scaleY;
				}
				_move.x = (contentWidth * _display.scaleX - rect.width) * 0.5 + offX * _display.scaleX;
			} else {
				if (__scaleMode > 0) {
					_display.scaleY = _display.scaleX = Math.min(rect.height / contentHeight, __scaleMode);
				}else {
				_display.scaleY = _display.scaleX = rect.height / contentHeight;
				}
				if (__heightOnly){
					_move.x = offX;
					rect.width = contentWidth * _display.scaleX;
				} else {
					_move.x = (contentWidth * _display.scaleX - rect.width) * 0.5 + offX * _display.scaleX;
				}
				_move.y = (contentHeight * _display.scaleY - rect.height) * 0.5 + offY * _display.scaleY;
			}
			_move.x *= _dir;
			_move.y *= _dir;
			
			_move.x = Math.round(_move.x);
			_move.y = Math.round(_move.y);
		}
	}
}
class DisplayProxy {STRETCH
	public var alignX:int = 0;
	public var alignY:int = 0;
	public var offX:int = 0;
	public var offY:int = 0;
	public var originalWidth:int = 0;
	public var originalHeight:int = 0;
	//-1:outside,0:noscale,1:inside,2:stretch,3:onlywidth,4:onlyheight
	public var scaleMode:int = 0;
	public function DisplayProxy() {
		
	}
}
