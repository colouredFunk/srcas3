/***
AVM1CodesGenerater
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月4日 09:43:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class AVM1CodesGenerater extends Sprite{
		
		private var xml:XML;
		private var xmlLoader:URLLoader;
		
		private var templates:Object;
		private var templateNameArr:Array=["fileAndUserInfo","AVM1Ops"];
		private var templateId:int;
		private var templateLoader:URLLoader;
		
		public function AVM1CodesGenerater(){
			
			xmlLoader=new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
			
			templateLoader=new URLLoader();
			templateLoader.addEventListener(Event.COMPLETE,loadTemplateComplete);
			
			xmlLoader.load(new URLRequest("AVM1Ops.xml"));
		}
		private function loadXMLComplete(event:Event):void{
			xml=new XML(xmlLoader.data);
			
			templates=new Object();
			templateId=-1;
			loadNextTemplate();
		}
		
		private function loadNextTemplate():void{
			if(++templateId>=templateNameArr.length){
				saveAVM1OpsCode();
				return;
			}
			templateLoader.load(new URLRequest("模板们/"+templateNameArr[templateId]+".as"));
		}
		private function loadTemplateComplete(event:Event):void{
			templates[templateNameArr[templateId]]=templateLoader.data;
			loadNextTemplate();
		}
		
		private function saveAVM1OpsCode():void{
			
			var op:int,opXML:XML;
			
			var opXMLArr:Array=new Array();
			for each(opXML in xml.children()){
				opXMLArr[int(opXML.@op.toString())]=opXML;
			}
			
			var defines:String="";
			var opNames:String="";
			for(op=0;op<256;op++){
				
				opXML=opXMLArr[op];
				
				defines+="		";
				opNames+="			";
				if(opXML){
					defines+="public static const "+opXML.@opName.toString()+":int="+op+";";
					opNames+='"'+opXML.@opName.toString()+'",'
				}else{
					opNames+="null,";
				}
				
				var tail:String=(op<16?"//0x0":"//0x")+op.toString(16)+"\n";
				defines+=tail;
				opNames+=tail;
			}
			
			var AVM1OpsCode:String=
			templates["AVM1Ops"]
			.replace(/\$\{fileAndUserInfo\}/g,templates["fileAndUserInfo"])
			.replace(/\$\{fileName\}/g,"AVM1Ops")
			.replace(/\$\{time\}/g,getTime())
			.replace(/\$\{CodesGenerater\}/g,decodeURI(this.loaderInfo.url))
			.replace(/\$\{defines\}/g,defines)
			.replace(/\$\{opNames\}/g,opNames)
			.replace(/^\s*|\s*$/g,"");
			
			new FileReference().save(AVM1OpsCode,"AVM1Ops.as");
		}
		
		private static function getTime():String{
			var date:Date=new Date();
			var month:int=date.getMonth()+1;
			var day:int=date.getDate();
			var hours:int=date.getHours();
			var minutes:int=date.getMinutes();
			var seconds:int=date.getSeconds();
			
			return date.getFullYear()+"年"
				+(month<10?"0":"")+month+"月"
				+(day<10?"0":"")+day+"日 "
				+(hours<10?"0":"")+hours+":"
				+(minutes<10?"0":"")+minutes+":"
				+(seconds<10?"0":"")+seconds;
		}
	}
}
		