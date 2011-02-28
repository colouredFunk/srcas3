package akdcl.application.image {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;

	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import ui.UISprite;
	import ui.ImageLoader;
	import ui.transformTool.TransformTool;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class CropImage extends UISprite {
		public var onChanging:Function;

		public var foreground:*;
		public var background:*;
		public var viewBackground:*;

		public var btnReset:*;

		protected var moveRect:UISprite;
		protected var foregroundRect:UISprite;
		protected var transformTool:TransformTool;
		protected var bitmapView:Bitmap;

		protected var imageLoader:ImageLoader;
		protected var bitmapTemp:Bitmap;
		//
		private var __rectWidth:uint = 100;

		public function get rectWidth():uint {
			return __rectWidth;
		}

		public function set rectWidth(_rectWidth:uint):void {
			__rectWidth = _rectWidth;
			viewBackground.width = __rectWidth;
			reset(true);
		}
		private var __rectHeight:uint = 100;

		public function get rectHeight():uint {
			return __rectHeight;
		}

		public function set rectHeight(_rectHeight:uint):void {
			__rectHeight = _rectHeight;
			viewBackground.height = __rectHeight;
			reset(true);
		}
		//
		private var __areaWidth:uint = 300;

		public function get areaWidth():uint {
			return __areaWidth;
		}

		public function set areaWidth(_areaWidth:uint):void {
			__areaWidth = Math.max(_areaWidth, rectWidth);
			foregroundRect.width = __areaWidth;
			reset(true);
		}
		private var __areaHeight:uint = 300;

		public function get areaHeight():uint {
			return __areaHeight;
		}

		public function set areaHeight(_areaHeight:uint):void {
			__areaHeight = Math.max(_areaHeight, rectHeight);
			foregroundRect.height = __areaHeight;
			reset(true);
		}
		//
		protected var __croppedBMD:BitmapData;

		public function get croppedBMD():BitmapData {
			return __croppedBMD;
		}

		public function get bitmapData():BitmapData {
			return imageLoader.bitmapData;
		}
		public function set bitmapData(_data:*):void {
			imageLoader.load(_data, 0, 0);
			reset(true);
		}

		override protected function init():void {
			super.init();
			if (background){
				__areaWidth = int(background.width) || __areaWidth;
				__areaHeight = int(background.height) || __areaHeight;
			}
			__rectWidth = int(viewBackground.width) || __rectWidth;
			__rectHeight = int(viewBackground.height) || __rectHeight;

			imageLoader = new ImageLoader();
			imageLoader.areaWidth = areaWidth;
			imageLoader.areaHeight = areaHeight;
			addChild(imageLoader);
			foreground = setForeground(foreground);

			bitmapView = new Bitmap();
			bitmapView.x = viewBackground.x;
			bitmapView.y = viewBackground.y;
			addChildAt(bitmapView, getChildIndex(viewBackground) + 1);
			bitmapTemp = new Bitmap();
			if (btnReset){
				btnReset.release = reset;
			}
		}

		override protected function onRemoveToStageHandler():void {
			__croppedBMD.dispose();
			super.onRemoveToStageHandler();

			background = null;
			onChanging = null;
			imageLoader = null;
			transformTool = null;
			__croppedBMD = null;
		}

		public function reset(_changeWH:Boolean = false):void {
			transformTool.selectedItem = null;
			transformTool.SetInfo(moveRect);
			if (_changeWH){
				transformTool.RemoveControl(moveRect);
				moveRect.width = rectWidth;
				moveRect.height = rectHeight;
				moveRect.x = int((areaWidth - rectWidth) * 0.5);
				moveRect.y = int((areaHeight - rectHeight) * 0.5);
				transformTool.AddControl(moveRect, true);
				transformTool.SetStyle(moveRect, {eqScale: true, enSetMidPoint: false});
			}
			transformTool.selectedItem = moveRect;
			updateBMD();
		}

		protected function setForeground(_container:* = null):* {
			moveRect = new UISprite();
			moveRect.blendMode = BlendMode.ERASE;
			moveRect.graphics.beginFill(0xffffff, 1);
			moveRect.graphics.drawRect(0, 0, rectWidth, rectHeight);
			moveRect.graphics.endFill();
			moveRect.x = int((areaWidth - rectWidth) * 0.5);
			moveRect.y = int((areaHeight - rectHeight) * 0.5);

			foregroundRect = new UISprite();
			foregroundRect.graphics.beginFill(0x000000, 0.5);
			foregroundRect.graphics.drawRect(0, 0, areaWidth, areaHeight);
			foregroundRect.graphics.endFill();

			if (!_container){
				_container = new UISprite();
				_container.x = background.x;
				_container.y = background.y;
				imageLoader.x = background.x;
				imageLoader.y = background.y;
				addChild(_container);
			}
			_container.blendMode = BlendMode.LAYER;
			_container.scrollRect = new Rectangle(0, 0, areaWidth, areaHeight);
			_container.addChild(foregroundRect);
			_container.addChild(moveRect);

			transformTool = new TransformTool(_container);
			transformTool.Init();
			transformTool.area = _container.scrollRect;
			transformTool.onChanging = updateBMD;
			return _container;
		}

		protected function updateBMD():void {
			if (__croppedBMD){
				__croppedBMD.dispose();
			}
			__croppedBMD = getContainBmd(moveRect, imageLoader);
			bitmapView.bitmapData = __croppedBMD;
			bitmapView.smoothing = true;
			if (onChanging != null){
				onChanging();
			}
		}

		private function getContainBmd(_obj:*, _bg:*):BitmapData {
			var _rect:Rectangle = _obj.getBounds(_obj);
			var _bmd:BitmapData = new BitmapData(rectWidth, rectHeight, true, 0x00000000);
			var _m:Matrix = _bg.transform.concatenatedMatrix;
			var _objM:Matrix = new Matrix(1, 0, 0, 1, -_rect.x, -_rect.y);
			_bmd.draw(_obj, _objM);
			_objM.tx *= -1;
			_objM.ty *= -1;
			var _m2:Matrix = _obj.transform.concatenatedMatrix;
			_objM.concat(_m2);
			_objM.invert();
			_m.concat(_objM);
			_bmd.draw(_bg, _m);
			return _bmd;
		}
	}
}