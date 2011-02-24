package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function stringToBoolean(_str:String, _isParam:Boolean = true):Boolean {
		if (_str){
			_str = String(_str);
		}
		if (!_str || (_isParam ? (_str == "false" || _str == "0") : false) || _str.replace(/\s+/, "") == ""){
			return false;
		}
		return true;
	}
}