package akdcl.skeleton
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Armature {
		public var container:Object;
		//参数依次为：动画ID，骨骼ID，状态标识(0:动画完毕/1:列表动画开始/2:列表动画关键帧位置到达), 关键帧标识(当状态标识为2时有效)
		public var animationCallBack:Function;
		
		protected var animationData:Object;
		protected var joints:Object;
		protected var bones:Object;
		protected var boneList:Vector.<Bone>;
		
		public function Armature(_container:Object) {
			super();
			joints = { };
			bones = { };
			boneList = new Vector.<Bone>;
			
			container = _container;
		}
		
		public function setup(_id:String):void {
			animationData = ConnectionData.getAnimation(_id);
			var _boneXMLList:XMLList = ConnectionData.getBones(_id);
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
				
				_joint = joints[_name];
				if (!_joint) {
					_joint = _container.getChildByName(_name);
					if (_joint) {
						addJoint(_joint, _name);
					}else {
						continue;
					}
				}
				
				//
				_bone = new Bone(_name, _joint);
				_bone.animation.callBack = animationCallBack;
				boneList.push(_bone);
				bones[_name] = _bone;
				_boneParent = bones[_boneXML.@parent];
				if (_boneParent) {
					_boneParent.addChild(_bone, Number(_boneXML.@x), Number(_boneXML.@y));
				}
				
				//
				_z = int(_boneXML.@z);
				for (var _j:uint = _z; _j < _list.length; _j++) {
					_jointHigher = _list[_j];
					if (_jointHigher) {
						break;
					}
				}
				if (_jointHigher) {
					container.addChildAt(_joint, container.getChildIndex(_jointHigher) - 1);
				}else {
					container.addChild(_joint);
				}
				_list[_z] = _joint;
				_jointHigher = null;
			}
		}
		
		public function playTo(_frameLabel:String, _toFrame:uint, _listFrame:uint = 0, _loopType:int = 0, _ease:int = 0):void {
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
		
		public function setAnimationScale(_scale:Number, _id:String = null):void {
			var _bone:Bone;
			if (_id) {
				_bone = bones[_id];
				if (_bone) {
					_bone.animation.scale = _scale;
				}
			}else {
				for each(_bone in boneList) {
					_bone.animation.scale = _scale;
				}
			}
		}
		
		public function update():void {
			var _length:uint = boneList.length;
			for (var _i:uint = 0; _i < _length; _i++ ) {
				boneList[_i].update();
			}
		}
		
		public function addJoint(_joint:Object, _id:String, _parentID:String = null, _x:Number = 0, _y:Number = 0):void {
			
			if (joints[_id]) {
				//替换现有关节
				joints[_id] = _joint;
			}
			
			//
			var _bone:Bone;
			_bone = new Bone(_id, _joint);
			_bone.animation.callBack = animationCallBack;
			boneList.push(_bone);
			bones[_name] = _bone;
			var _boneParent:Bone = bones[_parentID];
			if (_boneParent) {
				_boneParent.addChild(_bone, _x, _y);
			}
		}
		
		public function getJoint(_id:String):Object {
			return joints[_id];
		}
	}
	
}