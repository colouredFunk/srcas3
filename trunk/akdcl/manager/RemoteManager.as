package akdcl.manager {
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author akdcl
	 */
	final public class RemoteManager extends EventDispatcher {
		private static const ERROR:String = "RemoteManager Singleton already constructed!";
		private static var instance:RemoteManager;

		public static function getInstance():SourceManager {
			if (instance){
			} else {
				instance = new RemoteManager();
			}
			return instance;
		}

		public function RemoteManager(){
			lM = LoggerManager.getInstance();
			if (instance){
				lM.fatal(RemoteManager, ERROR);
				throw new Error("[ERROR]:" + ERROR);
			}
			instance = this;
			lM.info(RemoteManager, "init");
		}
		
		private var lM:LoggerManager;
	}
}