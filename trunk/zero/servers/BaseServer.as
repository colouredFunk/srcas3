/***
BaseServer 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月16日 12:04:16
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.servers{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class BaseServer{
		protected var clientConnNameV:Vector.<String>;
		protected var serverConnName:String;
		
		public function BaseServer(){
		}
		protected function initServer(_serverConnName:String):void{
			clientConnNameV=new Vector.<String>();
			serverConnName=_serverConnName;
		}
		protected function clearServer():void{
			clientConnNameV=null;
		}
		protected function client2server(cmdName:String,...args):void{
			trace("client2server cmdName="+cmdName+",args="+args);
			switch(cmdName){
				case "connect":
					clientConnNameV.push(args[0]);
					server2client(args[0],"connectSuccess");
				break;
			}
		}
		protected function server2client(clientConnName:String,cmdName:String,...args):void{
			//请 override 来使用
		}
	}
}

