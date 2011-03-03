package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function traceObject(_obj:Object):void {
		var _str:String = "";
		for (var _i:String in _obj){
			_str += _i + " : " + _obj[_i] + "\n";
		}
		trace(_str);
	}
}