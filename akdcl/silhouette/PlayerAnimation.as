package view.components 
{
	import game.model.AnimationPart;
	
	import akdcl.utils.objectToString;
	import flash.events.Event;
	import flash.geom.Point;
	import game.model.ModelData;
	import game.model.TweenValue;
	
	import game.model.ModelPart;
	/**
	 * ...
	 * @author Akdcl
	 */
	public final class PlayerAnimation extends AnimationPart 
	{
		private var footPoint:Point;
		override protected function init():void 
		{
			super.init();
			
			footPoint = new Point();
			
			animationData = fixAnimation(ModelData.data.animations.RobotBiped[0]);
			footPoint.x = 6;
			footPoint.y = 7;
			
			fixPart(ModelData.data.models.RobotBiped[0]);
		}
		
		private const A_CHANGE:uint = 4;
		private const RUN_LOOP:uint = 14;
		private const RUN_DELAY:uint = 4;
		
		public function run():void {
			var _frameLeg:int;
			var _frameLegChild:int;
			var _frame:int;
			
			//if (RUN_DELAY > 0) {
				_frameLeg = A_CHANGE + RUN_DELAY;
				_frameLegChild = A_CHANGE;
			//}else {
				//_frameLeg = A_CHANGE;
				//_frameLegChild = A_CHANGE - RUN_DELAY;
			//}
			for each(var _part:ModelPart in partDic) {
				if (_part == partDic.crusR || _part == partDic.crusL) {
					_frame = _frameLegChild;
				}else {
					_frame = _frameLeg;
				}
				_part.tween.tweenList(animationData[_part.name]["run"], _frame, _part == partDic.body?RUN_LOOP * 0.5:RUN_LOOP, -1);
			}
		}
	}

}