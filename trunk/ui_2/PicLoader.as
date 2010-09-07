package ui_2
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	import com.greensock.layout.AlignMode;
	import com.greensock.TweenMax;
	import ui_2.Btn;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class PicLoader extends Btn
	{
		private var autoFitArea:AutoFitArea;
		private var widthMax:uint;
		private var heightMax:uint;
		private var picDic:Object;
		public var frameClip:DisplayObject;
		public var container:DisplayObjectContainer;
		public var picNow:*;
		public var picPrev:*;
		public var onLoaded:Function;
		public var onChange:Function;
		public var isTweenShow:Boolean;
		public function PicLoader() 
		{
			picDic = { };
			if (frameClip) {
				widthMax = frameClip.width;
				heightMax = frameClip.height;
			}else if (container && container.width * container.height != 0) {
				widthMax = container.width;
				heightMax = container.height;
			}else {
				widthMax = width;
				heightMax = height;
			}
			if (!container) {
				container = this;
			}
			autoFitArea = new AutoFitArea(container, 0, 0, widthMax, heightMax);
		}
		private var __isLoading:Boolean;
		public function get isLoading():Boolean {
			return __isLoading;
		}
		public function loadPic(_path:String):void {
			if (__isLoading) {
				return;
			}
			if (picNow) {
				picPrev = picNow;
			}
			if (picDic[_path]) {
				addPic(picDic[_path]);
			}else {
				picDic[_path] = Common.loader(_path, onPicLoadedHandle);
			}
		}
		public function addPicByBitmapData(_path:String, _bmd:BitmapData):void {
			if (picDic[_path]) {
				
			}else {
				var _bmp:Bitmap = new Bitmap(_bmd);
				_bmp.smoothing = true;
				if (frameClip) {
					container.addChildAt(_bmp, getChildIndex(frameClip));
				}else {
					container.addChild(_bmp);
				}
				_bmp.visible = false;
				picDic[_path] = _bmp;
			}
		}
		protected function onPicLoadedHandle(_evt:Event):void {
			var _loader:Loader = _evt.currentTarget.loader as Loader;
			(_loader.content as Bitmap).smoothing = true;
			if (frameClip) {
				container.addChildAt(_loader, getChildIndex(frameClip));
			}else {
				container.addChild(_loader);
			}
			if (onLoaded!=null) {
				onLoaded(_loader);
			}
			addPic(_loader);
		}
		private function addPic(_pic:*):void {
			autoFitArea.attach(_pic, ScaleMode.PROPORTIONAL_INSIDE, AlignMode.CENTER, AlignMode.CENTER);
			if (isTweenShow) {
				if (picPrev) {
					TweenMax.to(picPrev, 10, { autoAlpha:0,useFrames:true } );
				}
				if (_pic.alpha==1) {
					_pic.alpha = 0;
				}
				TweenMax.to(_pic, 10, { autoAlpha:1,useFrames:true } );
			}else {
				if (picPrev) {
					picPrev.visible = false;
				}
				_pic.visible = true;
			}
			picNow = _pic;
			if (onChange!=null) {
				onChange();
			}
		}
	}

}