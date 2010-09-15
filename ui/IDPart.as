package ui
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class IDPart
	{
		public var autoID:Boolean = true;
		public var onIDChange:Function;
		private var __length:uint;
		public function get length():uint{
			return __length;
		}
		public function set length(_length:uint):void{
			__length=_length;
		}
		private var __id:int;
		public function get id():int{
			return __id;
		}
		public function set id(_id:int):void {
			if (autoID) {
				_id %= length;
			}
			if (_id < 0) {
				if (autoID) {
					_id = length - _id;
				}else {
					return;
				}
			}else if (_id >= length) {
				if (autoID) {
					_id = _id - length;
				}else {
					return;
				}
			}
			if (__id==_id) {
				return;
			}
			__dir = _id - __id;
			__id = _id;
			if (onIDChange!=null) {
				onIDChange(__id);
			}
		}
		private var __dir:int;
		public function get dir():int {
			return __dir;
		}
		public function setID(_id:int):void {
			__dir = _id - __id;
			__id = _id;
			if (onIDChange!=null) {
				onIDChange(__id);
			}
		}
		public function remove():void {
			onIDChange = null;
		}
	}
	
}