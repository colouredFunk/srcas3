package akdcl.media {

	/**
	 * ...
	 * @author ...
	 */
	public class PlayItem {
		private static const SOURCE:String = "source";
		private static const TOTAL_TIME:String = "totalTime";

		private var __source:String;

		public function get source():String {
			return __source;
		}

		private var __totalTime:uint;

		public function get totalTime():uint {
			return __totalTime;
		}

		public function PlayItem(_source:*){
			if (_source is XML){
				__source = _source.attribute(SOURCE);
				__totalTime = _source.attribute(TOTAL_TIME);
			} else if (_source is String){
				__source = _source;
			}
		}
	}

}