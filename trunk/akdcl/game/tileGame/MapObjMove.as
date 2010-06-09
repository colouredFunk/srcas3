package akdcl.game.tileGame
{
	import akdcl.math.Vector2D;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MapObjMove extends MapObj
	{
		public var userData:Object;
		//移动速度标量
		protected var speedMove:Number = 5;
		//移动速度矢量
		protected var vectorSpeed:Vector2D;
		//存放围绕物体四周的点的横纵偏移量
		protected var pointListX:Vector.<Number>;
		protected var pointListY:Vector.<Number>;
		
		//物体虚拟高
		public var width:uint;
		//物体虚拟宽
		public var height:uint;
		private var halfWidth:uint;
		private var halfHeight:uint;
		public function MapObjMove() {
			
		}
		//设置周围的点
		private function setCorners():Void {
			pointListX = new Vector();
			pointListY = new Vector();
			var _xn:uint = Math.ceil(width / map.tileWidth);
			var _yn:uint = Math.ceil(height / map.tileHeight);
			var _in:uint;
			for (_in = 0; _in < _xn + 1; _in++) {
				pointListX.push(width * (_in / _xn - 0.5));
			}
			for (_in = 0; _in < _yn + 1; _in++) {
				pointListY.push(height * (_in / _yn - 0.5));
			}
			//aPoint_x[aPoint_x.length-1]--;
			//aPoint_y[aPoint_y.length-1]--;
		}
	}
}