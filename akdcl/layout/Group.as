package akdcl.layout {
	import flash.events.Event;

	/**
	 * ...
	 * @author akdcl
	 */
	public class Group extends Rect {
		public static function createGroup(_xml:XML, _index:int):Object {
			var _rect:Object;
			switch (_xml.localName()){
				case "Group":
				case "HGroup":
				case "VGroup":
					_rect = new Group(0, 0, Number(_xml.@w), Number(_xml.@h), GROUP_VALUES[_xml.localName()]);
					_rect.userData = {xml: _xml};
					break;
				case "Display":
					_rect = new DisplayProxy(0, 0, Number(_xml.@w), Number(_xml.@h));
					_rect.userData = {xml: _xml};
					return _rect;
				case "Rect":
				default:
					_rect = new Rect(0, 0, Number(_xml.@w), Number(_xml.@h));
					_rect.userData = {xml: _xml};
					return _rect;
			}
			for each (var _xml:XML in _xml.children()){
				_rect.addChild(createGroup(_xml, _index + 1));
			}
			return _rect;
		}

		public static const GROUP:int = 0;
		public static const HGROUP:int = 1;
		public static const VGROUP:int = -1;

		public static const GROUP_VALUES:Object = {Group: GROUP, HGroup: HGROUP, VGroup: VGROUP};

		public var intervalH:Number = 0;
		public var intervalV:Number = 0;
		public var type:int;

		private var children:Array;

		public function Group(_x:Number, _y:Number, _width:Number, _height:Number, _type:int = 0){
			type = _type;
			children = [];
			super(_x, _y, _width, _height);
		}

		override public function remove():void {
			for each (var _child:Rect in children){
				_child.remove();
			}
			super.remove();
			children = null;
		}

		override protected function updatePoint(_dispathEvent:Boolean = true):void {
			var _x:Number;
			var _y:Number;
			var _prevChild:Rect;
			for each (var _child:Rect in children){
				if (type > GROUP && _prevChild){
					_x = _prevChild.__x + _prevChild.__width + intervalH;
				} else {
					_x = __x;
				}
				if (type < GROUP && _prevChild){
					_y = _prevChild.__y + _prevChild.__height + intervalV;
				} else {
					_y = __y;
				}
				_child.setPoint(_x, _y);
				_prevChild = _child;
			}
			super.updatePoint(_dispathEvent);
		}

		override protected function updateSize(_dispathEvent:Boolean = true):void {
			var _child:Rect;
			var _value:Number;
			var _percent:Number = 0;
			var _averageCount:Number = 0;
			var _width:Number;
			var _height:Number;

			if (type == GROUP){
				for each (_child in children){
					if (_child.isAverageHeight){
						_width = __width;
					} else if (_child.percentWidth){
						_width = _child.percentWidth * __width;
					} else {
						_width = _child.__width;
					}
					if (_child.isAverageHeight){
						_height = __height;
					} else if (_child.percentHeight){
						_height = _child.percentHeight * __height;
					} else {
						_height = _child.__height;
					}
					_child.setSize(_width, _height);
				}
			} else if (type > GROUP){
				_value = (children.length - 1) * intervalH;
				for each (_child in children){
					if (_child.isAverageWidth){
						_averageCount++;
					} else if (_child.percentWidth > 0){
						_percent += _child.percentWidth;
					} else {
						_value += _child.__width;
					}
				}
				if (_percent < 1){
					if (_averageCount > 0){
						_averageCount = (1 - _percent) / _averageCount;
					}
					_percent = 1;
				}
				_value = Math.max(0, __width - _value);
				for each (_child in children){
					_width = _value * (_child.isAverageWidth ? _averageCount : _child.percentWidth) / _percent;
					if (_child.isAverageHeight){
						_height = __height;
					} else if (_child.percentHeight){
						_height = _child.percentHeight * __height;
					} else {
						_height = _child.__height;
					}
					_child.setSize(_width, _height);
				}
			} else {
				_value = (children.length - 1) * intervalV;
				for each (_child in children){
					if (_child.isAverageHeight){
						_averageCount++;
					} else if (_child.percentHeight > 0){
						_percent += _child.percentHeight;
					} else {
						_value += _child.__height;
					}
				}
				if (_percent < 1){
					if (_averageCount > 0){
						_averageCount = (1 - _percent) / _averageCount;
					}
					_percent = 1;
				}
				_value = Math.max(0, __height - _value);
				for each (_child in children){
					if (_child.isAverageWidth){
						_width = __width;
					} else if (_child.percentWidth){
						_width = _child.percentWidth * __width;
					} else {
						_width = _child.__width;
					}
					_height = _value * (_child.isAverageHeight ? _averageCount : _child.percentHeight) / _percent;
					_child.setSize(_width, _height);
				}
			}
			updatePoint(_dispathEvent);
			super.updateSize(_dispathEvent);
		}

		public function addChild(_child:Rect):void {
			_child.addEventListener(Event.RESIZE, onChildResizeHandler);
			children.push(_child);
			if (autoUpdate){
				updateSize(true);
			}
		}

		private function onChildResizeHandler(e:Event):void {
			if (autoUpdate){
				updateSize(true);
			}
		}

		public function forEachGroup(_fun:Function, ... args){
			var _arr1:Array = args.concat();
			_arr1.unshift(this);
			_fun.apply(this, _arr1);

			var _arrn:Array = args.concat();
			_arrn.unshift(_fun);

			for each (var _child:Rect in children){
				if (_child is Group){
					(_child as Group).forEachGroup.apply(_child, _arrn);
				}
			}
		}

		public function forEachChild(_fun:Function, ... args){
			var _arr1:Array;
			//= args.concat();
			//_arr1.unshift(this);
			//_fun.apply(this, _arr1);
			var _arrn:Array = args.concat();
			_arrn.unshift(_fun);

			for each (var _child:Rect in children){
				if (_child is Group){
					(_child as Group).forEachChild.apply(_child, _arrn);
				} else {
					_arr1 = args.concat();
					_arr1.unshift(_child);
					_fun.apply(_child, _arr1);
				}
			}
		}

		override public function toString():String {
			var _str:String = super.toString();
			for each (var _child:Rect in children){
				_str += "\n";
				_str += _child.toString();
			}
			return _str;
		}
	}
}