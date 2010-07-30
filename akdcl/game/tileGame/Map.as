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
		protected static var vectorTemp_0:Vector2D = new Vector2D();
		protected static var vectorTemp_1:Vector2D = new Vector2D();
		protected static var vectorTemp_2:Vector2D = new Vector2D();
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
			return int(_x / tileWidth);
		}
		public function yToTileY(_y:Number):int {
			return int(_y / tileHeight);
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
					_y0 = (_tileY_t +(_dy > 0? 0: 1)) * tileHeight;
					_hitX = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
					_tileTemp = getTile(xToTileX(_hitX), _tileY_t);
					if (!_tileTemp || _dy * _tileTemp.walkY >= 0) {
						//目标区块x轴方向无法通过
						_x0 = (_tileX_t + (_dx > 0? 0: 1)) * tileWidth;
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
		public function hitTest_2(_x:Number, _y:Number, _dx:Number, _dy:Number, _auto:Boolean = true):Boolean {
			var _xt:Number = _dx + _x;
			var _yt:Number = _dy + _y;
			
			var _tileX:int = xToTileX(_x);
			var _tileY:int = yToTileY(_y);
			var _tileX_t:int = xToTileX(_xt);
			var _tileY_t:int = yToTileY(_yt);
			//var _tile:Tile;
			var _tile_t:Tile;
			if (_tileX_t < 0 || _tileY_t < 0 || _tileX_t >= mapWidth || _tileY_t >= mapHeight) {
				
			}else {
				_tile_t = getTile(_tileX_t, _tileY_t);
			}
			var _dTileX:uint = Math.abs(_tileX_t - _tileX);
			var _dTileY:uint = Math.abs(_tileY_t - _tileY);
			if (_auto) {
				var _dTileMax:uint = Math.max(_dTileX, _dTileY);
				if (_dTileMax>1) {
					//分_dTileMax段运行
					_dx /= _dTileMax, _dy /= _dTileMax;
					for (var _i:uint; _i < _dTileMax; _i++ ) {
						if (hitTest_2(_x, _y, _dx, _dy, false)) {
							return true;
						}
						_x += _dx, _y += _dy;
					}
					//目标区块可通行
					return false;
				}
			}
			var _crossX:Boolean = !_tile_t || (_dx * _tile_t.walkX >= 0);
			var _crossY:Boolean = !_tile_t || (_dy * _tile_t.walkY >= 0);
			var _x0, _y0:Number;
			var _hitX, _hitY:Number;
			var _tileTemp:Tile;
			if (_dTileX + _dTileY == 0) {
				//目标区块可通行
				return false;
			}else if (_dTileX * _dTileY == 0) {
				if (_dx == 0) {
					//水平方向无速度
					if (_crossY) {
						//目标区块可通行
						return false;
					}
					//目标区块y轴方向无法通过
					hitTestPt.x = _x, hitTestPt.y = (_tileY_t +(_dy > 0? 0: 1)) * tileHeight;
					hitTestTile = _tile_t;
					return true;
				}else if (_dy == 0) {
					//垂直方向无速度
					if (_crossX) {
						//目标区块可通行
						return false;
					}
					//目标区块x轴方向无法通过
					hitTestPt.x = (_tileX_t +(_dx > 0? 0: 1)) * tileWidth, hitTestPt.y = _y;
					hitTestTile = _tile_t;
					return true;
				}else {
					_x0 = (_tileX_t +(_dx > 0? 0: 1)) * tileWidth, _y0 = (_tileY_t +(_dy > 0? 0: 1)) * tileHeight;
					if ((_tileX_t - _tileX == 0)?_crossY:_crossX) {
						//目标区块可通行
						return false;
					}else {
						if (_tileX_t - _tileX == 0) {
							//目标区块y轴方向无法通过
							_hitX = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
							hitTestPt.x = _hitX, hitTestPt.y = _y0;
						}else {
							//目标区块x轴方向无法通过
							_hitY = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
							hitTestPt.x = _x0, hitTestPt.y = _hitY;
						}
					}
					hitTestTile = _tile_t;
					return true;
				}
			}else {
				_x0 = (_tileX_t +(_dx > 0? 0: 1)) * tileWidth;
				_y0 = (_tileY_t +(_dy > 0? 0: 1)) * tileHeight;
				var _isRight:Boolean = isXYOnRightSide(_x0, _y0, _x, _y, _xt, _yt);
				if ((_dx*_dy>0)?_isRight:!_isRight) {
					//y延长
					_hitY = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
					_tileTemp = getTile(_tileX_t, yToTileY(_hitY));
					if (!_tileTemp || _dx * _tileTemp.walkX >= 0) {
						if (_crossY) {
							//目标区块y轴方向可通行,x轴方向无需判断
							return false;
						}
						_hitX = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
						hitTestPt.x = _hitX, hitTestPt.y = _y0;
					}else {
						//目标区块x轴方向无法通过
						hitTestPt.x = _x0, hitTestPt.y = _hitY;
					}
				}else {
					//x延长
					_hitX = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
					_tileTemp = getTile(xToTileX(_hitX), _tileY_t);
					if (!_tileTemp || _dy * _tileTemp.walkY >= 0) {
						if (_crossX) {
							//目标区块x轴方向可通行,y轴方向无需判断
							return false;
						}
						_hitY = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
						hitTestPt.x = _x0, hitTestPt.y = _hitY;
					}else {
						//目标区块y轴方向无法通过
						hitTestPt.x = _hitX, hitTestPt.y = _y0;
					}
				}
				hitTestTile = _tileTemp?_tileTemp:_tile_t;
				return true;
			}
		}
		public static function isPointOnRightSide(_pt:Vector2D, _p0:Vector2D, _p1:Vector2D):Boolean {
			vectorTemp_0.copy(_pt);
			vectorTemp_1.copy(_p1);
			var _crossProduct:Number = vectorTemp_0.subtract(_p0).crossProd(vectorTemp_1.subtract(_p0));
			return _crossProduct > 0;
		}
		public static function isXYOnRightSide(_xt:Number,_yt:Number,_x0:Number,_y0:Number,_x1:Number,_y1:Number):Boolean {
			vectorTemp_0.x = _xt;
			vectorTemp_0.y = _yt;
			vectorTemp_1.x = _x0;
			vectorTemp_1.y = _y0;
			vectorTemp_2.x = _x1;
			vectorTemp_2.y = _y1;
			var _crossProduct:Number = vectorTemp_0.subtract(vectorTemp_2).crossProd(vectorTemp_1.subtract(vectorTemp_2));
			return _crossProduct > 0;
		}
	}
}