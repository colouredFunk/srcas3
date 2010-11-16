package ui {
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import com.greensock.TweenMax;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	import com.greensock.easing.Sine;
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import flash.events.ContextMenuEvent;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  ImageLoader extends Btn {
		private static var contextMenuImageLoader:ContextMenu;
		private static var contextMenuItemImageLoader:ContextMenuItem;
		private static function createMenu(_target:*):void {
			if (!contextMenuImageLoader) {
				contextMenuItemImageLoader = Common.addContextMenu(_target, "");
				contextMenuImageLoader = _target.contextMenu;
				contextMenuImageLoader.addEventListener(ContextMenuEvent.MENU_SELECT, onImageMenuShowHandler);
			}
		}
		private static function onImageMenuShowHandler(_evt:ContextMenuEvent):void {
			var _imageLoader:*=_evt.contextMenuOwner as ImageLoader;
			var _source:String = _imageLoader.source;
			if (_source) {
				_source = _source.split("/").pop();
			}else {
				_source = "--";
			}
			_source = _source + ":" + _imageLoader.areaWidth + " x " + _imageLoader.areaHeight;
			contextMenuItemImageLoader.caption = _source;
		}
		
		public var progressClip:*;
		public var container:*;
		public var foreground:*;
		public var background:*;
		public var limitSize:Boolean;
		protected var autoFitArea:AutoFitArea;
		protected var bmp:Bitmap;
		protected var bmdNow:BitmapData;
		protected var __loadProgress:Number = 0;
		public function get loadProgress():Number {
			return __loadProgress;
		}
		private var __imageGroup:String;
		public function get imageGroup():String{
			return __imageGroup;
		}
		public function set imageGroup(_imageGroup:String):void{
			__imageGroup = _imageGroup;
		}
		public function get maxConnections():uint{
			return createManager(imageGroup).maxConnections;
		}
		public function set maxConnections(_maxConnections:uint):void{
			createManager(imageGroup).maxConnections = _maxConnections;
		}
		public function get noCache():Boolean{
			return createManager(imageGroup).vars.noCache;
		}
		public function set noCache(_noCache:Boolean):void{
			createManager(imageGroup).vars.noCache = _noCache;
		}
		private var __areaWidth:uint = 1;
		public function get areaWidth():uint {
			return __areaWidth;
		};
		public function set areaWidth(_areaWidth:uint):void {
			__areaWidth = _areaWidth;
			autoFitArea.width = __areaWidth;
		};
		private var __areaHeight:uint = 1;
		public function get areaHeight():uint {
			return __areaHeight;
		};
		public function set areaHeight(_areaHeight:uint):void {
			__areaHeight = _areaHeight;
			autoFitArea.height = __areaHeight;
		};
		protected var __source:String;
		public function get source():String {
			return __source;
		}
		override protected function init():void {
			super.init();
			imageGroup = getQualifiedClassName(this);
			if (!container) {
				container = this;
			}
			if (background) {
				__areaWidth = background.width;
				__areaHeight = background.height;
			}else if (container.width * container.height > 0) {
				__areaWidth = container.width;
				__areaHeight = container.height;
			}
			setProgressClip(false);
			bmp = new Bitmap();
			bmp.alpha = 0;
			autoFitArea = new AutoFitArea(container, 0, 0, areaWidth, areaHeight);
			createMenu(this);
			contextMenu = contextMenuImageLoader;
		}
		override protected function onRemoveToStageHandler():void {
			TweenMax.killChildTweensOf(this);
			TweenMax.killTweensOf(bmp);
			super.onRemoveToStageHandler();
			if (container != this && container.contains(bmp)) {
				container.removeChild(bmp);
			}
			bmp.bitmapData = null;
			bmdNow = null;
			__source = null;
			progressClip = null;
			container = null;
			foreground = null;
			background = null;
			autoFitArea.destroy();
		}
		public function load(_source:*, _index:uint = 0, _changeImmediately:Boolean = false ):void {
			if (_source && __source == _source) {
				return;
			}
			__source = _source;
			if (_source is BitmapData) {
				bmdNow = _source;
				__source = null;
			}else {
				var _isReady:Boolean = !Boolean(bmdNow);
				bmdNow = loadBMD(_source, this, _index);
			}
			if (_changeImmediately) {
				if (bmdNow) {
					setBMP(bmdNow, _changeImmediately);
				}else {
					hideBMP(bmp, _changeImmediately, onHideEndHandler);
				}
			}else {
				if (bmdNow && _isReady) {
					setBMP(bmdNow, _changeImmediately);
				}else {
					hideBMP(bmp, _changeImmediately, onHideEndHandler);
				}
			}
		}
		public function unload(_changeImmediately:Boolean = false):void {
			hideBMP(bmp, _changeImmediately, onUnloadedHandler);
		}
		protected var isHideTweening:Boolean;
		protected function hideBMP(_content:*, _changeImmediately:Boolean = false , onHideComplete:Function = null):void {
			if (isHideTweening) {
				return;
			}
			isHideTweening = true;
			autoFitArea.release(_content);
			TweenMax.killTweensOf(bmp);
			TweenMax.to(bmp, _changeImmediately?0:12, { alpha:0, useFrames:true, ease:Sine.easeInOut, onComplete:onHideComplete } );
		}
		private function onUnloadedHandler():void {
			isHideTweening = false;
			bmp.bitmapData = null;
			bmdNow = null;
			__source = null;
		}
		private function onHideEndHandler():void {
			isHideTweening = false;
			setBMP(bmdNow);
		}
		protected function setBMP(_content:*, _changeImmediately:Boolean = false ):void {
			if (!_content || isHideTweening) {
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
			TweenMax.to(bmp, _changeImmediately?0:15, { alpha:1, useFrames:true, ease:Sine.easeInOut } );
			updateArea(bmp);
		}
		private const LIMITWH_MAX:uint = 999999;
		public function updateArea(_content:*):void {
			if (areaWidth + areaHeight <= 2) {
				//原始大小显示
			}else {
				var _widthMax:uint;
				var _heightMax:uint;
				var _scaleMode:String
				var _alignX:String = AlignMode.CENTER;
				var _alignY:String = AlignMode.CENTER;
				if(areaWidth<=1){
					_scaleMode = ScaleMode.PROPORTIONAL_OUTSIDE;
					_alignX = AlignMode.LEFT;
					_widthMax = limitSize?_content.width:LIMITWH_MAX;
					_heightMax = limitSize?Math.min(_content.height, areaHeight):LIMITWH_MAX;
				}else if (areaHeight<=1) {
					_scaleMode = ScaleMode.PROPORTIONAL_OUTSIDE;
					_alignY = AlignMode.TOP;
					_widthMax = limitSize?Math.min(_content.width, areaWidth):LIMITWH_MAX;
					_heightMax = limitSize?_content.height:LIMITWH_MAX;
				}else {
					_scaleMode = ScaleMode.PROPORTIONAL_INSIDE;
					_widthMax = limitSize?Math.min(_content.width, areaWidth):LIMITWH_MAX;
					_heightMax = limitSize?Math.min(_content.height, areaHeight):LIMITWH_MAX;
				}
				autoFitArea.attach(_content, _scaleMode, _alignX, _alignY, false, 0, _widthMax, 0, _heightMax);
			}
		}
		protected function onImageLoadingHandler(_evt:LoaderEvent):void {
			__loadProgress = _evt.target.progress;
			setProgressClip(_evt.target.progress);
		}
		protected function onImageLoadedHandler(_evt:LoaderEvent):void {
			bmdNow = _evt.target.rawContent.bitmapData;
			setBMP(bmdNow);
			setProgressClip(false);
		}
		protected function setProgressClip(_progress:*):void {
			if (!progressClip) {
				return;
			}
			if (_progress is Number) {
				progressClip.visible = true;
				if (progressClip.hasOwnProperty("text")) {
					progressClip.text = Math.round(_progress * 100) + " %";
				}else if (progressClip.hasOwnProperty("value")) {
					progressClip.value = _progress;
				}else if (progressClip is MovieClip) {
					progressClip.play();
				}
			}else {
				progressClip.visible = false;
				if (progressClip is MovieClip) {
					progressClip.stop();
				}
			}
		}
		
		
		private static var loaderMaxDic:Object = { };
		private static var imageLoaderDic:Object = { };
		private static var registeredDic:Object = { };
		private static var loaderMax:LoaderMax;
		private static var allContainer:Sprite = new Sprite();
		private static var imageLoader:com.greensock.loading.ImageLoader;
		private static var imageLoaderParams:Object = {container:allContainer};
		protected static function createManager(_imageGroup:String):LoaderMax {
			if (!loaderMaxDic[_imageGroup]) {
				loaderMax = new LoaderMax( { name:_imageGroup,
											noCache:false,
											onChildProgress:onChildProgressHandler,
											onChildComplete:onChildCompleteHandler,
											onProgress:onProgressHandler,
											onComplete:onCompleteHandler,
											onError:onErrorHandler
											} );
				loaderMaxDic[_imageGroup] = loaderMax;
			}
			return loaderMaxDic[_imageGroup];
		}
		public static var onGroupLoading:Function;
		public static var onGroupLoaded:Function;
		protected static function loadBMD(_source:String, _imageLoader:ui.ImageLoader, _index:uint = 0):BitmapData {
			imageLoader = imageLoaderDic[_source];
			if (imageLoader) {
				if (imageLoader.progress == 1 && imageLoader.rawContent && imageLoader.rawContent.bitmapData) {
					//已经加载完图片
					return imageLoader.rawContent.bitmapData;
				}else {
					register(_source, _imageLoader);
					//将正在加载的图片加载优先级提前或退后
					loaderMax = createManager(_imageLoader.imageGroup);
					if (imageLoader == loaderMax.getLoader(_source)) {
						//同组请求图片的情况
						loaderMax.insert(imageLoader, _index);
					}else {
						//异组请求图片的情况,要找到imageLoader属于哪个loaderMax
					}
					return null;
				}
			}
			//添加新的加载
			register(_source, _imageLoader);
			loaderMax = createManager(_imageLoader.imageGroup);
			
			imageLoaderParams.name = _source;
			imageLoaderParams.noCache = loaderMax.vars.noCache;
			imageLoader = new com.greensock.loading.ImageLoader(String(_source), imageLoaderParams);
			imageLoaderDic[_source] = imageLoader;
			
			loaderMax.insert(imageLoader, _index);
			loaderMax.load();
			return null;
		}
		private static function register(_source:String, _imageLoader:ui.ImageLoader):void {
			deregister(_imageLoader.__source, _imageLoader);
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
			var _dic:Dictionary = registeredDic[_evt.target.url];
			if (!_dic) {
				return;
			}
			for each(var _imageLoader:ui.ImageLoader in _dic) {
				_imageLoader.onImageLoadedHandler(_evt);
				deregister(_evt.target.url,_imageLoader);
			}
		}
		private static function onErrorHandler(_evt:LoaderEvent):void {
			//removeLoaderFormDic
			trace(_evt.toString());
		}
		private static function onProgressHandler(_evt:LoaderEvent):void{
			if (onGroupLoading!=null) {
				onGroupLoading(_evt.currentTarget.name, _evt.currentTarget.progress);
			}
		}
		private static function onCompleteHandler(_evt:LoaderEvent):void{
			if (onGroupLoaded!=null) {
				onGroupLoaded(_evt.currentTarget.name);
			}
		}
	}
}