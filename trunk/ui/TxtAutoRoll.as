package ui{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  TxtAutoRoll extends UISprite{
		public var txt:TextField;
		public var rollSpeed:Number = 1;
		protected var textWidth:uint;
		override protected function init():void {
			super.init();
			textWidth = txt.width;
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			txt = null;
		}
		private var __text:String;
		public function get text():String {
			return __text;
		}
		public function set text(_text:String):void {
			if (__text != _text) {
				__text = _text;
				txt.text = __text;
				txt.autoSize = TextFieldAutoSize.LEFT;
				scrollRect = new Rectangle(0, 0, textWidth, txt.height);
				if (__text && txt.width > textWidth) {
					txt.x = textWidth;
					addEventListener(Event.ENTER_FRAME, onRollingHandler);
				}else {
					txt.x = int((textWidth - txt.width) * 0.5);
					removeEventListener(Event.ENTER_FRAME, onRollingHandler);
				}
			}
		}
		protected function onRollingHandler(_evt:Event):void {
			txt.x -= rollSpeed;
			if (txt.x + txt.width < 0) {
				txt.x = textWidth;
			}
		}
	}
	
}