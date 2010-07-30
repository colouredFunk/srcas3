package 
{
	import ui_2.Btn;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Btn_pt extends Btn
	{
		public var onXYChange:Function;
		public var lineClip:*;
		override public function get x():Number { return super.x; }
		
		override public function set x(value:Number):void 
		{
			super.x = value;
			if (onXYChange!=null) {
				onXYChange(x, y);
			}
		}
		override public function get y():Number { return super.y; }
		
		override public function set y(value:Number):void 
		{
			super.y = value;
			if (onXYChange!=null) {
				onXYChange(x, y);
			}
		}
	}
	
}