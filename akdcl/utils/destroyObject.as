package akdcl.utils{
	/**
	 * ...
	 * @author Akdcl
	 */
	public function destroyObject(_data:Object):void {
		if (_data is Array) {
			for (var _n:int = _data.length - 1; _n >= 0; _n-- ) {
				_data.splice(_n, 1);
			}
		}else {
			for(var _i:String in _data){
				delete _data[_i];
			}
		}
	}
}