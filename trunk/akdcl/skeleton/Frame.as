package akdcl.skeleton
{
	//import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	// extends Point
	final public class Frame{
		public var rotation:Number;
		public var x:Number;
		public var y:Number;
		
		public var scaleX:Number;
		public var scaleY:Number;
		
		public var frame:uint;
		public function Frame(_x:Number = 0, _y:Number = 0, _rotation:Number = 0, _scaleX:Number = 1, _scaleY:Number = 1) {
			setValue(_x, _y, _rotation, _scaleX, _scaleY);
		}
		public function setValue(_x:Number, _y:Number, _rotation:Number, _scaleX:Number = 1, _scaleY:Number = 1):void {
			x = _x;
			y = _y;
			rotation = _rotation;
			scaleX = _scaleX;
			scaleY = _scaleY;
		}
		
		public function betweenValue(_from:Frame, _to:Frame, _k:Number):void {
			rotation = _from.rotation + (_to.rotation - _from.rotation) * _k;
			//
			x = _from.x + (_to.x - _from.x) * _k;
			y = _from.y + (_to.y - _from.y) * _k;
			//
			scaleX = _from.scaleX + (_to.scaleX - _from.scaleX) * _k;
			scaleY = _from.scaleY + (_to.scaleY - _from.scaleY) * _k;
		}
		
		public function copy(_fV:Frame):void {
			rotation = _fV.rotation;
			//
			x = _fV.x;
			y = _fV.y;
			//
			scaleX = _fV.scaleX;
			scaleY = _fV.scaleY;
			//
			frame = _fV.frame;
		}
		
		public function toString():String {
			return "x:" + x + " y:" + y + " rotation:" + rotation;
		}
	}
	
}