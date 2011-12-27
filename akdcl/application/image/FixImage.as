package akdcl.application.image {
	import akdcl.layout.Display;
	import akdcl.media.CameraUI;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.utils.ByteArray;

	import flash.events.Event;

	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import akdcl.display.UISprite;
	import akdcl.display.UIDisplay;

	import ui.transformTool.TransformTool;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class FixImage extends UISprite {
		private static const MATRIX:Matrix = new Matrix();

		public var backgroundColor:uint = 0xffffff;

		public var imageWidth:uint;
		public var imageHeight:uint;

		protected var iconWidth:uint;
		protected var iconHeight:uint;

		protected var areaWidth:uint;
		protected var areaHeight:uint;

		public var frameBorder:uint = 0;

		public var frameArea:DisplayObject;
		public var frameIcon:DisplayObject;

		protected var displayArea:UIDisplay;
		protected var proxyIcon:Display;

		protected var shapeMask:Shape;
		//shapeMove需要鼠标事件不能用Shape
		protected var shapeMove:UISprite;
		protected var shapesContainer:UISprite;

		protected var transformTool:TransformTool;
		protected var bitmap:Bitmap;
		protected var bitmapData:BitmapData;
		protected var orgBitmapData:BitmapData;

		override protected function init():void {
			super.init();

			areaWidth = frameArea.width - frameBorder * 2;
			areaHeight = frameArea.height - frameBorder * 2;

			iconWidth = frameIcon.width - frameBorder * 2;
			iconHeight = frameIcon.height - frameBorder * 2;

			shapesContainer = new UISprite();
			shapeMask = new Shape();
			shapeMove = new UISprite();
			
			bitmap = new Bitmap();

			displayArea = new UIDisplay(areaWidth, areaHeight, -1);
			proxyIcon = new Display(frameIcon.x + frameBorder, frameIcon.y + frameBorder, iconWidth, iconHeight);
			
			shapeMove.blendMode = BlendMode.ERASE;
			
			shapeMask.graphics.beginFill(0x000000, 0.5);
			shapeMask.graphics.drawRect(0, 0, areaWidth, areaHeight);

			displayArea.x = shapesContainer.x = frameArea.x + frameBorder;
			displayArea.y = shapesContainer.y = frameArea.y + frameBorder;
			
			addChildAt(displayArea, getChildIndex(frameArea) + 1);
			addChildAt(shapesContainer, getChildIndex(displayArea) + 1);
			addChildAt(bitmap, getChildIndex(frameIcon) + 1);

			transformTool = new TransformTool(shapesContainer);
			transformTool.area = new Rectangle(0, 0, areaWidth, areaHeight);
			transformTool.onChanging = updateBMD;
			transformTool.Init();

			shapesContainer.scrollRect = transformTool.area;
			shapesContainer.addChild(shapeMask);
			shapesContainer.addChild(shapeMove);
		}

		public function setImageSize(_width:uint, _height:uint):void {
			imageWidth = _width;
			imageHeight = _height;

			shapeMove.graphics.clear();
			shapeMove.graphics.beginFill(backgroundColor);
			shapeMove.graphics.drawRect(0, 0, imageWidth, imageHeight);

			proxyIcon.setContent(shapeMove, 0, 0, 11);
			
			iconWidth = proxyIcon.getScaleWidth();
			iconHeight = proxyIcon.getScaleHeight();
			
			frameIcon.width = iconWidth + frameBorder * 2;
			frameIcon.height = iconHeight + frameBorder * 2;
			
			shapeMove.x = int((areaWidth - iconWidth) * 0.5);
			shapeMove.y = int((areaHeight - iconHeight) * 0.5);
			
			//
			transformTool.RemoveControl(shapeMove);
			transformTool.AddControl(shapeMove, true);
			transformTool.SetStyle(shapeMove, {eqScale: true, enSetMidPoint: false});

			enabled = false;
		}

		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
			clear();
			transformTool.Clear();
			frameArea = null;
			frameIcon = null;
			displayArea = null;
			shapeMask = null;
			shapeMove = null;
			shapesContainer = null;
			transformTool = null;
			bitmap = null;
			bitmapData = null;
			orgBitmapData = null;
		}

		public function clear():void {
			reset();
			transformTool.ArrowClear();
			if (bitmapData){
				bitmapData.dispose();
				bitmapData = null;
			}
		}

		public function reset():void {
			transformTool.selectedItem = null;
			transformTool.SetInfo(shapeMove);
			transformTool.selectedItem = shapeMove;
			updateBMD();
		}

		public function getOrgBitmapData():BitmapData {
			return orgBitmapData;
		}

		//设置 width 和 height 后注意回收bitmapData;
		public function getFixBitmapData(_width:Number = 0, _height:Number = 0):BitmapData {
			if (!bitmapData){
				return null;
			}
			if (_width == 0 && _height == 0){
				return bitmapData;
			}
			var _bmd:BitmapData;

			var _aspectRatio:Number = _width / _height;
			var _aspectRatioOrg:Number = imageWidth / imageHeight;

			if (_width * _height > 0 ? (_aspectRatio < _aspectRatioOrg) : (_width > 0)){
				if (_width <= 1){
					_width = imageWidth * _width;
				}
				_height = _width / _aspectRatioOrg;
				MATRIX.d = MATRIX.a = _width / imageWidth;
			} else {
				if (_height <= 1){
					_height = imageHeight * _height;
				}
				_width = _height * _aspectRatioOrg;
				MATRIX.d = MATRIX.a = _height / imageHeight;
			}

			_bmd = new BitmapData(_width, _height, false, backgroundColor);
			_bmd.draw(bitmapData, MATRIX);

			//_bmd.dispose();

			return _bmd;
		}

		public function setImage(_bmd:BitmapData):void {
			enabled = true;
			shapesContainer.blendMode = BlendMode.LAYER;
			if (orgBitmapData) {
				orgBitmapData.dispose();
			}
			
			orgBitmapData = _bmd;
			displayArea.setContent(orgBitmapData, 0);
			reset();
			proxyIcon.setContent(bitmap, 0, 0, 11);
		}

		protected function updateBMD():void {
			if (bitmapData){
				bitmapData.dispose();
			}
			bitmapData = getContainBmd(shapeMove, displayArea, backgroundColor);

			bitmap.bitmapData = bitmapData;
			bitmap.smoothing = true;
		}

		private static function getContainBmd(_obj:*, _bg:*, _bgColor:uint = 0):BitmapData {
			var _rect:Rectangle = _obj.getBounds(_obj);
			var _bmd:BitmapData = new BitmapData(_rect.width, _rect.height, false, _bgColor);
			var _m:Matrix = _bg.transform.concatenatedMatrix;
			var _objM:Matrix = new Matrix(1, 0, 0, 1, _rect.x, _rect.y);

			var _m2:Matrix = _obj.transform.concatenatedMatrix;
			_objM.concat(_m2);
			_objM.invert();
			_m.concat(_objM);
			_bmd.draw(_bg, _m);
			return _bmd;
		}
	}

}