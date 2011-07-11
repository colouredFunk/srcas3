/***
ServerManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月16日 10:13:25
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.servers{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class ServerManager{
		
		private var server:*;
		
		public function ServerManager(
			serverClass:Class,
			connName:String
		){
			//SinglePlayer, LocalConnection, Socket, PHP, FMS, P2P
			
			server=new serverClass();
			server.init(connName);
		}
	}
}

