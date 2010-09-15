package ui{
	import ui.UISprite;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ProgressBar extends UISprite {
		public var thumb:*;
		public var bar:*;
		public var track:*;
		override protected function init():void {
			super.init();
		}
		private var __value:Number;
		public function get value():Number {
			return __value;
		}
		public function set value(_value:Number):void {
			if (_value < 0) {
				_value = 0;
			}elseif (_value > 1) {
				_value = 1;
			}
			if (__value == _value) {
				return;
			}
			__value = _value;
			setStyle();
		}
		public function setValue(_value:Number):void {
			if (_value < 0) {
				_value = 0;
			}elseif (_value > 1) {
				_value = 1;
			}
			__value = _value;
			setStyle();
		}
		protected function setStyle():void {
			bar.width = Math.round(value * length);
			if (thumb) {
				thumb.x = bar.width + bar.x;
			}
		}
	}
	
}