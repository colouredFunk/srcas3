package akdcl.skeleton
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Armature {
		protected var animationData:Object;
		protected var container:Object;
		protected var joints:Object;
		protected var bones:Object;
		protected var boneList:Vector.<Bone>;
		
		public function Armature(_container:Object) {
			super();
			joints = { };
			bones = { };
			boneList = new Vector.<Bone>;
			
			if (_container) {
				addJoints(_container);
			}
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
			var _parent:Object;
			var _boneXML:XML;
			var _name:String;
			var _z:int;
			var _list:Array = [];
			var _length:uint = _boneXMLList.length();
			
			//按照link和parent优先索引
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_boneXML = _boneXMLList[_i];
				_name = _boneXML.@name;
				_joint = joints[_name];
				if (!_joint) {
					continue;
				}
				
				_bone = new Bone(_name, _joint);
				_parent = joints[_boneXML.@parent];
				_boneParent = bones[_boneXML.@parent];
				if (_boneParent) {
					_boneParent.addChild(_bone, Number(_boneXML.@x), Number(_boneXML.@y));
				}
				
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
				
				//按照link和parent排序
				boneList.push(_bone);
				bones[_name] = _bone;
			}
		}
		
		public function playTo(_frameLabel:String, _toFrame:uint, _listFrame:uint = 0, _loopType:int = 0):void {
			var _data:Object = animationData[_frameLabel];
			var _eachD:Object;
			for each(var _bone:Bone in boneList) {
				_eachD = _data[_bone.name];
				if (_eachD) {
					_bone.animation.playTo(_eachD, _toFrame, _listFrame, _loopType);
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
		
		public function addJoints(_container:Object):void {
			var _id:String;
			var _joint:Object;
			for (var _i:uint = 0; _i < _container.numChildren; _i++) {
				_id = _container.getChildAt(_i).name;
				_joint = _container.getChildAt(_i);
				joints[_id] = _joint;
			}
			container = _container;
		}
	}
	
}