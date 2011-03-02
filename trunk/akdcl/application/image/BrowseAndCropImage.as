package {
	import flash.geom.Matrix;
	import flash.utils.ByteArray;

	import com.JPEGEncoder;
	
	import akdcl.application.image.CropImage;
	import akdcl.net.FileRef;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class BrowseAndCropImage extends CropImage {
		public var btnBrowse:*;
		public var onLoaded:Function;
		protected var matrixTemp:Matrix;
		protected var fileRef:FileRef;
		protected var jpegEncoder:JPEGEncoder

		override protected function init():void {
			super.init();
			matrixTemp = new Matrix();
			fileRef = new FileRef();
			fileRef.onLoadComplete = onImageLoadedHandler;
			if (btnBrowse){
				btnBrowse.release = browse;
			}
		}

		override protected function onRemoveToStageHandler():void {
			fileRef.remove();
			super.onRemoveToStageHandler();
			fileRef = null;
			onLoaded = null;
			btnBrowse = null;
			matrixTemp = null;
		}

		protected function onImageLoadedHandler(_data:*):void {
			bitmapData = _data;
			if (onLoaded != null){
				onLoaded();
			}
		}

		public function browse():void {
			fileRef.browseFile();
		}

		public function getJPEGData(_quality:uint = 80, _list:Array = null):* {
			if (!__croppedBMD){
				throw Error("not cropped image yet!");
				return null;
			}
			if (jpegEncoder) {
			}else {
				jpegEncoder = new JPEGEncoder(_quality);
			}
			if (_list){
				var _bmd:BitmapData;
				var _resultList:Vector.<ByteArray> = new Vector.<ByteArray>();
				for (var _i:uint; _i < _list.length; _i++){
					if (int(_list[_i]) == 0){
						_resultList[_i] = jpegEncoder.encode(bitmapData);
					} else {
						bitmapTemp.bitmapData = __croppedBMD;
						bitmapTemp.smoothing = true;
						bitmapTemp.width = int(_list[_i]) || bitmapTemp.width;
						matrixTemp.a = matrixTemp.d = bitmapTemp.scaleY = bitmapTemp.scaleX;
						bitmapTemp.height = Math.round(bitmapTemp.height);
						_bmd = new BitmapData(bitmapTemp.width, bitmapTemp.height, true, 0x000000);
						_bmd.draw(bitmapTemp, matrixTemp);
						_resultList[_i] = jpegEncoder.encode(_bmd);
						_bmd.dispose();
					}
				}
				return _resultList;
			} else {
				return jpegEncoder.encode(__croppedBMD);
			}
		}
	}

}