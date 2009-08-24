package ui_2{
	import flash.events.Event;
	public class BtnLabel extends ui_2.Btn {
		protected var __label:String;
		protected var txt:*;
		protected var txtName:String;
		protected var bar:*;
		protected var barName:String="__bar";
		override protected function init():void {
			aniClipName="__aniClip_0";
			mouseChildren=false;
			super.init();
		}
		protected function getTxt():void {
			if (txt) {
				return;
			}
			var _len:uint=numChildren;
			for (var _i:uint=0; _i<_len; _i++) {
				if (getChildAt(_i) is Txt) {
					txt=getChildAt(_i);
				}
			}
		}
		protected var __widthMax:int;
		[Inspectable(defaultValue=0,type="int",name="0_固定宽")]
		public function set widthMax(_widthMax:int):void {
			__widthMax=_widthMax;
		}
		protected var __heightMax:int;
		[Inspectable(defaultValue=0,type="int",name="0_固定高")]
		public function set heightMax(_heightMax:int):void {
			__heightMax=_heightMax;
		}
		protected var __xOff:int;
		[Inspectable(defaultValue=0,type="int",name="0_水平偏移")]
		public function set xOff(_xOff:int):void {
			__xOff=_xOff;
		}
		protected var __yOff:int;
		[Inspectable(defaultValue=0,type="int",name="0_垂直偏移")]
		public function set yOff(_yOff:int):void {
			__yOff=_yOff;
		}
		protected var __widthAdd:int;
		[Inspectable(defaultValue=0,type="int",name="0_宽增益")]
		public function set widthAdd(_widthAdd:int):void {
			__widthAdd=_widthAdd;
		}
		protected var __heightAdd:int;
		[Inspectable(defaultValue=0,type="int",name="0_高增益")]
		public function set heightAdd(_heightAdd:int):void {
			__heightAdd=_heightAdd;
		}

		public function get label():String {
			return __label;
		}
		[Inspectable(defaultValue="BtnLabel",type="String",name="文本")]
		public function set label(_label:String):void {
			if (__label!=_label) {
				__label=_label;
				if (! txt) {
					getTxt();
				}
				txt.text=__label;
				setStyleBar();
			}
		}
		[Inspectable(enumeration="left,right,center",defaultValue="left",type="String",name="对齐")]
		public function set autoSize(_autoSize:String):void {
			if (! txt) {
				getTxt();
			}
			txt.autoSize=_autoSize;
			setStyleBar();
		}
		override public function setStyle():void {
			super.setStyle();
			getTxt();
			setStyleBar();
		}
		protected function setStyleBar():void {
			bar=getChildByName(barName);
			if (! bar||! txt) {
				return;
			}
			bar.width=__widthMax?__widthMax:(txt.width+__widthAdd);
			bar.height=__heightMax?__heightMax:(txt.height+__heightAdd);
			if (txt.autoSize=="right") {
				bar.x=- int(bar.width)+__widthAdd*0.5;
			} else if (txt.autoSize=="center") {
				bar.x=- int(bar.width*0.5);
			} else {
				bar.x=- __widthAdd*0.5;
			}
			bar.x+=__xOff;
			bar.y=__yOff;
		}
	}
}