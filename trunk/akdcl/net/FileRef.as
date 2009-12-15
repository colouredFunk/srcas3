package net{
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.events.*;
	
	public class FileRef extends FileReference {

		public var fileTypes:String="jpg,jpeg,gif,png,bmp";
		public var fileInfos:String="图片";
		public var maxSize:int=10000;
		
		private var isSet:Boolean;
		public var onSelect:Function;
		
		public var onLoad:Function;
		public var onLoadComplete:Function;
		
		public var onUpload:Function;
		public var onUploading:Function;
		public var onUploadComplete:Function;
		
		public var onFailed:Function;

		public function FileRef() {
			init();
		}
		private function init():void{
		}
		public function remove(_evt:Event):void{
			removeEventListener(Event.SELECT,selectFile);
			removeEventListener(IOErrorEvent.IO_ERROR,error);
			removeEventListener(Event.COMPLETE,loadComplete);
			removeEventListener(ProgressEvent.PROGRESS,uploadProgress);
			removeEventListener(IOErrorEvent.IO_ERROR,error);
			removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadComplete);
			
			onSelect=null;
			
			onLoad=null;
			onLoadComplete=null;
			
			onUpload=null;
			onUploading=null;
			onUploadComplete=null;
			
			onFailed=null;
		}
		public function browseFile():void {
			try {
				addEventListener(Event.SELECT,selectFile);
				browse([new FileFilter(fileInfos,"*."+fileTypes.replace(/\,/g,";*."))]);
			} catch (e) {
				if(onFailed!=null){
					onFailed("打开"+fileInfos+"失败!");
				}
			}
		}
		private function selectFile(_evt:Event):void {
			removeEventListener(Event.SELECT,selectFile);
			if (size>maxSize*1024) {
				if(onFailed!=null){
					onFailed(fileInfos+"大小不要超过"+maxSize+"K!");
				}
				isSet=false;
				return;
			}
			isSet=true;
			if(onSelect!=null){
				onSelect();
			}
		}
		public function loadFile():Boolean{
			if(!isSet){
				if(onFailed!=null){
					onFailed("选择要打开的"+fileInfos+"!");
				}
				return false;
			}
			addEventListener(IOErrorEvent.IO_ERROR,error);
			addEventListener(Event.COMPLETE,loadComplete);
			load();
			if (onLoad!=null) {
				onLoad();
			}
			return true;
		}
		private function loadComplete(_evt:Event):void {
			removeEventListener(IOErrorEvent.IO_ERROR,error);
			removeEventListener(Event.COMPLETE,loadComplete);
			isSet=false;
			if (onLoadComplete!=null) {
				onLoadComplete(_evt.currentTarget.data);
			}
		}
		public function uploadFile(_url:String,_id:String):Boolean {
			if(!isSet){
				if(onFailed!=null){
					onFailed("选择要打开的"+fileInfos+"!");
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