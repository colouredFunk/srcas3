package akdcl.application.submit{
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	
	import akdcl.net.FileRef;
	
	import ui.ImageLoader;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ImageBrowse extends ImageLoader{
		public var label:*;
		public var focusRectClip:Sprite
		//override public function get width():Number { return areaWidth; }
		
		override public function set width(value:Number):void {
			//super.width = value;
			areaWidth = value - container.x * 2;
			focusRectClip.width = value;
			if (background) {
				background.width = value;
			}
			label.x = int((value - label.width) * 0.5);
		}
		//override public function get height():Number { return areaHeight; }
		
		override public function set height(value:Number):void {
			//super.height = value;
			areaHeight = value - container.y * 2;
			focusRectClip.height = value;
			if (background) {
				background.height = value;
			}
			label.y = int((value - label.height) * 0.5) + 2;
		}
		
		private var __data:Object;
		public function get data():Object {
			if (__data) {
				return __data;
			}else if (bitmapData) {
				return bitmapData;
			}else {
				return null;
			}
		}
		public function set data(_data:Object):void{
			__data = _data;
		}

		private var fileREF:FileRef;
		override protected function init():void {
			super.init();
			
			fileREF = new FileRef();
			
			label.mouseChildren = false;
			label.mouseEnabled = false;
			label.text = "浏览";
			focusRectClip.visible = false;
			
			rollOver = onRollOver;
			rollOut = onRollOut;
			release = browseImage;
			tabEnabled = false;
			tabChildren = false;
			focusRect = false;
		}
		override public function $release():void {
			super.$release();
			dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN, false));
		}
		
		private function onRollOver():void {
			focusRectClip.visible = true;
		}
		
		private function onRollOut():void{
			focusRectClip.visible = false;
			dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
		}
		
		private function browseImage():void{
			fileREF.browseFile();
			fileREF.onLoadComplete = onBrowseComplete;
		}
		private function onBrowseComplete(_bmd:*):void {
			load(_bmd);
			label.visible = false;
		}
	}
	
}