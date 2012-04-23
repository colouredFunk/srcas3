package akdcl.skeleton{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class Animation {
		private static const HALF_PI:Number = Math.PI * 0.5;
		public var callBack:Function;
		public var scale:Number;
		public var frame:Frame;
		public var name:String;
		private var boneName:String;
		
		private var from:Frame;
		private var to:Frame;
		private var list:FrameList;
		private var currentFrame:Number;
		private var totalFrames:uint;
		private var listFrames:uint;
		private var yoyo:Boolean;
		
		private var loop:int;
		private var ease:int;
		private var frameID:int;
		private var betweenFrames:uint;
		private var playedFrames:uint;
		private var realListFrames:uint;
		
		private var complete:Boolean;
		
		public function Animation(_boneName:String) {
			scale = 1;
			boneName = _boneName;
			complete = true;
			from = new Frame();
			to = new Frame();
		}
		
		//_loopType==0:不循环, _loopType>0:循环, _loopType<0:循环并自动反转;
		//_ease==0:线性, _ease>0:淡入, _ease<0:淡出;
		public function playTo(_to:Object, _toFrame:uint, _listFrame:uint = 0, _loopType:int = 0, _ease:int = 0):void {
			complete = false;
			currentFrame = 0;
			from.copy(frame);
			
			if (_to is Frame) {
				//普通过渡
				loop = -4;
				list = null;
				to.copy(_to as Frame);
				totalFrames = _toFrame;
			}else {
				list = _to as FrameList;
				to.copy(list.getValue(0));
				if (_loopType==0) {
					//列表过渡
					loop = -3;
					realListFrames = list.totalFrames - 1;
				}else {
					//循环过渡
					loop = -2;
					realListFrames = list.totalFrames;
					if (_loopType < 0) {
						yoyo = true;
						realListFrames--;
					}else {
						yoyo = false;
					}
				}
				listFrames = _listFrame * list.scale;
				totalFrames = _toFrame + listFrames * list.delay;
			}
			if (_ease==0) {
				ease = 0;
			}else {
				ease = _ease > 0?1: -1;
			}
		}
		
		public function update():void {
			if (complete) {
				return;
			}
			currentFrame += scale;
			
			var _kAll:Number = currentFrame / totalFrames;
			if (ease != 0) {
				_kAll = ease > 0?Math.sin(_kAll * HALF_PI):(1 - Math.cos(_kAll * HALF_PI));
			}
			var _kList:Number;
			
			if (_kAll > 1) {
				_kAll = 1;
			}
			if (loop >= -1) {
				//多关键帧动画过程
				var _playedFrames:Number = realListFrames * _kAll;
				if (_playedFrames >= playedFrames) {
					//到达新的关键点
					from.copy(to);
					if (loop > 0 && (loop & 1)) {
						do {
							if (--frameID<0) {
								frameID = list.length - 1;
							}
							betweenFrames = list.getValue(frameID).frame;
							playedFrames += betweenFrames;
						}while (_playedFrames >= playedFrames);
					}else {
						do {
							if (++frameID>=list.length) {
								frameID = 0;
							}
							betweenFrames = list.getValue(frameID).frame;
							playedFrames += betweenFrames;
						}while (_playedFrames >= playedFrames);
					}
					to.copy(list.getValue(frameID));
					if (callBack!=null) {
						callBack(name, boneName, 2, frameID);
					}
				}
				_kList = 1 - (playedFrames - _playedFrames ) / betweenFrames;
				if (loop >= 0 && list.length == 2) {
					//只有两个关键帧的动画在循环的时候需要平滑
					_kList = 0.5 * (1 - Math.cos(Math.PI * _kList));
				}
				if (_kList > 1) {
					_kList = 1;
				}
				frame.betweenValue(from, to, _kList);
			}else {
				//只有单独帧的动画过程
				frame.betweenValue(from, to, _kAll);
			}
			
			if (_kAll == 1) {
				//tween complete
				if (loop == -3) {
					//列表过渡
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = -1;
					frameID = 0;
					if (callBack!=null) {
						callBack(name, boneName, 1);
					}
				}else if (loop == -2) {
					//循环开始
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = 0;
					frameID = 0;
					if (callBack!=null) {
						callBack(name, boneName, 1);
					}
				}else if (loop >= 0) {
					//继续循环
					currentFrame = 0;
					playedFrames = 0;
					if (yoyo) {
						loop ++;
					}
					frameID = (loop & 1)?list.length - 1:0;
					to.copy(list.getValue(frameID));
					if (callBack!=null) {
						callBack(name, boneName, 0);
					}
				}else {
					complete = true;
					if (callBack!=null) {
						callBack(name, boneName, 0);
					}
				}
			}
		}
	}
}