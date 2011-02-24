package akdcl.net {

	import akdcl.utils.stringToBoolean;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class SubmitFields {
		public static var REQUIRED:String = "required";
		public static var KEY:String = "key";
		public static var REG:String = "reg";
		protected var sourceXML:XML;
		protected var __data:Object;

		//返回data的副本，所以请注意引用和使用的方式.
		public function get data():Object {
			var _data:Object = {};
			for (var _i:String in __data){
				_data[_i] = __data[_i];
			}
			return _data;
		}

		public function SubmitFields(_xml:XML = null){
			setSource(_xml);
		}

		public function setSource(_xml:XML):void {
			sourceXML = _xml;
			clear();
		}

		public function clear():void {
			for each (var _i:*in __data){
				delete __data[_i];
			}
			__data = {};
		}

		public function remove():void {
			clear();
			__data = null;
			sourceXML = null;
		}

		public function add(_key:String, _value:String):void {
			if (_value){
				__data[_key] = _value;
			}
		}

		public function addData(_data:Object):void {
			for (var _i:String in _data){
				add(_i, _data[_i]);
			}
		}

		public function isAllComplete():* {
			var _key:String;
			for each (var _xml:XML in sourceXML.children()) {
				_key = _xml.attribute(KEY);
				if (stringToBoolean(_xml.attribute(REQUIRED))) {
					if (!stringToBoolean(__data[_key])) {
						return _xml.childIndex();
					}
				}
				if (stringToBoolean(_xml.attribute(REG))) {
					if (__data[_key]) {
						if (testStringReg(__data[_key], String(_xml.attribute(REG)))) {
							return _xml.childIndex();
						}
					}
				}
			}
			return true;
		}

		private static function testStringReg(_str:String, _regStr:String):Boolean {
			var _reg:RegExp = new RegExp(_regStr);
			return !_reg.test(_str);
		}
	}

}