package akdcl.game.tileGame
{
	import akdcl.game.tileGame.Map;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Tile
	{
		protected static var vectorWalk:Array=[[0,0],[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1],[0,2],[2,0],[1,2],[2,1],[-1,2],[2,-1],[2,2]];
		public var map:Map;
		//区块行列坐标
		public var tileX:uint = 0;
		public var tileY:uint = 0;
		//水平方向：0畅通，1向正方向畅通，-1向负方向畅通，2不畅通
		public var walkX:int = 0;
		//垂直方向：0畅通，1向正方向畅通，-1向负方向畅通，2不畅通
		public var walkY:int = 0;
		//public var nDepth_lv:Number = 0;
		public function Tile(_tileX:uint, _tileY:uint, _vectorValue:uint = 0) {
			walkX = vectorWalk[_vectorValue][0];
			walkY = vectorWalk[_vectorValue][1];
		}
		public function setTileXY(_tileX:uint, _tileY:uint):void {
			tileX = _tileX;
			tileY = _tileY;
		}
	}
	
}