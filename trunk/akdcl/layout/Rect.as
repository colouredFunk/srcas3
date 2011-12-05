package akdcl.layout {

	/**
	 * ...
	 * @author ...
	 */
	public class Rect {
		public var userData:Object;
		internal var parent:Rect;
		internal var isAverageWidth:Boolean;
		internal var isAverageHeight:Boolean;

		internal var __x:Number = 0;
		internal var __y:Number = 0;
		internal var __width:Number = 0;
		internal var __height:Number = 0;

		internal var percentWidth:Number = 0;
		internal var percentHeight:Number = 0;

		public function get x():Number {
			return __x;
		}

		public function set x(_value:Number):void {
			__x = _value;
			updatePoint();
		}

		public function get y():Number {
			return __y;
		}

		public function set y(_value:Number):void {
			__y = _value;
			updatePoint();
		}

		public function get width():Number {
			return __width;
		}

		public function set width(_value:Number):void {
			__width = _value;
			updateSize();
		}

		public function get height():Number {
			return __height;
		}

		public function set height(_value:Number):void {
			__height = _value;
			updateSize();
		}

		public function Rect(_x:Number, _y:Number, _width:Number, _height:Number):void {
			setPoint(_x, __y);
			setSize(_width, _height);
			isAverageWidth = !Boolean(__width);
			isAverageHeight = !Boolean(__height);
		}

		public function setPoint(_x:Number, _y:Number):void {
			__x = _x;
			__y = _y;
			updatePoint();
		}

		public function setSize(_width:Number, _height:Number):void {
			if (_width > 1){
				__width = _width;
			} else {
				percentWidth = _width;
			}

			if (_height > 1){
				__height = _height;
			} else {
				percentHeight = _height;
			}
			updateSize();
		}
		
		public function remove():void {
			parent = null;
		}

		protected function updatePoint():void {

		}

		protected function updateSize():void {

		}

		public function toString():String {
			var _str:String = "";
			_str += "x:" + x + ", ";
			_str += "y:" + y + ", ";
			_str += "width:" + width + ", ";
			_str += "height:" + height + "\n";
			return _str;
		}
	}

}