/***
Btn 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月14日 20:50:10
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.html{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	
	public class Btn extends HTMLElement{
		private var txt:TextField;
		public function Btn(){
			txt=new TextField();
			this.addChild(txt);
			
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.border=true;
			txt.background=true;
			txt.selectable=false;
			
			this.buttonMode=true;
			this.mouseChildren=false;
		}
		
		private var __label:String;
		public function get label():String{
			return __label;
		}
		public function set label(_label:String):void{
			//大致的补齐按钮文本的两边
			__label=_label;
			var i:int=_label.length;
			var wid:int=0;
			while(--i>=0){
				if(_label.charCodeAt(i)>0xff){
					wid+=2;
				}else{
					wid++;
				}
			}
			while(wid<16){
				_label=" "+_label+" ";
				wid+=2;
			}
			txt.htmlText='<a href="event:'+id+'">'+_label+'</a>';
		}
		
		public function get styleSheet():StyleSheet{
			return txt.styleSheet;
		}
		public function set styleSheet(_styleSheet:StyleSheet):void{
			txt.styleSheet=_styleSheet;
		}
	}
}

