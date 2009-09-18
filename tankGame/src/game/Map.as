package game
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Map extends Sprite
	{
		public var ground:Sprite;
		protected var groundBmp:Bitmap;
		protected var groundBmd:BitmapData;
		public var mapWidth:uint=550;
		public var mapHeight:uint=400;
		protected var wind:Point;
		private var matrix:Matrix;
		private var colorTf:ColorTransform;
		public function Map(){
			addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function added(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
			if(!ground){
				return;
			}
			groundBmp=new Bitmap();
			groundBmd=new BitmapData(mapWidth,mapHeight,true,0);
			groundBmd.draw(ground);
			groundBmp.bitmapData=groundBmd;
			addChildAt(groundBmp,getChildIndex(ground));
			removeChild(ground);
			wind=new Point(0.1,0);
			matrix=new Matrix();
			colorTf=new ColorTransform();
		}
		protected function removed(event:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		private var _gravity:Point;
		public function addTank(_tank:*):void{
			_gravity=new Point(0,_tank.mass);
			_tank.addForceAir(_gravity);
			_tank.addForceAir(wind);
			_tank.ground=groundBmd;
			_tank.groundCoordinate=this;
			addChild(_tank);
		}
		public function paintGround(_sprite:Sprite):void {
			//Global.obTemp.matrix.tx = _mObj._x-_mGround._x;
			//Global.obTemp.matrix.ty = _mObj._y-_mGround._y;
			groundBmd.draw(_sprite,matrix,colorTf,BlendMode.SCREEN);
		}
	}
}