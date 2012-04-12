package akdcl.silhouette
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Silhouette {
		protected var animationDic:Dictionary;
		public function Silhouette() {
			animationDic = new Dictionary();
		}
		
		protected function addJoint(_parent:*, _child:*, _x:int, _y:int, _index:int = -1):void {
			_child.x = _x;
			_child.y = _y;
			if (_index < 0) {
				_parent.addChild(_child);
			}else {
				_parent.addChildAt(_child, _index);
			}
			var _a:Animation = new Animation();
			_a.clip = _child;
			animationDic[_child] = _a;
		}
		
		public function addLinked(_child:Object):void {
			
		}
		
		public function update():void {
			for each(var _a:Animation in animationDic) {
				_a.update();
			}
			/*for each(var _part:ModelPart in lockFrom) {
				pointTemp = localToTarget(_part.parent, _part.lockPoint);
				_part.control.x = pointTemp.x;
				_part.control.y = pointTemp.y;
				//_part.update();
			}*/
		}
	}
	
}