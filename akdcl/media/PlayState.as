package akdcl.media{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class PlayState {
		public static const PLAY:String = "play";
		public static const PAUSE:String = "pause";
		public static const STOP:String = "stop";
		public static const CONNECT:String = "connect";
		public static const WAIT:String = "wait";
		public static const BUFFER:String = "buffer";
		public static const READY:String = "ready";
		public static const RECONNECT:String = "reconnect";
		
		private static const NAME_LIST:Object = function():Object {
			var _obj:Object = { };
			_obj[PLAY] = "播放";
			_obj[PAUSE] = "暂停";
			_obj[STOP] = "停止";
			_obj[CONNECT] = "连接";
			_obj[WAIT] = "等待";
			_obj[BUFFER] = "缓冲";
			_obj[READY] = "就绪";
			_obj[RECONNECT] = "重新连接";
			return _obj;
		}();
		
		public static function getStateName(_state:String):String {
			return NAME_LIST[_state] || _state;
		}
	}
	
}