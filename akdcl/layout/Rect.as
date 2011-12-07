package akdcl.layout {
	import flash.events.Event;

	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author ...
	 */

	/// @eventType	flash.events.Event.RESIZE
	[Event(name="resize",type="flash.events.Event")]

	/// @eventType	flash.events.Event.SCROLL
	[Event(name="scroll",type="flash.events.Event")]
	public class Rect extends UIEventDispatcher {
		internal var isAverageWidth:Boolean;
		internal var isAverageHeight:Boolean;

		internal var __x:Number = 0;
		internal var __y:Number = 0;
		internal var __width:Number = 0;
		internal var __height:Number = 0;

		internal var percentWidth:Number = 0;
		internal var percentHeight:Number = 0;

		private var eventResize:Event;
		private var eventScroll:Event;

		public var autoUpdate:Boolean = true;

		public function get x():Number {
			return __x;
		}

		public function set x(_value:Number):void {
			if (__x == _value) {
				return;
			}
			__x = _value;
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function get y():Number {
			return __y;
		}

		public function set y(_value:Number):void {
			if (__y == _value) {
				return;
			}
			__y = _value;
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function get width():Number {
			return __width;
		}

		public function set width(_value:Number):void {
			if (__width == _value) {
				return;
			}
			__width = _value;
			if (autoUpdate){
				updateSize(true);
			}
		}

		public function get height():Number {
			return __height;
		}

		public function set height(_value:Number):void {
			if (__height == _value) {
				return;
			}
			__height = _value;
			if (autoUpdate){
				updateSize(true);
			}
		}

		public function Rect(_x:Number, _y:Number, _width:Number, _height:Number):void {
			__x = _x;
			__y = _y;
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
			isAverageWidth = !Boolean(__width);
			isAverageHeight = !Boolean(__height);
			eventResize = new Event(Event.RESIZE);
			eventScroll = new Event(Event.SCROLL);
			super();
		}

		public function setPoint(_x:Number, _y:Number):void {
			if (__x == _x && __y == _y) {
				return;
			}
			__x = _x;
			__y = _y;
			updatePoint(true);
		}

		public function setSize(_width:Number, _height:Number):void {
			if (__width == _width && __height == _height) {
				return;
			}
			__width = _width;
			__height = _height;
			updateSize(true);
		}

		override public function remove():void {
			super.remove();
			eventResize = null;
		}

		protected function updatePoint(_dispathEvent:Boolean = true):void {
			if (_dispathEvent && hasEventListener(Event.SCROLL)){
				dispatchEvent(eventScroll);
			}
		}

		protected function updateSize(_dispathEvent:Boolean = true):void {
			if (_dispathEvent && hasEventListener(Event.RESIZE)){
				dispatchEvent(eventResize);
			}
		}

		public function update():void {
			updatePoint();
			updateSize();
		}

		override public function toString():String {
			var _str:String = "";
			_str += "x:" + x + ", ";
			_str += "y:" + y + ", ";
			_str += "width:" + width + ", ";
			_str += "height:" + height + "\n";
			return _str;
		}
	}

}