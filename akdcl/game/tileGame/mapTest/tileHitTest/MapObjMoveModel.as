package tileHitTest
{
	import akdcl.game.tileGame.MapObjMove;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MapObjMoveModel extends Sprite 
	{
		public var mapObjMove:MapObjMove;
		public function MapObjMoveModel() {
			
		}
		public function update():void {
			if (!mapObjMove) {
				return;
			}
			x = mapObjMove.x;
			y = mapObjMove.y;
		}
	}
	
}