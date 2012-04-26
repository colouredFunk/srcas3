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
		 * 骨骼关键点信息
		 */
		public var node:Node;
		
		/**
		 * @private
		 */
		internal var parentNode:Node;
		internal var tweenNode:TweenNode;
		
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
			tweenNode = new TweenNode();
			//children = new Vector.<Bone>();
		}
		
		public function getGlobalRotation():Number {
			return node.rotation + parentNode.rotation + tweenNode.rotation;
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
			if (parent) {
				//把node和animationNode坐标和映射到parent的坐标系
				var _pr:Number = parent.joint.rotation;
				var _r:Number;
				var _dX:Number = lockX + node.x + tweenNode.x;
				var _dY:Number = lockY + node.y + tweenNode.y;
				if ("pivotX" in parent.joint) {
					_r = Math.atan2(_dY, _dX)+_pr;
					//pointTemp = parent.joint.transformationMatrix.transformPoint(pointTemp);
				}else {
					_r = Math.atan2(_dY, _dX) + _pr * Math.PI / 180;
					//pointTemp = parent.joint.transform.matrix.transformPoint(pointTemp);
				}
				
				//
				var _len:Number = Math.sqrt(_dX * _dX + _dY * _dY);
				
				//parentGlobalXY
				parentNode.x = _len * Math.cos(_r) + parent.joint.x;
				parentNode.y = _len * Math.sin(_r) + parent.joint.y;
				
				parentNode.rotation = _pr;
				joint.x = parentNode.x;
				joint.y = parentNode.y;
			}else {
				joint.x = node.x + parentNode.x + tweenNode.x;
				joint.y = node.y + parentNode.y + tweenNode.y;
			}
			joint.rotation = node.rotation + parentNode.rotation + tweenNode.rotation;
			
			//scale和alpha只由动画控制
			if (isNaN(tweenNode.scaleX)) {
			}else {
				joint.scaleX = tweenNode.scaleX;
			}
			if (isNaN(tweenNode.scaleY)) {
				
			}else {
				joint.scaleY = tweenNode.scaleY;
			}
			if (isNaN(tweenNode.alpha)) {
				
			}else {
				if (tweenNode.alpha) {
					joint.visible = true;
					joint.alpha = tweenNode.alpha;
				}else {
					joint.visible = false;
				}
			}
		}
	}
	
}