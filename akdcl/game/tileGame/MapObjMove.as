package akdcl.game.tileGame
{
	import akdcl.math.Vector2D;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MapObjMove extends MapObj
	{
		public var userData:Object;
		//移动速度标量
		protected var moveSpeed:Number = 3;
		//移动速度矢量
		protected var vector:Vector2D;
		//存放围绕物体四周的点的横纵偏移量
		protected var pointListX:Vector.<Array>;
		protected var pointListY:Vector.<Array>;
		//物体虚拟高
		public var width:uint;
		//物体虚拟宽
		public var height:uint;
		private var width_half:uint;
		private var height_half:uint;
		private var __nTile_x:Number = 0;
		private var __nTile_y:Number = 0;
		private var nTile_xPrev:Number = 0;
		private var nTile_yPrev:Number = 0;
		private var Prev_x:Number = 0;
		private var Prev_y:Number = 0;
		public function MapObjMove() {
			
		}
	}
}