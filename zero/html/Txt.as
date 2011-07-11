/***
Txt 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月14日 21:10:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.html{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class Txt extends HTMLElement{
		private var txt:TextField;
		public function Txt(){
			txt=new TextField();
			this.addChild(txt);
			
			txt.border=true;
			txt.background=true;
		}
		
		public function get text():String{
			return txt.text;
		}
		public function set text(_text:String):void{
			txt.text=_text;
		}
		
		public function get type():String{
			return txt.type;
		}
		public function set type(_type:String):void{
			txt.type=_type;
		}
		
		public function get styleSheet():StyleSheet{
			return txt.styleSheet;
		}
		public function set styleSheet(_styleSheet:StyleSheet):void{
			txt.styleSheet=_styleSheet;
		}
	}
}

