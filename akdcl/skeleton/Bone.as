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
		 * 骨骼动画
		 */
		public var animation:Animation;
		
		/**
		 * 骨骼关键点信息
		 */
		public var node:Node;
		
		/**
		 * @private
		 */
		internal var parentNode:Node;
		
		//private var children:Vector.<Bone>;
		private var parent:Bone;
		private var lockX:Number;
		private var lockY:Number;
		
		/**
		 * 构造函数
		 * @param _joint 受骨骼控制的显示关节
		 * @param _name 用于Armature索引
		 */
		public function Bone(_joint:Object, _name:String = null) {
			joint = _joint;
			name = _name;
			lockX = 0;
			lockY = 0;
			
			node = new Node();
			parentNode = new Node();
			//children = new Vector.<Bone>();
			
			animation = new Animation(_name);
			animation.node = node;
		}
		
		public function getGlobalRotation():Number {
			return node.rotation + parentNode.rotation;
		}
		
		/**
		 * 绑定骨骼到自身坐标系
		 * @param _child 要绑定的子骨骼
		 * @param _x x坐标
		 * @param _y y坐标
		 */
		public function addChild(_child:Bone, _x:Number, _y:Number):Bone {
			//children.push(_child);
			_child.lockX = _x;
			_child.lockY = _y;
			_child.parent = this;
			return _child;
		}
		
		/**
		 * 更新步进
		 */
		public function update():void {
			animation.update();
			if (parent) {
				var _pr:Number = parent.getGlobalRotation();
				var _r:Number;
				var _dX:Number;
				var _dY:Number;
				if ("pivotX" in parent.joint) {
					_dX = lockX + node.x;
					_dY = lockY + node.y;
					_r = Math.atan2(_dY, _dX)+_pr;
					//pointTemp = parent.joint.transformationMatrix.transformPoint(pointTemp);
				}else {
					_dX = lockX + node.x;
					_dY = lockY + node.y;
					_r = Math.atan2(_dY, _dX) + _pr * Math.PI / 180;
					//pointTemp = parent.joint.transform.matrix.transformPoint(pointTemp);
				}
				
				//
				var _len:Number = Math.sqrt(_dX * _dX + _dY * _dY);
				
				parentNode.x = _len * Math.cos(_r) + parent.joint.x;
				parentNode.y = _len * Math.sin(_r) + parent.joint.y;
				
				parentNode.rotation = _pr;
				joint.x = parentNode.x;
				joint.y = parentNode.y;
			}else {
				joint.x = node.x + parentNode.x;
				joint.y = node.y + parentNode.y;
			}
			joint.rotation = node.rotation + parentNode.rotation;
			
			//
			joint.scaleX = node.scaleX;
			joint.scaleY = node.scaleY;
			//
			if (isNaN(node.alpha)) {
				
			}else {
				if (node.alpha) {
					joint.visible = true;
					joint.alpha = node.alpha;
				}else {
					joint.visible = false;
				}
			}
		}
	}
	
}