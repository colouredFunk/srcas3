package game
{
	import game.CircleObj;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Tank extends CircleObj
	{
		public var groundCoordinate:Sprite;
		private var tempPt:Point;
		override protected function added(_evt:Event) : void{
			super.added(_evt);
			position.x=x;
			position.y=y;
			radian=rotation/(180*Math.PI);
			tempPt=new Point();
		}
		override public function run() : void{
			tempPt=parent.localToGlobal(position);
			tempPt=groundCoordinate.globalToLocal(position);
			super.run();
			tempPt=groundCoordinate.globalToLocal(position);
			tempPt=parent.localToGlobal(position);
			x=position.x;
			y=position.y;
			rotation=radian*(180/Math.PI);
		}
	}
}