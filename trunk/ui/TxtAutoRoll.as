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
		private var __textWidth:Number;
		public function get textWidth():Number{
			return __textWidth;
		}
		public function set textWidth(_textWidth:Number):void{
			__textWidth = _textWidth;
			fixScrollRect();
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
				if (__text && txt.width > textWidth) {
					txt.x = textWidth;
					fixScrollRect();
					addEventListener(Event.ENTER_FRAME, onRollingHandler);
				}else {
					txt.x = int((textWidth - txt.width) * 0.5);
					removeEventListener(Event.ENTER_FRAME, onRollingHandler);
				}
			}
		}
		override protected function init():void {
			super.init();
			if (txt) {
				textWidth = txt.width;
			}else {
				txt = new TextField();
				addChild(txt);
				textWidth = 100;
			}
			txt.multiline = false;
			txt.wordWrap = false;
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			txt = null;
		}
		protected function fixScrollRect():void {
			if (scrollRect) {
				scrollRect.width = textWidth;
				scrollRect.height = txt.height;
			}else {
				scrollRect = new Rectangle(0, 0, __textWidth, txt.height);
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