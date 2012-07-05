package akdcl.skeleton {
	import akdcl.textures.TextureMix;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	
	/**
	 * 骨架
	 * @author Akdcl
	 */
	public class StarlingCommand {
		/**
		 * 从ConnectionData数据设置骨骼
		 * @param _name 根据此值在 ConnectionData 中查找对应骨骼配置
		 * @param _animationID 根据此值在 ConnectionData 中查找对应的动画配置，不设置则默认和_name相同
		 * @param _useLocalXY 设置为true时，启用 display 中关节当前的位置关系而不是 ConnectionData中的配置关系 
		 */
		public static function createArmature(_name:String, _animationName:String, _textureMix:TextureMix, _isRadian:Boolean = false, _useLocalXY:Boolean = false):Armature {
			var _armatureData:XMLList = ConnectionData.getArmatureData(_name);
			if(!_armatureData){
				return null;
			}
			var _armatureDisplay:Object = new Sprite();
			_armatureDisplay.name = _name;
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
			var _length:uint = _armatureData.length();

			for(var indexI:uint = 0; indexI < _length; indexI++){
				_boneData = _armatureData[indexI];
				_boneName = String(_boneData.@name);
				_parentName = String(_boneData.@parent);
				_indexZ = int(_boneData.@z);
				
				_boneDisplay = getTextureDisplay(_textureMix, _name + "_" + _boneName);
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
				_bone = _armature.addBone(_boneName, _boneDisplay, _parentName, _indexZ);
				_bone.setLockPosition(Number(_boneData.@x), Number(_boneData.@y), 0);
			}
			return _armature;
		}
		
		public static function getTextureDisplay(_textureMix:TextureMix, _fullName:String):Image {
			var _texture:XML = _textureMix.getTexture(_fullName);
			if (_texture) {
				var _rect:Rectangle = new Rectangle(int(_texture.@x), int(_texture.@y), int(_texture.@width), int(_texture.@height));
				var _img:Image = new Image(new SubTexture(_textureMix.texture as Texture, _rect));
				_img.pivotX = -int(_texture.@frameX);
				_img.pivotY = -int(_texture.@frameY);
				return _img;
			}
			return null;
		}
	}
}