package akdcl.manager {

	import akdcl.manager.SourceManager;

	public class ElementManager {
		private static var instance:ElementManager;

		public static function getInstance():ElementManager {
			if (instance){
			} else {
				instance = new ElementManager();
			}
			return instance;
		}

		public function ElementManager(){
			if (instance){
				throw new Error("ERROR:ElementManager Singleton already constructed!");
			}
			instance = this;
		}

		private static const ELEMENTS_GROUP:String = "Elements";

		private static var sM:SourceManager = SourceManager.getInstance();

		public function recycle(_element:*):void {
			for each (var _elements:Elements in sM.getGroup(ELEMENTS_GROUP)){
				if (_elements.recycle(_element)){
					return;
				}
			}
		}

		public function register(_elementID:String, _ElementClass:Class):void {
			if (sM.getSource(ELEMENTS_GROUP, _elementID)){
				return;
			}
			if (_ElementClass){
				sM.addSource(ELEMENTS_GROUP, _elementID, new Elements(_ElementClass));
			} else {
				trace("WARNNING:" + _elementID + " class is null!");
			}
		}

		public function getElement(_elementID:String):* {
			var _elements:Elements = sM.getSource(ELEMENTS_GROUP, _elementID);
			if (_elements){
				return _elements.getElement();
			}
			throw new Error("ERROR:" + _elementID + " has not yet registered!");
		}
	}
}

class Elements extends Object {
	private var ElementClass:Class;
	private var elementPrepared:Array;

	function Elements(_ElementClass:Class):void {
		ElementClass = _ElementClass;
		elementPrepared = [];
	}

	public function getElement():* {
		if (elementPrepared.length > 0){
			return elementPrepared.pop();
		}
		return new ElementClass();
	}

	public function recycle(_element:*):Boolean {
		if (_element is ElementClass){
			elementPrepared.push(_element);
			return true;
		}
		return false;
	}
}

