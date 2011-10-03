/***
DataLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月2日 18:24:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class DataLoader{
		
		////===
		//加载 url
		//创建时间：2011年8月2日 18:26:25
		private var urlLoader:URLLoader;
		
		public var url:String;
		public var onLoadComplete:Function;
		public var onLoadError:Function;
		
		public function DataLoader(){
			//加载 url
			//创建时间：2011年8月2日 18:26:25
			urlLoader=new URLLoader();
			//urlLoader.addEventListener(ProgressEvent.PROGRESS,urlLoadProgress);
			urlLoader.addEventListener(Event.COMPLETE,urlLoadComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,urlLoadError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,urlLoadError);
			//urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			////===
		}
		public function clear():void{
			if(urlLoader){
				//urlLoader.removeEventListener(ProgressEvent.PROGRESS,urlLoadProgress);
				urlLoader.removeEventListener(Event.COMPLETE,urlLoadComplete);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,urlLoadError);
				urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,urlLoadError);
				urlLoader=null;
			}
			
			onLoadComplete=null;
			onLoadError=null;
		}
		
		public function load(_url:String,obj:*=null,dataFormat:String=null,method:String=null,contentType:String=null):void{
			url=_url;
			var urlRequest:URLRequest=new URLRequest(url);
			if(obj){
				urlRequest.data=obj;
				if(contentType){
					urlRequest.contentType=contentType;
				}else{
					if(obj is ByteArray){
						urlRequest.contentType="application/octet-stream";
					}
				}
				urlRequest.method=method||URLRequestMethod.POST
			}
			urlLoader.dataFormat=dataFormat||URLLoaderDataFormat.TEXT;
			urlLoader.load(urlRequest);
		}
		public function close():void{
			try{
				urlLoader.close();
			}catch(e:Error){}
		}
		
		////===
		//加载 url
		//创建时间：2011年8月2日 18:26:25
		//private function urlLoadProgress(event:ProgressEvent):void{
		//	trace("加载进度");
		//}
		private function urlLoadComplete(event:Event):void{
			if(onLoadComplete==null){
			}else{
				onLoadComplete(urlLoader.data);
			}
		}
		private function urlLoadError(event:Event):void{
			trace("加载失败："+url);
			if(onLoadError==null){
			}else{
				onLoadError();
			}
		}
		////===
		
	}
}