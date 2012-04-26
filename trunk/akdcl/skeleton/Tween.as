package akdcl.skeleton{
	
	/**
	 * 骨骼动画，处理关键帧数据后，输出到骨骼
	 * @author Akdcl
	 */
	public class Tween extends ProcessBase {
		private static const HALF_PI:Number = Math.PI * 0.5;
		
		/**
		 * @private
		 */
		public var node:TweenNode;
		
		private var from:FrameNode;
		private var to:FrameNode;
		private var list:FrameNodeList;
		
		/**
		 * 构造函数
		 */
		public function Tween() {
			super();
			from = new FrameNode();
			to = new FrameNode();
		}
		
		/**
		 * 控制动画播放
		 * @param _to 关键点Frame或FrameList
		 * @param _toFrame 过渡到该动画使用的帧数
		 * @param _listFrame FrameList列表动画所用的帧数
		 * @param _loopType FrameList动画播放方式，0：不循环，1：循环，-1：循环并自动反转
		 * @param _ease 缓动方式，0：线性，1：淡出，-1：淡入
		 */
		override public function playTo(_to:Object, _listFrame:uint, _toScale:Number = 1, _loopType:int = 0, _ease:int = 0):void {
			super.playTo(_to, _listFrame, _toScale, _loopType, _ease);
			from.copy(node);
			
			if (_to is FrameNode) {
				//普通过渡
				loop = -4;
				list = null;
				to.copy(_to as FrameNode);
			}else {
				list = _to as FrameNodeList;
				to.copy(list.getValue(0));
				if (_loopType == 0) {
					//列表过渡
					loop = -3;
					noScaleListFrames = list.totalFrames - 1;
				}else {
					//循环过渡
					loop = -2;
					noScaleListFrames = list.totalFrames;
					if (_loopType < 0) {
						yoyo = true;
						noScaleListFrames--;
					}else {
						yoyo = false;
					}
				}
				listFrames = _listFrame * list.scale;
				totalFrames += _listFrame * list.delay;
			}
			if (_ease == 0) {
				ease = 0;
			}else {
				ease = _ease > 0?1: -1;
			}
			node.betweenValue(from, to);
		}
		
		/**
		 * 更新步进
		 */
		override public function update():void {
			if (isComplete || isPause) {
				return;
			}
			super.update();
			
			if (loop < -1) {
				currentPrecent = Math.sin(currentPrecent * HALF_PI);
			}
			if (currentPrecent > 1) {
				currentPrecent = 1;
			}
			var _kD:Number;
			if (loop >= -1) {
				//多关键帧动画过程
				var _prevFrameID:int;
				var _playedFrames:Number = noScaleListFrames * currentPrecent;
				if (_playedFrames >= playedFrames) {
					//到达新的关键点
					if (loop > 0 && (loop & 1)) {
						do {
							betweenFrames = list.getValue(frameID).totalFrames;
							playedFrames += betweenFrames;
							_prevFrameID = frameID;
							if (--frameID<0) {
								frameID = list.length - 1;
							}
						}while (_playedFrames >= playedFrames);
					}else {
						do {
							betweenFrames = list.getValue(frameID).totalFrames;
							playedFrames += betweenFrames;
							_prevFrameID = frameID;
							if (++frameID>=list.length) {
								frameID = 0;
							}
						}while (_playedFrames >= playedFrames);
					}
					
					from.copy(list.getValue(_prevFrameID));
					to.copy(list.getValue(frameID));
					node.betweenValue(from, to);
				}
				var _t:Number = betweenFrames - (playedFrames - _playedFrames);
				var _d:Number = betweenFrames;
				
				_kD = _t/_d;
				if (ease == 2) {
					_kD = 0.5 * (1 - Math.cos(_t / _d * Math.PI ));
				}else if (ease != 0) {
					//_kD = ease < 0?((_t /= _d) * _t * _t):((_t = _t / _d - 1) * _t * _t + 1);
					_kD = ease > 0?Math.sin(_t/_d * HALF_PI):(1 - Math.cos(_t/_d * HALF_PI));
				}
				
				if (_kD > 1) {
					_kD = 1;
				}
			}else {
				//只有单独帧的动画过程
				_kD = currentPrecent;
			}
			node.tweenTo(_kD);
			
			if (currentPrecent == 1) {
				if (loop == -3) {
					//列表过渡
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = -1;
					frameID = 0;
				}else if (loop == -2) {
					//循环开始
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = 0;
					frameID = 0;
				}else if (loop >= 0) {
					//继续循环
					currentFrame = 0;
					playedFrames = 0;
					if (yoyo) {
						loop ++;
					}
					frameID = (loop & 1)?list.length - 1:0;
				}else {
					//complete
					isComplete = true;
				}
			}
		}
	}
}