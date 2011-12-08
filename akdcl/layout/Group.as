package akdcl.layout {
	import flash.events.Event;

	/**
	 * ...
	 * @author akdcl
	 */
	public class Group extends Rect {
		public static function createGroup(_xml:XML, _index:int = 0):Object {
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

		private static const GROUP:int = 0;
		private static const HGROUP:int = 1;
		private static const VGROUP:int = -1;

		private static const GROUP_VALUES:Object = {Group: GROUP, HGroup: HGROUP, VGroup: VGROUP};

		public var intervalH:Number = 10;
		public var intervalV:Number = 10;
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
				_child.setPoint(_x, _y, false);
				_prevChild = _child;
			}
			super.updatePoint(_dispathEvent);
		}

		override protected function updateSize(_dispathEvent:Boolean = true):void {
			var _child:Rect;
			var _value:Number;
			var _width:Number;
			var _height:Number;
			var _percent:Number = 0;
			var _averageCount:Number = 0;
			var _childrenValue:Number = 0;
			var _i:uint;
			var _length:uint=children.length;

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
					_child.setSize(_width, _height,false);
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
				for (_i = 0; _i < _length; _i++) {
					_child = children[_i];
					if (_child.isAverageHeight){
						_height = __height;
					} else if (_child.percentHeight){
						_height = _child.percentHeight * __height;
					} else {
						_height = _child.__height;
					}
					if (_i == _length - 1) {
						_width = __width - _childrenValue-(children.length - 1) * intervalH;
					}else {
						_width = _value * (_child.isAverageWidth ? _averageCount : _child.percentWidth) / _percent;
					}
					_child.setSize(_width, _height, false);
					_childrenValue += _child.__width;
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
				for (_i = 0; _i < _length; _i++) {
					_child = children[_i];
					if (_child.isAverageWidth){
						_width = __width;
					} else if (_child.percentWidth){
						_width = _child.percentWidth * __width;
					} else {
						_width = _child.__width;
					}
					if (_i == _length - 1) {
						_height = __height - _childrenValue-(children.length - 1) * intervalV;
					}else {
						_height = _value * (_child.isAverageHeight ? _averageCount : _child.percentHeight) / _percent;
					}
					_child.setSize(_width, _height, false);
					_childrenValue += _child.__height;
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