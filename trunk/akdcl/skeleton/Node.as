package akdcl.skeleton
{
	//import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	// extends Point
	final public class Node{
		public var rotation:Number;
		public var x:Number;
		public var y:Number;
		
		public var scaleX:Number;
		public var scaleY:Number;
		public var alpha:Number;
		
		public var totalFrames:uint;
		public function Node(_x:Number = 0, _y:Number = 0, _rotation:Number = 0) {
			scaleX = 1;
			scaleY = 1;
			alpha = NaN;
			totalFrames = 1;
			setValue(_x, _y, _rotation);
		}
		public function setValue(_x:Number, _y:Number, _rotation:Number):void {
			x = _x;
			y = _y;
			rotation = _rotation;
		}
		
		public function betweenValue(_from:Node, _to:Node, _k:Number):void {
			rotation = _from.rotation + (_to.rotation - _from.rotation) * _k;
			//
			x = _from.x + (_to.x - _from.x) * _k;
			y = _from.y + (_to.y - _from.y) * _k;
			//
			scaleX = _from.scaleX + (_to.scaleX - _from.scaleX) * _k;
			scaleY = _from.scaleY + (_to.scaleY - _from.scaleY) * _k;
			//
			var _aF:Boolean = isNaN(_from.alpha);
			var _aT:Boolean = isNaN(_to.alpha);
			if (_aF && _aT) {
				alpha = NaN;
			}else if (_aF) {
				alpha = 1 + (_to.alpha - 1) * _k;
			}else if (_aT) {
				alpha = _from.alpha * (1 - _k) + _k;
			}else {
				alpha = _from.alpha + (_to.alpha - _from.alpha) * _k;
			}
		}
		
		public function copy(_fV:Node):void {
			rotation = _fV.rotation;
			//
			x = _fV.x;
			y = _fV.y;
			//
			scaleX = _fV.scaleX;
			scaleY = _fV.scaleY;
			alpha = _fV.alpha;
			//
			totalFrames = _fV.totalFrames;
		}
		
		public function toString():String {
			return "x:" + x + " y:" + y + " rotation:" + rotation;
		}
	}
	
}