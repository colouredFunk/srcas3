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
		protected var aroundPointDic:Object;
		protected var pointListT:Vector.<Vector2D>;
		protected var pointListB:Vector.<Vector2D>;
		protected var pointListL:Vector.<Vector2D>;
		protected var pointListR:Vector.<Vector2D>;
		public var rectOffX:int=0;
		public var rectOffY:int=0;
		public var onHitTile:Function;
		public function ObjMove() {
			vectorSpeed = new Vector2D();
			
		}
		//设置周围的点
		protected var kD:Number = 0.1;
		public function setCorners():void {
			aroundPointDic = { };
			pointListT = new Vector.<Vector2D>();
			pointListB = new Vector.<Vector2D>();
			pointListL = new Vector.<Vector2D>();
			pointListR = new Vector.<Vector2D>();
			var _xn:uint = Math.ceil(width / map.tileWidth);
			var _yn:uint = Math.ceil(height / map.tileHeight);
			var _in:uint;
			var _pt:Number;
			var _vector2D:Vector2D;
			var _dirX:int;
			var _dirY:int;
			for (_in = 0; _in <= _xn; _in++) {
				_pt = width * (_in / _xn - 0.5);
				if (_in == _xn) {
					_pt -= kD;
				}
				if (_in == 0) {
					_dirX = -1;
				} else if (_in == _xn) {
					_dirX = 1;
				} else {
					_dirX = 0;
				}
				_dirY = -1;
				setAroundPoint(_dirX, _dirY, _pt + rectOffX, rectOffY - halfHeight);
				_dirY = 1;
				setAroundPoint(_dirX, _dirY, _pt + rectOffX, halfHeight + rectOffY - kD);
			}
			for (_in = 0; _in <= _yn; _in++) {
				_pt = height * (_in / _yn - 0.5);
				if (_in == _yn) {
					_pt -= kD;
				}
				if (_in == 0) {
					_dirY = -1;
				} else if (_in == _yn) {
					_dirY = 1;
				} else {
					_dirY = 0;
				}
				_dirX = -1;
				setAroundPoint(_dirX, _dirY, rectOffX - halfWidth, _pt + rectOffY);
				_dirX = 1;
				setAroundPoint(_dirX, _dirY, halfWidth + rectOffX - kD, _pt + rectOffY);
			}
			//trace(pointListT);
			//trace(pointListB);
			//trace(pointListL);
			//trace(pointListR);
		}
		protected function setAroundPoint(_dirX:int, _dirY:int, _x:Number, _y:Number):void {
			var _vector2D:Vector2D;
			_vector2D = getAroundPoint(_dirX, _dirY);
			if (_vector2D) {
				return;
			}
			_vector2D = new Vector2D(_x, _y);
			aroundPointDic["pt_" + _dirY + "_" + _dirX] = _vector2D;
			if (_dirX>0) {
				pointListR.push(_vector2D);
			}else if (_dirX < 0) {
				pointListL.push(_vector2D);
			}
			if (_dirY>0) {
				pointListB.push(_vector2D);
			}else if (_dirY < 0) {
				pointListT.push(_vector2D);
			}
		}
		protected function getAroundPoint(_dirX:int, _dirY:int):Vector2D {
			return aroundPointDic["pt_" + _dirY + "_" + _dirX];
		}
		//检测水平方向的通行状况
		public function hitTestX(_vx:Number):int {
			var _hitCounts:uint = 0;
			var _pointList:Vector.<Vector2D> = (_vx > 0)?pointListR:pointListL;
			var _i:String;
			var _x:Number;
			for (_i in _pointList) {
				_x = x + _pointList[_i].x;
				if (map.hitTest_2(_x, y + _pointList[_i].y, _vx, 0)) {
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
			var _pointList:Vector.<Vector2D> = (_vy > 0)?pointListB:pointListT;
			var _i:String;
			var _y:Number;
			for (_i in _pointList) {
				_y = y + _pointList[_i].y;
				if (map.hitTest_2(x + _pointList[_i].x, _y, 0, _vy)) {
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
					_x = map.hitTestPt.x - rectOffX +(vectorSpeed.x > 0? -0.5:0.5)*width;
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
					_y = map.hitTestPt.y - rectOffY +(vectorSpeed.y > 0? -0.5:0.5)*height;
					if (onHitTile!=null) {
						onHitTile(false);
					}
				} else {
					_y += vectorSpeed.y;
				}
			}
			//水平垂直方向速度均不为0，且没有发生碰撞，需要检测是否有穿过区块的情况
			if (vectorSpeed.y * vectorSpeed.x != 0 && !(_isHitX || _isHitY)) {
				var _vector:Vector2D = getAroundPoint(vectorSpeed.x > 0?1: -1, vectorSpeed.y > 0?1: -1);
				var _hit:Boolean = map.hitTest_2(x + _vector.x, y + _vector.y, vectorSpeed.x, vectorSpeed.y);
				if (_hit) {
					if (map.hitTestPt.x == (map.hitTestTile.tileX +(vectorSpeed.x > 0? 0: 1)) * map.tileWidth) {
						//_y = y;
					}else {
						//_x = x;
					}
				}
			}
			if (x != _x || y != _y) {
				setXY(_x,_y);
			}
		}
	}
}