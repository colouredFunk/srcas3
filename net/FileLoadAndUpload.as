package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	public class FileLoadAndUpload {

		public var fileTypes:String="jpg,jpeg,gif,png,bmp";
		public var url:String;
		public var maxSize:int=10000;
		protected var file:FileReference;

		public var onLoadComplete:Function;

		public function FileLoadAndUpload() {
			init();
		}
		protected function init():void {
			file=new FileReference();
			file.addEventListener(Event.SELECT,selectFile);
			file.addEventListener(Event.COMPLETE,loadComplete);
		}
		protected function remove():void {

			file.removeEventListener(Event.SELECT,selectFile);
			file.removeEventListener(Event.COMPLETE,loadComplete);

			file=null;

			onLoadComplete=null;
		}
		public function browse():void {
			try {
				file.browse([new FileFilter(fileTypes,"*."+fileTypes.replace(/\,/g,";*."))]);
			} catch (e) {
				trace("打开失败");
			}
		}
		protected function selectFile(event:Event):void {
			if (file.size>maxSize*1024) {
				trace("大小不要超过"+maxSize+"k!");
				return;
			}
			file.load();
		}
		protected function loadComplete(event:Event):void {
			if (onLoadComplete!=null) {
				onLoadComplete(event.currentTarget.data);
			}
		}
	}
}