package ui {
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import com.greensock.TweenMax;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	import com.greensock.easing.Cubic;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
    import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  ImageLoader extends UIMovieClip {
		public var container:*;
		public var foreground:*;
		public var background:*;
		public var limitWH:Boolean;
		protected var autoFitArea:AutoFitArea;
		//protected var contextMenuItem:ContextMenuItem;
		protected var bmp:Bitmap;
		protected var sourceNow:String;
		protected var bmdNow:BitmapData;
		private var __groupID:String;
		public function get groupID():String{
			return __groupID;
		}
		public function set groupID(_groupID:String):void{
			__groupID = _groupID;
			createManager(__groupID);
		}
		override protected function init():void {
			super.init();
			groupID = getQualifiedClassName(this);
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
			bmp = new Bitmap();
			bmp.alpha = 0;
			autoFitArea = new AutoFitArea(container, 0, 0, widthArea, heightArea);
			//contextMenuItem = Common.addContextMenu(this, "image:--");
		}
		override protected function onRemoveToStageHandler(_evt:Event):void {
			super.onRemoveToStageHandler(_evt);
			if (container!=this) {
				container.removeChildren();
			}
			//contextMenuItem = null;
			bmp.bitmapData = null;
			bmdNow = null;
			sourceNow = null;
			container = null;
			foreground = null;
			background = null;
			autoFitArea.destroy();
		}
		private var __widthArea:uint = 1;
		public function get widthArea():uint {
			return __widthArea;
		};
		public function set widthArea(_widthArea:uint):void {
			__widthArea = _widthArea;
			autoFitArea.width = __widthArea;
		};
		private var __heightArea:uint = 1;
		public function get heightArea():uint {
			return __heightArea;
		};
		public function set heightArea(_heightArea:uint):void {
			__heightArea = _heightArea;
			autoFitArea.height = __heightArea;
		};
		public function load(_source:String, _index:uint = 0):void {
			if (_source && sourceNow == _source) {
				return;
			}
			bmdNow = loadBMD(_source, this, _index);
			hideBMP(bmp);
			sourceNow = _source;
		}
		protected function hideBMP(_content:*):void {
			autoFitArea.release(_content);
			TweenMax.killTweensOf(bmp);
			TweenMax.to(bmp, 0.2, { alpha:0, ease:Cubic.easeInOut, onComplete:onHideEndHandler } );
		}
		private function onHideEndHandler():void {
			setBMP(bmdNow);
		}
		protected function setBMP(_content:*):void {
			if (!_content) {
				return;
			}
			bmp.bitmapData = _content;
			bmp.smoothing = true;
			if (container != this) {
				container.addChild(bmp);
			}else if (foreground) {
				container.addChildAt(bmp, getChildIndex(foreground));
			}else if (background) {
				container.addChildAt(bmp, getChildIndex(background) + 1);
			}else {
				container.addChild(bmp);
			}
			TweenMax.killTweensOf(bmp);
			TweenMax.to(bmp, 0.3, { alpha:1, ease:Cubic.easeInOut } );
			updateArea(bmp);
		}
		private const LIMITWH_MAX:uint = 999999;
		protected function updateArea(_content:*):void {
			if (widthArea + heightArea <= 2) {
				//原始大小显示
			}else {
				var _widthMax:uint;
				var _heightMax:uint;
				var _scaleMode:String
				var _alignX:String = AlignMode.CENTER;
				var _alignY:String = AlignMode.CENTER;
				if(widthArea<=1){
					_scaleMode = ScaleMode.PROPORTIONAL_OUTSIDE;
					_alignX = AlignMode.LEFT;
					_widthMax = limitWH?_content.width:LIMITWH_MAX;
					_heightMax = limitWH?Math.min(_content.height, heightArea):LIMITWH_MAX;
				}else if (heightArea<=1) {
					_scaleMode = ScaleMode.PROPORTIONAL_OUTSIDE;
					_alignY = AlignMode.TOP;
					_widthMax = limitWH?Math.min(_content.width, widthArea):LIMITWH_MAX;
					_heightMax = limitWH?_content.height:LIMITWH_MAX;
				}else {
					_scaleMode = ScaleMode.PROPORTIONAL_INSIDE;
					_widthMax = limitWH?Math.min(_content.width, widthArea):LIMITWH_MAX;
					_heightMax = limitWH?Math.min(_content.height, heightArea):LIMITWH_MAX;
				}
				autoFitArea.attach(_content, _scaleMode, _alignX, _alignY, false, 0, _widthMax, 0, _heightMax);
			}
		}
		protected function onImageLoadingHandler(_evt:LoaderEvent):void {
			//trace(_evt);
		}
		protected function onImageLoadedHandler(_evt:LoaderEvent):void {
			bmdNow = _evt.target.rawContent.bitmapData;
			setBMP(bmdNow);
		}
		
		
		private static var loaderMaxDic:Object = { };
		private static var imageLoaderDic:Object = { };
		private static var registeredDic:Object = { };
		private static var loaderMax:LoaderMax;
		private static var allContainer:Sprite = new Sprite();
		private static var imageLoader:com.greensock.loading.ImageLoader;
		private static var imageLoaderParams:Object;
		protected static function createManager(_groupID:String):LoaderMax {
			if (!loaderMaxDic[_groupID]) {
				imageLoaderParams = { container:allContainer };
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
		protected static function loadBMD(_source:String, _imageLoader:ui.ImageLoader, _index:uint = 0):BitmapData {
			imageLoader = imageLoaderDic[_source];
			if (imageLoader) {
				if (imageLoader.progress == 1) {
					//已经加载完图片
					return imageLoader.rawContent.bitmapData;
				}else {
					register(_source, _imageLoader);
					//将正在加载的图片加载优先级提前或退后
					loaderMax = createManager(_imageLoader.groupID);
					if (imageLoader == loaderMax.getLoader(_source)) {
						//同组请求图片的情况
						loaderMax.insert(imageLoader, _index);
					}else {
						//异组请求图片的情况,要找到imageLoader属于哪个loaderMax
					}
					return null;
				}
			}
			register(_source, _imageLoader);
			//添加新的加载
			imageLoaderParams.name = _source;
			imageLoader = new com.greensock.loading.ImageLoader(_source, imageLoaderParams);
			imageLoaderDic[_source] = imageLoader;
			loaderMax.insert(imageLoader, _index);
			loaderMax.load();
			return null;
		}
		private static function register(_source:String, _imageLoader:ui.ImageLoader):void {
			deregister(_imageLoader.sourceNow, _imageLoader);
			if (!registeredDic[_source]) {
				registeredDic[_source] = new Dictionary();
			}
			registeredDic[_source][_imageLoader] = _imageLoader;
		}
		private static function deregister(_source:String, _imageLoader:ui.ImageLoader):void {
			if (registeredDic[_source]) {
				delete registeredDic[_source][_imageLoader];
			}
		}
		private static function onChildProgressHandler(_evt:LoaderEvent):void {
			var _dic:Dictionary = registeredDic[_evt.target.url];
			if (!_dic) {
				return;
			}
			for each(var _imageLoader:ui.ImageLoader in _dic) {
				_imageLoader.onImageLoadingHandler(_evt);
			}
		}
		private static function onChildCompleteHandler(_evt:LoaderEvent):void {
			//_evt.target.content.visible = false;
			var _dic:Dictionary = registeredDic[_evt.target.url];
			if (!_dic) {
				return;
			}
			for each(var _imageLoader:ui.ImageLoader in _dic) {
				_imageLoader.onImageLoadedHandler(_evt);
				deregister(_evt.target.url,_imageLoader);
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