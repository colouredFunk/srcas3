package akdcl.game.tileGame
{
	import akdcl.game.tileGame.Tile;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Map
	{
		
		//private var nLeft:Number;
		//private var nRight:Number;
		//private var nTop:Number;
		//private var nBottom:Number;
		protected var tileDic:Object;
		public function Map() {
			tileDic = { };
		}
		private var __matrix:Array;
		public function get matrix():Array {
			return __matrix;
		}
		public function set matrix(_matrix:Array):void {
			if (!_matrix) {
				throw new Error("map marix set null!");
				return;
			}
			__matrix = _matrix;
			__mapHeight = __matrix.length;
			__mapWidth = __matrix[0].length;
		}
		//地图宽
		private var __mapWidth:uint;
		public function get mapWidth():uint {
			return __mapWidth;
		}
		//地图高
		private var __mapHeight:uint;
		public function get mapHeight():uint {
			return __mapHeight;
		}
		private var __tileWidth:uint;
		public function get tileWidth():uint {
			return __tileWidth;
		}
		public function set tileWidth(_tileWidth:uint):void {
			__tileWidth = _tileWidth;
			__tileHalfWidth = __tileWidth * 0.5;
		}
		private var __tileHalfWidth:Number;
		public function get tileHalfWidth():uint {
			return __tileHeight;
		}
		private var __tileHeight:uint;
		public function get tileHeight():uint {
			return __tileHeight;
		}
		public function set tileHeight(_tileHeight:uint):void {
			__tileHeight = _tileHeight;
			__tileHalfHeight = __tileHeight * 0.5;
		}
		private var __tileHalfHeight:Number;
		public function get tileHalfHeight():uint {
			return __tileHalfHeight;
		}
		public function mapping():void {
			var _x, _y:uint = 0;
			var _tile:Tile;
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					_tile = new Tile(_x, _y);
					tileDic[getTileName(x, y)] = _tile;
					_tile.map = this;
				}
			}
		}
		//返回对应横纵序区块
		public function getTile(_tileX:uint, _tileY:uint):Tile {
			return tileDic[getTileName(_tileX, _tileY)];
		}
		//返回对应横纵序区块名字
		protected static function getTileName(_tileX:uint, _tileY:uint):String {
			return "tile_" + _tileY + "_" + _tileX;
		}
		//返回坐标对应的序列；
		public function xToTileX(_x:Number):uint {
			return Math.round(_x / tileWidth);
		}
		public function yToTileY(_y:Number):uint {
			return Math.round(_y / tileHeight);
		}
	}
}