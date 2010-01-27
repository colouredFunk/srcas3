package akdcl.game.tetris
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Tile extends Sprite
	{
		public static var TILE_WIDTH:uint = 20;
		public static var TILE_HEIGHT:uint = 20;
		public static const A0:Array = [[0, 0], [1, 0], [2, 0], [3, 0]];
		public static const A1:Array = [[0, 0], [1, 0], [0, 1], [1, 1]];
		public static const A2:Array = [[0, 0], [1, 0], [1, 1], [2, 0]];
		public static const A3:Array = [[0, 0], [1, 0], [2, 0], [2, 1]];
		public static const A4:Array = [[0, 0], [1, 0], [2, 0], [0, 1]];
		public static const A5:Array = [[0, 0], [1, 0], [1, 1], [2, 1]];
		public static const A6:Array = [[1, 0], [2, 0], [0, 1], [1, 1]];
		public static const ROTATENUM_MAX:Array = [1, 0, 3, 3, 3, 1, 1];
		protected var matrix:Array;
		protected var clipList:Array;
		public function Tile(_matrix:Array = null) {
			if (_matrix) {
				matrix = Common.clone(_matrix);
			}else {
				matrix = Common.clone(A1);
			}
			setClip();
			offset( -1, 0);
		}
		private var __lineX:int;
		public function get lineX():int{
			return __lineX;
		}
		public function set lineX(_lineX:int):void{
			__lineX = _lineX;
			x = __lineX * TILE_WIDTH;
		}
		private var __lineY:int;
		public function get lineY():int{
			return __lineY;
		}
		public function set lineY(_lineY:int):void{
			__lineY = _lineY;
			y = __lineY * TILE_HEIGHT;
		}
		/*public function get rect():Rectangle {
			var _rect:Rectangle = new Rectangle();
			for each(var _e:Array in matrix) {
				_rect.left = Math.min(_rect.left, _e[0]);
				_rect.right = Math.max(_rect.right, _e[0]);
				_rect.top = Math.min(_rect.top, _e[1]);
				_rect.bottom = Math.max(_rect.bottom, _e[1]);
			}
			_rect.left += lineX;
			_rect.right += lineX;
			_rect.top += lineY;
			_rect.bottom += lineY;
			_rect.right++;
			_rect.bottom++;
			return _rect;
		}*/
		public function get matrixCopy():Array {
			//var _matrix:Array = Common.clone(matrix);
			return matrix;
		}
		protected function setClip():void {
			clipList = [];
			var _clip:TileClip;
			for(var _i:String in matrix) {
				_clip = new TileClip();
				addChild(_clip);
				clipList[_i] = _clip;
			}
			updateClip();
		}
		public var frame:uint;
		public function changeStyle(_frame:uint):void {
			frame = _frame;
			for each(var _clip:TileClip in clipList) {
				_clip.changeStyle(_frame);
			}
		}
		protected function updateClip():void {
			var _clip:TileClip;
			for(var _i:String in matrix) {
				_clip = clipList[_i];
				_clip.x = matrix[_i][0]*TILE_WIDTH;
				_clip.y = matrix[_i][1]*TILE_HEIGHT;
			}
		}
		protected var rotateNum:int;
		public var rotateMax:int = 3;
		public function rotate(_dir:int = 1):void {
			var _rotateTo:int = rotateNum + _dir;
			if (_rotateTo<0) {
				_rotateTo = rotateMax;
			}else if (_rotateTo>rotateMax) {
				_rotateTo = 0;
			}
			_dir = _rotateTo - rotateNum;
			if (_dir==0) {
				return;
			}
			rotateNum = _rotateTo;
			var _ary:Array;
			for (var _i:String in matrix) {
				_ary = matrix[_i];
				_ary = rotateV(_ary[0], _ary[1], Math.PI * 0.5 * _dir);
				matrix[_i] = _ary;
			}
			updateClip();
		}
		public function offset(_dx:int,_dy:int):void {
			var _ary:Array;
			for (var _i:String in matrix) {
				_ary = matrix[_i];
				_ary[0] += _dx;
				_ary[1] += _dy;
			}
			updateClip();
		}
		protected static function rotateV(_v0:Number,_v1:Number,_rot:Number):Array {
			var _c:Number=Math.cos(_rot);
			var _s:Number=Math.sin(_rot);
			return [Math.round(_v0 * _c - _v1 * _s), Math.round(_v0 * _s + _v1 * _c)];
		}
	}
	
}