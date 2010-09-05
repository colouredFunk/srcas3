package ui {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	import flash.events.Event;
	
	import com.greensock.TweenMax;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	import com.greensock.easing.Cubic;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  ImageLoader extends UIMovieClip {
		public var container:*;
		public var foreground:*;
		public var background:*;
		public var groupID:String = "ImageLoader";
		public var limitsWH:Boolean;
		protected var autoFitArea:AutoFitArea;
		protected var contentNow:*;
		override protected function init():void {
			super.init();
			createManager(groupID);
			if (!container) {
				container = this;
				if (background) {
					__widthArea = background.width;
					__heightArea = background.height;
				}
			}else {
				//有预置容器
				if (container.width * container.height > 0) {
					__widthArea = container.width;
					__heightArea = container.height;
				}else if (background) {
					__widthArea = background.width;
					__heightArea = background.height;
				}
			}
			autoFitArea = new AutoFitArea(container, 0, 0, widthArea, heightArea);
		}
		override protected function onRemoveToStageHandler(_evt:Event):void {
			super.onRemoveToStageHandler(_evt);
			removeChildren();
			if (container!=this) {
				container.removeChildren();
			}
			container = null;
			foreground = null;
			background = null;
			contentNow = null;
			autoFitArea.destroy();
		}
		private var __widthArea:uint = 100;
		public function get widthArea():uint {
			return __widthArea;
		};
		public function set widthArea(_widthArea:uint):void {
			__widthArea = _widthArea;
			autoFitArea.width = __widthArea;
		};
		private var __heightArea:uint = 100;
		public function get heightArea():uint {
			return __heightArea;
		};
		public function set heightArea(_heightArea:uint):void {
			__heightArea = _heightArea;
			autoFitArea.height = __heightArea;
		};
		private var __scaleMode:String = ScaleMode.PROPORTIONAL_INSIDE;
		public function get scaleMode():String {
			return __scaleMode;
		}
		public function set scaleMode(_scaleMode:String):void {
			__scaleMode = _scaleMode;
			if (contentNow) {
				updateArea(contentNow);
			}
		}
		public function load(_source:String):void {
			var _content:*= getContent(_source);
			if (_content == contentNow && contentNow) {
				return;
			}
			if (contentNow) {
				hideContent(contentNow);
				contentNow = null;
			}
			if (_content) {
				if (_content.loader.progress == 1) {
					showContent(_content);
				}else {
					_content = addContent(_source, container, groupID);
				}
			}else {
				_content = addContent(_source, container, groupID);
			}
			contentNow = _content;
		}
		protected function showContent(_content:*):void {
			TweenMax.to(_content, 0.5, { autoAlpha:1, ease:Cubic.easeInOut } );
			if (container != this) {
				
			}else {
				if (foreground) {
					container.addChildAt(_content, getChildIndex(foreground));
				}else if (background) {
					container.addChildAt(_content, getChildIndex(background) + 1);
				}
			}
			updateArea(_content);
		}
		protected function hideContent(_content:*):void {
			autoFitArea.release(_content);
			TweenMax.to(_content, 0.5, { autoAlpha:0, ease:Cubic.easeInOut } );
		}
		protected function updateArea(_content:*):void {
			var _width:uint = limitsWH?Math.min(_content.width, widthArea):99999;
			var _height:uint = limitsWH?Math.min(_content.height, heightArea):99999;
			autoFitArea.attach(_content, scaleMode, AlignMode.CENTER, AlignMode.CENTER, false, 0, _width, 0, _height);
		}
		protected function onImageLoadedHandler(_content:*):void {
			if (_content==contentNow) {
				showContent(_content);
			}
		}
		protected function onImageLoadingHandler(_content:*):void {
			if (_content==contentNow) {
				_content.loader.progress;
			}
		}
		
		
		private static var loaderMaxDic:Object = { };
		private static var contentDic:Object = { };
		private static var imageLoader:com.greensock.loading.ImageLoader;
		private static var imageLoaderParams:Object;
		private static var loaderMax:LoaderMax;
		protected static function createManager(_groupID:String):LoaderMax {
			if (!loaderMaxDic[_groupID]) {
				imageLoaderParams = { };
				loaderMax = new LoaderMax( { name:_groupID,
											onChildProgress:onChildProgressHandler,
											onChildComplete:onChildCompleteHandler,
											onProgress:onProgressHandler,
											onComplete:onCompleteHandler,
											onError:onErrorHandler
											} );
				loaderMaxDic[_groupID] = loaderMax;
			}
			return loaderMaxDic[_groupID];
		}
		protected static function getContent(_source:String):* {
			return contentDic[_source];
		}
		protected static function addContent(_source:String, _container:*, _groupID:String, _index:uint = 0):* {
			loaderMax = createManager(_groupID);
			imageLoader = loaderMax.getLoader(_source);
			if (imageLoader) {
				loaderMax.insert(imageLoader, _index);
				return imageLoader.content;
			}
			imageLoaderParams.container = _container;
			imageLoaderParams.name = _source;
			imageLoader = new com.greensock.loading.ImageLoader(_source, imageLoaderParams);
			contentDic[_source] = imageLoader.content;
			loaderMax.insert(imageLoader, _index);
			loaderMax.load();
			return contentDic[_source];
		}
		private static function onChildProgressHandler(_evt:LoaderEvent):void {
			if (_evt.target.content.parent is ui.ImageLoader) {
				_evt.target.content.parent.onImageLoadingHandler(_evt.target.content);
			}else if (_evt.target.content.parent.parent is ui.ImageLoader) {
				_evt.target.content.parent.onImageLoadedHandler(_evt.target.content);
			}
		}
		private static function onChildCompleteHandler(_evt:LoaderEvent):void {
			_evt.target.content.visible = false;
			_evt.target.content.alpha = 0;
			if (_evt.target.content.parent is ui.ImageLoader) {
				_evt.target.content.parent.onImageLoadedHandler(_evt.target.content);
			}else if (_evt.target.content.parent.parent is ui.ImageLoader) {
				_evt.target.content.parent.onImageLoadedHandler(_evt.target.content);
			}
		}
		private static function onErrorHandler(_evt:LoaderEvent):void{
			trace(_evt.toString());
		}
		private static function onProgressHandler(_evt:LoaderEvent):void{
			//trace(_evt.toString());
		}
		private static function onCompleteHandler(_evt:LoaderEvent):void{
			//trace(_evt.toString());
		}
	}
}