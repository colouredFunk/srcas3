package akdcl.skeleton
{
	/**
	 * ...
	 * @author akdcl
	 */
	final public class FrameList{
		public var delay:Number;
		public var scale:Number;
		public var totalFrames:uint;
		public var length:uint;
		private var list:Vector.<Frame>;
		
		public function FrameList(_delay:Number = 0, _scale:Number = 1) {
			delay = _delay;
			scale = _scale;
			totalFrames = 0;
			length = 0;
			
			list = new Vector.<Frame>;
		}
		
		public function addValue(_value:Frame):void {
			list.push(_value);
			totalFrames += _value.frame;
			length++;
		}
		
		public function getValue(_id:int):Frame {
			if (_id<0) {
				_id = length - 1;
			}
			return list[_id];
		}
	}
	
}