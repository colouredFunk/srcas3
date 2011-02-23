package akdcl.net {

	/**
	 * ...
	 * @author Akdcl
	 */
	public class SubmitFields {
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
			for each (var _xml:XML in sourceXML.children()){
				if (_xml.@required.length() > 0 && stringIsTrue(String(_xml.@required))){
					_key = _xml.@key;
					if (!__data[_key]){
						return _xml.childIndex();
					}
				}
				if (_xml.@reg.length() > 0){
					_key = _xml.@key;
					if (__data[_key]){
						if (testStringReg(__data[_key], String(_xml.@reg))){
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

		private static function stringIsTrue(_str:String):Boolean {
			if (!_str || _str == "" || _str == "0" || _str == " " || _str == "false"){
				return false;
			}
			return true;
		}
	}

}