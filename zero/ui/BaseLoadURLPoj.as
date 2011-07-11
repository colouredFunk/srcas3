/***
BaseLoadURLPoj 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月27日 21:24:00
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	public class BaseLoadURLPoj extends MovieClip{
		private var defaultXMLPath:String;
		private var xmlVarName:String;
		
		public var urlLoader:URLLoader;
		public static var xml:XML;
		
		public var needXML:Boolean;
		
		public function BaseLoadURLPoj(_defaultXMLPath:String=null,_xmlVarName:String="xml"){
			needXML=true;
			if(_defaultXMLPath){
				trace("使用指定的 xml 路径: "+_defaultXMLPath);
				defaultXMLPath=_defaultXMLPath;
			}else{
				defaultXMLPath="xml/"+getQualifiedClassName(this).toLowerCase()+".xml";
			}
			xmlVarName=_xmlVarName;
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			if(needXML){
				this.visible=false;
				urlLoader=new URLLoader();
				urlLoader.load(new URLRequest((stage.loaderInfo.parameters[xmlVarName]||defaultXMLPath)));
				urlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
			}else{
				this["init"]();
			}
		}
		private function loadXMLComplete(event:Event):void{
			xml=new XML(urlLoader.data);
			urlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
			this.visible=true;
			this["init"]();
		}
	}
}

