package akdcl.media {
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
			if (scaleMode < 0){
				container.scrollRect = areaRect;
			}
		}

		override protected function init():void {
			super.init();
			bitmap = new Bitmap();
			if (container){
				areaRect = getBounds(container);
				container.addChild(bitmap);
			} else {
				container = this;
				if (progressClip && contains(progressClip)) {
					container.addChildAt(bitmap, getChildIndex(progressClip));
				} else {
					areaRect = getBounds(this);
					container.addChild(bitmap);
				}
			}
			setProgressClip(false);
			contextMenu = createMenu(this);
		}

		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			unload();
			progressClip = null;
			container = null;
			bitmap = null;
			areaRect = null;
		}

		public function load(_url:String, _tweenMode:int = 2):void {
			tweenMode = _tweenMode;
			hideContent(__content && tweenMode == 2 ? true : false);
			rM.loadDisplay(_url, onImageHandler, onImageHandler, onImageHandler);
		}

		public function unload():void {
			setProgressClip(false);
			TweenNano.killTweensOf(bitmap);
			bitmap.bitmapData = null;
			__source = null;
			__content = null;
		}

		protected function hideContent(_isTween:Boolean):void {
			if (isTweenning){
				return;
			}
			__source = null;
			__content = null;
			TweenNano.killTweensOf(bitmap);
			TweenNano.to(bitmap, _isTween ? 12 : 0, {alpha: 0, useFrames: true, onComplete: showContent});
		}

		protected function onImageHandler(_p:*, _url:String = null):void {
			if (_p is IOErrorEvent){
				setProgressClip(false);
				
				dispatchEvent(errorEvent);
			} else if (_p is ProgressEvent){
				__loadProgress = _p.bytesLoaded / _p.bytesTotal;
				if (isNaN(__loadProgress)){
					__loadProgress = 0;
				}
				setProgressClip(__loadProgress);
				progressEvent.bytesLoaded = _p.bytesLoaded;
				progressEvent.bytesTotal = _p.bytesTotal;
				
				dispatchEvent(progressEvent);
			} else {
				setProgressClip(false);
				__source = _url;
				__content = _p;
				showContent(true);
				
				dispatchEvent(completeEvent);
			}
		}

		protected function showContent(_isTween:Boolean = true):void {
			if (!__content){
				return;
			}
			TweenNano.killTweensOf(bitmap);
			if (__content is BitmapData) {
				bitmap.bitmapData = __content;
				bitmap.smoothing = true;
				TweenNano.to(bitmap, (_isTween && tweenMode > 0) ? 12 : 0, {alpha: 1, useFrames: true});
			}else {
				container.addChildAt(__content, container.getChildIndex(bitmap));
				__content.alpha = 0;
				TweenNano.to(__content, (_isTween && tweenMode > 0) ? 12 : 0, {alpha: 1, useFrames: true});
			}
			updateArea();
			isTweenning = false;
		}

		protected function updateArea():void {
			var _areaAspectRatio:Number = areaRect.width / areaRect.height;
			var _contentAspectRatio:Number;
			if (__content is BitmapData) {
				bitmap.scaleX = bitmap.scaleY = 1;
				if (areaRect.width + areaRect.height <= 0){
					//原始大小显示
					bitmap.x = bitmap.y = 0;
				} else {
					_contentAspectRatio = bitmap.width / bitmap.height;
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
			}else {
				if (areaRect.width + areaRect.height <= 0){
				} else {
					if (__content is Loader) {
						_contentAspectRatio = __content.contentLoaderInfo.width / __content.contentLoaderInfo.height;
					}else {
						_contentAspectRatio = __content.parent.contentLoaderInfo.width / __content.parent.contentLoaderInfo.height;
					}
					if (scaleMode >= 0 ? (_areaAspectRatio > _contentAspectRatio) : (_areaAspectRatio < _contentAspectRatio)){
						__content.height = areaRect.height;
						__content.scaleX = bitmap.scaleY;
						__content.y = areaRect.y;
						__content.x = areaRect.x + (areaRect.width - __content.width) * 0.5;
					} else {
						__content.width = areaRect.width;
						__content.scaleY = bitmap.scaleX;
						__content.x = areaRect.x;
						__content.y = areaRect.y + (areaRect.height - __content.height) * 0.5;
					}
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