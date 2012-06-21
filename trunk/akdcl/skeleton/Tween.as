package akdcl.skeleton{
	
	/**
	 * 骨骼动画，处理关键帧数据并渲染到骨骼
	 * @author Akdcl
	 */
	final public class Tween extends ProcessBase {
		private static const HALF_PI:Number = Math.PI * 0.5;
		
		private static var list:Vector.<Tween> = new Vector.<Tween>;
		public static function create():Tween {
			if (list.length > 0) {
				return list.pop();
			}
			return new Tween();
		}
		
		public static function recycle(_tween:Tween):void {
			_tween.reset();
			list.push(_tween);
		}
		
		/**
		 * Bone.TweenNode的引用
		 * @private
		 */
		private var from:FrameNode;
		private var to:FrameNode;
		private var node:TweenNode;
		private var list:FrameNodeList;
		
		/**
		 * 构造函数
		 */
		public function Tween() {
			super();
			from = new FrameNode();
			to = new FrameNode();
		}
		
		override public function reset():void {
			super.reset();
			node = null;
			list = null;
		}
		
		override public function remove():void {
			super.remove();
			node = null;
			list = null;
			from = null;
			to = null;
		}
		
		internal function setNode(_node:TweenNode):void {
			node = _node;
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
			node.betweenValue(from, to);
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
							break;
						}
					case -1:
					case -4:
						currentPrecent = 1;
						isComplete = true;
						break;
					case -2:
						//循环开始
						if (yoyo) {
							loop = int(currentPrecent) - 1;
						}else {
							loop = 0;
						}
						currentPrecent %= 1;
						totalFrames = listFrames;
						listEndFrame = 0;
						break;
					default:
						//继续循环
						if (yoyo) {
							loop += int(currentPrecent);
						}
						currentPrecent %= 1;
						break;
				}
			}else if (loop < -1) {
				//
				currentPrecent = Math.sin(currentPrecent * HALF_PI);
			}
			
			if (loop >= -1) {
				//多关键帧动画过程
				updateCurrentPrecent();
			}
			node.tweenTo(currentPrecent);
		}
		
		private function updateCurrentPrecent():void {
			var _playedFrames:Number = noScaleListFrames * currentPrecent;
			if (_playedFrames <= listEndFrame-betweenFrame || _playedFrames > listEndFrame) {
				toFrameID = 0;
				listEndFrame = 0;
				var _prevFrameID:int;
				if (loop > 0 && (loop & 1)) {
					do {
						betweenFrame = list.getValue(toFrameID).totalFrames;
						listEndFrame += betweenFrame;
						_prevFrameID = toFrameID;
						if (--toFrameID<0) {
							toFrameID = list.length - 1;
						}
					}while (_playedFrames >= listEndFrame);
				}else {
					do {
						betweenFrame = list.getValue(toFrameID).totalFrames;
						listEndFrame += betweenFrame;
						_prevFrameID = toFrameID;
						if (++toFrameID >= list.length) {
							toFrameID = 0;
						}
					}while (_playedFrames >= listEndFrame);
				}
				
				from.copy(list.getValue(_prevFrameID));
				to.copy(list.getValue(toFrameID));
				node.betweenValue(from, to);
			}
			
			currentPrecent = 1 - (listEndFrame - _playedFrames) / betweenFrame;
			if (ease == 2) {
				currentPrecent = 0.5 * (1 - Math.cos(currentPrecent * Math.PI ));
			}else if (ease != 0) {
				currentPrecent = ease > 0?Math.sin(currentPrecent * HALF_PI):(1 - Math.cos(currentPrecent * HALF_PI));
			}
		}
	}
}