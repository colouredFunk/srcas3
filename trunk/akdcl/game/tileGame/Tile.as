package akdcl.game.tileGame
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Tile
	{
		private static var vectorWalk:Array=[[0,0],[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1],[0,2],[2,0],[1,2],[2,1],[-1,2],[2,-1],[2,2]];
		//区块行列坐标
		public var tileX:uint = 0;
		public var tileY:uint = 0;
		//水平方向：0畅通，1向正方向畅通，-1向负方向畅通
		public var walkX:int = 0;
		//垂直方向：0畅通，1向正方向畅通，-1向负方向畅通
		public var walkY:int = 0;
		//public var nDepth_lv:Number = 0;
		public function Tile(_x:uint, _y:uint,_vectorValue:uint=15) {
			walkX = vectorWalk[_vectorValue][0];
			walkY = vectorWalk[_vectorValue][1];
		}
		public function setTileXY(_x:uint, _y:uint):void {
			tileX = _x;
			tileY = _y;
		}
	}
	
}