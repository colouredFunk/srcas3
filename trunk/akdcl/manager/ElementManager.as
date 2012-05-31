package akdcl.manager {
	import flash.events.EventDispatcher;

	final public class ElementManager extends BaseManager {
		baseManager static var instance:ElementManager;
		public static function getInstance():ElementManager {
			return createConstructor(ElementManager) as ElementManager;
		}
		
		public function ElementManager() {
			super(this);
			
			elementsDic = { };
		}
		
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
				lM.warn(ElementManager, "register(id:{0}, class:{1}) id is already registed!", null, _elementID, _ElementClass);
				return;
			}
			if (_ElementClass) {
				lM.info(ElementManager, "register(id:{0}, class:{1})", null, _elementID, _ElementClass);
				elementsDic[_elementID] = new Elements(_ElementClass);
			} else {
				lM.warn(ElementManager, "register(id:{0}, class:{1}) class is null!", null, _elementID, _ElementClass);
			}
		}
		
		public function unregister(_elementID:String):void {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				delete elementsDic[_elementID];
				_elements.remove();
			}
		}

		public function getElement(_elementID:String, _build:Function = null):* {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				var _length:uint = _elements.getLength();
				if (_build == null || _length > 0) {
					lM.info(ElementManager, "getElement(id:{0}) length:{1}", null, _elementID, Math.max(_length - 1, 0));
					return _elements.getElement();
				}
				return _build(_elementID, _elements.getClass());
			}
			
			lM.warn(ElementManager, "getElement(id:{0}) class is unregistered!", null, _elementID);
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
	
	public function getClass():Class {
		return ElementClass;
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