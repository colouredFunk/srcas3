package akdcl.skeleton{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author akdcl
	 */
	final public class Bone {
		private static var pointTemp:Point = new Point();
		
		public var name:String;
		public var joint:Object;
		public var animation:Animation;
		
		public var frame:Frame;
		public var offset:Frame;
		private var parent:Bone;
		private var lockX:Number;
		private var lockY:Number;
		
		//private var children:Vector.<Bone>;
		
		public function Bone(_name:String, _joint:Object) {
			name = _name;
			joint = _joint;
			lockX = 0;
			lockY = 0;
			
			frame = new Frame();
			offset = new Frame();
			//children = new Vector.<Bone>();
			
			animation = new Animation(_name);
			animation.frame = offset;
		}
		
		public function addChild(_child:Bone, _x:Number, _y:Number):void {
			//children.push(_child);
			_child.lockX = _x;
			_child.lockY = _y;
			_child.parent = this;
		}
		
		public function update():void {
			animation.update();
			if (parent) {
				if ("transformationMatrix" in parent.joint) {
					pointTemp.x = lockX + offset.x + parent.joint.pivotX;
					pointTemp.y = lockY + offset.y + parent.joint.pivotY;
					pointTemp = parent.joint.transformationMatrix.transformPoint(pointTemp);
				}else {
					pointTemp.x = lockX + offset.x;
					pointTemp.y = lockY + offset.y;
					pointTemp = parent.joint.transform.matrix.transformPoint(pointTemp);
				}
				frame.x = pointTemp.x;
				frame.y = pointTemp.y;
				frame.rotation = parent.frame.rotation + parent.offset.rotation;
				joint.x = frame.x ;
				joint.y = frame.y ;
			}else {
				joint.x = frame.x + offset.x;
				joint.y = frame.y + offset.y;
			}
			joint.rotation = frame.rotation + offset.rotation;
			
			joint.scaleX = offset.scaleX;
			joint.scaleY = offset.scaleY;
			
		}
	}
	
}