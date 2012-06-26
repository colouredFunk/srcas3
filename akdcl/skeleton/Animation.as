package akdcl.skeleton{
	
	/**
	 * 管理tween
	 * @author Akdcl
	 */
	final public class Animation extends ProcessBase {
		public static const START:String = "start";
		public static const COMPLETE:String = "complete";
		public static const LOOP_COMPLETE:String = "loopComplete";
		public static const IN_FRAME:String = "inFrame";
		
		public var onAnimation:Function;
		
		private var armatureAniData:ArmatureAniData;
		private var boneAniData:Object;
		private var tweens:Object;
		private var aniIDNow:String;
		
		public function Animation() {
			tweens = { };
		}
		
		override public function reset():void {
			super.reset();
			for each(var _tween:Tween in tweens) {
				Tween.recycle(_tween);
			}
			armatureAniData = null;
			boneAniData = null;
			aniIDNow = null;
			tweens = { };
		}
		
		override public function remove():void {
			super.remove();
			for each(var _tween:Tween in tweens) {
				_tween.remove();
			}
			
			armatureAniData = null;
			boneAniData = null;
			aniIDNow = null;
			tweens = null;
		}
		
		public function setData(_aniData:ArmatureAniData):void {
			reset();
			armatureAniData = _aniData;
		}
		
		public function addTween(_bone:Bone):void {
			var _boneID:String = _bone.name;
			var _tween:Tween = tweens[_boneID];
			if (!_tween) {
				tweens[_boneID] = _tween = Tween.create();
			}
			_tween.setNode(_bone.tweenNode);
		}
		
		public function removeTween(_bone:Bone):void {
			var _boneID:String = _bone.name;
			var _tween:Tween = tweens[_boneID];
			if (_tween) {
				delete tweens[_boneID];
				Tween.recycle(_tween);
			}
		}
		
		public function getTween(_boneID:String):Tween {
			return tweens[_boneID];
		}
		
		override public function playTo(_to:Object, _listFrame:uint, _toScale:Number = 1, _loop:Boolean = false, _ease:int = 0):void {
			super.playTo(_to, _listFrame, _toScale, _loop, _ease);
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
					_tween.playTo(_eachA, _listFrame, _toScale, _loop, _ease);
				}
			}
			noScaleListFrames = boneAniData.totalFrames;
			
			if (noScaleListFrames == 1) {
				//普通过渡
				loop = -4;
			}else {
				if (_loop) {
					//循环过渡
					loop = -2;
				}else {
					//列表过渡
					loop = -3;
					noScaleListFrames --;
				}
				listFrames = _listFrame;
			}
		}
		
		override protected function updateHandler():void {
			if (currentPrecent >= 1) {
				switch(loop) {
					case -3:
						//列表过渡
						loop = -1;
						currentPrecent = (currentPrecent - 1) * totalFrames / listFrames;
						if (currentPrecent >= 1) {
							//
						}else {
							currentPrecent %= 1;
							totalFrames = listFrames;
							listEndFrame = 0;
							if (onAnimation!=null) {
								onAnimation(START, aniIDNow);
							}
							break;
						}
					case -1:
					case -4:
						currentPrecent = 1;
						isComplete = true;
						if (onAnimation!=null) {
							onAnimation(COMPLETE, aniIDNow);
						}
						break;
					case -2:
						//循环开始
						loop = 0;
						currentPrecent %= 1;
						totalFrames = listFrames;
						listEndFrame = 0;
						if (onAnimation!=null) {
							onAnimation(START, aniIDNow);
						}
						break;
					default:
						//继续循环
						loop += int(currentPrecent);
						currentPrecent %= 1;
						if (onAnimation != null) {
							onAnimation(LOOP_COMPLETE, aniIDNow);
						}
						break;
				}
			}
			
			if (loop >= -1 && boneAniData.list) {
				//多关键帧动画过程
				updateCurrentPrecent();
			}
		}
		
		private function updateCurrentPrecent():void {
			var _playedFrames:Number = noScaleListFrames * currentPrecent;
			if (_playedFrames <= listEndFrame-betweenFrame || _playedFrames > listEndFrame) {
				toFrameID = 0;
				listEndFrame = 0;
				
				var _prevFrameID:int;
				do {
					betweenFrame = boneAniData.list[toFrameID].totalFrames;
					listEndFrame += betweenFrame;
					_prevFrameID = toFrameID;
					if (++toFrameID>=boneAniData.list.length) {
						toFrameID = 0;
					}
				}while (_playedFrames >= listEndFrame);
				
				if (onAnimation != null) {
					onAnimation(IN_FRAME, aniIDNow, boneAniData.list[_prevFrameID].name);
				}
			}
			
			currentPrecent = 1 - (listEndFrame - _playedFrames) / betweenFrame;
		}
		
		public function updateTween(_boneName:String):void {
			var _tween:Tween = tweens[_boneName];
			if (_tween) {
				_tween.update();
			}
		}
		
		override public function pause():void {
			super.pause();
			for each(var _tween:Tween in tweens) {
				_tween.pause();
			}
		}
		
		override public function resume():void 	{
			super.resume();
			for each(var _tween:Tween in tweens) {
				_tween.resume();
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