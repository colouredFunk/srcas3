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
			
			elementsDic = { };
		}

		private var lM:LoggerManager;
		
		private var elementsDic:Object;

		public function recycle(_element:*):void {
			var _success:Boolean;
			for each (var _elements:Elements in elementsDic){
				if (_elements.recycle(_element)) {
					_success = true;
					break;
				}
			}
			lM.info(ElementManager, "recycle({0}) success:{1} length:{2}", null, _element, _success, _elements.getLength());
		}

		public function register(_elementID:String, _ElementClass:Class):void {
			if (elementsDic[_elementID]) {
				//trace("[WARNNING]:");
				return;
			}
			if (_ElementClass) {
				lM.info(ElementManager, "register(id:{0}, class:{1})", null, _elementID, _ElementClass);
				elementsDic[_elementID] = new Elements(_ElementClass);
			} else {
				var _str:String = "ElementManager.register(id, class), class is null!";
				lM.warn(ElementManager, _str);
				trace("[WARNNING]:" + _str);
			}
		}
		
		public function unregister(_elementID:String):void {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				delete elementsDic[_elementID];
				_elements.remove();
			}
		}

		public function getElement(_elementID:String):* {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				lM.info(ElementManager, "getElement(id:{0}) length:{1}", null, _elementID, Math.max(_elements.getLength() - 1, 0));
				return _elements.getElement();
			}
			
			var _str:String = "ElementManager.getElement(" + _elementID + "), class is unregistered!";
			lM.warn(ElementManager, _str);
			trace("[WARNNING]:" + _str);
			return null;
		}
	}
}

class Elements extends Object {
	private var ElementClass:Class;
	private var elementPrepared:Array;

	public function Elements(_ElementClass:Class):void {
		ElementClass = _ElementClass;
		elementPrepared = [];
	}

	public function getElement():* {
		var _element:* = elementPrepared.length > 0?elementPrepared.pop():new ElementClass();
		return _element;
	}

	public function getLength():uint {
		return elementPrepared.length;
	}

	public function recycle(_element:*):Boolean {
		if (_element is ElementClass){
			elementPrepared.push(_element);
			return true;
		}
		return false;
	}
	
	public function remove():void {
		ElementClass = null;
		elementPrepared = null;
	}
}