package akdcl.media {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.events.ContextMenuEvent;

	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	import com.greensock.TweenLite;

	import ui.UISprite;

	import akdcl.layout.DisplayProxy;
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
			_source = _source + ": " + _rect.proxy.width + " x " + _rect.proxy.height;
			contextMenuItem.caption = _source;
		}

		private static function onMenuItemSelectHandler(_evt:ContextMenuEvent):void {
			System.setClipboard(sourceLabel);
		}

		public var label:String = "Size";
		public var moveRect:Boolean;
		public var proxy:DisplayProxy;

		public var container:DisplayObjectContainer;

		public function get displayContent():DisplayObject {
			return (content is BitmapData ? bitmap : content) as DisplayObject;
		}

		protected var tweenOutVar:Object;
		protected var tweenInVar:Object;

		protected var eventChange:Event = new Event(Event.CHANGE);
		protected var eventResize:Event = new Event(Event.RESIZE);

		protected var bitmap:Bitmap;
		protected var content:Object;
		protected var contentReady:Object;
		protected var maskShape:Shape;
		
		protected var useScroll:Boolean;
		protected var useMask:Boolean;

		protected var isHidding:Boolean = false;
		protected var tweenMode:int;

		protected var alignXReady:Number;
		protected var alignYReady:Number;
		protected var scaleModeReady:Number;

		protected var scrollRectCopy:Rectangle;

		public function DisplayRect(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = 0):void {
			if (!container){
				container = this;
			}
			proxy = new DisplayProxy(0, 0, _rectWidth || container.width, _rectHeight || container.height);
			if (_bgColor >= 0){
				setUseScroll(true, _bgColor)
			}
			super();
		}

		override protected function init():void {
			super.init();
			tweenOutVar = {alpha: 0, useFrames: true, onComplete: onHideCompleteHandler};
			tweenInVar = {alpha: 1, useFrames: true};
			bitmap = new Bitmap();
			container.addChild(bitmap);
			contextMenu = createMenu(this);
			mouseChildren = false;
			proxy.addEventListener(Event.RESIZE, onProxyResizeHandler);

		}

		override protected function onRemoveToStageHandler():void {
			TweenLite.killTweensOf(displayContent);
			bitmap.bitmapData = null;
			proxy.remove();
			super.onRemoveToStageHandler();
			proxy = null;
			bitmap = null;
			content = null;
			contentReady = null;

			tweenOutVar = null;
			tweenInVar = null;
			eventChange = null;
			eventResize = null;
		}

		public function setUseMask(_useMask:Boolean):void {
			useMask = _useMask;
			if (useMask && !maskShape){
				maskShape = new Shape();
				maskShape.graphics.beginFill(0);
				maskShape.graphics.drawRect(0, 0, 1, 1);
				maskShape.graphics.endFill();
				maskShape.visible = false;
				addChildAt(maskShape, 0);
			}
			onProxyResizeHandler();
			if (useMask){
				container.mask = maskShape;
				container.scrollRect = null;
			} else {
				container.mask = null;
			}
		}

		public function setUseScroll(_useScroll:Boolean, _color:int = -1):void {
			useScroll = _useScroll;
			if (useScroll && !scrollRectCopy){
				scrollRectCopy = new Rectangle(0, 0, 0, 0);
			}
			if (useScroll) {
				container.mask = null;
			}else {
				container.scrollRect = null;
			}
			onProxyResizeHandler();
			container.opaqueBackground = (_useScroll && _color >= 0) ? _color : null;
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
				TweenLite.killTweensOf(displayContent);
				TweenLite.to(displayContent, tweenMode > 2 ? tweenMode : TWEEN_FRAME, tweenOutVar);
			} else {
				onHideCompleteHandler();
			}
		}

		protected function onHideCompleteHandler():void {
			if (content){
				TweenLite.killTweensOf(displayContent);
				if (content is BitmapData){
					bitmap.bitmapData = null;
				} else {
					container.removeChild(content as DisplayObject);
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
				container.addChildAt(content as DisplayObject, container.getChildIndex(bitmap));
				_display = content;
			}
			if (_display){
				if (tweenMode > 0){
					_display.alpha = 0;
					TweenLite.to(_display, tweenMode > 2 ? tweenMode : TWEEN_FRAME, tweenInVar);
				}
				proxy.setContent(_display, alignXReady, alignYReady, scaleModeReady);
				onProxyResizeHandler();
			}
		}

		protected function onProxyResizeHandler(_e:Event = null):void {
			if (useScroll){
				scrollRectCopy.width = proxy.width;
				scrollRectCopy.height = proxy.height;
				container.scrollRect = scrollRectCopy;
			} else if (useMask){
				maskShape.x = proxy.x;
				maskShape.y = proxy.y;
				maskShape.width = proxy.width;
				maskShape.height = proxy.height;
			}
		}
	}
}