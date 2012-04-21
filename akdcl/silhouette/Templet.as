package akdcl.silhouette
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Templet extends MovieClip{
		public var xml:XML;
		public function Templet() {
			gotoAndStop(1);
		}
		
		public function getTempletName():String {
			return xml.name();
		}
		
		public function getJoint(_id:String):MovieClip {
			return getChildByName(_id) as MovieClip;
		}
		
		public function remove():void {
			stop();
			xml = null;
			if (parent) {
				parent.removeChild(this);
			}
		}
	}
	
}