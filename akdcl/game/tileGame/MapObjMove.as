package akdcl.game.tileGame
{
	import akdcl.math.Vector2D;
	import akdcl.game.tileGame.Tile;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MapObjMove extends MapObj
	{
		public var userData:Object;
		protected var tempData:Object;
		//移动速度标量
		protected var speedMove:Number = 5;
		//移动速度矢量
		protected var vectorSpeed:Vector2D;
		//存放围绕物体四周的点的横纵偏移量
		protected var pointListTop:Vector.<Array>;
		protected var pointListBottom:Vector.<Array>;
		protected var pointListLeft:Vector.<Array>;
		protected var pointListRight:Vector.<Array>;
		public var rectOffX:int=0;
		public var rectOffY:int=0;
		//物体虚拟高
		public var width:uint=50;
		//物体虚拟宽
		public var height:uint=50;
		private var halfWidth:Number;
		private var halfHeight:Number;
		public function MapObjMove() {
			tempData = { };
		}
		public function hitTestPt(_x:Number, _y:Number):Boolean {
			var _tileX:uint = map.xToTileX(_x);
			var _tileY:uint = map.yToTileY(_y);
			var _tile:Tile = map.getTile(_tileX, _tileY);
			if (_tile && _tile.unwalkable) {
				return true;
			}
			return false;
		}
		public function hitTestPtVector(_x:Number, _y:Number,_dx:Number,_dy:Number):void {
			var _tileX_0:uint = map.xToTileX(_x);
			var _tileY_0:uint = map.yToTileY(_y);
			
			var _tileX_t:uint = map.xToTileX(_x + _dx);
			var _tileY_t:uint = map.yToTileY(_y + _dy);
			var _tile_t:Tile = map.getTile(_tileX_t, _tileY_t);
			if (_tile_t) {
				var _checkX:Boolean = (_dx * _tile_t.walkX >= 0);
				var _checkY:Boolean = (_dy * _tile_t.walkY >= 0);
				if (_checkX && _checkY) {
					//目标区块可通行
				}else if (!_checkX && !_checkY) {
					//目标区块无法通行
					//找到精确的碰撞点
				}else if(_checkX) {
					//y轴方向有可能无法通过
				}else {
					//x轴方向有可能无法通过
				}
			}
			//return false;
		}
		//设置周围的点
		private function setCorners():Void {
			pointListTop = new Vector();
			pointListBottom = new Vector();
			pointListLeft = new Vector();
			pointListRight = new Vector();
			var _xn:uint = Math.ceil(width / map.tileWidth);
			var _yn:uint = Math.ceil(height / map.tileHeight);
			var _in:uint;
			var _pt:Number;
			for (_in = 0; _in < _xn + 1; _in++) {
				_pt = width * (_in / _xn - 0.5);
				pointListTop.push([_pt, -(halfHeight + rectOffY)]);
				pointListBottom.push([_pt, halfHeight - rectOffY]);
			}
			for (_in = 0; _in < _yn + 1; _in++) {
				_pt = height * (_in / _yn - 0.5);
				pointListLeft.push([ -(halfWidth + rectOffX), _pt]);
				pointListRight.push([halfWidth - rectOffX, _pt]);
			}
			//aPoint_x[aPoint_x.length-1]--;
			//aPoint_y[aPoint_y.length-1]--;
		}
		//检测水平方向的通行状况
		private function hitTestX(_x:Number, _dir:int):int {
			var _hitCounts:uint = 0;
			var _pointList:Vector = (_dir > 0)?pointListRight:pointListLeft;
			var _tile:Tile;
			var _i:String;
			var _tileX, _tileY:uint;
			var _px, _py:Number;
			
			for (_i in _pointList) {
				_px = _x + _pointList[_i][0];
				_py = y + _pointList[_i][1];
				_tileX = map.xToTileX(_px);
				_tileY = map.yToTileY(_py);
				_tile = map.getTile(_tileX, _tileY);
				if (_tile.walkX == 2 || _dir == -_tile.walkX) {
					_hitCounts++;
				}
			}
			if (_hitCounts == _pointList.length) {
				return 2;
			}else {
				return 0;
			}
		}
		//检测垂直方向的通行状况
		private function hitTestY(_y:Number, _dir:int):int {
			var _hitCounts:uint = 0;
			var _pointList:Vector = (_dir > 0)?pointListTop:pointListBottom;
			var _tile:Tile;
			var _i:String;
			var _tileX, _tileY:uint;
			var _px, _py:Number;
			
			for (_i in _pointList) {
				_px = x + _pointList[_i][0];
				_py = _y + _pointList[_i][1];
				_tileX = map.xToTileX(_px);
				_tileY = map.yToTileY(_py);
				_tile = map.getTile(_tileX, _tileY);
				if (_tile.walkY == 2 || _dir == -_tile.walkY) {
					_hitCounts++;
				}
			}
			if (_hitCounts == _pointList.length) {
				return 2;
			}else {
				return 0;
			}
		}
		private function closeToLR(_tileX:uint, _dir:int):Number {
			var _x:Number;
			if (_dir>0) {
				_x = map.tileWidth * _tileX + map.tileHalfWidth - (halfWidth - rectOffX);
			}else {
				_x = map.tileWidth * _tileX - map.tileHalfWidth + (halfWidth + rectOffX);
			}
			return _x;
		}
		private function closeToTB(_tileY:uint, _dir:int):Number {
			var _y:Number;
			if (_dir>0) {
				_y = map.tileHeight * _tileY + map.tileHalfHeight - (halfHeight - rectOffY);
			}else {
				_y = map.tileHeight * _tileY - map.tileHalfHeight + (halfHeight + rectOffY);
			}
			return _y;
		}
		//普通移动方式
		public function runStep():Void {
			var _x:Number = x;
			var _y:Number = y;
			var _isHitX:Boolean;
			var _isHitY:Boolean;
			if (vectorSpeed.x != 0) {
				_isHitX = hitTestX() != 0;
				if (_isHitX) {
					//_x = closeToLR(obTemp.dx-obTemp.dsp_x, vectorSpeed.x > 0?1: -1);
					//onHit(0,obSpeed.x);
				} else {
					_x += vectorSpeed.x;
				}
			}
			if (vectorSpeed.y != 0) {
				_isHitY = hitTestY() != 0;
				if (_isHitY) {
					//_y = closeToY(obTemp.dy-obTemp.dsp_y, obTemp.dsp_y);
					//onHit(1,obSpeed.y);
				} else {
					_y += vectorSpeed.y;
				}
			}
			if (_isHitX && _isHitY) {
				/*var _offx:Number = aPoint_x[obSpeed.x>0 ? aPoint_x.length-1 : 0];
				var _offy:Number = aPoint_y[obSpeed.y>0 ? aPoint_y.length-1 : 0];
				var _tile = Map.mapNow.getTile(Map.vpToLine(_ix+_offx), Map.vpToLine(_iy+_offy));
				if (isNaN(_tile.nWalk_x) || isNaN(_tile.nWalk_y)) {
					if (nTile_xPrev == nTile_x) {
						_ix = x;
					} else if (nTile_yPrev == nTile_y) {
						_iy = y;
					} else {
						random(2)>0 ? _ix=x : _iy=y;
					}
				}*/
			}
			if (x != _x || y != _y) {
				setXY(_ix,_iy);
			}
		}
	}
}