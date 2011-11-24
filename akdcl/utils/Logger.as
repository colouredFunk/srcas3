package akdcl.utils {

	/**
	 * ...
	 * @author ...
	 */
	public class Logger {
		public static var logList:Object = {};

		public static var onLog:Function;

		public static function log(_target:*, ... args):void {
			var _log:String = logList[_target] || "";
			if (!_log || _log.length > 10000){
				logList[_target] = args + "\n\n";
			} else {
				logList[_target] = args + "\n" + _log;
			}
			if (onLog != null) {
				switch(onLog.length) {
					case 0:
						onLog();
						break;
					case 1:
						onLog(args);
						break;
					case 2:
						onLog(_target, args);
						break;
					case 3:
					default:
						onLog(_target, args, logList[_target]);
						break;
				}
			}
		}

		public static function getLog(_target:*):String {
			var _log:String = logList[_target];
			if (_log){
				return _target + " log result:\n\n";
			}
			return _target + " no log result!\n\n";
		}

		public static function getAllLog():String {
			var _allLog:String = "";
			for (var _target:String in logList){
				_allLog += getLog(_target);
			}
			return _allLog;
		}
	}

}