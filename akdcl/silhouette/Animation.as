package akdcl.silhouette
{
	import akdcl.utils.localToLocal;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class Animation {
		public var name:String;
		public var joint:Object;
		
		public var value:FrameValue;
		public var offset:FrameValue;
		public var parent:Animation;
		
		private var from:FrameValue;
		private var to:FrameValue;
		
		private var list:FrameList;
		private var children:Dictionary;
		
		private var currentFrame:Number;
		private var totalFrames:uint;
		private var listFrames:uint;
		
		private var betweenFrames:uint;
		private var playedFrames:uint;
		private var realListFrames:uint;
		private var frameID:int;
		
		private var loop:int;
		private var yoyo:Boolean;
		
		private var complete:Boolean;
		private var listComplete:Boolean;
		
		public function Animation(_name:String) {
			name = _name;
			value = new FrameValue();
			offset = new FrameValue();
			from = new FrameValue();
			to = new FrameValue();
		}
		
		//_loopType==0:noLoop, _loopType<0:loop, _loopType>0:loopAndYoyo;
		public function playTo(_to:Object, _toFrame:int, _listFrame:uint = 0, _loopType:int = 0 ):void {
			complete = false;
			currentFrame = 0;
			from.copy(value);
			
			if (_to is FrameValue) {
				totalFrames = _toFrame;
				list = null;
				to.copy(_to as FrameValue);
				//普通过渡
				loop = -4;
			}else {
				list = _to as FrameList;
				to.copy(list.getValue(0));
				if (_loopType==0) {
					//过渡到列表
					realListFrames = list.totalFrames - 1;
					loop = -3;
				}else {
					//过渡到循环
					loop = -2;
					if (_loopType >= 0) {
						yoyo = true;
						realListFrames = list.totalFrames-1;
					}else {
						yoyo = false;
						realListFrames = list.totalFrames;
					}
				}
				_listFrame *= list.scale;
				listFrames = _listFrame < realListFrames?realListFrames:_listFrame;
				totalFrames = _toFrame + listFrames * list.delay;
			}
		}
		
		public function update():void {
			if (complete) {
				return;
			}
			currentFrame += 1;
			
			var _k:Number = currentFrame / totalFrames;
			var _k2:Number;
			
			if (_k > 1) {
				_k = 1;
			}
			if (loop >= -1) {
				if (listComplete) {
				}else {
					var _playedFrames:Number = realListFrames * _k;
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
								loop == -1 && (listComplete = true);
							}
							if (!listComplete) {
								to.copy(list.getValue(frameID));
								betweenFrames = from.frame;
								playedFrames += betweenFrames;
							}
						}
					}
					_k2 = 1 - (playedFrames - _playedFrames ) / betweenFrames;
					if (loop >= 0 && (yoyo || list.length == 2)) {
						_k2 = 0.5 * (1 - Math.cos(Math.PI * _k2));
					}
					if (_k2 > 1) {
						_k2 = 1;
					}
					value.betweenValue(from, to, _k2);
				}
			}else {
				value.betweenValue(from, to, _k);
			}
			
			updateJoint();
			
			if (_k == 1) {
				//tween complete
				if (loop == -3) {
					//列表过渡
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = -1;
					frameID = 0;
					listComplete = false;
				}else if (loop == -2) {
					//循环开始
					totalFrames = listFrames;
					currentFrame = 0;
					playedFrames = 0;
					loop = 0;
					frameID = 0;
					listComplete = false;
				}else if (loop >= 0) {
					//继续循环
					currentFrame = 0;
					playedFrames = 0;
					if (yoyo) {
						loop ++;
					}
					frameID = (loop & 1)?list.length - 1:0;
					to.copy(list.getValue(frameID));
					listComplete = false;
				}else {
					complete = true;
				}
			}
		}
		
		private function updateJoint():void {
			joint.x = value.x + offset.x;
			joint.y = value.y + offset.y;
			joint.rotation = value.rotation + offset.rotation;
			if (children) {
				var _point:Point;
				for (var _child:* in children) {
					_point = children[_child];
					_point = localToLocal(joint, _child.joint.parent, _point);
					_child.offset.x = _point.x;
					_child.offset.y = _point.y;
					//自动由于列表动画只有一个关键帧而停止更新的时候，需要父节点来驱动
					if (_child.complete) {
						_child.updateJoint();
					}
				}
			}
		}
		
		public function addChild(_child:Animation, _x:Number, _y:Number):void {
			if (!children) {
				children = new Dictionary();
			}
			children[_child] = new Point(_x, _y);
			_child.parent = this;
		}
	}
	
}