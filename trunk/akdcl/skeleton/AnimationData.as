package akdcl.skeleton{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class AnimationData {
		private var animations:Object;
		public function AnimationData() {
			animations = { };
		}
		public function addAnimation(_animation:Object, _animationName:String, _boneName:String):void {
			var _boneAnimations:Object = animations[_animationName];
			if (!_boneAnimations) {
				animations[_animationName] = _boneAnimations = { };
			}
			_boneAnimations[_boneName] = _animation;
		}
		
		public function getAnimation(_animationName:String, _boneName:String = null):Object {
			var _boneAnimations:Object = animations[_animationName];
			if (_boneName) {
				return _boneAnimations?_boneAnimations[_boneName]:null;
			}else {
				return _boneAnimations;
			}
		}
	}
}