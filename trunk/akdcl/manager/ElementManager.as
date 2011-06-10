package akdcl.manager {

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
			elementsGroup = {};
		}

		private var elementsGroup:Object;

		public function recycle(_element:*):void {
			for each (var _elements:Elements in elementsGroup){
				if (_elements.recycle(_element)){
					return;
				}
			}
		}

		public function register(_elementID:String, _ElementClass:Class):void {
			if (elementsGroup[_elementID]){
				return;
			}
			elementsGroup[_elementID] = new Elements(_ElementClass);
		}

		public function getElement(_elementID:String):* {
			var _elements:Elements = elementsGroup[_elementID];
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

