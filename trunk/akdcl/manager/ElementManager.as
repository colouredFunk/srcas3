package akdcl.manager {
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

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

		public function register(_elementID:String, _ElementClassOrFactory:*):void {
			if (elementsDic[_elementID]) {
				lM.warn(ElementManager, "register(id:{0}, classOrFactory:{1}) id is already registed!", null, _elementID, _ElementClassOrFactory);
				return;
			}
			if (_ElementClassOrFactory) {
				lM.info(ElementManager, "register(id:{0}, classOrFactory:{1})", null, _elementID, _ElementClassOrFactory);
				var _elements:Elements = elementsDic[_elementID] = new Elements(_ElementClassOrFactory);
			} else {
				lM.warn(ElementManager, "register(id:{0}, classOrFactory:{1}) class or factory mast be setted!", null, _elementID, _ElementClassOrFactory);
			}
		}
		
		public function unregister(_elementID:String):void {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				delete elementsDic[_elementID];
				_elements.remove();
			}
		}
		
		public function registerByClass(_ElementClass:Class, _factory:Function = null):void {
			var _id:String = getQualifiedClassName(_ElementClass);
			register(_id, _factory == null?_ElementClass:_factory);
		}
		
		public function unregisterByClass(_ElementClass:Class):void {
			var _id:String = getQualifiedClassName(_ElementClass);
			unregister(_id);
		}

		public function getElement(_elementID:String, ...arg):Object {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				var _length:uint = _elements.getLength();
				lM.info(ElementManager, "getElement(id:{0}) length:{1}", null, _elementID, Math.max(_length - 1, 0));
				return (arg.length > 0?_elements.getElement.apply(null, arg):_elements.getElement());
			}
			lM.warn(ElementManager, "getElement(id:{0}) class is unregistered!", null, _elementID);
			return null;
		}
		
		public function getElementByClass(_ElementClass:Class, ...args):Object {
			var _id:String = getQualifiedClassName(_ElementClass);
			if (args.length > 0) {
				args.unshift(_id);
				return getElement.apply(null, args);
			}
			return getElement(_id);
		}
		
		public function recycle(_element:Object):void {
			var _success:Boolean;
			for each (var _elements:Elements in elementsDic){
				if (_elements.recycle(_element)) {
					_success = true;
					break;
				}
			}
			lM.info(ElementManager, "recycle({0}) success:{1} length:{2}", null, _element, _success, _elements.getLength());
		}
	}
}

class Elements extends Object {
	private var factory:Function;
	private var ElementClass:Class;
	private var elementPrepared:Array;
	private var length:uint;

	public function getLength():uint {
		return length;
	}
	
	public function Elements(_ElementClassOrFactory:Object):void {
		if (_ElementClassOrFactory is Function) {
			factory = _ElementClassOrFactory as Function;
		}else {
			ElementClass = _ElementClassOrFactory as Class;
		}
		elementPrepared = [];
		length = 0;
	}

	public function getElement(...args):Object {
		var _element:*;
		if (length > 0) {
			_element = elementPrepared.pop();
			length--;
		}else if(factory != null) {
			_element = (args.length > 0?factory.apply(null, args):factory());
			if (!ElementClass) {
				ElementClass = _element.constructor;
			}
		}else if (ElementClass) {
			_element = new ElementClass();
		}
		return _element;
	}

	public function recycle(_element:Object):Boolean {
		if (_element is ElementClass){
			elementPrepared.push(_element);
			length++;
			return true;
		}
		return false;
	}
	
	public function remove():void {
		ElementClass = null;
		factory = null;
		elementPrepared = null;
		length = 0;
	}
}