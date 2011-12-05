package akdcl.layout {

	/**
	 * ...
	 * @author akdcl
	 */
	public class Group extends Rect {
		public var intervalH:Number = 10;
		public var intervalV:Number = 10;
		public var type:int;

		private var children:Array;

		public function Group(_x:Number, _y:Number, _width:Number, _height:Number, _type:int = 0){
			type = _type;
			children = [];
			super(_x, _y, _width, _height);
		}

		override protected function updatePoint():void {
			var _x:Number;
			var _y:Number;
			var _prevChild:Rect;
			for each (var _child:Rect in children){
				if (type > 0 && _prevChild){
					_x = _prevChild.__x + _prevChild.__width + intervalH;
				} else {
					_x = __x;
				}
				if (type < 0 && _prevChild){
					_y = _prevChild.__y + _prevChild.__height + intervalV;
				} else {
					_y = __y;
				}
				_child.setPoint(_x, _y);
				_prevChild = _child;
			}
		}

		override protected function updateSize():void {
			var _child:Rect;
			var _value:Number;
			var _percent:Number = 0;
			var _averageCount:Number = 0;

			if (type == 0){
				for each (_child in children){
					_child.setSize(__width, __height);
				}
			} else if (type > 0){
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
					_child.setSize(_value * (_child.isAverageWidth ? _averageCount : _child.percentWidth) / _percent, __height);
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
					_child.setSize(__width, _value * (_child.isAverageHeight ? _averageCount : _child.percentHeight) / _percent);
				}
			}
			updatePoint();
		}

		public function addChild(_child:Rect):void {
			_child.parent = this;
			children.push(_child);
			updateSize();
		}

		public function forEach(_fun:Function, ... args){
			var _arr1:Array = args.concat();
			_arr1.unshift(this);
			//_fun.apply(this, _arr1);
			var _arrn:Array = args.concat();
			_arrn.unshift(_fun);

			for each (var _child:Rect in children){
				if (_child is Group){
					(_child as Group).forEach.apply(_child, _arrn);
				} else {
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