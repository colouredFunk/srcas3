package akdcl.application.image {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.utils.ByteArray;

	import flash.events.Event;

	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import ui.Alert;
	import ui.UISprite;
	import ui.transformTool.TransformTool;

	import akdcl.net.FileRef;
	import akdcl.media.DisplayRect;
	import akdcl.media.CameraProvider;
	import akdcl.events.MediaEvent;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class FixImage extends UISprite {
		private static const MATRIX:Matrix = new Matrix();

		public var backgroundColor:uint = 0xffffff;
		public var frameBorder:uint = 10;
		public var maxImageWidth:uint;
		public var maxImageHeight:uint;
		public var imageWidth:uint;
		public var imageHeight:uint;

		public var frameArea:*;
		public var frameShow:*;
		public var onChanging:Function;
		public var onLoaded:Function;

		protected var displayRect:DisplayRect;
		protected var shapeMask:Shape;
		protected var shapeMove:UISprite;
		protected var shapesContainer:UISprite;

		protected var cameraProvider:CameraProvider;
		protected var fileRef:FileRef;
		protected var transformTool:TransformTool;
		protected var bitmap:Bitmap;
		protected var bitmapData:BitmapData;
		protected var orgBitmapData:BitmapData;

		public var isCamera:Boolean;

		override protected function init():void {
			super.init();

			fileRef = new FileRef();
			fileRef.onFailed = onImageFailedHandler;
			fileRef.onLoadComplete = onImageCompleteHandler;

			cameraProvider = new CameraProvider();
			cameraProvider.addEventListener(MediaEvent.DISPLAY_CHANGE, onCameraOpenHandler);
			cameraProvider.addEventListener(MediaEvent.PLAY_PROGRESS, onCameraPlayingHandler);
			cameraProvider.addEventListener(MediaEvent.LOAD_ERROR, onCameraFailedHandler);

			imageWidth = maxImageWidth = frameShow.width - frameBorder * 2;
			imageHeight = maxImageHeight = frameShow.height - frameBorder * 2;

			displayRect = new DisplayRect(frameArea.width - frameBorder * 2, frameArea.height - frameBorder * 2, -1);
			shapesContainer = new UISprite();
			shapeMask = new Shape();
			shapeMove = new UISprite();
			bitmap = new Bitmap();

			shapesContainer.blendMode = BlendMode.LAYER;
			shapeMove.blendMode = BlendMode.ERASE;
			displayRect.x = shapesContainer.x = frameArea.x + frameBorder;
			displayRect.y = shapesContainer.y = frameArea.y + frameBorder;
			bitmap.x = frameShow.x + frameBorder;
			bitmap.y = frameShow.y + frameBorder;

			addChildAt(displayRect, getChildIndex(frameArea) + 1);
			addChildAt(shapesContainer, getChildIndex(displayRect) + 1);
			addChildAt(bitmap, getChildIndex(frameShow) + 1);

			shapesContainer.addChild(shapeMask);
			shapesContainer.addChild(shapeMove);

			transformTool = new TransformTool(shapesContainer);
			transformTool.onChanging = updateBMD;
			transformTool.area = new Rectangle(0, 0, displayRect.rectWidth, displayRect.rectHeight);
			shapesContainer.scrollRect = transformTool.area;

			enabled = false;
		}

		override protected function onRemoveToStageHandler():void {
			clear();
			transformTool.Clear();
			fileRef.remove();
			cameraProvider.remove();
			super.onRemoveToStageHandler();
			frameArea = null;
			frameShow = null;
			onChanging = null;
			onLoaded = null;
			displayRect = null;
			shapeMask = null;
			shapeMove = null;
			shapesContainer = null;
			cameraProvider = null;
			fileRef = null;
			transformTool = null;
			bitmap = null;
			bitmapData = null;
			orgBitmapData = null;
		}

		public function browse():void {
			fileRef.browseFile();
		}

		public function useCamera():void {
			cameraProvider.pause();
			cameraProvider.load(null);
		}

		public function clear():void {
			reset();
			transformTool.ArrowClear();
			cameraProvider.stop();

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

		public function activate():void {
			if (isCamera){
				cameraProvider.play();
			}
		}

		public function deactivate():void {
			if (isCamera){
				cameraProvider.pause();
			}
		}

		public function getOrgBitmapData():BitmapData {
			return orgBitmapData;
		}

		public function getOrgFile():ByteArray {
			return isCamera ? null : fileRef.data;
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
			bitmap.scaleY = bitmap.scaleX = 1;

			var _aspectRatio:Number = _width / _height;
			var _aspectRatioOrg:Number = bitmapData.width / bitmapData.height;
			if (_width * _height > 0 ? (_aspectRatio < _aspectRatioOrg) : (_width > 0)){
				if (_width <= 1){
					bitmap.width = bitmap.width * _width;
				} else {
					bitmap.width = _width;
				}
				bitmap.scaleY = bitmap.scaleX;
				bitmap.height = Math.round(bitmap.height);
				MATRIX.d = MATRIX.a = bitmap.scaleX;
			} else {
				if (_height <= 1){
					bitmap.height = bitmap.height * _height;
				} else {
					bitmap.height = _height;
				}
				bitmap.scaleX = bitmap.scaleY;
				bitmap.width = Math.round(bitmap.width);
				MATRIX.d = MATRIX.a = bitmap.scaleY;
			}

			_bmd = new BitmapData(bitmap.width, bitmap.height, false, backgroundColor);
			_bmd.draw(bitmap, MATRIX);
			//还原
			bitmap.width = imageWidth;
			bitmap.height = imageHeight;
			//_bmd.dispose();

			return _bmd;
		}

		protected function onImageCompleteHandler(_data:*):void {
			if (isCamera){
				if (orgBitmapData){
					orgBitmapData.dispose();
				}
				isCamera = false;
				cameraProvider.stop();
			}
			enabled = true;
			setShapes();
			orgBitmapData = _data;
			displayRect.setContent(_data, 0);
			reset();
			if (onLoaded != null){
				onLoaded();
			}
		}

		protected function onImageFailedHandler(_str:String):void {
			Alert.show(_str);
		}

		protected function onCameraOpenHandler(_e:* = null):void {
			if (!isCamera){
				orgBitmapData = null;
				isCamera = true;
			}
			enabled = true;
			setShapes();
			displayRect.setContent(cameraProvider.playContent, 0);
			reset();
			if (onLoaded != null){
				onLoaded();
			}
		}

		protected function onCameraPlayingHandler(_e:Event):void {
			if (!orgBitmapData){
				orgBitmapData = new BitmapData(cameraProvider.playContent.width, cameraProvider.playContent.height, false, backgroundColor);
			}
			MATRIX.d = MATRIX.a = cameraProvider.playContent.scaleX;
			orgBitmapData.draw(cameraProvider.playContent, MATRIX);
			updateBMD();
		}

		protected function onCameraFailedHandler(_e:* = null){
			Alert.show("请允许使用摄像头或检查摄像头是否正常！");
		}

		protected function setShapes():void {
			if (shapeMove.width == 0){
				shapeMask.graphics.beginFill(0x000000, 0.5);
				shapeMask.graphics.drawRect(0, 0, displayRect.rectWidth, displayRect.rectHeight);
				shapeMove.graphics.beginFill(backgroundColor);
				shapeMove.graphics.drawRect(0, 0, maxImageWidth, maxImageHeight);

				shapeMove.width = imageWidth;
				shapeMove.height = imageHeight;
				shapeMove.x = int((shapesContainer.scrollRect.width - imageWidth) * 0.5);
				shapeMove.y = int((shapesContainer.scrollRect.height - imageHeight) * 0.5);

				transformTool.Init();
				transformTool.AddControl(shapeMove, true);
				transformTool.SetStyle(shapeMove, {eqScale: true, enSetMidPoint: false});
			}
		}


		protected function updateBMD():void {
			if (bitmapData){
				bitmapData.dispose();
			}
			bitmapData = getContainBmd(shapeMove, displayRect, backgroundColor);

			bitmap.bitmapData = bitmapData;
			bitmap.smoothing = true;
			if (bitmap.width > 0 && bitmap.width != imageWidth){
				bitmap.width = imageWidth;
				bitmap.height = imageHeight;
			}
			if (onChanging != null){
				onChanging();
			}
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