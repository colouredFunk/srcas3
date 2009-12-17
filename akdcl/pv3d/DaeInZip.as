package akdcl.pv3d{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import riaidea.utils.zip.*;
	import org.papervision3d.materials.BitmapMaterial;
	
	public class DaeInZip{
		public var onComplete:Function;
		private var zipArchive:ZipArchive;
		private var dae:XML;
		private var materialListByImageName:Object;
		public function DaeInZip(){
		}
		public function loadZip(_source:*):void {
			materialListByImageName={};
			dae=null;
			zipArchive=new ZipArchive();
			if(_source is ByteArray){
				if(zipArchive.open(_source)){
					onZipLoader({currentTarget:zipArchive});
				}
			}else{
				zipArchive.load(_source);
				zipArchive.addEventListener(ZipEvent.ZIP_INIT, onZipLoader);
			}
		}
		private var images_loaded:uint;
		private var images_total:uint;
		private function onZipLoader(_evt:Object):void {
			var _zipArchive:ZipArchive = (_evt.currentTarget as ZipArchive);
			_zipArchive.removeEventListener(ZipEvent.ZIP_INIT, onZipLoader);
			_zipArchive.addEventListener(ZipEvent.ZIP_CONTENT_LOADED, imageLoaded);
			var _lth:uint=_zipArchive.length;
			images_total = (_lth - 1);
			images_loaded=0;
			var _i:uint;
			var _str:String;
			while (_i < _lth) {
				_str=_zipArchive.getFileAt(_i).name;
				if (_str.toLowerCase().indexOf(".dae")<0) {
					_zipArchive.getBitmapByName(_str);
				} else {
					dae=new XML(_zipArchive.getFileByName(_str).data);
				}
				_i++;
			}
		}
		private function imageLoaded(_evt:ZipEvent):void {
			images_loaded++;
			var _img:Bitmap = (_evt.content as Bitmap);
			materialListByImageName[_evt.file.name]=new BitmapMaterial(_img.bitmapData);
			if (images_loaded>=images_total) {
				_evt.currentTarget.removeEventListener(ZipEvent.ZIP_CONTENT_LOADED, imageLoaded);
				setMaterialsList();
			}
		}
		private function setMaterialsList():void {
			if(dae==null){
				return;
			}
			default xml namespace = dae.namespace();
			//trace("image lenght: "+dae.library_images.image.length());
			//trace("material lenght: "+dae.library_materials.material.length());
			//trace("effects lenght: "+dae.library_effects.effect.length());
			var _materialId:String;
			var _imageName:String;
			var _materialList:Object={};
			var _lth:uint=dae.library_materials.material.length();
			var _i:uint;
			while (_i < _lth) {
				_materialId=dae.library_materials.material[_i].@id;
				//trace("material id: "+_materialId);
				_imageName = dae.library_images.image.(@id.contains(dae.library_effects.effect[_i].profile_COMMON.newparam[0].surface.init_from)).init_from;
				//trace("set: "+_materialId+" width "+_imageName);
				_materialList[_materialId]=materialListByImageName[_imageName];
				_i++;
			}
			if(onComplete!=null){
				onComplete(dae,_materialList);
			}
		}
	}
}