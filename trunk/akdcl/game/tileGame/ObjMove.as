package akdcl.game.tileGame
{
	import akdcl.math.Vector2D;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ObjMove extends Obj
	{
		//移动速度标量
		//protected var speedMove:Number = 5;
		//移动速度矢量
		public var vectorSpeed:Vector2D;
		//存放围绕物体四周的点的横纵偏移量
		protected var pointListTop:Vector.<Array>;
		protected var pointListBottom:Vector.<Array>;
		protected var pointListLeft:Vector.<Array>;
		protected var pointListRight:Vector.<Array>;
		public var rectOffX:int=0;
		public var rectOffY:int=0;
		public var onHitTile:Function;
		public function ObjMove() {
			vectorSpeed = new Vector2D();
		}
		//设置周围的点
		protected var kY:Number = 0.1;
		public function setCorners():void {
			pointListTop = new Vector.<Array>();
			pointListBottom = new Vector.<Array>();
			pointListLeft = new Vector.<Array>();
			pointListRight = new Vector.<Array>();
			var _xn:uint = Math.ceil(width / map.tileWidth);
			var _yn:uint = Math.ceil(height / map.tileHeight);
			var _in:uint;
			var _pt:Number;
			for (_in = 0; _in < _xn + 1; _in++) {
				_pt = width * (_in / _xn - 0.5);
				if (_in==_xn) {
					_pt-=kY;
				}
				pointListTop.push([_pt - rectOffX, -(halfHeight + rectOffY)]);
				pointListBottom.push([_pt - rectOffX, halfHeight - rectOffY - kY]);
			}
			for (_in = 0; _in < _yn + 1; _in++) {
				_pt = height * (_in / _yn - 0.5);
				if (_in==_yn) {
					_pt-=kY;
				}
				pointListLeft.push([ -(halfWidth + rectOffX), _pt - rectOffY]);
				pointListRight.push([halfWidth - rectOffX - kY, _pt - rectOffY]);
			}
			trace(pointListTop);
			trace(pointListBottom);
			trace(pointListLeft);
			trace(pointListRight);
		}
		//检测水平方向的通行状况
		public function hitTestX(_vx:Number):int {
			var _hitCounts:uint = 0;
			var _pointList:Vector.<Array> = (_vx > 0)?pointListRight:pointListLeft;
			var _i:String;
			var _x:Number;
			for (_i in _pointList) {
				_x = x + _pointList[_i][0];
				if (map.hitTest_2(_x, y + _pointList[_i][1], _vx, 0)) {
					_hitCounts++;
				}
			}
			if (_hitCounts==0) {
				return 0;
			}else if (_hitCounts == _pointList.length) {
				return 2;
			}else {
				return 1;
			}
		}
		//检测垂直方向的通行状况
		public function hitTestY(_vy:Number):int {
			var _hitCounts:uint = 0;
			var _pointList:Vector.<Array> = (_vy > 0)?pointListBottom:pointListTop;
			var _i:String;
			var _y:Number;
			for (_i in _pointList) {
				_y = y + _pointList[_i][1];
				if (map.hitTest_2(x + _pointList[_i][0], _y, 0, _vy)) {
					_hitCounts++;
				}
			}
			if (_hitCounts==0) {
				return 0;
			}else if (_hitCounts == _pointList.length) {
				return 2;
			}else {
				return 1;
			}
		}
		//普通移动方式
		public function runStep():void {
			var _x:Number = x;
			var _y:Number = y;
			var _isHitX:Boolean;
			var _isHitY:Boolean;
			if (vectorSpeed.x != 0) {
				_isHitX = hitTestX(vectorSpeed.x) != 0;
				if (_isHitX) {
					_x = map.hitTestPt.x + rectOffX +(vectorSpeed.x > 0? 0:width);
					if (onHitTile!=null) {
						onHitTile(true);
					}
				} else {
					_x += vectorSpeed.x;
				}
			}
			if (vectorSpeed.y != 0) {
				_isHitY = hitTestY(vectorSpeed.y) != 0;
				if (_isHitY) {
					_y = map.hitTestPt.y + rectOffY +(vectorSpeed.y > 0? 0:height);
					if (onHitTile!=null) {
						onHitTile(false);
					}
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
				setXY(_x,_y);
			}
		}
	}
}