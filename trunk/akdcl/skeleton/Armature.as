package akdcl.skeleton
{
	import flash.geom.Point;
	
	/**
	 * 骨架，包含相关骨骼和显示对象的衔接，同时可以总体控制各个骨骼的动画
	 * @author Akdcl
	 */
	public class Armature {
		
		/**
		 * 动画播放事件回调函数
		 * 参数1：animationID 动画ID，
		 * 参数2：boneID 骨骼ID，
		 * 参数3：typeID 状态标识(0:动画完毕/1:列表动画开始/2:列表动画关键帧位置到达)，
		 * 参数4：frameID 关键帧标识(当typeID为2时有效)。
		 */
		public var animationCallBack:Function;
		
		public var animationLast:String;
		
		/**
		 * name
		 */
		public var name:String;
		
		/**
		 * @private
		 */
		protected var container:Object;
		
		/**
		 * @private
		 */
		protected var animationData:Object;
		
		/**
		 * @private
		 */
		protected var joints:Object;
		
		/**
		 * @private
		 */
		protected var bones:Object;
		
		/**
		 * @private
		 */
		protected var boneList:Vector.<Bone>;
		
		/**
		 * 构造函数
		 * @param _container 包含所有显示关节的显示容器
		 */
		public function Armature(_container:Object) {
			super();
			joints = { };
			bones = { };
			boneList = new Vector.<Bone>;
			
			container = _container;
		}
		
		/**
		 * 初始化骨骼系统
		 * @param _name 会根据此值在 ConnectionData 中查找对应的骨骼配置和动画配置
		 * @param _useLocalXY 当设置为true时，启用 container 中关节当前的位置关系而不是 ConnectionData中的配置关系 
		 */
		public function setup(_name:String, _useLocalXY:Boolean = false):void {
			name = _name;
			animationData = ConnectionData.getAnimation(_name);
			var _boneXMLList:XMLList = ConnectionData.getBones(_name);
			if (!container || !_boneXMLList) {
				return;
			}
			
			var _bone:Bone;
			var _boneParent:Bone;
			var _joint:Object;
			var _jointHigher:Object;
			var _boneXML:XML;
			var _name:String;
			var _z:int;
			var _list:Array = [];
			var _length:uint = _boneXMLList.length();
			
			//按照link和parent优先索引排序boneList
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_boneXML = _boneXMLList[_i];
				_name = _boneXML.@name;
				_joint = joints[_name] || container.getChildByName(_name);
				if (_joint) {
					//
					_z = int(_boneXML.@z);
					for (var _j:uint = _z; _j < _list.length; _j++) {
						_jointHigher = _list[_j];
						if (_jointHigher) {
							break;
						}
					}
					_list[_z] = _joint;
					
					if (_jointHigher) {
						_z = container.getChildIndex(_jointHigher) - 1;
					}else {
						_z = -1;
					}
					_jointHigher = null;
					addJoint(_joint, _name, _z, _boneXML.@parent, Number(_boneXML.@x), Number(_boneXML.@y));
				}
			}
		}
		
		/**
		 * 播放动画
		 * @param _frameLabel 动画ID
		 * @param _toFrame 过渡到该动画使用的帧数
		 * @param _listFrame 如果该动画是列表动画，则此值为列表动画所用的帧数
		 * @param _loopType 动画播放方式，0：不循环，1：循环，-1：循环并自动反转
		 * @param _ease 缓动方式，0：线性，1：淡入，-1：淡出
		 * @example 例子播放跑步动画
		 * <listing version="3.0">playTo("run", 4, 20, 1);</listing >
		 */
		public function playTo(_frameLabel:String, _toFrame:uint, _listFrame:uint = 0, _loopType:int = 0, _ease:int = 0):void {
			animationLast = _frameLabel;
			var _data:Object = animationData[_frameLabel];
			var _eachD:Object;
			for each(var _bone:Bone in boneList) {
				_eachD = _data[_bone.name];
				if (_eachD) {
					_bone.animation.name = _frameLabel;
					_bone.animation.playTo(_eachD, _toFrame, _listFrame, _loopType, _ease);
				}
			}
		}
		
		/**
		 * 暂停或继续动画
		 */
		public function pause(_bause:Boolean = true):void {
			for each(var _bone:Bone in boneList) {
				_bone.animation.pause(_bause);
			}
		}
		
		/**
		 * 停止动画
		 */
		public function stop():void {
			for each(var _bone:Bone in boneList) {
				_bone.animation.stop();
			}
		}
		
		/**
		 * 对骨骼动画的速度进行缩放
		 * @param _scale 缩放值做为系数乘到原来的动画帧值
		 * @param _id 指定的骨骼ID，默认为所有骨骼
		 * @example 例子让ID为"body"的骨骼的动画播放变慢为原来的0.5
		 * <listing version="3.0">setAnimationScale(0.5, "body");</listing >
		 */
		public function setAnimationScale(_scale:Number, _id:String = null):void {
			var _bone:Bone;
			if (_id) {
				_bone = getBone(_id);
				if (_bone) {
					_bone.animation.scale = _scale;
				}
			}else {
				for each(_bone in boneList) {
					_bone.animation.scale = _scale;
				}
			}
		}
		
		/**
		 * 更新步进
		 */
		public function update():void {
			var _length:uint = boneList.length;
			for (var _i:uint = 0; _i < _length; _i++ ) {
				boneList[_i].update();
			}
		}
		
		/**
		 * 绑定显示关节
		 * @param _joint 显示关节
		 * @param _id 关节ID
		 * @param _index 绑定到深度，如果是替换原有关节，则使用原有关节的深度
		 * @param _parentID 绑定到父骨骼的ID
		 * @param _x 绑定的坐标x
		 * @param _y 绑定的坐标y
		 * @example 例子绑定手臂到身体上
		 * <listing version="3.0">addJoint(new Sprite(), "arm", -1, "body", 5, -10)</listing >
		 */
		public function addJoint(_joint:Object, _id:String=null, _index:int = -1, _parentID:String = null, _x:Number = 0, _y:Number = 0):* {
			var _bone:Bone;
			if (_id && _id != _joint.name) {
				_joint.name = _id;
			}else {
				_id = _joint.name;
			}
			var _jointOld:Object = joints[_id];
			if (_jointOld) {
				//替换现有关节
				joints[_id] = _joint;
				_bone = getBone(_id);
				_bone.joint = _joint;
				
				container.addChildAt(_joint, container.getChildIndex(_jointOld) - 1);
				return _joint;
			}
			//添加新的关节
			joints[_id] = _joint;
			_bone = new Bone(_joint, _id);
			_bone.animation.callBack = animationCallBack;
			boneList.push(_bone);
			bones[_id] = _bone;
			var _boneParent:Bone = getBone(_parentID);
			if (_boneParent) {
				_boneParent.addChild(_bone, _x, _y);
			}
			if (_index < 0) {
				container.addChild(_joint);
			}else {
				container.addChildAt(_joint, _index);
			}
			return _joint;
		}
		
		/**
		 * 获取显示关节
		 * @param _id 关节ID
		 */
		public function getJoint(_id:String):Object {
			return joints[_id];
		}
		
		/**
		 * 获取骨骼
		 * @param _id 骨骼ID
		 */
		public function getBone(_id:String):Bone {
			return bones[_id];
		}
		
		/**
		 * 获取显示关节容器
		 */
		public function getContainer():Object {
			return container;
		}
	}
	
}