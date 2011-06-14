package {
	import flash.media.Sound;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class SoundManager {
		private static var instance:SoundManager;

		public static function getInstance():SoundManager {
			if (instance){
			} else {
				instance = new SoundManager();
			}
			return instance;
		}

		public function SoundManager(){
			if (instance){
				throw new Error("ERROR:SoundManager Singleton already constructed!");
			}
			instance = this;
		}
	}

}