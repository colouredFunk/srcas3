package akdcl.media {

	/**
	 * ...
	 * @author ...
	 */
	public class PlayItem {
		private var __source:String;
		public function get source():String {
			return __source;
		}

		public function PlayItem(_source:String){
			__source = _source;
		}
	}

}