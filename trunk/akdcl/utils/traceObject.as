package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function traceObject(...args):void {
		var _str:String = "";
		
		for (var _i:uint; _i < args.length; _i++ ) {
			var _eachStr:String;
			var _obj:*= args[_i];
			if (_obj && _obj["constructor"] === Object) {
				_eachStr = "{\n";
				for (var _j:String in _obj){
					_eachStr += _j + " : " + _obj[_j] + "\n";
				}
				_eachStr += "}\n";
			}else {
				_eachStr = _obj + "\n";
			}
			_str += _eachStr;
		}
		trace(_str);
	}
}