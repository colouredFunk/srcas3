package akdcl.utils {
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function copyObject(_source:Object):* {
		var _copy:ByteArray = new ByteArray();
		_copy.writeObject(_source);
		_copy.position = 0;
		return (_copy.readObject());
	}
}