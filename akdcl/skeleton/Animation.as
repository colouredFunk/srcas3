package akdcl.skeleton{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class Animation extends ProcessBase {
		public static const START:String = "start";
		public static const COMPLETE:String = "complete";
		public static const LOOP_COMPLETE:String = "loopComplete";
		public static const IN_FRAME:String = "inFrame";
		
		public var onAnimation:Function;
		
		private var armatureAniData:ArmatureAniData;
		private var boneAniData
		private var tweens:Object;
		private var aniIDNow:String;
		
		public function Animation() {
			tweens = { };
		}
		
		public function setData(_aniData:ArmatureAniData):void {
			armatureAniData = _aniData;
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
			boneAniData = armatureAniData.getAnimation(_to as String);
			if (!boneAniData) {
				return;
			}
			aniIDNow = _to as String;
			var _eachA:Object;
			var _tween:Tween;
			for (var _boneName:String in tweens) {
				_tween = tweens[_boneName];
				_eachA = boneAniData[_boneName];
				if (_eachA) {
					_tween.playTo(_eachA, _listFrame, _toScale, _loopType, _ease);
				}
			}
			noScaleListFrames = boneAniData.totalFrames;
			
			if (noScaleListFrames == 1) {
				//普通过渡
				loop = -4;
			}else {
				if (_loopType == 0) {
					//列表过渡
					loop = -3;
					noScaleListFrames --;
				}else {
					//循环过渡
					loop = -2;
					if (_loopType < 0) {
						yoyo = true;
						noScaleListFrames--;
					}else {
						yoyo = false;
					}
				}
				listFrames = _listFrame;
			}
		}
		
		override public function update():void {
			if (isComplete || isPause) {
				return;
			}
			super.update();
			
			if (loop >= -1 && boneAniData.list) {
				var _kD:Number;
				//多关键帧动画过程
				var _prevFrameID:int;
				var _playedFrames:Number = noScaleListFrames * currentPrecent;
				
				if (_playedFrames >= playedFrames) {
					//到达新的关键点
					if (loop > 0 && (loop & 1)) {
						do {
							betweenFrames = boneAniData.list[toFrameID].totalFrames;
							playedFrames += betweenFrames;
							_prevFrameID = toFrameID;
							if (--toFrameID<0) {
								toFrameID = boneAniData.list.length - 1;
							}
						}while (_playedFrames >= playedFrames);
					}else {
						do {
							betweenFrames = boneAniData.list[toFrameID].totalFrames;
							playedFrames += betweenFrames;
							_prevFrameID = toFrameID;
							if (++toFrameID>=boneAniData.list.length) {
								toFrameID = 0;
							}
						}while (_playedFrames >= playedFrames);
					}
					if (_playedFrames > 0) {
						if (onAnimation!=null) {
							onAnimation(IN_FRAME, aniIDNow, boneAniData.list[_playedFrames].name);
						}
					}
				}
				_kD = 1 - (playedFrames - _playedFrames)/betweenFrames;
				if (_kD > 1) {
					_kD = 1;
				}
			}
			
			if (currentPrecent == 1) {
				if (loop == -3) {
					//列表过渡
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = -1;
					toFrameID = 0;
					if (onAnimation!=null) {
						onAnimation(START, aniIDNow);
					}
				}else if (loop == -2) {
					//循环开始
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = 0;
					toFrameID = 0;
					if (onAnimation!=null) {
						onAnimation(START, aniIDNow);
					}
				}else if (loop >= 0) {
					//继续循环
					currentFrame = 0;
					playedFrames = 0;
					if (yoyo) {
						loop ++;
					}
					toFrameID = (loop & 1)?boneAniData.list.length - 1:0;
					if (onAnimation!=null) {
						onAnimation(LOOP_COMPLETE, aniIDNow);
					}
				}else {
					//complete
					isComplete = true;
					if (onAnimation!=null) {
						onAnimation(COMPLETE, aniIDNow);
					}
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