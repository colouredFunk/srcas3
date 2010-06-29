package akdcl.game.tileGame
{
	import akdcl.game.tileGame.Tile;
	import akdcl.math.Vector2D;
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
			hitTestPt = new Vector2D();
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
			return __tileHalfWidth;
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
		public function hitTest_0(_x:Number, _y:Number):Boolean {
			var _tileX:uint = xToTileX(_x);
			var _tileY:uint = yToTileY(_y);
			if (_tileX >= mapWidth || _tileY >= mapHeight) {
				//超过区域不可通行
				return true;
			}else {
				var _tile:Tile = getTile(_tileX, _tileY);
				if (_tile?_tile.unwalkable:false) {
					//不可通行
					hitTestTile = _tile;
					return true;
				}
				//可通行区块
				return false;
			}
		}
		public var hitTestPt:Vector2D;
		public var hitTestTile:Tile;
		public function hitTest_1(_x:Number, _y:Number,_dx:Number,_dy:Number):Boolean {
			var _xt:Number = _dx + _x;
			var _yt:Number = _dy + _y;
			
			var _tileX_t:uint = xToTileX(_xt);
			var _tileY_t:uint = yToTileY(_yt);
			
			var _tile_t:Tile = getTile(_tileX_t, _tileY_t);
			
			var _tileTemp:Tile;
			
			if (_tile_t) {
				var _x0, _y0:Number;
				var _hitX, _hitY:Number;
				if (_tile_t.unwalkable) {
					_y0 = (_tileY_t +(_dy > 0? -0.5: 0.5)) * tileHeight;
					_hitX = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
					_tileTemp = getTile(xToTileX(_hitX), _tileY_t);
					if (!_tileTemp || _dy * _tileTemp.walkY >= 0) {
						//目标区块x轴方向无法通过
						_x0 = (_tileX_t + (_dx > 0? -0.5: 0.5)) * tileWidth;
						_hitY = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
						hitTestPt.x = _x0;
						hitTestPt.y = _hitY;
					}else {
						//目标区块y轴方向无法通过
						hitTestPt.x = _hitX;
						hitTestPt.y = _y0;
					}
					hitTestTile = _tileTemp?_tileTemp:_tile_t;
					return true;
				}else {
					//目标区块可通行
					return false;
				}
			}
			//目标区块可通行
			return false;
		}
		public function hitTest_2(_x:Number, _y:Number,_dx:Number,_dy:Number):Boolean {
			var _xt:Number = _dx + _x;
			var _yt:Number = _dy + _y;
			
			var _tileX_t:uint = xToTileX(_xt);
			var _tileY_t:uint = yToTileY(_yt);
			
			var _tile_t:Tile = getTile(_tileX_t, _tileY_t);
			if (_tile_t) {
				var _crossX:Boolean = (_dx * _tile_t.walkX >= 0);
				var _crossY:Boolean = (_dy * _tile_t.walkY >= 0);
				if (_dx == 0) {
					if (_crossY||(_tileY_t == yToTileY(_y))) {
						//目标区块可通行
						return false;
					}
					//目标区块y轴方向无法通过
					//hitTestPt.x=_x;
					hitTestPt.y = (_tileY_t +(_dy > 0? -0.5: 0.5)) * tileHeight;
					hitTestTile = _tile_t;
					return true;
				}else if (_dy == 0) {
					if (_crossX||(_tileX_t == xToTileX(_x))) {
						//目标区块可通行
						return false;
					}
					//目标区块x轴方向无法通过
					//hitTestPt.y=_y;
					hitTestPt.x = (_tileX_t +(_dx > 0? -0.5: 0.5)) * tileWidth;
					hitTestTile = _tile_t;
					return true;
				}else {
					var _x0, _y0:Number;
					var _hitX, _hitY:Number;
					var _tileTemp:Tile;
					if (_crossX && _crossY) {
						//目标区块可通行
						return false;
					}else if (!_crossX && !_crossY) {
						_y0 = (_tileY_t +(_dy > 0? -0.5: 0.5)) * tileHeight;
						_hitX = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
						_tileTemp = getTile(xToTileX(_hitX), _tileY_t);
						if (!_tileTemp || _dy * _tileTemp.walkY >= 0) {
							//目标区块x轴方向无法通过
							_x0 = (_tileX_t + (_dx > 0? -0.5: 0.5)) * tileWidth;
							_hitY = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
							hitTestPt.x = _x0;
							hitTestPt.y = _hitY;
						}else {
							//目标区块y轴方向无法通过
							hitTestPt.x = _hitX;
							hitTestPt.y = _y0;
						}
						hitTestTile = _tileTemp?_tileTemp:_tile_t;
						return true;
					}else if(_crossX) {
						_y0 = (_tileY_t +(_dy > 0? -0.5: 0.5)) * tileHeight;
						_hitX = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
						_tileTemp = getTile(xToTileX(_hitX), _tileY_t);
						if (!_tileTemp || _dy * _tileTemp.walkY >= 0) {
							//目标区块可通行
							return false;
						}
						//目标区块y轴方向无法通过
						hitTestPt.x = _hitX;
						hitTestPt.y = _y0;
						hitTestTile = _tileTemp?_tileTemp:_tile_t;
						return true;
					}else {
						_x0 = (_tileX_t + (_dx > 0? -0.5: 0.5)) * tileWidth;
						_hitY = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
						_tileTemp = getTile(_tileX_t, yToTileY(_hitY));
						if (!_tileTemp || _dx * _tileTemp.walkX >= 0) {
							//目标区块可通行
							return false;
						}
						//目标区块x轴方向无法通过
						hitTestPt.x = _x0;
						hitTestPt.y = _hitY;
						hitTestTile = _tileTemp?_tileTemp:_tile_t;
						return true;
					}
				}
			}
			//目标区块可通行
			return false;
		}
	}
}