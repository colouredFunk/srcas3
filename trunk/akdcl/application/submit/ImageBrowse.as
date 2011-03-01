package akdcl.application.submit{
	import fl.controls.Label;
	import flash.display.Sprite;
	import ui.ImageLoader;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ImageBrowse extends ImageLoader{
		public var label:Label;
		public var focusRectClip:Sprite
		//override public function get width():Number { return areaWidth; }
		
		override public function set width(value:Number):void {
			//super.width = value;
			areaWidth = value;
			label.x = int((areaWidth - label.width) * 0.5);
			focusRectClip.width = areaWidth;
			if (background) {
				background.width = areaWidth;
			}
		}
		//override public function get height():Number { return areaHeight; }
		
		override public function set height(value:Number):void {
			//super.height = value;
			areaHeight = value;
			label.y = int((areaHeight - label.height) * 0.5);
			focusRectClip.height = areaHeight;
			if (background) {
				background.height = areaHeight;
			}
		}
		
		override protected function init():void {
			super.init();
			label.mouseChildren = false;
			label.mouseEnabled = false;
			label.text = "浏 览";
			focusRectClip.visible = false;
			rollOver = onRollOver;
			rollOut = onRollOut;
			tabEnabled = false;
		}
		
		private function onRollOver():void {
			focusRectClip.visible = true;
		}
		
		private function onRollOut():void{
			focusRectClip.visible = false;
		}
	}
	
}