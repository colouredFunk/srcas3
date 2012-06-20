package akdcl.skeleton {
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ProcessBase {
		/**
		 * 动画缩放值，默认为1
		 */
		public var scale:Number;
		
		protected var isPause:Boolean;
		protected var isComplete:Boolean;
		
		/**
		 * @private
		 */
		protected var currentFrame:Number;
		protected var totalFrames:uint;
		protected var listFrames:uint;
		protected var yoyo:Boolean;
		protected var currentPrecent:Number;
		
		protected var loop:int;
		protected var ease:int;
		protected var toFrameID:int;
		protected var betweenFrames:uint;
		protected var playedFrames:uint;
		protected var noScaleListFrames:uint;
		
		public function ProcessBase() {
			scale = 1;
			isComplete = true;
			isPause = false;
			currentFrame = 0;
		}
		
		public function reset():void {
			scale = 1;
			isComplete = true;
			isPause = false;
			currentFrame = 0;
		}
		
		public function remove():void {
			
		}
		
		public function pause():void {
			isPause = true;
		}
		
		public function resume():void {
			isPause = false;
		}
		
		public function stop():void {
			isComplete = true;
			currentFrame = 0;
		}
		
		public function playTo(_to:Object, _listFrame:uint, _toScale:Number = 1, _loopType:int = 0, _ease:int = 0):void {
			isComplete = false;
			isPause = false;
			currentFrame = 0;
			ease = _ease;
			totalFrames = _listFrame * _toScale;
		}
		
		public function update():void {
			currentFrame += scale;
			currentPrecent = currentFrame / totalFrames;
			if (currentPrecent > 1) {
				currentPrecent = 1;
			}
		}
	}
	
}