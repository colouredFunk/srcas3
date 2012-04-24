package akdcl.skeleton{
	import flash.geom.Point;
	
	/**
	 * 骨骼，用来控制显示关节的移动
	 * @author akdcl
	 */
	final public class Bone {
		//private static var pointTemp:Point = new Point();
		
		/**
		 * 用于Armature索引
		 */
		public var name:String;
		
		/**
		 * 受骨骼控制的显示关节
		 */
		public var joint:Object;
		
		/**
		 * 骨骼偏移动画
		 */
		public var animation:Animation;
		
		/**
		 * 骨骼关键点信息
		 */
		public var frame:Frame;
		
		/**
		 * 骨骼偏移点信息
		 */
		public var offset:Frame;
		
		//private var children:Vector.<Bone>;
		private var parent:Bone;
		private var lockX:Number;
		private var lockY:Number;
		
		/**
		 * 构造函数
		 * @param _name 用于Armature索引
		 * @param _joint 受骨骼控制的显示关节
		 */
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
		
		/**
		 * 绑定骨骼到自身坐标系
		 * @param _child 要绑定的子骨骼
		 * @param _x x坐标
		 * @param _y y坐标
		 */
		public function addChild(_child:Bone, _x:Number, _y:Number):void {
			//children.push(_child);
			_child.lockX = _x;
			_child.lockY = _y;
			_child.parent = this;
		}
		
		/**
		 * 更新步进
		 */
		public function update():void {
			animation.update();
			if (parent) {
				var _pr:Number = parent.frame.rotation + parent.offset.rotation;
				var _r:Number;
				var _dX:Number;
				var _dY:Number;
				if ("pivotX" in parent.joint) {
					_dX = lockX + offset.x;
					_dY = lockY + offset.y;
					_r = Math.atan2(_dY, _dX)+_pr;
					//pointTemp = parent.joint.transformationMatrix.transformPoint(pointTemp);
				}else {
					_dX = lockX + offset.x;
					_dY = lockY + offset.y;
					_r = Math.atan2(_dY, _dX) + _pr * Math.PI / 180;
					//pointTemp = parent.joint.transform.matrix.transformPoint(pointTemp);
				}
				//frame.x = pointTemp.x;
				//frame.y = pointTemp.y;
				
				//
				var _len:Number = Math.sqrt(_dX * _dX + _dY * _dY);
				
				frame.x = _len * Math.cos(_r) + parent.joint.x;
				frame.y = _len * Math.sin(_r) + parent.joint.y;
				
				frame.rotation = _pr;
				joint.x = frame.x;
				joint.y = frame.y;
			}else {
				joint.x = frame.x + offset.x;
				joint.y = frame.y + offset.y;
			}
			joint.rotation = frame.rotation + offset.rotation;
			
			joint.scaleX = offset.scaleX;
			joint.scaleY = offset.scaleY;
			
			if (isNaN(offset.alpha)) {
				
			}else {
				if (offset.alpha) {
					joint.visible = true;
					joint.alpha = offset.alpha;
				}else {
					joint.visible = false;
				}
			}
		}
	}
	
}