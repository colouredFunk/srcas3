package ui {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class AlignGroup extends UIEventDispatcher {
		public function get x():Number {
			if (rect) {
				return rect.x;
			}else {
				return NaN;
			}
		}
		public function set x(_x:Number):void{
			if (rect) {
				rect.x = _x;
			}
		}
		public function get y():Number{
			if (rect) {
				return rect.y;
			}else {
				return NaN;
			}
		}
		public function set y(_y:Number):void {
			if (rect) {
				rect.y = _y;
			}
		}
		public function get width():Number{
			if (rect) {
				return rect.width;
			}else {
				return NaN;
			}
		}
		public function set width(_width:Number):void{
			if (rect) {
				rect.width = _width;
			}
		}
		public function get height():Number{
			if (rect) {
				return rect.height;
			}else {
				return NaN;
			}
		}
		public function set height(_height:Number):void{
			if (rect) {
				rect.height = _height;
			}
		}
		public var rect:Rectangle;
		public var childrenDic:Dictionary;
		public function AlignGroup(_xOrRect:*, _y:Number = 0, _width:Number = 0, _height:Number = 0) {
			if (_xOrRect is Rectangle) {
				rect = _xOrRect;
			}else {
				rect = new Rectangle(_xOrRect, _y, _width, _height);
			}
			super();
		}
		override protected function init():void {
			super.init();
			childrenDic = new Dictionary();
		}
		public function addChild(_child:*, ...args):void {
			if (!_child || !rect) {
				return;
			}
			if (!childrenDic[_child]) {
				childrenDic[_child] = { };
			}
			var _obj:Object = childrenDic[_child];
			
		}
	}
	
}