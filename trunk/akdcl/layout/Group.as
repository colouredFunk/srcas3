package akdcl.layout {

	/**
	 * ...
	 * @author akdcl
	 */
	public class Group {
		public var userData:Object;
		public var x:Number = 0;
		public var y:Number = 0;
		public var interval:Number = 10;
		public var displayContent:Object;

		internal var parent:Group;
		internal var children:Array;

		internal var autoPercentX:Boolean;
		internal var autoPercentY:Boolean;

		internal var percentWidth:Number = 0;
		internal var percentHeight:Number = 0;

		internal var __width:Number = 0;

		public function get width():Number {
			return __width;
		}

		public function set width(_value:Number):void {
			setWidth(_value);
			if (parent){
				parent.update();
			} else {
				update();
			}
		}

		internal var __height:Number = 0;

		public function get height():Number {
			return __height;
		}

		public function set height(_value:Number):void {
			setHeight(_value);
			if (parent){
				parent.update();
			} else {
				update();
			}
		}

		//0~1为设置percentWH,1~n为设置WH
		public function Group(_width:Number = 1, _height:Number = 1, _display:Object = null){
			autoPercentX = _width == 0;
			autoPercentY = _height == 0;

			if (_width > 1){
				__width = _width;
			} else {
				percentWidth = _width;
			}

			if (_height > 1){
				__height = _height;
			} else {
				percentHeight = _height;
			}
			children = [];
			displayContent = _display;
			update();
		}

		public function addChild(_child:Group):void {
			_child.parent = this;
			children.push(_child);
			update();
		}

		public function forEach(_fun:Function, ... args){
			var _argCopy1:Array = args.concat();
			_argCopy1.unshift(this);
			_fun.apply(this, _argCopy1);
			var _argCopy2:Array = args.concat();
			_argCopy2.unshift(_fun);
			for each (var _child:Group in children){
				_child.forEach.apply(_child, _argCopy2);
			}
		}

		public function setSize(_w:Number, _h:Number):void {
			setWidth(_w);
			setHeight(_h);
			if (parent){
				parent.update();
			} else {
				update();
			}
		}

		public function update():void {
			for each (var _each:Group in children){
				_each.x = x;
				_each.y = y;
				_each.setWidth(__width);
				_each.setHeight(__height);
				_each.update();
			}
			updateDisplay();
		}
		
		internal function updateDisplay():void {
			if (displayContent){
				displayContent.x = x;
				displayContent.y = y;
				displayContent.width = width;
				displayContent.height = height;
			}
		}

		internal function setWidth(_value:Number = 0):void {
			if (autoPercentX){
				_value = _value || percentWidth;
			} else {
				_value = _value || percentWidth || __width;
			}
			if (_value > 1){
				__width = _value;
				percentWidth = 0;
			} else {
				percentWidth = _value;
				__width = parent.getChildWidth(this);
			}
		}

		internal function setHeight(_value:Number = 0):void {
			if (autoPercentY){
				_value = _value || percentHeight;
			} else {
				_value = _value || percentHeight || __height;
			}
			if (_value > 1){
				__height = _value;
				percentHeight = 0;
			} else {
				percentHeight = _value;
				__height = parent.getChildHeight(this);
			}
		}

		internal function getChildWidth(_child:Group):Number {
			return (_child.percentWidth || 1) * __width;
		}

		internal function getChildHeight(_child:Group):Number {
			return (_child.percentHeight || 1) * __height;
		}

		public function toString():String {
			var _str:String = "";
			_str += "x:" + x + "\n";
			_str += "y:" + y + "\n";
			_str += "width:" + width + "\n";
			_str += "height:" + height + "\n";
			for each (var _child:Group in children){
				_str += "\n";
				_str += _child.toString();
			}
			return _str;
		}
	}

}