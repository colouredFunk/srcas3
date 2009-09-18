package game {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	final public class HitTest {
		public static function crossPoint(_x0:Number,_y0:Number,_xt:Number,_yt:Number,_hit:*,_pt:*=null):Object {
			var _step:Number=1;
			var _isHit:Boolean;
			var _x,_y:Number;
			var _i:Number=0;
			
			var _dis:Number = distance(_x0, _y0, _xt, _yt);
			_x=(_xt-_x0)/_dis*_step, _y=(_yt-_y0)/_dis*_step;
			while (!_isHit && _i++<_dis) {
				_x0 += _x, _y0 += _y;
				_isHit = hitTest(_hit,_x0,_y0);
			}
			if(_isHit&&_pt){
				_x0 -= _x, _y0 -= _y;
				_pt.x=_x0,_pt.y=_y0;
			}
			return _isHit;
		}
		public static function closePoint(_x0:Number,_y0:Number,_xt:Number,_yt:Number,_hit:*,_pt:*=null):Boolean {
			var _step:Number=0.5;
			var _isHit:Boolean;
			var _x,_y:Number;
			var _i:Number=0;
			while (side_max(_x0,_y0,_xt,_yt)>_step&&_i++<100) {
				_x=(_x0+_xt)*0.5,_y=(_y0+_yt)*0.5;
				if (hitTest(_hit,_x,_y)) {
					_isHit=true;
					_xt=_x,_yt=_y;
				} else {
					_x0=_x,_y0=_y;
				}
			}
			if (_isHit&&_pt) {
				_pt.x=_x0,_pt.y=_y0;
			}
			return _isHit;
		}
		//hitTestPoint需要global
		//getPixel32需要bitmapData容器的local坐标
		private static function hitTest(_hit:*,_x:Number,_y:Number):Boolean{
			if(_hit is DisplayObject){
				return _hit.hitTestPoint(_x,_y,true);
			}else{
				return _hit.getPixel32(_x,_y);
			}
		}
		private static function distance(_x0:Number,_y0:Number,_xt:Number,_yt:Number):Number {
			return Math.sqrt(Math.pow(_xt-_x0,2)+Math.pow(_yt-_y0,2));
		}
		//返回矩形区域最大正边长
		private static function side_max(_x0:Number,_y0:Number,_xt:Number,_yt:Number):Number {
			var _nDx:Number=_xt-_x0;
			_nDx<0&&(_nDx=- _nDx);
			var _nDy:Number=_yt-_y0;
			_nDy<0&&(_nDy=- _nDy);
			return Math.max(_nDx,_nDy);
		}
	}
}