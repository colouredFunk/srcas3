package akdcl.game.tileGame
{
	import akdcl.game.tileGame.Map;
	import akdcl.math.Vector2D;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Tile
	{
		public var hitTestPt:Vector2D;
		public var map:Map;
		//区块行列坐标
		public var tileX:uint = 0;
		public var tileY:uint = 0;
		public function Tile(_tileX:uint, _tileY:uint) {
			setTileXY(_tileX, _tileY);
		}
		public function setTileXY(_tileX:uint, _tileY:uint):void {
			tileX = _tileX;
			tileY = _tileY;
		}
		public function get x():uint {
			return tileX * map.mapWidth;
		}
		public function get y():uint {
			return tileY * map.tileHeight;
		}
		public function hitTest(_x:Number, _y:Number, _dx:Number, _dy:Number, _xt:Number, _yt:Number):Boolean {
			return null;
		}
		/*
		
		//水平方向：0：←→畅通，1：→方向畅通，-1：←方向畅通，NaN：不畅通
		public var walkX:Number = 0;
		//垂直方向：0：↑↓畅通，1：↓方向畅通，-1：↑方向畅通，NaN：[-]不畅通
		public var walkY:Number = 0;
		private var __walkFlag:uint;
		public function get walkFlag():uint {
			return __walkFlag;
		}
		public function set walkFlag(_walkFlag:uint):void {
			__walkFlag = _walkFlag;
			if (__walkFlag >= walkFlagValues.length) {
				__walkFlag = 0;
			}
			walkX = walkFlagValues[__walkFlag][0];
			walkY = walkFlagValues[__walkFlag][1];
		}
		public function get walkable():Boolean {
			return walkX == 0 && walkY == 0;
		}
		public function get unwalkable():Boolean {
			return isNaN(walkX) && isNaN(walkY);
		}*/
	}
}