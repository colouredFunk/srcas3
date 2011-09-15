package akdcl.media {
	import akdcl.manager.ElementManager;
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
		protected var contentProxy:DisplayProxy;

		protected var isHidding:Boolean = false;
		protected var useScrollRect:Boolean = true;
		
		protected var tweenMode:int;

		protected var tweenOutVar:Object;
		protected var tweenInVar:Object;
		
		protected var alignX:int;
		protected var alignY:int;
		protected var scaleMode:int;

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

		public function DisplayRect(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = 0):void {
			rect = new Rectangle();
			var _rect:Rectangle = getRect(this);
			rect.width = _rectWidth || _rect.width;
			rect.height = _rectHeight || _rect.height;
			if (_bgColor >= 0){
				opaqueBackground = _bgColor;
			}
			super();
		}
		override protected function init():void {
			super.init();
			tweenOutVar = {alpha: 0, useFrames: true, onComplete: onHideCompleteHandler};
			tweenInVar = { alpha: 1, useFrames: true };
			contentProxy = new DisplayProxy();
			bitmap = new Bitmap();
			addChild(bitmap);
			contextMenu = createMenu(this);
			mouseChildren = false;
		}

		override public function remove():void {
			TweenNano.killTweensOf(bitmap);
			bitmap.bitmapData = null;
			contentProxy.clear();
			super.remove();
			rect = null;
			bitmap = null;
			content = null;
			contentProxy = null;
			contentReady = null;
			tweenOutVar = null;
			tweenInVar = null;
		}

		public function setContent(_content:Object = null, _tweenMode:int = 2, _alignX:int = 0, _alignY:int = 0, _scaleMode:int = 1):void {
			alignX = _alignX;
			alignY = _alignY;
			scaleMode = _scaleMode;
			contentReady = _content;
			if (isHidding){
				return;
			}
			tweenMode = _tweenMode;
			isHidding = true;
			if (content && tweenMode == 2 ? true : false) {
				var _display:Object = content is BitmapData?bitmap:content;
				TweenNano.killTweensOf(_display);
				TweenNano.to(_display, TWEEN_FRAME, tweenOutVar);
			} else {
				onHideCompleteHandler();
			}
		}

		public function updateRect(_useScrollRect:Boolean = true):void {
			if (content) {
				contentProxy.update(rect.width, rect.height);
			}
			useScrollRect = _useScrollRect;
			if (useScrollRect){
				scrollRect = rect;
			}
		}

		protected function onHideCompleteHandler():void {
			if (content) {
				var _display:Object = content is BitmapData?bitmap:content;
				TweenNano.killTweensOf(content);
			}
			isHidding = false;
			showContent();
		}

		protected function showContent():void {
			content = contentReady;
			contentReady = null;
			var _display:Object;
			if (content is BitmapData) {
				bitmap.bitmapData = content as BitmapData;
				bitmap.smoothing = true;
				_display = bitmap;
			}else if (content) {
				addChildAt(content as DisplayObject, getChildIndex(bitmap));
				_display = content;
			}
			//
			if (_display) {
				contentProxy.setTarget(_display, alignX, alignY, scaleMode);
				if (_display && tweenMode > 0){
					_display.alpha = 0;
					TweenNano.to(_display, TWEEN_FRAME, tweenInVar);
				}
				updateRect(useHandCursor);
			}
		}
	}
}
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.geom.Rectangle;
import flash.media.Video;

class DisplayProxy {
	public var alignX:int;
	public var alignY:int;
	public var offX:int;
	public var offY:int;
	public var originalWidth:int;
	public var originalHeight:int;
	public var aspectRatio:Number;
	//-1:outside,0:noscale,1:inside,2:stretch,3:onlywidth,4:onlyheight
	public var scaleMode:int;

	public var target:*;

	public function DisplayProxy(){
	}
	
	public function clear():void {
		target = null;
	}

	public function setTarget(_target:*, _alignX:int = 0, _alignY:int = 0, _scaleMode:int = 1):void {
		alignX = _alignX;
		alignY = _alignY;
		scaleMode = _scaleMode;
		target = _target;
		offX = offY = 0;
		if (target is Bitmap){
			originalWidth = target.width/target.scaleX;
			originalHeight = target.height/target.scaleY;
		} else if (target is Loader){
			originalWidth = target.contentLoaderInfo.width;
			originalHeight = target.contentLoaderInfo.height;
		} else if (target is Video){
			originalWidth = target.videoWidth || target.width / target.scaleX;
			originalHeight = target.videoHeight || target.height / target.scaleY;
		} else if (target is DisplayObject){
			var _rect:Rectangle = target.getRect(target);
			offX = _rect.x;
			offY = _rect.y;
			originalWidth = target.width/target.scaleX;
			originalHeight = target.height/target.scaleY;
		} else {
			return;
		}
		aspectRatio = originalWidth / originalHeight;
	}
	
	public function update(_width:int, _height:int):void {
		var _aspectRatio:Number = _width / _height;
		var _isWidth:Boolean;
		switch(scaleMode) {
			case 0:
				break;
			case -1:
			case 1:
				if (scaleMode < 0?(_aspectRatio > aspectRatio):(_aspectRatio < aspectRatio)) {
					target.scaleY = target.scaleX = _width / originalWidth;
				}else {
					target.scaleY = target.scaleX = _height / originalHeight;
				}
				break;
			case 2:
				target.scaleX = _width / originalWidth;
				target.scaleY = _height / originalHeight;
				break;
			case 3:
				target.scaleX = _width / originalWidth;
				break;
			case 4:
				target.scaleY = _height / originalHeight;
				break;
		}
		switch(alignX) {
			case -1:
				target.x = offX * target.scaleX;
				break;
			case 0:
				target.x = (originalWidth * target.scaleX - _width) * 0.5 + offX * target.scaleX;
				break;
			case 1:
				target.x = (originalWidth * target.scaleX - _width) + offX * target.scaleX;
				break;
		}
		switch(alignY) {
			case -1:
				target.y = offY * target.scaleY;
				break;
			case 0:
				target.y = (originalHeight * target.scaleY - _height) * 0.5 + offY * target.scaleY;
				break;
			case 1:
				target.y = (originalHeight * target.scaleY - _height) + offY * target.scaleY;
				break;
		}
		target.x = -target.x;
		target.y = -target.y;
		target.x = Math.round(target.x);
		target.y = Math.round(target.y);
	}
}
