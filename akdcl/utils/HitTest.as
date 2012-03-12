package akdcl.utils
{
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class HitTest
	{
		public static var hitPoint:Point = new Point();
		
		//hitTestPoint需要global
		//getPixel32需要bitmapData容器的local坐标
		public static function hitTest(_isHit:Object, _x:Number, _y:Number):Boolean {
			if(_isHit is DisplayObject){
				return _isHit.hitTestPoint(_x, _y, true);
			}else if (_isHit is BitmapData) {
				return _isHit.getPixel32(_x, _y);
			}
			return false;
		}
		
		//x0,y0开始为没有撞倒的点
		public static function crossPoint(_x0:Number, _y0:Number, _xt:Number, _yt:Number, _display:Object, _minStep:Number = 1):Object {
			var _isHit:Boolean = false;
			var _x:Number;
			var _y:Number;
			var _i:int = 0;
			
			if (hitTest(_display, _x0, _y0)) {
				//应该反向查找
				hitPoint.x = _x0;
				hitPoint.y = _y0;
				return true;
			}
			
			if (hitTest(_display, _xt, _yt)) {
				while (sideMax(_x0, _y0, _xt, _yt) > _minStep && _i++ < 100){
					_x = (_x0 + _xt) * 0.5;
					_y = (_y0 + _yt) * 0.5;
					if (hitTest(_display, _x, _y)) {
						_isHit = true;
						_xt = _x;
						_yt = _y;
					} else {
						_x0 = _x;
						_y0 = _y;
					}
				}
			}else {
				var _dis:Number = int(distance(_x0, _y0, _xt, _yt));
				_x = (_xt - _x0) / _dis * _minStep;
				_y = (_yt - _y0) / _dis * _minStep;
				while (_i++ < _dis) {
					_isHit = hitTest(_display, _x0 + _x, _y0 + _y);
					if (_isHit) {
						break;
					}
					_x0 += _x;
					_y0 += _y;
				}
			}
			
			if (_isHit) {
				hitPoint.x = _x0;
				hitPoint.y = _y0;
			}
			return _isHit;
		}
		
		//获得hitTest点的切面角弧度，未碰撞返回NaN
		public static function hitTestRadian(_x0:Number, _y0:Number, _xt:Number, _yt:Number, _display:Object, _radius:uint = 10):Number {
			var _isHit:Boolean;
			_isHit = crossPoint(_x0, _y0, _xt, _yt, _display);
			if (_isHit) {
				var _hitX:Number = hitPoint.x;
				var _hitY:Number = hitPoint.y;
				
				var _dX:Number = _xt - _x0;
				var _dY:Number = _yt - _y0;
				var _radian:Number = Math.atan2(_dY, _dX);
				
				_dX = Math.cos(_radian) * _radius;
				_dY = Math.sin(_radian) * _radius;
				
				var _rX:Number;
				var _rY:Number;
				var _lX:Number;
				var _lY:Number;
				if (!crossPoint(_hitX - _dX, _hitY - _dY, _hitX + _dY, _hitY - _dX, _display)) {
					crossPoint(_hitX + _dY, _hitY - _dX, _hitX + _dX, _hitY + _dY, _display);
				}
				_rX = hitPoint.x;
				_rY = hitPoint.y;
				if (!crossPoint(_hitX - _dX, _hitY - _dY, _hitX - _dY, _hitY + _dX, _display)) {
					crossPoint(_hitX - _dY, _hitY + _dX, _hitX + _dX, _hitY + _dY, _display);
				}
				_lX = hitPoint.x;
				_lY = hitPoint.y;
				
				hitPoint.x = _hitX;
				hitPoint.y = _hitY;
				return Math.atan2(_rY - _lY, _rX - _lX);
			}
			return NaN;
		}

		//返回矩形区域最大正边长
		private static function sideMax(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _dX:Number = _xt - _x0;
			var _dY:Number = _yt - _y0;
			if (_dX < 0) {
				_dX = -_dX;
			}
			if (_dY < 0) {
				_dY = -_dY;
			}
			return _dX > _dY?_dX:_dY;
		}

		private static function distance(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _dX:Number = _xt - _x0;
			var _dY:Number = _yt - _y0;
			return Math.sqrt(_dX * _dX + _dY * _dY);
		}
	}
	
}