package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function getNearest2N(_n:uint):uint {
		return _n & _n - 1 ? 1 << _n.toString(2).length : _n;
	}
}