package akdcl.skeleton {
	
	/**
	 * 骨架
	 * @author Akdcl
	 */
	public class Armature {
		/**
		 * 从ConnectionData数据设置骨骼
		 * @param _name 根据此值在 ConnectionData 中查找对应骨骼配置
		 * @param _animationID 根据此值在 ConnectionData 中查找对应的动画配置，不设置则默认和_name相同
		 * @param _useLocalXY 设置为true时，启用 display 中关节当前的位置关系而不是 ConnectionData中的配置关系 
		 */
		public function create(_name:String, _armatureFactory:Function, _boneFactory:Function = null, _isRadian:Boolean = false, _useLocalXY:Boolean = false):Armature {
			var _armatureData:XMLList = ConnectionData.getArmatureData(_name);
			if(!_armatureData){
				return null;
			}
			var _armatureDisplay:Object = _armatureFactory(_name);
			var _armature:Armature = new Armature(_armatureDisplay, _isRadian);
			
			var _animationData:* = ConnectionData.getAnimationData(_name);
			if(_animationData){
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
			var _length:uint = _armatureData.length;

			for(var indexI:uint = 0; indexI < _length; indexI++){
				_boneData = _armatureData[indexI];
				_boneName = String(_boneData.@name);
				_parentName = String(_boneData.@parent);
				_indexZ = int(_boneData.@z);
				
				if (_boneFactory != null) {
					_boneDisplay = _boneFactory(_name, _boneName);
				}else {
					_boneDisplay = null;
				}
				
				if(_boneDisplay){
					_displayHigher = null;
					for(var indexJ:uint = _indexZ; indexJ < _list.length; indexJ++){
						_displayHigher = _list[indexJ];
						if(_displayHigher){
							break;
						}
					}
					_list[_indexZ] = _boneDisplay;
					if(_displayHigher){
						_indexZ = _armature.display.getChildIndex(_displayHigher) - 1;
					}else{
						_indexZ = -1;
					}
				}
				
				_bone = _armature.addBone(_boneName, _boneDisplay, _parentName, _indexZ);
				_bone.setLockPosition(_boneData.x, _boneData.y, 0);
			}
			return _armature;
			/*if (_useLocalXY && _parentName) {
				_jointParent = joints[_parentName] || display.getChildByName(_parentName);
				
				_x = _joint.x - _jointParent.x;
				_y = _joint.y - _jointParent.y;
				_r = Math.atan2(_y, _x) - _jointParent.rotation * Math.PI / 180;
				_len = Math.sqrt(_x * _x + _y * _y);
				_x = _len * Math.cos(_r);
				_y = _len * Math.sin(_r);
			}*/
		}
		
		
		public var name:String;
		public var animation:Animation;
		
		protected var isRadian:Boolean;
		protected var display:Object;
		protected var boneDic:Object;
		protected var boneList:Vector.<Bone>;
		
		/**
		 * 构造函数
		 * @param _display 包含所有骨骼显示对象的显示容器
		 * @param _isRadian 骨骼旋转角度是否采用弧度制，比如starling使用的是弧度制
		 */
		public function Armature(_display:Object, _isRadian:Boolean = false) {
			boneDic = { };
			boneList = new Vector.<Bone>;
			animation = new Animation();
			display = _display;
			isRadian = _isRadian;
		}
		
		/**
		 * 更新步进
		 */
		public function update():void {
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
		 * 删除
		 */
		public function remove():void {
			for each(var _bone:Bone in boneList) {
				_bone.remove();
			}
			
			animation.remove();
			animation = null;
			display = null;
			boneDic = null;
			boneList = null;
		}
		
		/**
		 * 绑定骨骼
		 * @param _name 骨骼名
		 * @param _display 骨骼的显示对象
		 * @param _parentID 绑定到父骨骼名
		 * @param _index 绑定到深度，如果是替换原有显示对象，则使用原显示对象的深度
		 */
		public function addBone(_name:String, _display:Object=null, _parentName:String = null, _index:int = -1):Bone {
			var _bone:Bone = boneDic[_name];
			if(!_bone){
				_bone = Bone.create();
				_bone.name = name;
				boneList.push(_bone);
				boneDic[name] = _bone;
				boneParent = boneDic[_parentName];
				if(boneParent){
					boneParent.addChild(_bone);
				}
				animation.addTween(_bone);
			}
			if(_display){
				if(_display.name != name){
					_display.name = name;
				}
				var _displayOld = _bone.display;
				_bone.display = _display;
				if(_displayOld){
					display.addChildAt(_display, display.getChildIndex(_displayOld) - 1);
				}else if(index < 0){
					display.addChild(_display);
				}else{
					display.addChildAt(_display, index);
				}
			}
			return _bone;
		}
		
		public function removeBone(_name:String):void {
			var _bone = boneDic[_name];
			if(_bone){
				if(_bone.display && display.contains(_bone.display)){
					display.removeChild(_bone.display);
				}
				animation.removeTween(_bone);
				_bone.remove();
			}
		}
		
		public function getBone(_name:String):Bone {
			return boneDic[_name];
		}
		
		/**
		 * 获取骨架显示对象
		 */
		public function getDisplay():Object {
			return display;
		}
	}
}