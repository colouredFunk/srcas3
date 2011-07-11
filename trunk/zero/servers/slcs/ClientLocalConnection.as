/***
ClientLocalConnection 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月16日 11:38:05
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.servers.slcs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.servers.BaseClient;
	import zero.servers.IClient;
	
	public class ClientLocalConnection extends BaseClient implements IClient{
		private var lc:LC;
		
		public function ClientLocalConnection(){
		}
		public function connect(_serverConnName:String):void{
			//
			initClient(_serverConnName);
			
			//
			lc=new LC();
			lc.connect("_"+clientConnName);
			lc.that2this=server2client;
			
			//
			client2server("connect",clientConnName);
		}
		public function close():void{
			clearClient();
			if(lc){
				lc.clear();
				lc=null;
			}
		}
		
		override protected function client2server(cmdName:String,...args):void{
			lc.send.apply(lc,["_"+serverConnName,"that2this",cmdName].concat(args));
		}
	}
}

