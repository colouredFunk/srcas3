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
					_rect = new Display(0, 0, Number(_xml.@w), Number(_xml.@h));
					_rect.userData = {xml: _xml};
					return _rect;
				case "Rect":
				default:
					_rect = new Rect(0, 0, Number(_xml.@w), Number(_xml.@h));
					_rect.userData = {xml: _xml};
					return _rect;
			}
			for each (var _xml:XML in _xml.children()){
				_rect.addChild(createGroup(_xml, _index + 1), false);
			}
			return _rect;
		}

		private static const GROUP:int = 0;
		private static const HGROUP:int = 1;
		private static const VGROUP:int = -1;

		private static const GROUP_VALUES:Object = {Group: GROUP, HGroup: HGROUP, VGroup: VGROUP};

		public var intervalH:Number;
		public var intervalV:Number;
		public var type:int;

		//alignX,alignY -1 0 1
		private var __alignX:int;
		public function get alignX():int {
			return __alignX;
		}
		public function set alignX(_value:int):void {
			if (__alignX == _value){
				return;
			}
			__alignX = _value;
		}

		private var __alignY:int;
		public function get alignY():int {
			return __alignY;
		}
		public function set alignY(_value:int):void {
			if (__alignY == _value){
				return;
			}
			__alignY = _value;
		}
		private var numChildren:uint;
		private var children:Array;
		private var childrenWidth:int;
		private var childrenHeight:int;

		public function Group(_x:Number, _y:Number, _width:Number, _height:Number, _type:int = 0){
			type = _type;
			super(_x, _y, _width, _height);
		}
		
		override protected function init():void 
		{
			super.init();
			intervalH = 10;
			intervalV = 10;
			children = [];
		}

		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			for each (var _child:Rect in children){
				_child.remove();
			}
			children = null;
		}

		public function addChild(_child:Rect, _dispathEvent:Boolean = true):void {
			_child.addEventListener(Event.RESIZE, onChildResizeHandler);
			children.push(_child);
			numChildren = children.length;
			if (autoUpdate){
				updateSize(_dispathEvent);
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

		override protected function updatePoint(_dispathEvent:Boolean = true):void {
			var _x:Number;
			var _y:Number;
			var _child:Rect;
			var _prevChild:Rect;
			var _off:int;
			var _i:uint = 0;
			
			if (type==GROUP) {
				for (; _i < numChildren; _i++ ) {
					_child = children[_i];
					if (__alignX < 0) {
						_x = __x;
					}else if (__alignX == 0) {
						_x = __x + int((__width - _child.__width) * 0.5);
					}else {
						_x = __x + __width - _child.__width;
					}
					if (__alignY < 0) {
						_y = __y;
					}else if (__alignY == 0) {
						_y = __y + int((__height - _child.__height) * 0.5);
					}else {
						_y = __y + __height - _child.__height;
					}
					_child.setPoint(_x, _y, false);
					_prevChild = _child;
				}
			}else if (type==HGROUP) {
				if (__alignX < 0) {
					_off = 0;
				}else if (__alignX == 0) {
					_off = int((__width - childrenWidth - intervalH * (numChildren - 1)) * 0.5);
				}else {
					_off = __width - childrenWidth - intervalH * (numChildren - 1);
				}
				for (; _i < numChildren; _i++ ) {
					_child = children[_i];
					_x = _i == 0?__x + _off:_prevChild.__x + _prevChild.__width + intervalH;
					if (__alignY < 0) {
						_y = __y;
					}else if (__alignY == 0) {
						_y = __y + int((__height - _child.__height) * 0.5);
					}else {
						_y = __y + __height - _child.__height;
					}
					_child.setPoint(_x, _y, false);
					_prevChild = _child;
				}
			}else {
				if (__alignY < 0) {
					_off = 0;
				}else if (__alignY == 0) {
					_off = int((__height - childrenHeight - intervalV * (numChildren - 1)) * 0.5);
				}else {
					_off = __height - childrenHeight - intervalV * (numChildren - 1);
				}
				for (; _i < numChildren; _i++ ) {
					_child = children[_i];
					if (__alignX < 0) {
						_x = __x;
					}else if (__alignX == 0) {
						_x = __x + int((__width - _child.__width) * 0.5);
					}else {
						_x = __x + __width - _child.__width;
					}
					_y = _i == 0?__y + _off:_prevChild.__y + _prevChild.__height + intervalV;
					_child.setPoint(_x, _y, false);
					_prevChild = _child;
				}
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
			var _i:uint=0;
			
			switch(type) {
				case GROUP:
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
					break;
				case HGROUP:
					_value = (numChildren - 1) * intervalH;
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
					childrenWidth = 0;
					_value = Math.max(0, __width - _value);
					for (_i = 0; _i < numChildren; _i++) {
						_child = children[_i];
						if (_child.isAverageHeight) {
							_height = __height;
						} else if (_child.percentHeight){
							_height = _child.percentHeight * __height;
						} else {
							_height = _child.__height;
						}
						if (_child.isAverageWidth) {
							if (_i == numChildren - 1) {
								_width = __width - childrenWidth-(numChildren - 1) * intervalH;
							}else {
								_width = _value * (_child.isAverageWidth ? _averageCount : _child.percentWidth) / _percent;
							}
						}else {
							_width = _child.__width;
						}
						if (_child.isAverageWidth || _child.isAverageHeight) {
							_child.setSize(_width, _height, false);
						}
						childrenWidth += _child.__width;
					}
					break;
				case VGROUP:
					_value = (numChildren - 1) * intervalV;
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
					childrenHeight = 0;
					_value = Math.max(0, __height - _value);
					for (_i = 0; _i < numChildren; _i++) {
						_child = children[_i];
						if (_child.isAverageWidth){
							_width = __width;
						} else if (_child.percentWidth){
							_width = _child.percentWidth * __width;
						} else {
							_width = _child.__width;
						}
						
						if (_child.isAverageHeight) {
							if (_i == numChildren - 1) {
								_height = __height - childrenHeight-(numChildren - 1) * intervalV;
							}else {
								_height = _value * (_child.isAverageHeight ? _averageCount : _child.percentHeight) / _percent;
							}
						}else {
							_height = _child.__height;
						}
						if (_child.isAverageWidth || _child.isAverageHeight) {
							_child.setSize(_width, _height, false);
						}
						childrenHeight += _child.__height;
					}
					break;
			}
			updatePoint(_dispathEvent);
			super.updateSize(_dispathEvent);
		}

		private function onChildResizeHandler(e:Event):void {
			if (autoUpdate){
				updateSize(true);
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