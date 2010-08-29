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
		public var picNow:DisplayObject;
		public var picPrev:DisplayObject;
		public var onLoaded:Function;
		public var isTweenShow:Boolean;
		public function PicLoader() 
		{
			picDic = { };
			if (frameClip) {
				widthMax = frameClip.width;
				heightMax = frameClip.height;
			}else if (container) {
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
		protected function onPicLoadedHandle(_evt:Event):void {
			var _loader:Loader = _evt.currentTarget.loader as Loader;
			(_loader.content as Bitmap).smoothing = true;
			if (frameClip) {
				container.addChildAt(_loader, getChildIndex(frameClip));
			}else {
				container.addChild(_loader);
			}
			addPic(_loader);
			if (onLoaded!=null) {
				onLoaded();
			}
		}
		private function addPic(_pic:DisplayObject):void {
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
		}
	}

}