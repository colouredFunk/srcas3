package ui {
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	import flash.display.MovieClip;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
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
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  ImageLoader extends Btn {
		private static var contextMenuImageLoader:ContextMenu;
		private static var contextMenuItemImageLoader:ContextMenuItem;
		private static function createMenu(_target:*):ContextMenu {
			if (!ApplicationDomain.currentDomain.hasDefinition("Common")) {
				return null;
			}
			if (!contextMenuImageLoader) {
				contextMenuItemImageLoader = ApplicationDomain.currentDomain.getDefinition("Common").addContextMenu(_target, "");
				contextMenuImageLoader = _target.contextMenu;
				contextMenuImageLoader.addEventListener(ContextMenuEvent.MENU_SELECT, onImageMenuShowHandler);
			}
			return contextMenuImageLoader;
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
		public function get areaWidth():uint {
			return autoFitArea.width;
		}
		public function set areaWidth(_areaWidth:uint):void {
			autoFitArea.width = _areaWidth;
		}
		public function get areaHeight():uint {
			return autoFitArea.height;
		}
		public function set areaHeight(_areaHeight:uint):void {
			autoFitArea.height = _areaHeight;
		}
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
			var _areaWidth:uint = 1;
			var _areaHeight:uint = 1;
			if (background) {
				_areaWidth = background.width;
				_areaHeight = background.height;
			}else if (container.width * container.height > 0) {
				_areaWidth = container.width;
				_areaHeight = container.height;
			}
			setProgressClip(false);
			bmp = new Bitmap();
			bmp.alpha = 0;
			autoFitArea = new AutoFitArea(container, 0, 0, _areaWidth, _areaHeight);
			contextMenu = createMenu(this);
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
		public var changeImmediately:Boolean;
		public function load(_source:*, _index:uint = 0, _changeImmediately:Boolean = false ):void {
			if (_source && __source == _source) {
				onImageLoadingHandler(null);
				onImageLoadedHandler(null);
				return;
			}
			__source = _source;
			changeImmediately = _changeImmediately;
			if (_source is BitmapData) {
				bmdNow = _source;
				__source = null;
				setBMP(bmdNow);
			}else {
				loadBMD(_source, this, _index);
			}
		}
		public function unload():void {
			hideBMP(bmp, onUnloadedHandler);
		}
		protected var isHideTweening:Boolean;
		protected function hideBMP(_content:*, onHideComplete:Function = null):void {
			if (isHideTweening) {
				return;
			}
			isHideTweening = true;
			autoFitArea.release(_content);
			TweenMax.killTweensOf(bmp);
			TweenMax.to(bmp, changeImmediately?0:12, { alpha:0, useFrames:true, ease:Sine.easeInOut, onComplete:onHideComplete } );
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
		protected function setBMP(_content:*):void {
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
			TweenMax.to(bmp, changeImmediately?0:15, { alpha:1, useFrames:true, ease:Sine.easeInOut } );
			updateArea(bmp);
		}
		private const LIMITWH_MAX:uint = 999999;
		protected function updateArea(_content:*):void {
			if (areaWidth + areaHeight <= 2) {
				//原始大小显示
			}else {
				var _widthMax:uint;
				var _heightMax:uint;
				var _scaleMode:String
				var _alignX:String = AlignMode.CENTER;
				var _alignY:String = AlignMode.CENTER;
				if (areaWidth <= 1) {
					_scaleMode = ScaleMode.PROPORTIONAL_OUTSIDE;
					_alignX = AlignMode.LEFT;
					_widthMax = limitSize?_content.width:LIMITWH_MAX;
					_heightMax = limitSize?Math.min(_content.height, areaHeight):LIMITWH_MAX;
				}else if (areaHeight <= 1) {
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
		protected function onImageErrorHandler(_evt:*):void {
			setProgressClip(false);
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		protected function onImageLoadingHandler(_evt:*):void {
			__loadProgress = _evt?_evt.target.progress:1;
			setProgressClip(__loadProgress);
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _evt?_evt.target.bytesLoaded:100, _evt?_evt.target.bytesTotal:100));
		}
		protected function onImageLoadedHandler(_evt:*):void {
			var _isReady:Boolean = !Boolean(bmdNow);
			if (_evt is LoaderEvent) {
				bmdNow = _evt.target.rawContent.bitmapData;
			}else if (_evt is BitmapData) {
				bmdNow = _evt as BitmapData;
			}
			if (_evt && bmdNow) {
				if (_isReady) {
					setBMP(bmdNow);
				}else {
					hideBMP(bmp, onHideEndHandler);
				}
			}
			setProgressClip(false);
			dispatchEvent(new Event(Event.COMPLETE));
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
											onChildFail:onChildFailHandler,
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
		protected static function loadBMD(_source:String, _imageLoader:ui.ImageLoader, _index:uint = 0):void {
			imageLoader = imageLoaderDic[_source];
			if (imageLoader) {
				if (imageLoader.progress == 1 && imageLoader.rawContent && imageLoader.rawContent.bitmapData) {
					//已经加载完图片
					_imageLoader.onImageLoadingHandler(null);
					_imageLoader.onImageLoadedHandler(imageLoader.rawContent.bitmapData);
					return;
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
					return;
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
			return;
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
		private static function onChildFailHandler(_evt:LoaderEvent):void {
			var _dic:Dictionary = registeredDic[_evt.target.url];
			if (!_dic) {
				return;
			}
			for each(var _imageLoader:ui.ImageLoader in _dic) {
				_imageLoader.onImageErrorHandler(_evt);
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