package akdcl.silhouette
{
	/**
	 * ...
	 * @author akdcl
	 */
	public class FrameList
	{
		public var delay:Number = 0;
		public var scale:Number = 1;
		public var totalFrames:uint = 0;
		public var length:uint = 0;
		private var list:Vector.<FrameValue>;
		
		public function FrameList() {
			list = new Vector.<FrameValue>;
		}
		public function addValue(_value:FrameValue):void {
			list.push(_value);
			totalFrames += _value.frame;
			length++;
		}
		public function getValue(_id:int):FrameValue {
			return list[_id];
		}
	}
	
}