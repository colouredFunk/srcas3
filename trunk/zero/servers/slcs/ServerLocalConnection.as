/***
ServerLocalConnection 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月16日 11:00:09
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.servers.slcs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.servers.BaseServer;
	import zero.servers.IServer;
	
	public class ServerLocalConnection extends BaseServer implements IServer{
		private var lc:LC;
		
		public function ServerLocalConnection(){
		}
		public function connect(_serverConnName:String):void{
			//
			initServer(_serverConnName);
			
			//
			lc=new LC();
			lc.connect("_"+serverConnName);
			lc.that2this=client2server;
			
			//
			
		}
		public function close():void{
			clearServer();
			if(lc){
				lc.clear();
				lc=null;
			}
		}
		
		override protected function server2client(clientConnName:String,cmdName:String,...args):void{
			lc.send.apply(lc,["_"+clientConnName,"that2this",cmdName].concat(args));
		}
	}
}

