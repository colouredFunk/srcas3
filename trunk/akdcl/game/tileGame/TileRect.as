package akdcl.game.tileGame
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class TileRect extends Tile
	{
		//水平方向：0：←→畅通，1：→方向畅通，-1：←方向畅通，NaN：不畅通
		protected var walkX:Number = 0;
		//垂直方向：0：↑↓畅通，1：↓方向畅通，-1：↑方向畅通，NaN：[-]不畅通
		protected var walkY:Number = 0;
		public function TileRect(_tileX:uint, _tileY:uint,_flagAry:Array) {
			super(_tileX, _tileY);
			walkX = _flagAry[0], walkY = _flagAry[1];
		}
		override public function hitTest(_x:Number, _y:Number, _dx:Number, _dy:Number, _xt:Number, _yt:Number):Boolean 
		{
			var _crossX:Boolean = _dx * walkX >= 0;
			var _crossY:Boolean = _dy * walkY >= 0;
			var _x0:Number = (tileX +(_dx > 0? 0: 1)) * map.tileWidth;
			var _y0:Number = (tileY +(_dy > 0? 0: 1)) * map.tileHeight;
			if (_dx == 0) {
				//水平方向无速度
				if (_crossY) {
					//目标区块可通行
					return false;
				}
				//目标区块y轴方向无法通过
				hitTestPt.x = _x, hitTestPt.y = _y0;
				return true;
			}else if (_dy == 0) {
				//垂直方向无速度
				if (_crossX) {
					//目标区块可通行
					return false;
				}
				//目标区块x轴方向无法通过
				hitTestPt.x = _x0, hitTestPt.y = _y;
				return true;
			}else {
				var _tileX_0:uint = map.xToTileX(_x);
				if ((tileX - _tileX_0 == 0)?_crossY:_crossX) {
					//目标区块可通行
					return false;
				}else {
					if (_tileX_t - _tileX_0 == 0) {
						//目标区块y轴方向无法通过
						hitTestPt.x = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x, hitTestPt.y = _y0;
					}else {
						//目标区块x轴方向无法通过
						hitTestPt.x = _x0, hitTestPt.y = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
					}
				}
				return true;
			}
		}
	}
	
}