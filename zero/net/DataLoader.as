/***
DataLoader 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月1日 14:46:00
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class DataLoader extends URLLoader{
		public var requestLoader:RequestLoader;
		public var url:String;
		
		private var onLoadFinished:Function;
		
		public function DataLoader(_onLoadProgress:Function,_onLoadFinished:Function){
			
			onLoadFinished=_onLoadFinished;
			
			requestLoader=new RequestLoader(this,_onLoadProgress,loadFinished);
		}
		public function clear():void{
			try{
				this.close();
				//trace("loadData close "+_url);
			}catch(e:Error){
				//trace("loadData no stream, no need to close "+_url);
			}
			requestLoader.clear();
			requestLoader=null;
		}
		
		public function loadData(_url:String,variables:Object=null,_dataFormat:String=null,_method:String=null):void{
			url=_url;
			//trace("url="+_url);
			
			this.dataFormat=_dataFormat?_dataFormat:(
				RequestLoader.isText(url)?URLLoaderDataFormat.TEXT:URLLoaderDataFormat.BINARY
			);
			
			this.load(requestLoader.load(url,variables,_method));
		}
		
		private function loadFinished(info:String):void{
			//trace("info="+info);
			
			if(onLoadFinished==null){
			}else{
				onLoadFinished(info);
			}
		}
	}
}

