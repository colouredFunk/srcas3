package akdcl.application.image{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.utils.ByteArray;
	import ui.Alert;
	import zero.ui.CameraPan;

	import flash.events.Event;

	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import ui.UISprite;
	import ui.transformTool.TransformTool;

	import akdcl.net.FileRef;
	import akdcl.media.DisplayRect;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class FixImage extends UISprite {
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

		protected var cameraPan:CameraPan;
		protected var transformTool:TransformTool;
		protected var fileRef:FileRef;
		protected var bitmap:Bitmap;
		protected var bitmapData:BitmapData;
		protected var orgBitmapData:BitmapData;
		protected var bitmapShow:Bitmap;
		
		public var isCamera:Boolean;

		override protected function init():void {
			super.init();

			fileRef = new FileRef();
			fileRef.onFailed = onImageFailedHandler;
			fileRef.onLoadComplete = onImageCompleteHandler;

			cameraPan = new CameraPan();
			cameraPan.onOpen = onCameraOpenHandler;
			cameraPan.onFailed = onCameraFailedHandler;
			
			imageWidth = maxImageWidth = frameShow.width - frameBorder * 2;
			imageHeight = maxImageHeight = frameShow.height - frameBorder * 2;

			displayRect = new DisplayRect(frameArea.width - frameBorder * 2, frameArea.height - frameBorder * 2, -1);
			shapesContainer = new UISprite();
			shapeMask = new Shape();
			shapeMove = new UISprite();
			bitmap = new Bitmap();
			bitmapShow = new Bitmap();

			shapesContainer.blendMode = BlendMode.LAYER;
			shapeMove.blendMode = BlendMode.ERASE;
			displayRect.x = shapesContainer.x = frameArea.x + frameBorder;
			displayRect.y = shapesContainer.y = frameArea.y + frameBorder;
			bitmapShow.x = frameShow.x + frameBorder;
			bitmapShow.y = frameShow.y + frameBorder;

			addChildAt(displayRect, getChildIndex(frameArea) + 1);
			addChildAt(shapesContainer, getChildIndex(displayRect) + 1);
			addChildAt(bitmapShow, getChildIndex(frameShow) + 1);

			shapesContainer.addChild(shapeMask);
			shapesContainer.addChild(shapeMove);

			transformTool = new TransformTool(shapesContainer);
			transformTool.area = new Rectangle(0, 0, displayRect.rectWidth, displayRect.rectHeight);
			shapesContainer.scrollRect = transformTool.area;

			enabled = false;
		}

		override protected function onRemoveToStageHandler():void {
			clear();
			transformTool.Clear();
			fileRef.remove();
			cameraPan.remove();
			super.onRemoveToStageHandler();
			onChanging = null;
			onLoaded = null;
			transformTool = null;
			fileRef = null;
			bitmapData = null;
			cameraPan = null;
		}

		public function browse():void {
			fileRef.browseFile();
		}
		
		public function useCamera():void {
			cameraPan.open("http://vhot2.qqvideo.tc.qq.com/59261446/7O9m8Qn4Ron.flv");
		}

		public function clear():void {
			reset();
			transformTool.ArrowClear();

			if (bitmapData){
				bitmapData.dispose();
				bitmapData = null;
			}
			removeEventListener(Event.ENTER_FRAME, onCameraPlayingHandler);
			cameraPan.close();
		}

		public function reset():void {
			transformTool.selectedItem = null;
			transformTool.SetInfo(shapeMove);
			transformTool.selectedItem = shapeMove;
			updateBMD();
		}
		
		public function pauseCamera():void {
			removeEventListener(Event.ENTER_FRAME, onCameraPlayingHandler);
			cameraPan.pause();
		}
		
		public function resumeCamera():void {
			if (isCamera) {
				addEventListener(Event.ENTER_FRAME, onCameraPlayingHandler);
				cameraPan.resume();
			}
		}

		public function getOrgBitmapData():BitmapData {
			return orgBitmapData;
		}

		public function getOrgFile():ByteArray {
			return isCamera?null:fileRef.data;
		}

		public function getFixBitmapData(_width:Number = 0, _height:Number = 0):BitmapData {
			if (!bitmapData){
				return null;
			}
			if (_width == 0 && _height == 0){
				return bitmapData;
			}
			var _bmd:BitmapData;
			bitmap.bitmapData = bitmapData;
			bitmap.smoothing = true;
			bitmap.scaleY = bitmap.scaleX = 1;

			var _matirx:Matrix = new Matrix();

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
				_matirx.d = _matirx.a = bitmap.scaleX;
			} else {
				if (_height <= 1){
					bitmap.height = bitmap.height * _height;
				} else {
					bitmap.height = _height;
				}
				bitmap.scaleX = bitmap.scaleY;
				bitmap.width = Math.round(bitmap.width);
				_matirx.d = _matirx.a = bitmap.scaleY;
			}

			_bmd = new BitmapData(bitmap.width, bitmap.height, false, backgroundColor);
			_bmd.draw(bitmap, _matirx);
			//_bmd.dispose();
			return _bmd;
		}

		protected function onImageCompleteHandler(_data:*):void {
			isCamera = false;
			removeEventListener(Event.ENTER_FRAME, onCameraPlayingHandler);
			cameraPan.close();
			transformTool.onChanging = updateBMD;
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

		protected function onCameraOpenHandler():void {
			orgBitmapData = null;
			isCamera = true;
			addEventListener(Event.ENTER_FRAME, onCameraPlayingHandler);
			transformTool.onChanging = null;
			enabled = true;
			setShapes();
			displayRect.setContent(cameraPan, 0);
			reset();
			if (onLoaded != null){
				onLoaded();
			}
		}
		
		protected function onCameraPlayingHandler(_e:Event):void {
			if (orgBitmapData) {
				orgBitmapData.dispose();
			}
			orgBitmapData = cameraPan.getBmd();
			updateBMD();
		}

		protected function onCameraFailedHandler(_str:String) {
			Alert.show(_str);
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

			bitmapShow.bitmapData = bitmapData;
			bitmapShow.smoothing = true;
			if (bitmapShow.scaleX == 1 && bitmapShow.width > 0){
				bitmapShow.width = imageWidth;
				bitmapShow.height = imageHeight;
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