/***
BaseApp
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月7日 17:32:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.apps2011{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class BaseApp extends MovieClip{
		
		public var settingXMLPath:String;//仅在编译测试时使用
		
		private var settingXMLLoader:URLLoader;
		
		public var settingXML:XML;
		
		public function BaseApp(){
			if(stage){
				initByShell({});
			}
			if(this.totalFrames==3){
				this.addFrameScript(2,stop);
			}
		}
		public function initByShell(values:Object):void{
			//被壳初始化
			if(values.settingXML){
				settingXML=values.settingXML;
			}
			
			stage.addEventListener(Event.ADDED,added);
			this.addEventListener(Event.ENTER_FRAME,initDataDelay);
			
			forEachChildAddThingsToStage(stage);
		}
		private function added(event:Event):void{
			addThingsToStage(event.target as DisplayObject);
		}
		public function addThingsToStage(thing:DisplayObject):void{
			throw new Error("舞台上添加东西将调用此函数，请 override 来使用");
		}
		public function forEachChildAddThingsToStage(obj:DisplayObjectContainer):void{
			var i:int=obj.numChildren;
			while(--i>=0){
				var child:DisplayObject=obj.getChildAt(i);
				addThingsToStage(child);
				if(child is DisplayObjectContainer){
					forEachChildAddThingsToStage(child as DisplayObjectContainer);
				}
			}
		}
		
		private function initDataDelay(event:Event):void{
			this.removeEventListener(Event.ENTER_FRAME,initDataDelay);
			
			if(settingXML){
				initSettingXMLFinished();
			}else if(settingXMLPath){
				//编译测试
				//加载 settingXML
				//创建时间：2011年4月8日 10:59:14
				settingXMLLoader=new URLLoader();
				//settingXMLLoader.addEventListener(ProgressEvent.PROGRESS,settingXMLLoadProgress);
				settingXMLLoader.addEventListener(Event.COMPLETE,settingXMLLoadComplete);
				settingXMLLoader.addEventListener(IOErrorEvent.IO_ERROR,settingXMLLoadError);
				//settingXMLLoader.dataFormat=URLLoaderDataFormat.BINARY;
				settingXMLLoader.load(new URLRequest(settingXMLPath));
				////===
			}else{
				//throw new Error("未配置 settingXML 或 settingXMLPath");
				
				trace("未配置 settingXML 或 settingXMLPath");
			}
		}
		
		////===
		//加载 settingXML
		//创建时间：2011年4月8日 10:59:14
		//private function settingXMLLoadProgress(event:ProgressEvent):void{
		//	trace("加载进度");
		//}
		private function settingXMLLoadComplete(event:Event):void{
			//编译测试
			settingXML=new XML(settingXMLLoader.data);
			//settingXMLLoader.removeEventListener(ProgressEvent.PROGRESS,settingXMLLoadProgress);
			settingXMLLoader.removeEventListener(Event.COMPLETE,settingXMLLoadComplete);
			settingXMLLoader.removeEventListener(IOErrorEvent.IO_ERROR,settingXMLLoadError);
			settingXMLLoader=null;
			
			initSettingXMLFinished();
		}
		private function settingXMLLoadError(event:IOErrorEvent):void{
			//编译测试
			//settingXMLLoader.removeEventListener(ProgressEvent.PROGRESS,settingXMLLoadProgress);
			settingXMLLoader.removeEventListener(Event.COMPLETE,settingXMLLoadComplete);
			settingXMLLoader.removeEventListener(IOErrorEvent.IO_ERROR,settingXMLLoadError);
			settingXMLLoader=null;
			
			trace("加载 \""+settingXMLPath+"\" 失败");
			
			initSettingXMLFinished();//主要是为了动画能在没配置 xml 的情况下仍然能正常导出检查
		}
		////===
		
		public function initSettingXMLFinished():void{
			throw new Error("数据初始化完毕将调用此函数，请 override 来使用");
		}
	}
}
		