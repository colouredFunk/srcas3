package akdcl.media {

	/**
	 * ...
	 * @author ...
	 */
	public class PlayItem {
		private static const SOURCE:String = "source";
		private static const TOTAL_TIME:String = "totalTime";
		private static const TYPE:String = "type";

		private var __source:String;
		public function get source():String {
			return __source;
		}
		
		private var __type:String;
		public function get type():String {
			return __type;
		}

		private var __totalTime:uint;
		public function get totalTime():uint {
			return __totalTime;
		}

		public function PlayItem(_source:*){
			if (_source is XML){
				__source = String(_source.attribute(SOURCE));
				__type = String(_source.attribute(TYPE));
				__totalTime = int(_source.attribute(TOTAL_TIME));
			} else if (_source is String){
				__source = _source;
			}
			if (!__type) {
				__type = String(playItem.source.split("?")[0].split(".").pop()).toLowerCase();
			}
		}
	}

}