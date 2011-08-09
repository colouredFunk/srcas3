/***
ServerTime
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月6日 13:19:41
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
	
	public class ServerTime{
		
		////===
		//加载 getTime
		//创建时间：2011年5月11日 15:29:43
		private var getTimeLoader:URLLoader;
		
		private var onGetTimeComplete:Function;
		
		public function ServerTime(_onGetTimeComplete:Function){
			
			onGetTimeComplete=_onGetTimeComplete;
			
			//加载 getTime
			//创建时间：2011年5月11日 15:29:43
			getTimeLoader=new URLLoader();
			//getTimeLoader.addEventListener(ProgressEvent.PROGRESS,getTimeLoadProgress);
			getTimeLoader.addEventListener(Event.COMPLETE,getTimeLoadComplete);
			getTimeLoader.addEventListener(IOErrorEvent.IO_ERROR,getTimeLoadError);
			getTimeLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,getTimeLoadError);
			//getTimeLoader.dataFormat=URLLoaderDataFormat.BINARY;
			try{
				getTimeLoader.load(new URLRequest("http://event21.wanmei.com/demo/flash/systime.jsp?"+Math.random()));
			}catch(e:Error){
				onGetTimeComplete(new Date());
				
				//getTimeLoader.removeEventListener(ProgressEvent.PROGRESS,getTimeLoadProgress);
				getTimeLoader.removeEventListener(Event.COMPLETE,getTimeLoadComplete);
				getTimeLoader.removeEventListener(IOErrorEvent.IO_ERROR,getTimeLoadError);
				getTimeLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,getTimeLoadError);
				getTimeLoader=null;
				
				onGetTimeComplete=null;
			}
			////===
		}
		
		////===
		//加载 getTime
		//创建时间：2011年5月11日 15:29:43
		//private function getTimeLoadProgress(event:ProgressEvent):void{
		//	trace("加载进度");
		//}
		private function getTimeLoadComplete(event:Event):void{
			trace("getTimeLoader.data="+getTimeLoader.data);
			var execResult:Array=/(\d\d\d\d)\-(\d\d)\-(\d\d) (\d\d)\:(\d\d)\:(\d\d)/.exec(getTimeLoader.data);
			
			//getTimeLoader.removeEventListener(ProgressEvent.PROGRESS,getTimeLoadProgress);
			getTimeLoader.removeEventListener(Event.COMPLETE,getTimeLoadComplete);
			getTimeLoader.removeEventListener(IOErrorEvent.IO_ERROR,getTimeLoadError);
			getTimeLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,getTimeLoadError);
			getTimeLoader=null;
			
			onGetTimeComplete(new Date(
				int(execResult[1]),
				int(execResult[2])-1,
				int(execResult[3]),
				int(execResult[4]),
				int(execResult[5]),
				int(execResult[6])
			));
			
			onGetTimeComplete=null;
		}
		private function getTimeLoadError(event:Event):void{
			trace("加载 getTime 失败");
			//getTimeLoader.removeEventListener(ProgressEvent.PROGRESS,getTimeLoadProgress);
			getTimeLoader.removeEventListener(Event.COMPLETE,getTimeLoadComplete);
			getTimeLoader.removeEventListener(IOErrorEvent.IO_ERROR,getTimeLoadError);
			getTimeLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,getTimeLoadError);
			getTimeLoader=null;
			
			onGetTimeComplete(new Date());
			
			onGetTimeComplete=null;
		}
		////===
	}
}