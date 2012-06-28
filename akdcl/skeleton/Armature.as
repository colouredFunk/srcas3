package akdcl.skeleton {
	
	/**
	 * 骨架，包含相关骨骼和显示对象的衔接
	 * @author Akdcl
	 */
	public class Armature {
		public var animation:Animation;
		
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
		protected var joints:Object;
		
		/**
		 * @private
		 */
		protected var bones:Object;
		
		/**
		 * @private
		 */
		protected var boneList:Vector.<Bone>;
		
		protected var isRadian:Boolean;
		
		/**
		 * 构造函数
		 * @param _container 包含所有显示关节的显示容器
		 * @param _isRadian 骨骼旋转角度是否采用弧度制，比如starling使用的是弧度制
		 */
		public function Armature(_container:Object, _isRadian:Boolean = false) {
			super();
			joints = { };
			bones = { };
			boneList = new Vector.<Bone>;
			animation = new Animation();
			container = _container;
			
			isRadian = _isRadian;
		}
		
		public function remove():void {
			for each(var _bone:Bone in boneList) {
				Bone.recycle(_bone);
			}
			
			animation.remove();
			animation = null;
			container = null;
			joints = null;
			bones = null;
			boneList.length = 0;
			boneList = null;
		}
		
		/**
		 * 从ConnectionData数据设置骨骼
		 * @param _name 根据此值在 ConnectionData 中查找对应骨骼配置
		 * @param _animationID 根据此值在 ConnectionData 中查找对应的动画配置，不设置则默认和_name相同
		 * @param _useLocalXY 设置为true时，启用 container 中关节当前的位置关系而不是 ConnectionData中的配置关系 
		 */
		public function setup(_name:String, _animationID:String = null, _useLocalXY:Boolean = false):void {
			var _boneXMLList:XMLList = ConnectionData.getBones(_name);
			if (!_boneXMLList) {
				throw "can't find config xml in ConnectionData!";
				return;
			}
			name = _name;
			
			animation.setData(ConnectionData.getArmatureAniData(_animationID || _name));
			
			var _bone:Bone;
			var _joint:Object;
			var _jointParent:Object;
			var _jointHigher:Object;
			var _boneXML:XML;
			var _name:String;
			var _parentName:String;
			var _x:Number;
			var _y:Number;
			var _z:int;
			var _r:Number;
			var _len:Number;
			var _list:Array = [];
			var _length:uint = _boneXMLList.length();
			
			//按照link和parent优先索引排序boneList
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_boneXML = _boneXMLList[_i];
				_name = String(_boneXML.@name);
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
					_parentName = String(_boneXML.@parent);
					
					addJoint(_joint, _name, _parentName, _z);
					
					_bone = getBone(_name);
					if (_useLocalXY && _parentName) {
						_jointParent = joints[_parentName] || container.getChildByName(_parentName);
						
						_x = _joint.x - _jointParent.x;
						_y = _joint.y - _jointParent.y;
						_r = Math.atan2(_y, _x) - _jointParent.rotation * Math.PI / 180;
						_len = Math.sqrt(_x * _x + _y * _y);
						_x = _len * Math.cos(_r);
						_y = _len * Math.sin(_r);
					}else {
						_x = Number(_boneXML.@x);
						_y = Number(_boneXML.@y);
					}
					_bone.setLockPosition(_x, _y, 0);
				}
			}
		}
		
		/**
		 * 更新步进
		 */
		public function update():void {
			//bonelist包含bone的优先顺序
			var _len:uint = boneList.length;
			var _bone:Bone;
			for (var _i:uint = 0; _i < _len; _i++ ) {
				_bone = boneList[_i];
				animation.updateTween(_bone.name);
				_bone.update();
			}
			animation.update();
		}
		
		/**
		 * 绑定显示关节
		 * @param _joint 显示关节
		 * @param _id 关节ID
		 * @param _parentID 绑定到父骨骼的ID
		 * @param _index 绑定到深度，如果是替换原有关节，则使用原有关节的深度
		 * @example 例子绑定手臂到身体上
		 * <listing version="3.0">addJoint(new Sprite(), "arm", "body", -1)</listing >
		 */
		public function addJoint(_joint:Object, _id:String, _parentID:String = null, _index:int = -1):Object {
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
			_bone = Bone.create();
			_bone.joint = _joint;
			_bone.name = _id;
			_bone.isRadian = isRadian;
			
			animation.addTween(_bone);
			
			boneList[boneList.length] = _bone;
			bones[_id] = _bone;
			
			var _boneParent:Bone = getBone(_parentID);
			if (_boneParent) {
				_boneParent.addChild(_bone);
			}
			if (_index < 0) {
				container.addChild(_joint);
			}else {
				container.addChildAt(_joint, _index);
			}
			return _joint;
		}
		
		public function removeJoint(_id:String):Object {
			var _bone:Bone = bones[_id];
			animation.removeTween(_bone);
			_bone.remove();
			Bone.recycle(_bone);
			
			var _joint:Object = joints[_id];
			if (_joint) {
				delete joints[_id];
				container.removeChild(_joint);
				return _joint;
			}
			return null
		}
		
		/**
		 * 获取显示关节容器
		 */
		public function getContainer():Object {
			return container;
		}
		
		public function getBone(_id:String):Bone {
			return bones[_id];
		}
		
		public function getJoint(_id:String):Object {
			return joints[_id];
		}
		
	}
}