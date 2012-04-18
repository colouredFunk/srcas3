package akdcl.silhouette
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class Animation {
		public var name:String;
		public var joint:Object;
		
		public var value:FrameValue;
		public var offset:FrameValue;
		
		private var from:FrameValue;
		private var to:FrameValue;
		
		private var list:Array;
		
		private var currentFrame:Number;
		private var totalFrames:uint;
		private var listFrames:uint;
		
		private var betweenFrames:uint;
		private var playedFrames:uint;
		private var realListFrames:uint;
		private var frameID:int;
		
		private var loop:int;
		
		private var complete:Boolean;
		
		public function Animation(_name:String) {
			name = _name;
			value = new FrameValue();
			offset = new FrameValue();
			from = new FrameValue();
			to = new FrameValue();
		}
		
		public function playTo(_to:Object, _toFrame:uint, _listFrame:uint = 0, _isLoop:Boolean = false ):void {
			complete = false;
			totalFrames = _toFrame;
			currentFrame = 0;
			from.copy(value);
			
			if (_to is FrameValue) {
				list = null;
				to.copy(_to as FrameValue);
				//普通过渡
				loop = -4;
			}else {
				list = _to as Array;
				to.copy(list[0]);
				
				listFrames = _listFrame;
				realListFrames = 0;
				for each(var _fV:FrameValue in list) {
					realListFrames += _fV.frame;
				}
				if (_isLoop) {
					//过渡到循环
					loop = -2;
				}else {
					//过渡到列表
					loop = -3;
				}
			}
		}
		
		public function update():void {
			if (complete) {
				return;
			}
			currentFrame += 1;
			
			var _k:Number = currentFrame / totalFrames;
			
			if (loop >= 0) {
				_k = (1 - Math.cos(Math.PI * _k)) * 0.5;
			}
			if (_k > 1) {
				_k = 1;
			}
			
			if (loop >= -1) {
				//列表处理k值
				var _playedFrames:Number = realListFrames * _k;
				if (playedFrames == int(_playedFrames)) {
					from.copy(to);
					if (loop > 0 && (loop & 1)) {
						if (frameID-- > 0) {
							to.copy(list[frameID]);
							betweenFrames = to.frame;
							playedFrames += betweenFrames;
						}else {
							
						}
					}else {
						if (++frameID < list.length) {
							to.copy(list[frameID]);
							betweenFrames = from.frame;
							playedFrames += betweenFrames;
						}else {
							
						}
					}
				}
				_k = 1 - (playedFrames - _playedFrames ) / betweenFrames;
			}
			
			value.betweenValue(from, to, _k);
			
			if (joint) {
				joint.x = value.x + offset.x;
				joint.y = value.y + offset.y;
				joint.rotation = value.rotation + offset.rotation;
			}
			
			if (_k == 1) {
				//tween complete
				if (loop == -3) {
					//列表过渡
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					frameID = 0;
					
					loop = -1;
				}else if (loop == -2) {
					//循环开始
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					frameID = 0;
					
					loop = 0;
				}else if (loop >= 0) {
					//继续循环
					currentFrame = 0;
					playedFrames = 0;
					frameID = (loop & 1)?0:list.length - 1;
					
					loop ++;
				}else {
					complete = true;
				}
			}
		}
	}
	
}