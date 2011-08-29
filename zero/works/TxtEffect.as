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
		public function TxtEffect(){
			this.stop();
			this.addFrameScript(this.totalFrames-1,update);
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
			num2["txt"].text=__value.toString();
		}
		private function update():void{
			this.gotoAndStop(1);
			num1["txt"].text=num2["txt"].text;
		}
	}
}
		