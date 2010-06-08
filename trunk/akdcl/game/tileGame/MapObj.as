package akdcl.game.tileGame
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MapObj
	{
		
		public var tileX:uint = 0;
		public var tileY:uint = 0;
		public var x:uint;
		public var y:uint;
		public function MapObj() {
			
		}	
		public function setXY(_x:uint, _y:uint):Void {
			x = __x, y = __y;
			//tileX = Map.vpToLine(x);
			//tileY = Map.vpToLine(y);
		}
	}
	
}