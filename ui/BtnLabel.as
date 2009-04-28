package ui{
	import flash.display.*;
	import flash.events.*;
	import ui.Txt;
	public class BtnLabel extends ui.Btn {
		protected var __label:String;
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
		protected var txt:Txt;
		protected var txtName:String="__txt";
		protected var bar:Sprite;
		protected var barName:String="__bar";
		override protected function init():void {
			aniClipName="__aniClip_0";
			mouseChildren=false;
			super.init();
		}
		override protected function removed(evt:Event):void {
			super.removed(evt);
			removeChild(txt);
			txt=null;
			if(bar){
				removeChild(bar);
				bar=null;
			}
		}
		public function get label():String {
			return __label;
		}
		[Inspectable(defaultValue="BtnLabel",type="String",name="标签")]
		public function set label(_label:String):void {
			if (__label!=_label) {
				__label=_label;
				reset();
				txt.text=__label;
				resetBar();
			}
		}
		[Inspectable(enumeration="left,right,center",defaultValue="left",type="String",name="对齐")]
		public function set autoSize(_autoSize:String):void {
			txt.autoSize=_autoSize;
			reset();
		}
		override protected function reset():void {
			super.reset();
			txt=getChildByName(txtName) as Txt;
			resetBar();
		}
		private function resetBar():void {
			bar=getChildByName(barName) as Sprite;
			if (! bar) {
				return;
			}
			bar.width=widthMax?widthMax:txt.width+widthAdd;
			bar.height=heightMax?heightMax:txt.height+heightAdd;
			if (txt.autoSize=="left") {
				bar.x=- widthAdd*0.5;
			} else if (txt.autoSize=="right") {
				bar.x=- int(bar.width)+widthAdd*0.5;
			} else {
				bar.x=- int(bar.width*0.5);
			}
			bar.x+=xOff;
			bar.y=yOff;
		}
	}
}