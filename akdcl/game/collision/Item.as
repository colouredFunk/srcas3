package akdcl.game.collision
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Item
	{
		private static const total:uint = 99;
		public function Item(_type:uint, _value:uint) {
		__type = _type;
		__value = _value;
		}
		private var __remain:uint = 1;
		public function get remain():uint{
			return __remain;
		}
		public function set remain(_remain:uint):void {
			if (_remain<0) {
				_remain = 0;
			}else if(_remain>total) {
				_remain = total;
			}
			__remain = _remain;
		}
		private var __type:uint;
		public function get type():uint{
			return __type;
		}
		private var __value:uint;
		public function get value():uint{
			return __value;
		}
		public function isSame(_type:uint, _value:uint):Boolean {
			return value == _value && type == _type;
		}
		public function toString():String {
			return "Item_" + type + "_" + value + "_" + remain;
		}
	}
	
}