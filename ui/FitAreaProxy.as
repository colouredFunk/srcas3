package ui{
	import flash.display.Shape;
	import flash.events.Event;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class FitAreaProxy extends UISprite  {
		public var proxyTarget:*;
		protected var shape:Shape;
		public var onChange:Function;
		override protected function init():void {
			super.init();
			shape = new Shape();
			shape.graphics.beginFill(0xff00ff, 0.5);
			shape.graphics.drawRect(0, 0, 100, 100);
			addChild(shape);
		}
		override protected function onRemoveToStageHandler():void {
			removeChild(shape);
			shape = null;
			super.onRemoveToStageHandler();
			onChange = null;
			proxyTarget = null;
		}
		private var __widthOrg:Number;
		public function get widthOrg():Number{
			return __widthOrg;
		}
		public function set widthOrg(_widthOrg:Number):void{
			__widthOrg = _widthOrg;
			shape.width = __widthOrg;
		}
		private var __heightOrg:Number;
		public function get heightOrg():Number{
			return __heightOrg;
		}
		public function set heightOrg(_heightOrg:Number):void{
			__heightOrg=_heightOrg;
			shape.height = __heightOrg;
		}
		override public function set x(value:Number):void {
			super.x = value;
			onChangeHandler();
		}
		override public function set y(value:Number):void {
			super.y = value;
			onChangeHandler();
		}
		override public function set width(value:Number):void {
			super.width = value;
			onChangeHandler();
		}
		override public function set height(value:Number):void {
			super.height = value;
			onChangeHandler();
		}
		override public function set scaleX(value:Number):void {
			super.scaleX = value;
			onChangeHandler();
		}
		override public function set scaleY(value:Number):void {
			super.scaleY = value;
			onChangeHandler();
		}
		protected function onChangeHandler():void {
			if (onChange != null) {
				onChange(this);
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
}