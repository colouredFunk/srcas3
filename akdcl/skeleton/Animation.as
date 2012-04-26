package akdcl.skeleton{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class Animation extends ProcessBase {
		/**
		 * 动画播放事件回调函数
		 * 参数1：animationID 动画ID，
		 * 参数2：boneID 骨骼ID，
		 * 参数3：typeID 状态标识(0:动画完毕/1:列表动画开始/2:列表动画关键帧位置到达)，
		 * 参数4：frameID 关键帧标识(当typeID为2时有效)。
		 */
		public var animationCallBack:Function;
		
		private var animationData:ArmatureAniData;
		private var tweens:Object;
		
		public function Animation() {
			tweens = { };
		}
		
		public function setData(_aniData:ArmatureAniData):void {
			animationData = _aniData;
		}
		
		public function addTween(_bone:Bone):void {
			var _tween:Tween = tweens[_bone.name];
			if (!_tween) {
				tweens[_bone.name] = _tween = new Tween();
			}
			_tween.node = _bone.tweenNode;
		}
		
		public function getTween(_boneName:String):Tween {
			return tweens[_boneName];
		}
		
		override public function playTo(_to:Object, _listFrame:uint, _toScale:Number = 1, _loopType:int = 0, _ease:int = 0):void {
			super.playTo(_to, _listFrame, _toScale, _loopType, _ease);
			var _boneAnimations:Object = animationData.getAnimation(_to as String);
			if (!_boneAnimations) {
				return;
			}
			var _eachA:Object;
			var _tween:Tween;
			for (var _i:String in tweens) {
				_tween = tweens[_i];
				_eachA = _boneAnimations[_i];
				if (_eachA) {
					_tween.playTo(_eachA, _listFrame, _toScale, _loopType, _ease);
				}
			}
		}
		
		public function updateTween(_boneName:String):void {
			var _tween:Tween = tweens[_boneName];
			if (_tween) {
				_tween.update();
			}
		}
		
		override public function pause(_bause:Boolean = true):void {
			super.pause(_bause);
			for each(var _tween:Tween in tweens) {
				_tween.pause(_bause);
			}
		}
		
		override public function stop():void {
			super.stop();
			for each(var _tween:Tween in tweens) {
				_tween.stop();
			}
		}
		
		/**
		 * 对骨骼动画的速度进行缩放
		 * @param _scale 缩放值做为系数乘到原来的动画帧值
		 * @param _boneName 指定的骨骼ID，默认为所有骨骼
		 * @example 例子让ID为"body"的骨骼的动画播放变慢为原来的0.5
		 * <listing version="3.0">setAnimationScale(0.5, "body");</listing >
		 */
		public function setAnimationScale(_scale:Number, _boneName:String = null):void {
			var _tween:Tween;
			if (_boneName) {
				_tween = tweens[_boneName];
				if (_tween) {
					_tween.scale = _scale;
				}
			}else {
				scale = _scale;
				for each(_tween in tweens) {
					_tween.scale = _scale;
				}
			}
		}
	}
	
}