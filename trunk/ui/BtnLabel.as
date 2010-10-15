package ui{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.StyleSheet;
	public class BtnLabel extends Btn {
		public var txt:*;
		public var bar:*;
		public var endClip:*;
		
		protected var widthAdd:int;
		protected var heightAdd:int;
		protected var xOff:int;
		protected var yOff:int;
		
		protected var __widthMax:int;
		[Inspectable(defaultValue=0,type="int",name="0_固定宽")]
		public function set widthMax(_widthMax:int):void {
			__widthMax = _widthMax;
			$setStyle(false);
		}
		protected var __heightMax:int;
		[Inspectable(defaultValue=0,type="int",name="0_固定高")]
		public function set heightMax(_heightMax:int):void {
			__heightMax = _heightMax;
			$setStyle(false);
		}
		private var __label:String;
		public function get label():String {
			return __label;
		}
		[Inspectable(defaultValue="label",type="String",name="文本")]
		public function set label(_label:String):void {
			if (__label!=_label) {
				__label=_label;
				txt.text=__label;
				$setStyle(false);
			}
		}
		[Inspectable(enumeration="left,right,center",defaultValue="left",type="String",name="对齐")]
		public function set autoSize(_autoSize:String):void {
			txt.autoSize = _autoSize;
			$setStyle(false);
		}
		override protected function init():void {
			super.init();
			widthAdd = bar.width - txt.width;
			heightAdd = bar.height - txt.height;
			xOff = bar.x - txt.x;
			yOff = bar.y - txt.y;
		}
		internal function $setStyle(_isActive:Boolean):void {
			if (bar) {
				bar.width = __widthMax?__widthMax:(txt.width + widthAdd);
				bar.height = __heightMax?__heightMax:(txt.height + heightAdd);
				if (txt.autoSize == "right") {
					bar.x = int(txt.x - txt.width + xOff);
				} else if (txt.autoSize == "center") {
					bar.x = int(txt.x - txt.width * 0.5 + xOff);
				} else {
					bar.x = int(txt.x + xOff);
				}
				bar.y = int(txt.y + yOff);
			}
			if (endClip) {
				endClip.x = txt.txt.x + txt.width;
				endClip.mouseEnabled = false;
				endClip.mouseChildren = false;
			}
		}
	}
}