package net{
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	import flash.system.*;
	
	public class FileUploader {

		public var fileTypes:String="jpg,jpeg,gif,png,bmp";
		public var fileInfos:String="图片";
		public var fileName:String;
		public var url:String;

		private var file:FileReference;
		private var isSet:Boolean;
		public var maxSize:int=10000;
		public var version:uint=9;
		public var onUpload:Function;
		public var onUploading:Function;
		public var onUploadFailed:Function;
		public var onUploadComplete:Function;
		public var onLoad:Function;
		public var onLoadComplete:Function;
		public var onFailed:Function;

		public function FileUploader() {
			init();
		}
		private function init():void{
			file=new FileReference();
		}
		public function remove(_evt:Event):void{
			file.removeEventListener(Event.SELECT,selectFile);
			file.removeEventListener(Event.COMPLETE,loadComplete);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			file.removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			file=null;
			
			onUpload=null;
			onUploading=null;
			onUploadFailed=null;
			onUploadComplete=null;
			onLoad=null;
			onLoadComplete=null;
			onFailed=null;
		}
		public function browse():void {
			try {
				file.addEventListener(Event.SELECT,selectFile);
				file.browse([new FileFilter(fileInfos,"*."+fileTypes.replace(/\,/g,";*."))]);
			} catch (e) {
				if(onFailed!=null){
					onFailed("打开"+fileInfos+"失败!");
				}
			}
		}
		private function selectFile(_evt:Event):void {
			file.removeEventListener(Event.SELECT,selectFile);
			if (file.size>maxSize*1024) {
				if(onFailed!=null){
					onFailed(fileInfos+"大小不要超过"+maxSize+"K!");
				}
				isSet=false;
				return;
			}
			isSet=true;
			if(version<10){
				upload();
			}else{
				load();
			}
		}
		private function load():void{
			if(!isSet){
				if(onFailed!=null){
					onFailed("选择要打开的"+fileInfos+"!");
				}
				return;
			}
			file.addEventListener(Event.COMPLETE,loadComplete);
			file.addEventListener(IOErrorEvent.IO_ERROR,uploadError);
			file.load();
			if (onLoad!=null) {
				onLoad();
			}
		}
		private function loadComplete(_evt:Event):void {
			file.removeEventListener(Event.COMPLETE,loadComplete);
			if (onLoadComplete!=null) {
				onLoadComplete(_evt.currentTarget.data);
			}
		}
		private function upload():void {
			if(!isSet){
				if(onFailed!=null){
					onFailed("选择要打开的"+fileInfos+"!");
				}
				return;
			}
			if (url) {
				file.addEventListener(ProgressEvent.PROGRESS,uploadProgress);
				file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
				file.addEventListener(IOErrorEvent.IO_ERROR,uploadError);
				file.upload(new URLRequest(url),fileName);
				if (onUpload!=null) {
					onUpload();
				}
			} else {
				if(onFailed!=null){
					onFailed("没有上传地址!");
				}
			}
		}
		private function uploadProgress(_evt:ProgressEvent):void {
			if(onUploading!=null){
				onUploading(_evt.bytesLoaded/_evt.bytesTotal);
			}
		}
		private function uploadComplete(_evt:DataEvent):void {
			file.removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			file.removeEventListener(IOErrorEvent.IO_ERROR,uploadError);
			var str:String=_evt.data.replace(/(^\s*)|(\s*$)/g,"");
			trace("上传完毕:"+str);
			if (str=="Failed!") {
				if (onUploadFailed!=null) {
					onUploadFailed("上传失败，页面程序异常!");
				}
				if(onFailed!=null){
					onFailed("上传失败，页面程序异常!");
				}
				return;
			}else if(str=="Refused!"){
				if (onUploadFailed!=null) {
					onUploadFailed("拒绝上传!");
				}
				if(onFailed!=null){
					onFailed("拒绝上传!");
				}
				return;
			}
			if (onUploadComplete!=null) {
				onUploadComplete(str);
			}
		}
		private function uploadError(_evt:IOErrorEvent):void {
			file.removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			file.removeEventListener(IOErrorEvent.IO_ERROR,uploadError);
			if (onUploadFailed!=null) {
				onUploadFailed("上传失败，页面未响应!");
			}
			if(onFailed!=null){
				onFailed("上传失败，页面未响应!");
			}
		}
	}
}