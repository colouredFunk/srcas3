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
		public static function hitTest(_hit:Object, _x:Number, _y:Number):Boolean {
			if(_hit is DisplayObject){
				return _hit.hitTestPoint(_x, _y, true);
			}else if (_hit is BitmapData) {
				return _hit.getPixel32(_x, _y);
			}
			return false;
		}
		
		//x0,y0开始为没有撞倒的点
		public static function crossPoint(_x0:Number, _y0:Number, _xt:Number, _yt:Number, _display:Object, _minStep:Number = 1):Object {
			var _hit:Boolean = false;
			var _dis:Number = int(distance(_x0, _y0, _xt, _yt));
			var _x:Number = (_xt - _x0) / _dis * _minStep;
			var _y:Number = (_yt - _y0) / _dis * _minStep;
			var _i:int = 0;
			
			while (!_hit && _i++<_dis) {
				_x0 += _x;
				_y0 += _y;
				_hit = hitTest(_display, _x0, _y0);
			}
			if (_hit) {
				_x0 -= _x;
				_y0 -= _y;
				hitPoint.x = _x0;
				hitPoint.y = _y0;
			}
			return _hit;
		}
		
		//x0,y0开始为没有撞倒的点
		public static function closePoint(_x0:Number, _y0:Number, _xt:Number, _yt:Number, _display:Object, _minStep:Number = 2):Object {
			var _hit:Boolean = false;
			var _x, _y:Number;
			var _i:Number = 0;
			
			if (hitTest(_display, _x0, _y0)) {
				if (hitTest(_display, _xt, _yt)) {
					//应该反向查找
					hitPoint.x = _x0;
					hitPoint.y = _y0;
					return true;
				} else {
					_x = _x0;
					_y = _y0;
					_x0 = _xt;
					_y0 = _yt;
					_xt = _x;
					_yt = _y;
				}
			}

			while (sideMax(_x0, _y0, _xt, _yt) > _minStep && _i++ < 100){
				_x = (_x0 + _xt) * 0.5;
				_y = (_y0 + _yt) * 0.5;
				if (hitTest(_display, _x, _y)) {
					_hit = true;
					_xt = _x;
					_yt = _y;
				} else {
					_x0 = _x;
					_y0 = _y;
				}
			}
			
			hitPoint.x = _x0;
			hitPoint.y = _y0;
			return _hit;
		}

		//返回矩形区域最大正边长
		private static function sideMax(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _nDx:Number = _xt - _x0;
			var _nDy:Number = _yt - _y0;
			if (_nDx < 0) {
				_nDx = -_nDx;
			}
			if (_nDy < 0) {
				_nDy = -_nDy;
			}
			return _nDx > _nDy?_nDx:_nDy;
		}

		private static function distance(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _dx:Number = _xt - _x0;
			var _dy:Number = _yt - _y0;
			return Math.sqrt(_dx * _dx + _dy * _dy);
		}
	}
	
}