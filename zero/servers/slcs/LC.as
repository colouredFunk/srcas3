/***
LC 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月16日 11:26:14
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.servers.slcs{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	public class LC extends LocalConnection{
		
		public var that2this:Function;
		
		public function LC(){
			this.addEventListener(StatusEvent.STATUS,onStatus);
			this.allowDomain("*");
		}
		
		public function clear():void{
			this.removeEventListener(StatusEvent.STATUS,onStatus);
			that2this=null;
			try{
				this.close();
			}catch(e:Error){};
		}
		private function onStatus(event:StatusEvent):void{
			switch(event.level){
				case "error":
					throw new Error("lc onStatus 出错 event="+event);
				break;
			}
		}
	}
}

