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

		public var onUpload:Function;
		public var onUploadComplete:Function;
		public var onUploading:Function;
		public var onUploadFailed:Function;
		public var onLoad:Function;
		public var onLoadComplete:Function;
		public var openFailed:Function;

		public function FileUploader() {
			init();
		}
		private function init():void{
			file=new FileReference();
			file.addEventListener(Event.SELECT,selectFile);
			//file.addEventListener(Event.COMPLETE,loadComplete);
			//file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			//file.addEventListener(ProgressEvent.PROGRESS,uploadProgress);
		}
		public function remove(event:Event):void{
			file.removeEventListener(Event.SELECT,selectFile);
			file.removeEventListener(Event.COMPLETE,loadComplete);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			file.removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			file=null;
			
			onUpload=null;
			onUploadComplete=null;
			onLoad=null;
			onLoadComplete=null;
			onUploading=null;
			openFailed=null;
		}
		public function browse():void {
			try {
				file.browse([new FileFilter(fileInfos,"*."+fileTypes.replace(/\,/g,";*."))]);
			} catch (e) {
				if(openFailed!=null){
					openFailed("error!");
				}
			}
		}
		private function selectFile(event:Event):void {
			if (file.size>maxSize*1024) {
				if(openFailed!=null){
				openFailed(fileInfos+"大小不要超过"+maxSize+"k!");}
				isSet=false;
				return;
			}
			isSet=true;
			upload();
		}
		private function loadComplete(event:Event):void {
			file.removeEventListener(Event.COMPLETE,loadComplete);
			if (onLoadComplete!=null) {
				onLoadComplete(event.currentTarget.data);
			}
		}
		private function upload():void {
			if(!isSet){
				if(openFailed!=null){
					openFailed("选择要打开的"+fileInfos+"!");
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
				
			}
		}
		private function uploadProgress(event:ProgressEvent):void {
			if(onUploading!=null){
				onUploading(event.bytesLoaded/event.bytesTotal);
			}
		}
		private function uploadComplete(event:DataEvent):void {
			file.removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			file.removeEventListener(IOErrorEvent.IO_ERROR,uploadError);
			var str:String=event.data.replace(/(^\s*)|(\s*$)/g,"");
			trace("上传完毕:"+str);
			if (str=="Failed!") {
				if (onUploadFailed!=null) {
					onUploadFailed();
				}
				return;
			}
			if (onUploadComplete!=null) {
				onUploadComplete(str);
			}
		}
		private function uploadError(event:IOErrorEvent):void {
			file.removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			file.removeEventListener(IOErrorEvent.IO_ERROR,uploadError);
			if (onUploadFailed!=null) {
				onUploadFailed();
			}
		}
	}
}