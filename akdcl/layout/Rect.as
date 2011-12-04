package akdcl.layout
{
	/**
	 * ...
	 * @author ...
	 */
	public class Rect
	{
		internal var __x:Number = 0;
		internal var __y:Number = 0;
		internal var __width:Number;
		internal var __height:Number;
		
		public function get x():Number 
		{
			return __x;
		}
		
		public function set x(_value:Number):void 
		{
			__x = _value;
			updatePoint();
		}
		
		public function get y():Number 
		{
			return __y;
		}
		
		public function set y(_value:Number):void 
		{
			__y = _value;
			updatePoint();
		}
		
		public function get width():Number 
		{
			return __width;
		}
		
		public function set width(_value:Number):void 
		{
			__width = _value;
			updateSize();
		}
		
		public function get height():Number 
		{
			return __height;
		}
		
		public function set height(_value:Number):void 
		{
			__height = _value;
			updateSize();
		}
		
		public function Rect(_x:Number, _y:Number, _width:Number, _height:Number):void {
			__x = _x;
			__y = _y;
			__width = _width;
			__height = _height;
		}
		
		public function setPoint(_x:Number, _y:Number):void {
			__x = _x;
			__y = _y;
			updatePoint();
		}
		
		public function setSize(_w:Number, _h:Number):void {
			__width = _w;
			__height = _h;
			updateSize();
		}
		
		protected function updatePoint():void {
			
		}
		
		protected function updateSize():void {
			
		}
	}
	
}