package akdcl.layout {

	/**
	 * ...
	 * @author akdcl
	 */
	public class Group extends Rect{
		public var interval:Number = 10;
		
		internal var parent:Group;
		internal var children:Array;

		internal var percentWidth:Number = 0;
		internal var percentHeight:Number = 0;

		//0~1为设置percentWH,1~n为设置WH
		public function Group(_width:Number = 1, _height:Number = 1) {
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
		}
		
		override protected function updatePoint():void 
		{
			super.updatePoint();
			for each (var _child:Rect in children){
				_child.setPoint(__x, __y);
			}
		}
		
		override protected function updateSize():void 
		{
			super.updateSize();
			for each (var _child:Rect in children){
				_child.setSize(__width, __height);
			}
		}

		public function addChild(_child:Rect):void {
			//_child.parent = this;
			children.push(_child);
			update();
		}

		public function forEach(_fun:Function, ... args){
			var _arr1:Array = args.concat();
			_arr1.unshift(this);
			
			//_fun.apply(this, _arr1);
			
			var _arrn:Array = args.concat();
			_arrn.unshift(_fun);
			
			for each (var _child:Rect in children) {
				if (_child is Group) {
					(_child as Group).forEach.apply(_child, _arrn);
				}else {
					_fun.apply(_child, _arr1);
				}
			}
		}

		internal function setWidth(_value:Number = NaN):void {
			if (isNaN(_value)) {
				percentWidth = 0;
				__width = parent.getChildWidth(this);
			} else if (_value < 1) {
				percentWidth = _value;
				__width = parent.getChildWidth(this);
			} else {
				__width = _value;
				percentWidth = 0;
			}
		}

		internal function setHeight(_value:Number = 0):void {
			if (isAverageH){
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
	}
}