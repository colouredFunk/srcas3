package akdcl.pv3d{
	public class DaeInZip {
		public var onComplete:Function;
		public function DaeInZip() {
		}
		public function loadZip(_source:*):void {
			var _zipArchive:ZipArchiveForDaeZip = new ZipArchiveForDaeZip();
			_zipArchive.onComplete = function(_daeXML:XML, _materialList:Object):void {
				if (onComplete!=null) {
					onComplete(_daeXML, _materialList);
				}
				this.remove();
			}
			_zipArchive.loadZip(_source);
		}
	}
}
import flash.display.BitmapData;
import flash.utils.ByteArray;
import riaidea.utils.zip.ZipArchive;
import riaidea.utils.zip.ZipEvent;
import riaidea.utils.zip.ZipFile;
import org.papervision3d.materials.BitmapMaterial;
class ZipArchiveForDaeZip extends ZipArchive {
	private var daeXML:XML;
	private var materialListByImageName:Object;
	private var materialListLength:uint;
	public var onComplete:Function;
	public function ZipArchiveForDaeZip(_name:String = null) {
		super(_name);
		materialListByImageName = { };
	}
	public function loadZip(_source:*):void {
		if(_source is ByteArray){
			if(open(_source)){
				onZipLoadedHandle({currentTarget:this});
			}
		}else{
			load(_source);
			addEventListener(ZipEvent.ZIP_INIT, onZipLoadedHandle);
		}
	}
	public function remove():void {
		onComplete = null;
		materialListByImageName = null;
		daeXML = null;
		removeEventListener(ZipEvent.ZIP_INIT, onZipLoadedHandle);
		removeEventListener(ZipEvent.ZIP_CONTENT_LOADED, onImageLoadedHandle);
	}
	private function onZipLoadedHandle(_evt:Object):void {
		removeEventListener(ZipEvent.ZIP_INIT, onZipLoadedHandle);
		addEventListener(ZipEvent.ZIP_CONTENT_LOADED, onImageLoadedHandle);
		var _i:uint;
		var _str:String;
		while (_i < length) {
			_str=getFileAt(_i).name;
			if (_str.toLowerCase().indexOf(".dae")<0) {
				getBitmapByName(_str);
			} else {
				daeXML = XML(getFileByName(_str).data);
			}
			_i++;
		}
	}
	private function onImageLoadedHandle(_evt:ZipEvent):void {
		materialListByImageName[_evt.file.name] = new BitmapMaterial(_evt.content);
		materialListLength++;
		if (materialListLength >= length-1) {
			removeEventListener(ZipEvent.ZIP_CONTENT_LOADED, onImageLoadedHandle);
			setMaterialsList();
		}
	}
	private function setMaterialsList():void {
		if(daeXML==null){
			return;
		}
		default xml namespace = daeXML.namespace();
		//trace("image lenght: "+daeXML.library_images.image.length());
		//trace("material lenght: "+daeXML.library_materials.material.length());
		//trace("effects lenght: "+daeXML.library_effects.effect.length());
		var _materialId:String;
		var _imageName:String;
		var _materialList:Object = { };
		var _lth:uint = daeXML.library_materials.material.length();
		var _i:uint;
		while (_i < _lth) {
			_materialId = daeXML.library_materials.material[_i].@id;
			//trace("material id: "+_materialId);
			_imageName = daeXML.library_images.image.(@id.contains(daeXML.library_effects.effect[_i].profile_COMMON.newparam[0].surface.init_from)).init_from;
			//trace("set: "+_materialId+" width "+_imageName);
			_materialList[_materialId] = materialListByImageName[_imageName];
			_i++;
		}
		if (onComplete!=null) {
			onComplete(daeXML, _materialList);
		}
	}
}