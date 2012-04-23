package akdcl.skeleton
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Contour extends MovieClip {
		public var xml:XML;
		private var values:Object;
		public function Contour() {
			reset();
		}
		
		public function getName():String {
			return xml.name();
		}
		
		public function setValue(_id:String, _key:String, _v:*):void {
			var _value:Object = values[_id];
			if (!_value) {
				_value = values[_id] = { };
			}
			_value[_key] = _v;
		}
		public function getValue(_id:String, _key:String):* {
			var _value:Object = values[_id];
			if (_value) {
				return _value[_key];
			}
			return false;
		}
		
		public function reset():void {
			values = { };
			gotoAndStop(1);
		}
		
		public function remove():void {
			stop();
			xml = null;
			if (parent) {
				parent.removeChild(this);
			}
		}
		
		public function clearValues():void {
			values = { };
		}
	}
	
}