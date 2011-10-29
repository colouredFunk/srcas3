package akdcl.manager
{
	import akdcl.utils.copyObject;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ShareObjectManager 
	{
		public static var instance:ShareObjectManager;

		public static function getInstance():ShareObjectManager {
			if (instance){
			}else {
				instance = new ShareObjectManager();
			}
			return instance;
		}

		public function ShareObjectManager(){
			if (instance){
				throw new Error("ERROR:ShareObjectManager Singleton already constructed!");
			}
			instance = this;
		}
		
		private var shareObject:SharedObject;
		
		public function setLocal(_domain:String):void {
			shareObject = SharedObject.getLocal(_domain);
		}
		public function getValue(_key:String):Object {
			return shareObject.data[_key];
		}
		public function setValue(_key:String, _value:Object):void {
			shareObject.data[_key] = _object;
		}
		public function getValueCopy(_key:String):Object {
			var _object:Object = shareObject.data[_key];
			return copyObject(_object);
		}
		public function setValueCopy(_key:String, _value:Object):void {
			shareObject.data[_key] = copyObject(_object);
		}
		public function flush():void {
			if (shareObject) {
				shareObject.flush();
			}
		}
	}
	
}