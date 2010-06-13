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
				//throw new Error("map marix set null!");
				return;
			}
			__matrix = _matrix;
			if (__matrix.length>mapHeight) {
				mapHeight = __matrix.length;
			}
			var _mapWidth:uint;
			for (var _i in __matrix) {
				if (__matrix[_i]) {
					_mapWidth = Math.max(_mapWidth, __matrix[_i].length);
				}
			}
			if (_mapWidth>mapWidth) {
				mapWidth = _mapWidth;
			}
		}
		//地图宽
		private var __mapWidth:uint = 20;
		public function get mapWidth():uint {
			return __mapWidth;
		}
		public function set mapWidth(_mapWidth:uint):void {
			__mapWidth = _mapWidth;
		}
		//地图高
		private var __mapHeight:uint = 20;
		public function get mapHeight():uint {
			return __mapHeight;
		}
		public function set mapHeight(_mapHeight:uint):void {
			__mapHeight = _mapHeight;
		}
		private var __tileWidth:uint = 36;
		public function get tileWidth():uint {
			return __tileWidth;
		}
		public function set tileWidth(_tileWidth:uint):void {
			__tileWidth = _tileWidth;
			__tileHalfWidth = __tileWidth * 0.5;
		}
		private var __tileHalfWidth:Number = 18;
		public function get tileHalfWidth():uint {
			return __tileHeight;
		}
		private var __tileHeight:uint = 36;
		public function get tileHeight():uint {
			return __tileHeight;
		}
		public function set tileHeight(_tileHeight:uint):void {
			__tileHeight = _tileHeight;
			__tileHalfHeight = __tileHeight * 0.5;
		}
		private var __tileHalfHeight:Number = 18;
		public function get tileHalfHeight():uint {
			return __tileHalfHeight;
		}
		public function mapping():void {
			var _x, _y:uint = 0;
			var _tile:Tile;
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					_tile = getTile(_x, _y);
					if (matrix[_y] && (matrix[_y][_x] is Number)) {
						if (!_tile) {
							_tile = new Tile(_x, _y, matrix[_y][_x]);
							tileDic[getTileName(_x, _y)] = _tile;
							_tile.map = this;
						}else {
							_tile.walkFlag = matrix[_y][_x];
						}
					}
				}
			}
		}
		public function eachTile(_forEach:Function):void {
			if (_forEach == null) {
				return;
			}
			for each(var _tile:Tile in tileDic) {
				_forEach(_tile);
			}
		}
		//返回坐标对应的序列；
		public function xToTileX(_x:Number):int {
			return Math.round(_x / tileWidth);
		}
		public function yToTileY(_y:Number):int {
			return Math.round(_y / tileHeight);
		}
		//返回对应横纵序区块
		public function getTile(_tileX:uint, _tileY:uint):Tile {
			return tileDic[getTileName(_tileX, _tileY)];
		}
		//返回对应横纵序区块名字
		protected static function getTileName(_tileX:uint, _tileY:uint):String {
			return "tile_" + _tileY + "_" + _tileX;
		}
	}
}