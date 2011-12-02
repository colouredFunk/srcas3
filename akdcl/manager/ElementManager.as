package akdcl.manager {
	import flash.events.EventDispatcher;

	final public class ElementManager extends EventDispatcher{
		private static const ERROR:String = "ElementManager Singleton already constructed!";
		private static var instance:ElementManager;

		public static function getInstance():ElementManager {
			if (instance){
			} else {
				instance = new ElementManager();
			}
			return instance;
		}

		public function ElementManager(){
			lM = LoggerManager.getInstance();
			if (instance){
				lM.fatal(ElementManager, ERROR);
				throw new Error("[ERROR]:" + ERROR);
			}
			instance = this;
			lM.info(ElementManager, "init");
			
			sM = SourceManager.getInstance();
		}

		private static const ELEMENTS_GROUP:String = "Elements";

		private var lM:LoggerManager;
		private var sM:SourceManager;

		public function recycle(_element:*):void {
			var _success:Boolean;
			for each (var _elements:Elements in sM.getGroup(ELEMENTS_GROUP)){
				if (_elements.recycle(_element)) {
					_success = true;
					break;
				}
			}
			lM.info(ElementManager, "recycle({0}) success:{1} length:{2}", null, _element, _success, _elements.getElementsLength());
		}

		public function register(_elementID:String, _ElementClass:Class):void {
			if (sM.getSource(ELEMENTS_GROUP, _elementID)){
				return;
			}
			if (_ElementClass) {
				lM.info(ElementManager, "register(id:{0}, class:{1})", null, _elementID, _ElementClass);
				sM.addSource(ELEMENTS_GROUP, _elementID, new Elements(_ElementClass));
			} else {
				var _str:String = "ElementManager.register(id, class), class is null!";
				lM.warn(ElementManager, _str);
				trace("[WARNNING]:" + _str);
			}
		}

		public function getElement(_elementID:String):* {
			var _elements:Elements = sM.getSource(ELEMENTS_GROUP, _elementID);
			if (_elements) {
				lM.info(ElementManager, "getElement(id:{0})", null, _elementID);
				return _elements.getElement();
			}
			
			var _str:String = "ElementManager.getElement(" + _elementID + "), class is unregistered!";
			lM.warn(ElementManager, _str);
			trace("[WARNNING]:" + _str);
			return null;
		}

		public function getElementsLength(_elementID:String):uint {
			var _elements:Elements = sM.getSource(ELEMENTS_GROUP, _elementID);
			if (_elements){
				return _elements.getElementsLength();
			}
			return 0;
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

	public function getElementsLength():uint {
		return elementPrepared.length;
	}

	public function recycle(_element:*):Boolean {
		if (_element is ElementClass){
			elementPrepared.push(_element);
			return true;
		}
		return false;
	}
}

