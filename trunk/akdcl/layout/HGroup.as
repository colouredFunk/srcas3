package akdcl.layout {

	/**
	 * ...
	 * @author akdcl
	 */
	public class HGroup extends Group {
		public function HGroup(_width:Number = 0, _height:Number = 1, _display:Object = null){
			super(_width, _height,_display);
		}

		override public function update():void {
			var _each:Group;
			var _prevGroup:Group;

			for (var _i:uint = 0; _i < children.length; _i++){
				_each = children[_i];
				_each.y = y;
				if (_prevGroup){
					_each.x = _prevGroup.x + _prevGroup.__width + interval;
				} else {
					_each.x = x;
				}
				_each.setWidth();
				_each.setHeight();
				_each.update();
				_prevGroup = _each;
			}
			updateDisplay();
		}

		override internal function getChildWidth(_child:Group):Number {
			var _each:Group;
			var _width:Number = (children.length - 1) * interval;
			var _percent:Number = 0;
			var _defaultPercent:Number = 0;
			for each (_each in children){
				if (_each.percentWidth){
					_percent += _each.percentWidth;
				} else if (_each.autoPercentX){
					_defaultPercent++;
				} else if (_each.percentWidth == 0 && _each.__width){
					_width += _each.__width;
				}
			}
			if (_percent < 1){
				if (_defaultPercent > 0){
					_defaultPercent = (1 - _percent) / _defaultPercent;
				}
				_percent = 1;
			}
			_width = Math.max(0, __width - _width);
			_width = _width * (_child.autoPercentX ? _defaultPercent : _child.percentWidth) / _percent;
			return _width;
		}
	}

}