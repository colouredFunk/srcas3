/***
TxtEffects
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月4日 19:21:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class TxtEffects extends Sprite{
		public function TxtEffects(){
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
			var i:int=0;
			var num:int=1;
			while(this.hasOwnProperty("txt"+i)){
				var txt:TxtEffect=this["txt"+i];
				num*=10;
				txt.value=(__value%num)/int(num/10);
				i++;
			}
		}
	}
}
		