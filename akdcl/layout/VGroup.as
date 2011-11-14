package akdcl.layout {

	/**
	 * ...
	 * @author akdcl
	 */
	public class VGroup extends Group {
		public function VGroup(_width:Number = 1, _height:Number = 0){
			super(_width, _height);
		}

		override public function update():void {
			var _each:Group;
			var _prevGroup:Group;

			for (var _i:uint = 0; _i < children.length; _i++){
				_each = children[_i];
				_each.setWidth();
				_each.setHeight();
				_each.x = x;
				if (_prevGroup){
					_each.y = _prevGroup.y + _prevGroup.__height + interval;
				} else {
					_each.y = y;
				}
				_each.update();
				_prevGroup = _each;
			}
		}

		override internal function getChildHeight(_child:Group):uint {
			var _each:Group;
			var _height:uint = (children.length - 1) * interval;
			var _percent:Number = 0;
			var _defaultPercent:Number = 0;
			for each (_each in children){
				if (_each.percentHeight > 0){
					_percent += _each.percentHeight;
				} else if (_each.autoPercentY){
					_defaultPercent++;
				} else if (_each.percentHeight == 0 && _each.__height){
					_height += _each.__height;
				}
			}
			if (_percent < 1){
				if (_defaultPercent > 0){
					_defaultPercent = (1 - _percent) / _defaultPercent;
				}
				_percent = 1;
			}
			//剩余height
			_height = Math.max(0, __height - _height);
			return Math.round(_height * (_each.autoPercentY ? _defaultPercent : _child.percentHeight) / _percent);
		}
	}

}