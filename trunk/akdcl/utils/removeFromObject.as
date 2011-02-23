package akdcl.utils{
	/**
	 * ...
	 * @author Akdcl
	 */
	public function removeFromObject(_container:*, _content:*):void {
		if (_container is Array || _container is Vector) {
			var _i:int = _container.indexOf(_content);
			if (_i >= 0) {
				_container.splice(_content, 1);
			}
		}else {
			
		}
	}
}