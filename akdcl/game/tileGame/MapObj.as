package akdcl.game.tileGame
{
	import akdcl.game.tileGame.Map;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MapObj
	{
		public var map:Map;
		public var x:uint = 0;
		public var y:uint = 0;
		public var tileX:uint = 0;
		public var tileY:uint = 0;
		public function MapObj() {
			
		}	
		public function setXY(_x:uint, _y:uint):Void {
			x = _x, y = _y;
			//tileX = Map.vpToLine(x);
			//tileY = Map.vpToLine(y);
		}
	}
	
}