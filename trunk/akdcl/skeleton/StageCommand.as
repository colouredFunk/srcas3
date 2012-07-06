package akdcl.skeleton {
	
	/**
	 * 骨架
	 * @author Akdcl
	 */
	final public class StageCommand {
		public static var armatureFactory:Function;
		public static function createArmature(_name:String, _animationName:String, _armarureDisplayFactory:* = null, _boneDisplayFactory:Function = null, _isRadian:Boolean = false):Armature {
			var _armatureData:XMLList = ConnectionData.getArmatureData(_name);
			if(!_armatureData){
				return null;
			}
			var _armatureDisplay:Object;
			
			if (_armarureDisplayFactory != null) {
				if (_armatureDisplay is Function) {
					_armatureDisplay = _armarureDisplayFactory(_name);
				}else {
					_armatureDisplay = _armarureDisplayFactory;
				}
			}
			if (!_armatureDisplay) {
				return null;
			}
			_armatureDisplay.name = _name;
			
			var _armature:Armature;
			if (armatureFactory != null) {
				_armature = armatureFactory(_name, _animationName, _armatureDisplay) as Armature;
			}else {
				_armature = new Armature(_armatureDisplay, _isRadian);
			}
			
			var _animationData:* = ConnectionData.getAnimationData(_animationName);
			if (_animationData) {
				_armature.animation.setData(_animationData);
			}
			
			var _bone:Bone;
			var _boneData:XML;
			var _boneName:String;
			var _parentName:String;
			var _boneDisplay:Object;
			var _displayHigher:Object;
			var _indexZ:int;
			var _list:Array = [];
			var _length:uint = _armatureData.length();

			for(var indexI:uint = 0; indexI < _length; indexI++){
				_boneData = _armatureData[indexI];
				_boneName = String(_boneData.@name);
				_parentName = String(_boneData.@parent);
				_indexZ = int(_boneData.@z);
				
				
				if (_boneDisplayFactory != null) {
					_boneDisplay = _boneDisplayFactory(_name, _boneName);
				}else {
					_boneDisplay = _armature.getDisplay().getChildByName(_boneName);
				}
				
				if (_boneDisplay) {
					_displayHigher = null;
					for(var indexJ:uint = _indexZ; indexJ < _list.length; indexJ++){
						_displayHigher = _list[indexJ];
						if(_displayHigher){
							break;
						}
					}
					_list[_indexZ] = _boneDisplay;
					if(_displayHigher){
						_indexZ = _armature.getDisplay().getChildIndex(_displayHigher) - 1;
					}else{
						_indexZ = -1;
					}
				}
				_bone = _armature.addBone(_boneName, _parentName, _boneDisplay, _indexZ);
				_bone.setLockPosition(Number(_boneData.@x), Number(_boneData.@y), 0);
			}
			return _armature;
		}
	}
}