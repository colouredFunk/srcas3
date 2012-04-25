package akdcl.skeleton
{
	//import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	// extends Point
	public class Node{
		public var rotation:Number;
		public var x:Number;
		public var y:Number;
		public function Node(_x:Number = 0, _y:Number = 0, _rotation:Number = 0) {
			x = _x;
			y = _y;
			rotation = _rotation;
		}
		
		public function copy(_fV:Node):void {
			rotation = _fV.rotation;
			x = _fV.x;
			y = _fV.y;
		}
	}
	
}