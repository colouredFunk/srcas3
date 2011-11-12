package akdcl.layout {

	/**
	 * ...
	 * @author akdcl
	 */
	public class HGroup extends Group {
		public function HGroup(_width:Number = 0, _height:Number = 1){
			super(_width, _height);
		}

		override internal function update():void {
			var _each:Group;
			var _prevGroup:Group;

			for (var _i:uint = 0; _i < children.length; _i++){
				_each = children[_i];
				_each.setWidth();
				_each.setHeight();
				if (_prevGroup){
					_each.x = _prevGroup.x + _prevGroup.__width;
				} else {
					_each.x = 0;
				}
				_prevGroup = _each;
			}
		}

		override internal function getChildWidth(_child:Group):uint {
			var _each:Group;
			var _width:uint = 0;
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
			//剩余height
			_width = Math.max(0, __width - _width);
			return Math.round(_width * (_each.autoPercentX ? _defaultPercent : _child.percentWidth) / _percent);
		}
	}

}