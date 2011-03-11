package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function numberToString(_value:uint, _lenght:uint = 2):String {
		var _str:String = String(_value);
		_lenght--;
		var _d:uint = Math.pow(10, _lenght);
		if (_value < _d){
			_value += _d;
			_str = "0" + String(_value).substr(1);
		}
		return _str;
	}
}