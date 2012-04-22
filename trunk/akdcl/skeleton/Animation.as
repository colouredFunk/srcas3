package akdcl.skeleton{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class Animation {
		public var scale:Number;
		public var frame:Frame;
		
		private var from:Frame;
		private var to:Frame;
		private var list:FrameList;
		private var currentFrame:Number;
		private var totalFrames:uint;
		private var listFrames:uint;
		private var yoyo:Boolean;
		
		private var loop:int;
		private var frameID:int;
		private var betweenFrames:uint;
		private var playedFrames:uint;
		private var realListFrames:uint;
		
		private var complete:Boolean;
		
		public function Animation() {
			scale = 1;
			complete = true;
			from = new Frame();
			to = new Frame();
		}
		
		//_loopType==0:noLoop, _loopType>0:loop, _loopType<0:loopAndYoyo;
		public function playTo(_to:Object, _toFrame:int, _listFrame:uint = 0, _loopType:int = 0 ):void {
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
				//listFrames = listFrames < realListFrames?realListFrames:listFrames;
				totalFrames = _toFrame + listFrames * list.delay;
			}
		}
		
		public function update():void {
			if (complete) {
				return;
			}
			currentFrame += scale;
			
			var _kAll:Number = currentFrame / totalFrames;
			
			//_kAll = Math.sin(_kAll * Math.PI * 0.5);
			//_kAll = 1 - Math.cos(_kAll * Math.PI * 0.5);
			//_kAll = 0.5 * (1 - Math.cos(Math.PI * _kAll));
			var _kList:Number;
			
			if (_kAll > 1) {
				_kAll = 1;
			}
			if (loop >= -1) {
				var _playedFrames:Number = realListFrames * _kAll;
				if (_playedFrames >= playedFrames) {
					from.copy(to);
					if (loop > 0 && (loop & 1)) {
						frameID--;
						if (frameID<0) {
							frameID = list.length - 1;
						}
						to.copy(list.getValue(frameID));
						betweenFrames = to.frame;
						playedFrames += betweenFrames;
					}else {
						frameID++;
						if (frameID>=list.length) {
							frameID = 0;
						}
						to.copy(list.getValue(frameID));
						betweenFrames = from.frame;
						playedFrames += betweenFrames;
					}
				}
				_kList = 1 - (playedFrames - _playedFrames ) / betweenFrames;
				if (loop >= 0 && list.length == 2) {
					_kList = 0.5 * (1 - Math.cos(Math.PI * _kList));
				}
				if (_kList > 1) {
					_kList = 1;
				}
				frame.betweenValue(from, to, _kList);
			}else {
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
					to.copy(list.getValue(frameID));
				}else {
					complete = true;
				}
			}
		}
	}
}