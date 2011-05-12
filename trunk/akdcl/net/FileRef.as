package akdcl.net{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import zero.FileTypes;
	import zero.encoder.BMPEncoder;
	
	public class FileRef extends FileReference {
		protected var fileInfo:String;
		public var fileTypes:String;
		public var maxSize:int = 10000;
		public var autoLoad:Boolean = true;
		public var autoImage:Boolean = true;
		
		private var isSet:Boolean;
		public var onSelect:Function;
		
		public var onLoad:Function;
		public var onLoadComplete:Function;
		
		public var onUpload:Function;
		public var onUploading:Function;
		public var onUploadComplete:Function;
		public var onFailed:Function;
		public function remove():void{
			removeEventListener(Event.SELECT, selectFile);
			removeEventListener(IOErrorEvent.IO_ERROR, error);
			removeEventListener(Event.COMPLETE, loadComplete);
			removeEventListener(ProgressEvent.PROGRESS, uploadProgress);
			removeEventListener(IOErrorEvent.IO_ERROR, error);
			removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadComplete);
			
			onSelect=null;
			
			onLoad=null;
			onLoadComplete=null;
			
			onUpload=null;
			onUploading=null;
			onUploadComplete=null;
			
			onFailed=null;
		}
		public function browseFile(_fileInfo:String = "图片", _fileTypes:String = "jpg,jpeg,gif,png,bmp"):void {
			try {
				fileInfo = _fileInfo;
				fileTypes = _fileTypes;
				addEventListener(Event.SELECT, selectFile);
				browse([new FileFilter(fileInfo, "*." + fileTypes.replace(/\,/g, ";*."))]);
			} catch (e:Error) {
				if(onFailed!=null){
					onFailed("打开" + fileInfo + "失败!");
				}
			}
		}
		private function selectFile(_evt:Event):void {
			removeEventListener(Event.SELECT, selectFile);
			if (size > maxSize * 1024) {
				if (onFailed != null) {
					onFailed(fileInfo + "大小不要超过" + maxSize + "K!");
				}
				isSet = false;
				return;
			}
			isSet = true;
			if (onSelect != null) {
				onSelect();
			}
			if (autoLoad) {
				loadFile();
			}
		}
		public function saveFile(_data:*, _fileName:String):void {
			save(_data, _fileName);
		}
		public function loadFile():Boolean{
			if(!isSet){
				if(onFailed!=null){
					onFailed("选择要打开的" + fileInfo + "!");
				}
				return false;
			}
			addEventListener(IOErrorEvent.IO_ERROR, error);
			addEventListener(Event.COMPLETE, loadComplete);
			load();
			if (onLoad!=null) {
				onLoad();
			}
			return true;
		}
		private function loadComplete(_evt:Event):void {
			removeEventListener(IOErrorEvent.IO_ERROR, error);
			removeEventListener(Event.COMPLETE, loadComplete);
			isSet = false;
			var _data:*;
			_data = _evt.currentTarget.data;
			if (autoImage) {
				if (FileTypes.getType(_data, name) == FileTypes.BMP ) {
					_data = BMPEncoder.decode(_data);
					if (onLoadComplete!=null) {
						onLoadComplete(_data);
					}
				}else {
					var _loader:Loader = new Loader();
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadedComplete);
					_loader.loadBytes(_data);
					return;
				}	
				//}
			}else {
				if (onLoadComplete!=null) {
					onLoadComplete(_data);
				}
			}
		}
		private function onImageLoadedComplete(_evt:Event):void {
			_evt.currentTarget.removeEventListener(Event.COMPLETE, onImageLoadedComplete);
			if (onLoadComplete != null) {
				var _loader:Loader = _evt.currentTarget.loader;
				onLoadComplete((_loader.content as Bitmap).bitmapData);
				_loader.unload();
			}
		}
		public function uploadFile(_url:String, _id:String):Boolean {
			if(!isSet){
				if(onFailed!=null){
					onFailed("选择要打开的"+fileInfo+"!");
				}
				return false;
			}else if(!_url){
				if(onFailed!=null){
					onFailed("没有上传地址!");
				}
				return false;
			}
			addEventListener(ProgressEvent.PROGRESS,uploadProgress);
			addEventListener(IOErrorEvent.IO_ERROR,error);
			addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			upload(new URLRequest(_url),_id);
			if (onUpload!=null) {
				onUpload();
			}
			return true;
		}
		private function uploadProgress(_evt:ProgressEvent):void {
			if(onUploading!=null){
				onUploading(_evt.bytesLoaded/_evt.bytesTotal);
			}
		}
		private function uploadComplete(_evt:DataEvent):void {
			removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			removeEventListener(IOErrorEvent.IO_ERROR,error);
			removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			isSet=false;
			var _result:String=_evt.data.replace(/(^\s*)|(\s*$)/g,"");
			if (onUploadComplete!=null) {
				onUploadComplete(_result);
			}
		}
		private function error(_evt:IOErrorEvent):void {
			removeEventListener(Event.SELECT,selectFile);
			removeEventListener(IOErrorEvent.IO_ERROR,error);
			removeEventListener(Event.COMPLETE,loadComplete);
			removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			removeEventListener(IOErrorEvent.IO_ERROR,error);
			removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			if(onFailed!=null){
				onFailed("程序失败，页面未响应!");
			}
		}
	}
}