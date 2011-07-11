/***
BaseClient 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月16日 12:04:47
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.servers{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class BaseClient{
		protected var serverConnName:String;
		protected var clientConnName:String;
		
		public function BaseClient(){
		}
		protected function initClient(_serverConnName:String):void{
			serverConnName=_serverConnName;
			clientConnName=_serverConnName+Math.random().toString().substr(2);
		}
		protected function clearClient():void{
			
		}
		protected function server2client(cmdName:String,...args):void{
			trace("server2client cmdName="+cmdName+",args="+args);
			switch(cmdName){
				case "connectSuccess":
					//
				break;
			}
		}
		protected function client2server(cmdName:String,...args):void{
			//请 override 来使用
		}
	}
}

