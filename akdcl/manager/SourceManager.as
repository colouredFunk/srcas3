package akdcl.manager {

	/**
	 * ...
	 * @author ...
	 */
	public class SourceManager {
		private static var instance:SourceManager;

		public static function getInstance():SourceManager {
			if (instance){
			} else {
				instance = new SourceManager();
			}
			return instance;
		}

		private var group

		public function SourceManager(){
			if (instance){
				throw new Error("ERROR:SourceManager Singleton already constructed!");
			}
			instance = this;
		}
	}

}