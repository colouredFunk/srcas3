package akdcl.utils {
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function getObjectClassName(_object:Object):String {
		return getQualifiedClassName(_object).split("::").pop();
	}
}