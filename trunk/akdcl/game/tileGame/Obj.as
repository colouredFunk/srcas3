package akdcl.game.tileGame
{
	import akdcl.game.tileGame.Map;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Obj
	{
		public var userData:Object;
		protected var tempData:Object;
		public var map:Map;
		public var x:Number = 0;
		public var y:Number = 0;
		public var tileX:uint = 0;
		public var tileY:uint = 0;
		//物体虚拟高
		private var __width:uint = 40;
		protected var halfWidth:Number = 20;
		public function get width():uint{
			return __width;
		}
		public function set width(_width:uint):void{
			__width = _width;
			halfWidth = __width * 0.5;
		}
		//物体虚拟宽
		private var __height:uint = 40;
		protected var halfHeight:Number = 20;
		public function get height():uint{
			return __height;
		}
		public function set height(_height:uint):void{
			__height=_height;
			halfHeight = __height * 0.5;
		}
		public function Obj() {
			tempData = { };
		}	
		public function setXY(_x:Number, _y:Number):void {
			x = _x, y = _y;
			//tileX = Map.vpToLine(x);
			//tileY = Map.vpToLine(y);
		}
	}
	
}