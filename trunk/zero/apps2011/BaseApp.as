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
	
	import ui.Btn;
	
	public class BaseApp extends MovieClip{
		private var btns:Object;
		private var statusMcs:Object;
		public var settingXMLPath:String;//仅在编译测试时使用
		
		private var settingXMLLoader:URLLoader;
		
		public var settingXML:XML;
		
		public function BaseApp(){
			btns=new Object();
			statusMcs=new Object();
			if(stage){
				initByShell({});
			}
			if(this.totalFrames==3){
				this.addFrameScript(2,stop);
			}
		}
		public function initByShell(values:Object):void{
			//被壳初始化
			
			//20110418
			if(stage.loaderInfo.parameters.xml){
				values.settingXML=null;
				settingXMLPath=stage.loaderInfo.parameters.xml;
			}
			//
			
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
		private function addThingsToStage(thing:DisplayObject):void{
			if(thing is Btn){
				var btnKey:String=getBtnKey(thing as Btn);
				btns[btnKey]=thing;
				if(settingXML){
					initItems(btnKey);
				}
			}else if(thing.name.indexOf("_status_mc")>-1){
				var statusMcKey:String=thing.name.replace("_status_mc","");
				if(thing is MovieClip){
					thing["mouseEnabled"]=thing["mouseChildren"]=false;
					statusMcs[statusMcKey]=thing;
					thing["stop"]();
					if(settingXML){
						initItems(statusMcKey);
					}
				}else{
					throw new Error("status_mc 只能是影片剪辑");
				}
			}
		}
		private function initItems(key:String):void{
			for each(var btnXML:XML in settingXML.btn){
				if(btnXML.@key.toString()==key){
					//trace("btnXML="+btnXML.toXMLString());
					if(btns[key]){
						btns[key].hrefXML=btnXML;
						if(btnXML.@status.toString()=="未开放"){
							btns[key].mouseEnabled=btns[key].mouseChildren=false;
						}
					}else{
						throw new Error("key="+key+", 找不到 btn");
					}
					trace("key="+key);
					if(statusMcs[key]){
						statusMcs[key].gotoAndStop(btnXML.@status.toString());
					}
				}
			}
		}
		private function getBtnKey(btn:Btn):String{
			if(btn.name){
				if(/^instance\d+$/.test(btn.name)){
					//一般就是没命名的，系统给自动命名成：instancexxx
				}else{
					return btn.name;
				}
			}
			return getQualifiedClassName(btn);
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
		
		
		private function initSettingXMLFinished():void{
			for(var btnKey:String in btns){
				initItems(btnKey);
			}
			
			//throw new Error("settingXML="+settingXML.toXMLString());
		}
	}
}
		