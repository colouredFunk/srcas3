package akdcl.manager{
	import flash.events.EventDispatcher;
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class BaseManager extends EventDispatcher {
		protected namespace baseManager;
		
		private static const ABSTRACT_ERROR:String = "Abstract class did not receive reference to self. BaseManager cannot be instantiated directly.";
		
		private static const SINGLETON_ERROR:String = "Singleton already constructed!";
		
		private static const CONSTRUCTOR:String = "constructor";
		
		protected static var lM:LoggerManager;
		
		public function BaseManager(_self:BaseManager) {
			if (_self != this) {
				throw new IllegalOperationError(ABSTRACT_ERROR);
				if (lM) {
					lM.fatal(this[CONSTRUCTOR], ABSTRACT_ERROR);
				}
			}
			
			if (this[CONSTRUCTOR].baseManager::instance) {
				throw new IllegalOperationError(SINGLETON_ERROR);
				if (lM) {
					lM.fatal(this[CONSTRUCTOR], SINGLETON_ERROR);
				}
			}
			this[CONSTRUCTOR].baseManager::instance = this;
			
			lM = LoggerManager.getInstance();
			lM.info(this[CONSTRUCTOR], "init");
		}
		
		protected static function createConstructor(_constructor:Class):BaseManager {
			if (_constructor.baseManager::instance) {
				
			} else {
				new _constructor();
			}
			return _constructor.baseManager::instance;
		}
	}
	
}