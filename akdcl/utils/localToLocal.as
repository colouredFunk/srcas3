package akdcl.utils {
	import flash.geom.Point;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function localToLocal(_from:Object, _to:Object , _point:Object):Point {
		return _to.globalToLocal(_from.localToGlobal(_point));
	}
}