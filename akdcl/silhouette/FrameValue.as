package akdcl.silhouette
{
	//import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	// extends Point
	final public class FrameValue{
		public var x:Number;
		public var y:Number;
		public var rotation:Number;
		//public var scaleX:Number;, _scaleX:Number = 1, _scaleY:Number = 1,_scaleX,_scaleY
		//public var scaleY:Number;, _scaleX:Number = 1, _scaleY:Number = 1
		public var frame:uint;
		public function FrameValue(_x:Number = 0, _y:Number = 0, _rotation:Number = 0) {
			setValue(_x, _y, _rotation);
		}
		public function setValue(_x:Number, _y:Number, _rotation:Number):void {
			x = _x;
			y = _y;
			rotation = _rotation;
			//scaleX = _scaleX;
			//scaleY = _scaleY;
		}
		
		public function betweenValue(_from:FrameValue, _to:FrameValue, _k:Number):void {
			x = _from.x + (_to.x - _from.x) * _k;
			y = _from.y + (_to.y - _from.y) * _k;
			rotation = _from.rotation + (_to.rotation - _from.rotation) * _k;
			//scaleX = _from.scaleX + (_to.scaleX - _from.scaleX) * _k;
			//scaleY = _from.scaleY + (_to.scaleY - _from.scaleY) * _k;
		}
		
		public function copy(_fV:FrameValue):void {
			x = _fV.x;
			y = _fV.y;
			rotation = _fV.rotation;
			//scaleX = _fV.scaleX;
			//scaleY = _fV.scaleY;
			frame = _fV.frame;
		}
		
		public function toString():String {
			return "x:" + x + " y:" + y + " rotation:" + rotation;
		}
	}
	
}