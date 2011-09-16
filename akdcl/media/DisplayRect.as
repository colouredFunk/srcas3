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
	[Event(name = "change", type = "flash.events.Event")]
	 /// @eventType	flash.events.Event.RESIZE
	[Event(name = "resize", type = "flash.events.Event")]
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
		
		private const eventChange:Event = new Event(Event.CHANGE);
		private const eventResize:Event = new Event(Event.RESIZE);

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
		
		private var __scrollX:Number = 0;
		public function get scrollX():Number {
			return __scrollX;
		}
		public function set scrollX(_value:Number):void {
			if (_value < -0.5) {
				_value = -0.5;
			}else if (_value>1.5) {
				_value = 1.5;
			}
			if (__scrollX==_value) {
				return;
			}
			__scrollX = _value;
			if (autoUpdate){
				updateRect(useScrollRect, false);
			}
		}
		
		private var __scrollY:Number = 0;
		public function get scrollY():Number {
			return __scrollY;
		}
		public function set scrollY(_value:Number):void {
			if (_value < -0.5) {
				_value = -0.5;
			}else if (_value>1.5) {
				_value = 1.5;
			}
			if (__scrollX==_value) {
				return;
			}
			__scrollY = _value;
			if (autoUpdate){
				updateRect(useScrollRect, false);
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
			tweenInVar = {alpha: 1, useFrames: true};
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
			if (content && tweenMode == 2 ? true : false){
				var _display:Object = content is BitmapData ? bitmap : content;
				TweenNano.killTweensOf(_display);
				TweenNano.to(_display, TWEEN_FRAME, tweenOutVar);
			} else {
				onHideCompleteHandler();
			}
		}

		public function getDisplayContent():DisplayObject {
			return (content is BitmapData ? bitmap : content) as DisplayObject;
		}

		public function updateRect(_useScrollRect:Boolean = true, _isWH:Boolean = true):void {
			if (content && _isWH) {
				contentProxy.update(rect.width, rect.height);
			}
			//rect.x = (contentProxy.width - rectWidth) * (__scrollX - contentProxy.alignX);
			//rect.y = (contentProxy.height - rectHeight) * __scrollY;
			useScrollRect = _useScrollRect;
			if (useScrollRect){
				scrollRect = rect;
			}
			dispatchEvent(eventResize);
		}

		protected function onHideCompleteHandler():void {
			if (content){
				var _display:Object = content is BitmapData ? bitmap : content;
				TweenNano.killTweensOf(content);
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
			//
			if (_display){
				contentProxy.setTarget(_display, alignX, alignY, scaleMode);
				if (_display && tweenMode > 0){
					_display.alpha = 0;
					TweenNano.to(_display, TWEEN_FRAME, tweenInVar);
				}
				updateRect(useHandCursor);
				dispatchEvent(eventChange);
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
	public var width:Number = 0;
	public var height:Number = 0;
	private var offX:int;
	private var offY:int;
	private var originalWidth:int;
	private var originalHeight:int;
	private var aspectRatio:Number;
	//-1:outside,0:noscale,1:inside,2:stretch,3:onlywidth,4:onlyheight
	private var scaleMode:int;

	private var target:*;

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
			originalWidth = target.width / target.scaleX;
			originalHeight = target.height / target.scaleY;
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
			originalWidth = target.width / target.scaleX;
			originalHeight = target.height / target.scaleY;
		} else {
			return;
		}
		aspectRatio = originalWidth / originalHeight;
	}

	public function update(_width:int, _height:int):void {
		var _aspectRatio:Number = _width / _height;
		var _isWidth:Boolean;
		switch (scaleMode){
			case 0:
				break;
			case-1:
			case 1:
				if (scaleMode < 0 ? (_aspectRatio > aspectRatio) : (_aspectRatio < aspectRatio)){
					target.scaleY = target.scaleX = _width / originalWidth;
				} else {
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
		width = originalWidth * target.scaleX;
		height = originalHeight * target.scaleY;
		
		switch (alignX){
			case-1:
				target.x = offX * target.scaleX;
				break;
			case 0:
				target.x = (width - _width) * 0.5 + offX * target.scaleX;
				break;
			case 1:
				target.x = (width - _width) + offX * target.scaleX;
				break;
		}
		switch (alignY){
			case-1:
				target.y = offY * target.scaleY;
				break;
			case 0:
				target.y = (height- _height) * 0.5 + offY * target.scaleY;
				break;
			case 1:
				target.y = (height - _height) + offY * target.scaleY;
				break;
		}
		target.x = -target.x;
		target.y = -target.y;
		target.x = Math.round(target.x);
		target.y = Math.round(target.y);
	}
}
