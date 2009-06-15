package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	public class Txt extends Sprite {
		private var __text:String="Txt";
		//[Inspectable(defaultValue=0,type="int",name="固定宽")]
		private var widthMax:int=0;
		//[Inspectable(defaultValue=0,type="int",name="固定高")]
		private var heightMax:int=0;
		//[Inspectable(defaultValue=0,type="int",name="水平偏移")]
		private var xOff:int=0;
		//[Inspectable(defaultValue=0,type="int",name="垂直偏移")]
		private var yOff:Number=0;
		//[Inspectable(defaultValue=0,type="int",name="宽增益")]
		private var widthAdd:Number=0;
		//[Inspectable(defaultValue=0,type="int",name="高增益")]
		private var heightAdd:Number=0;
		protected var txt:TextField;
		protected var txtName:String="__txt";
		protected var bar:Sprite;
		protected var barName:String="__bar";
		public var html:Boolean;
		public var onChange:Function;
		public function Txt() {
			init();
		}
		protected function init():void {
			bar=getChildByName(barName) as Sprite;
			txt=getChildByName(txtName) as TextField;
			txt.mouseWheelEnabled=false;
			if (html) {
				txt.htmlText=__text;
			} else {
				txt.text=__text;
			}
			txt.multiline=false;
			txt.wordWrap=false;
			if (bar) {
				bar.mask=txt;
			}
			reset();
		}
		public function get text():String {
			if (txt.selectable) {
				__text=txt.text;
			}
			return __text;
		}
		[Inspectable(defaultValue="Txt",type="String",name="文本")]
		public function set text(_text):void {
			if (__text!=_text) {
				if (html) {
					txt.htmlText=__text=_text;
				} else {
					txt.text=__text=_text;
				}
				//txt.text=__text=_text.toUpperCase();//如果要全部大写
				reset();
			}
		}
		public function get autoSize():String {
			return txt.autoSize;
		}
		[Inspectable(enumeration="left,right,center,none",defaultValue="left",type="String",name="对齐")]
		public function set autoSize(_autoSize:String):void {
			if (txt.autoSize!=_autoSize) {
				txt.autoSize=_autoSize;
				reset();
			}
		}
		public function get type():String {
			return txt.type;
		}
		[Inspectable(enumeration="dynamic,input",defaultValue="dynamic",type="String",name="类型")]
		public function set type(_type:String):void {
			txt.type=_type;
		}
		public function set selectable(_selectable:Boolean):void {
			txt.selectable=_selectable;
		}
		public function set maxChars(_maxChars:int):void {
			txt.maxChars=_maxChars;
		}
		public function set restrict(_restrict:String):void {
			txt.restrict=_restrict;
		}
		protected function reset():void {
			if (widthMax) {
				txt.width=widthMax;
			} else {
				txt.autoSize=txt.autoSize;
			}
			if (txt.autoSize=="left") {
				txt.x=0;
			} else if (txt.autoSize == "right") {
				txt.x=- int(txt.width);
			} else if (txt.autoSize == "center") {
				txt.x=- int(txt.width*0.5);
			}
			if (bar) {
				bar.width=txt.width+widthAdd;
				bar.height=txt.height+heightAdd;
				if (txt.autoSize=="left") {
					bar.x=- widthAdd*0.5;
				} else if (txt.autoSize == "right") {
					bar.x=- int(bar.width)+widthAdd*0.5;
				} else if (txt.autoSize == "center") {
					bar.x=- int(bar.width*0.5);
				}
				bar.x+=xOff;
				bar.y=yOff;
			}
			if (onChange!=null) {
				onChange();
			}
		}
	}
}