package akdcl.skeleton{
	import flash.geom.Point;
	
	/**
	 * 骨骼，用来控制显示关节的移动
	 * @author akdcl
	 */
	final public class Bone {
		public static const isRadianMode:Boolean = false;
		
		private static var list:Vector.<Bone> = new Vector.<Bone>;
		public static function create():Bone {
			if (list.length > 0) {
				return list.pop();
			}
			return new Bone();
		}
		
		public static function recycle(_bone:Bone):void {
			list.push(_bone);
		}
		
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
		internal var tweenNode:TweenNode;
		
		//private var children:Vector.<Bone>;
		private var parent:Bone;
		private var parentX:Number;
		private var parentY:Number;
		private var parentR:Number;
		private var parentLocalX:Number;
		private var parentLocalY:Number;
		
		private var lockX:Number;
		private var lockY:Number;
		
		/**
		 * 构造函数
		 * @param _joint 受骨骼控制的显示关节
		 * @param _name 用于Armature索引
		 */
		public function Bone() {
			parentX = 0;
			parentY = 0;
			parentR = 0;
			parentLocalX = 0;
			parentLocalY = 0;
			lockX = 0;
			lockY = 0;
			
			node = new Node();
			tweenNode = new TweenNode();
			//children = new Vector.<Bone>();
		}
		
		public function remove():void {
			joint = null;
			parent = null;
		}
		
		internal function getGlobalX():Number {
			return parentLocalX + parentX;
		}
		
		internal function getGlobalY():Number {
			return parentLocalY + parentY;
		}
		
		internal function getGlobalR():Number {
			return node.rotation + tweenNode.rotation + parentR;
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
		 * 更新
		 */
		public function update():void {
			if (parent) {
				//把node和animationNode坐标和映射到parent的坐标系
				parentX = parent.getGlobalX();
				parentY = parent.getGlobalY();
				parentR = parent.getGlobalR();
				
				var _dX:Number = lockX + node.x + tweenNode.x;
				var _dY:Number = lockY + node.y + tweenNode.y;
				var _r:Number;
				if (isRadianMode) {
					_r = Math.atan2(_dY, _dX) + parentR;
				}else {
					_r = Math.atan2(_dY, _dX) + parentR * Math.PI / 180;
				}
				
				var _len:Number = Math.sqrt(_dX * _dX + _dY * _dY);
				parentLocalX = _len * Math.cos(_r);
				parentLocalY = _len * Math.sin(_r);
			}else {
				parentLocalX = node.x + tweenNode.x;
				parentLocalY = node.y + tweenNode.y;
			}
			
			if (joint) {
				joint.x = getGlobalX();
				joint.y = getGlobalY();
				joint.rotation = getGlobalR();
				
				
				//scale和alpha只由tweenNode控制
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
	
}