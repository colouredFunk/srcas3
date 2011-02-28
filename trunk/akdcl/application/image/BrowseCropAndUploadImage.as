package {
	import com.JPEGEncoder;

	import akdcl.application.image.CropImage;
	
	import akdcl.net.DataLoader;
	import akdcl.net.FileRef;
	import akdcl.net.FormVariables;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class BrowseCropAndUploadImage extends CropImage {
		

		//public var btnBrowse:*;
		//public var onLoaded:Function;
		//protected var fileRef:FileRef;
		//protected var formVariables:FormVariables;

			//fileRef = new FileRef();
			//fileRef.onLoadComplete = onImageLoadedHandler;
			//formVariables = new FormVariables();
			//if (btnBrowse){
				//btnBrowse.release = browse;
			//}
			//fileRef.remove();
			//formVariables.removeAll();
			//btnBrowse = null;
			//fileRef = null;
			//onLoaded = null;
			//formVariables = null;


		/*protected function onImageLoadedHandler(_data:*):void {
			if (onLoaded != null){
				onLoaded();
			}
		}*/
		/*public function browse():void {
			fileRef.browseFile();
		}*/

		/*public function addData(_data:Object):void {
			for (var _i:String in _data){
				formVariables.add(_i, _data[_i]);
			}
		}*/
		/*
		public function upload(_url:String, _quality:uint = 80, _isGBKData:Boolean = false, ... args):DataLoader {
			if (!__cutedBMD){
				return null;
			}

			if (!args || args.length < 1){
				throw Error("no file name");
			}
			var _jpgEncoder:JPEGEncoder = new JPEGEncoder(_quality);
			if (args.length == 1){
				formVariables.addFile(args[0], _jpgEncoder.encode(__cutedBMD));
			} else {
				var _bmd:BitmapData;
				for (var _i:uint; _i < args.length; _i += 2){
					bitmapTemp.bitmapData = __cutedBMD;
					bitmapTemp.smoothing = true;
					//if () {
						//上传从未裁切过的图片
					//}
					bitmapTemp.width = int(args[_i + 1]) || bitmapTemp.width;
					matrixTemp.a = matrixTemp.d = bitmapTemp.scaleY = bitmapTemp.scaleX;
					bitmapTemp.height = Math.round(bitmapTemp.height);
					_bmd = new BitmapData(bitmapTemp.width, bitmapTemp.height, true, 0x000000);
					_bmd.draw(bitmapTemp, matrixTemp);
					formVariables.addFile(args[_i], _jpgEncoder.encode(_bmd));
					_bmd.dispose();
				}
			}
			return DataLoader.load(_url, null, onUploadComplete, null, _isGBKData ? formVariables.dataGBK : formVariables.data, formVariables.contentType);
		}

		private function onUploadComplete(e:Event):void {
			formVariables.removeAll();
		}*/
	}
	
}