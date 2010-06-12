package akdcl.game.tileGame
{
	import akdcl.game.tileGame.Map;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Tile
	{
		protected static var vectorWalk:Array=[[0,0],[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1],[0,NaN],[NaN,0],[1,NaN],[NaN,1],[-1,NaN],[NaN,-1],[NaN,NaN]];
		public var map:Map;
		//区块行列坐标
		public var tileX:uint = 0;
		public var tileY:uint = 0;
		//水平方向：0：←→畅通，1：→方向畅通，-1：←方向畅通，NaN：不畅通
		public var walkX:Number = 0;
		//垂直方向：0：↑↓畅通，1：↓方向畅通，-1：↑方向畅通，NaN：[-]不畅通
		public var walkY:Number = 0;
		public function Tile(_tileX:uint, _tileY:uint, _vectorValue:uint = 0) {
			walkX = vectorWalk[_vectorValue][0];
			walkY = vectorWalk[_vectorValue][1];
		}
		public function setTileXY(_tileX:uint, _tileY:uint):void {
			tileX = _tileX;
			tileY = _tileY;
		}
		public function get walkable():Boolean {
			return walkX == 0 && walkY == 0;
		}
		public function get unwalkable():Boolean {
			return walkX == NaN && walkY == NaN;
		}
	}
	
}