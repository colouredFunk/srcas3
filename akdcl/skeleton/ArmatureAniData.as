package akdcl.skeleton{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class ArmatureAniData {
		private var boneAniDataDic:Object;
		public function ArmatureAniData() {
			boneAniDataDic = { };
		}
		public function addAnimation(_boneAniData:BoneAniData, _animationName:String):void {
			boneAniDataDic[_animationName] = _boneAniData;
		}
		
		public function getAnimation(_animationName:String):BoneAniData {
			return boneAniDataDic[_animationName];
		}
	}
}