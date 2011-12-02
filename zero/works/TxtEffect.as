/***
TxtEffect
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月4日 18:35:55
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class TxtEffect extends MovieClip{
		
		public var num1:Sprite;
		public var num2:Sprite;
		public var bg:Sprite;
		
		private var txt1:TextField;
		private var txt2:TextField;
		
		private var bgWid:int=-1;
		private var bgHei:int=-1;
		private var size:int=-1;
		private var isBold:Boolean=false;
		
		public function TxtEffect(){
			txt1=num1["txt"];
			txt2=num2["txt"];
			setTxt(txt1,"0");
			setTxt(txt2,"0");
			this.stop();
			this.addFrameScript(this.totalFrames-1,update);
			
			if(bgWid>0){
				bg.width=bgWid;
			}
			if(bgHei>0){
				bg.height=bgHei;
			}
		}
		
		private function setTxt(txt:TextField,htmlText:String):void{
			if(size>0){
				htmlText='<font size="'+size+'">'+htmlText+'</font>';
			}
			if(isBold){
				htmlText="<b>"+htmlText+"</b>";
			}
			txt.htmlText=htmlText;
			txt.autoSize=TextFieldAutoSize.CENTER;
			txt.x=-txt.width/2;
			txt.y=-txt.height/2;
		}
		
		private var __value:int;
		public function get value():int{
			return __value;
		}
		public function set value(_value:int):void{
			if(__value==_value){
				return;
			}
			__value=_value;
			this.gotoAndPlay(2);
			setTxt(txt2,__value.toString());
		}
		private function update():void{
			this.gotoAndStop(1);
			setTxt(txt1,txt2.text);
		}
	}
}
		