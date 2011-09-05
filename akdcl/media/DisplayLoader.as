package akdcl.media {
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;

	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	import com.greensock.TweenNano;

	import ui.UISprite;

	import akdcl.manager.RequestManager;
	import akdcl.utils.addContextMenu;

	/**
	 * ...
	 * @author ...
	 */
	public class DisplayLoader extends UISprite {
		protected static const TWEEN_FRAME:uint = 12;
		protected static var rM:RequestManager = RequestManager.getInstance();
		protected static var progressEvent:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
		protected static var completeEvent:Event = new Event(Event.COMPLETE);
		protected static var errorEvent:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);

		private static var contextMenuImageLoader:ContextMenu;
		private static var contextMenuItemImageLoader:ContextMenuItem;

		private static function createMenu(_target:*):ContextMenu {
			if (!contextMenuImageLoader){
				contextMenuItemImageLoader = addContextMenu(_target, "");
				contextMenuImageLoader = _target.contextMenu;
				contextMenuImageLoader.addEventListener(ContextMenuEvent.MENU_SELECT, onImageMenuShowHandler);
			}
			return contextMenuImageLoader;
		}

		private static function onImageMenuShowHandler(_evt:ContextMenuEvent):void {
			var _loader:* = _evt.contextMenuOwner;
			var _source:String = _loader.source;
			if (_source){
				_source = _source.split("/").pop();
			} else {
				_source = "--";
			}
			_source = _source + ":" + _loader.areaRect.width + " x " + _loader.areaRect.height;
			contextMenuItemImageLoader.caption = _source;
		}

		public var progressClip:*;
		public var container:DisplayObjectContainer;
		public var bitmap:Bitmap;

		public var areaRect:Rectangle;
		protected var isTweenning:Boolean = false;
		protected var tweenMode:int;
		protected var contentWidth:uint;
		protected var contentHeight:uint;
		protected var contentLast:*;

		protected var __source:String = null;

		public function get source():String {
			return __source;
		}

		protected var __loadProgress:Number = 0;

		public function get loadProgress():Number {
			return __loadProgress;
		}

		protected var __content:* = null;

		public function get content():* {
			return __content;
		}
		//0:等比内部填充,(0~1]:限制缩放比，-1:等比外部填充
		private var __scaleMode:Number = 0;

		public function get scaleMode():Number {
			return __scaleMode;
		}

		public function set scaleMode(_scaleMode:Number):void {
			__scaleMode = _scaleMode;
			updateRect();
		}

		override protected function init():void {
			super.init();
			bitmap = new Bitmap();
			if (container){
				areaRect = getBounds(container);
				container.addChild(bitmap);
			} else {
				container = this;
				if (progressClip && contains(progressClip) && numChildren == 1) {
					areaRect = new Rectangle();
					container.addChildAt(bitmap, getChildIndex(progressClip));
				} else {
					areaRect = getBounds(this);
					if (progressClip && contains(progressClip)) {
						container.addChildAt(bitmap, getChildIndex(progressClip));
					}else {
						container.addChild(bitmap);
					}
					
				}
			}
			setProgressClip(false);
			contextMenu = createMenu(this);
		}

		override protected function onRemoveToStageHandler():void {
			unload();
			progressClip = null;
			container = null;
			bitmap = null;
			areaRect = null;
			super.onRemoveToStageHandler();
		}

		public function load(_url:String, _tweenMode:int = 2):void {
			if (__source == _url){
				//return;
			}
			tweenMode = _tweenMode;
			hideContent(__content && tweenMode == 2 ? true : false);
			rM.loadDisplay(_url, onImageHandler, onImageHandler, onImageHandler);
		}

		public function unload():void {
			setProgressClip(false);
			TweenNano.killTweensOf(bitmap);
			TweenNano.killTweensOf(__content);
			fixContentLast();
			bitmap.bitmapData = null;
			__source = null;
			__content = null;
			contentLast = null;
		}

		protected function hideContent(_isTween:Boolean):void {
			if (isTweenning){
				return;
			}
			isTweenning = true;
			TweenNano.killTweensOf(bitmap);
			TweenNano.killTweensOf(__content);
			if (!__content || __content is BitmapData) {
				TweenNano.to(bitmap, _isTween ? TWEEN_FRAME : 0, {alpha: 0, useFrames: true, onComplete: showContent});
			} else {
				TweenNano.to(__content, _isTween ? TWEEN_FRAME : 0, {alpha: 0, useFrames: true, onComplete: showContent});
				contentLast = __content;
			}
			__source = null;
			__content = null;
		}

		protected function onImageHandler(_p:*, _url:String = null):void {
			if (_p is IOErrorEvent){
				setProgressClip(false);
				dispatchEvent(errorEvent);
			} else if (!_p || _p is ProgressEvent) {
				if (_p) {
					__loadProgress = _p.bytesLoaded / _p.bytesTotal;
					progressEvent.bytesLoaded = _p.bytesLoaded;
					progressEvent.bytesTotal = _p.bytesTotal;
				}else {
					__loadProgress = 1;
				}
				if (isNaN(__loadProgress)){
					__loadProgress = 0;
				}
				setProgressClip(__loadProgress);
				dispatchEvent(progressEvent);
			} else {
				setProgressClip(false);
				if (_p is BitmapData){
					contentWidth = _p.width;
					contentHeight = _p.height;
				} else if (_p is Loader){
					contentWidth = _p.contentLoaderInfo.width;
					contentHeight = _p.contentLoaderInfo.height;
				} else {
					contentWidth = _p.parent.contentLoaderInfo.width;
					contentHeight = _p.parent.contentLoaderInfo.height;
				}
				__source = _url;
				__content = _p;
				showContent(true, true);
				dispatchEvent(completeEvent);
			}
		}

		protected function showContent(_isTween:Boolean = true, _complete:Boolean = false):void {
			if (_complete) {
			}else {
				isTweenning = false;
				fixContentLast();
			}
			if (!__content || isTweenning) {
				return;
			}
			TweenNano.killTweensOf(bitmap);
			if (__content is BitmapData) {
				bitmap.bitmapData = __content;
				bitmap.smoothing = true;
				TweenNano.to(bitmap, (_isTween && tweenMode > 0) ? TWEEN_FRAME : 0, { alpha: 1, useFrames: true } );
			} else {
				container.addChildAt(__content, container.getChildIndex(bitmap));
				__content.alpha = 0;
				TweenNano.to(__content, (_isTween && tweenMode > 0) ? TWEEN_FRAME : 0, {alpha: 1, useFrames: true});
			}
			updateRect();
		}
		
		protected function fixContentLast():void {
			if (contentLast && container.contains(contentLast)){
				container.removeChild(contentLast);
				TweenNano.killTweensOf(contentLast);
				contentLast = null;
			}
		}

		public function updateRect():void {
			if (__content) {
				
			}else {
				return;
			}
			var _areaAspectRatio:Number = areaRect.width / areaRect.height;
			var _contentAspectRatio:Number = contentWidth / contentHeight;
			if (__content is BitmapData){
				if (areaRect.width + areaRect.height <= 0){
					//原始大小显示
					bitmap.x = bitmap.y = 0;
					bitmap.scaleX = bitmap.scaleY = 1;
				} else {
					if (scaleMode >= 0 ? (_areaAspectRatio > _contentAspectRatio) : (_areaAspectRatio < _contentAspectRatio)){
						bitmap.height = areaRect.height;
						bitmap.scaleX = bitmap.scaleY;
						bitmap.y = areaRect.y;
						bitmap.x = areaRect.x + (areaRect.width - bitmap.width) * 0.5;
					} else {
						bitmap.width = areaRect.width;
						bitmap.scaleY = bitmap.scaleX;
						bitmap.x = areaRect.x;
						bitmap.y = areaRect.y + (areaRect.height - bitmap.height) * 0.5;
					}
				}
			} else {
				if (areaRect.width + areaRect.height <= 0){
				} else {
					if (scaleMode >= 0 ? (_areaAspectRatio > _contentAspectRatio) : (_areaAspectRatio < _contentAspectRatio)){
						__content.scaleX = __content.scaleY = areaRect.height / contentHeight;
						__content.y = areaRect.y;
						__content.x = areaRect.x + (areaRect.width - contentWidth * __content.scaleX) * 0.5;
					} else {
						__content.scaleY = __content.scaleX = areaRect.width / contentWidth;
						__content.x = areaRect.x;
						__content.y = areaRect.y + (areaRect.height - contentHeight * __content.scaleY) * 0.5;
					}
				}
			}
			if (scaleMode < 0){
				container.scrollRect = areaRect;
			} else {
				if (container.scrollRect) {
					container.scrollRect = null;
				}
			}
		}

		protected function setProgressClip(_progress:*):void {
			if (!progressClip){
				return;
			}
			if (_progress is Number){
				progressClip.visible = true;
				if ("text" in progressClip){
					progressClip.text = Math.round(_progress * 100) + " %";
				} else if ("value" in progressClip){
					progressClip.value = _progress;
				} else if (progressClip is MovieClip){
					progressClip.play();
				}
			} else {
				progressClip.visible = _progress;
				if (progressClip is MovieClip){
					if (_progress){
						progressClip.play();
					} else {
						progressClip.stop();
					}
				}
			}
		}
	}

}