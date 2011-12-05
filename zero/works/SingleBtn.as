/***
SingleBtn
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月2日 14:04:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class SingleBtn extends Sprite{
		public var btn:Btn;
		
		private var version:String="";
		private var wid:int=-1;
		private var hei:int=-1;
		
		[Inspectable(name="链接",defaultValue="http://www.wanmei.com")]
		public var href:String="http://www.wanmei.com";
		
		[Inspectable(name="目标",defaultValue="_blank")]
		public var target:String="_blank";
		
		[Inspectable(name="JavaScript代码",defaultValue="")]
		public var js:String="";
		
		private var delayTime:int;
		
		private var xmlLoader:URLLoader;
		
		public function SingleBtn(){
			this.addEventListener(Event.ENTER_FRAME,init);
		}
		private function init(event:Event):void{
			if(wid>0&&hei>0){
			}else{
				try{
					wid=this.loaderInfo.width;
					hei=this.loaderInfo.height;
				}catch(e:Error){
					wid=-1;
					hei=-1;
					return;
				}
			}
			this.removeEventListener(Event.ENTER_FRAME,init);
			
			//this.graphics.clear();
			//this.graphics.beginFill(0x00ff00,0.3);
			//this.graphics.drawRect(0,0,wid,hei);
			//this.graphics.endFill();
			
			if(this.contextMenu){
			}else{
				this.contextMenu=new ContextMenu();
			}
			this.contextMenu.hideBuiltInItems();
			if(this.contextMenu.customItems){
			}else{
				this.contextMenu.customItems=new Array();
			}
			var item:ContextMenuItem=new ContextMenuItem("宽 "+wid+" 像素，高 "+hei+" 像素"+(version?"；出厂时间："+version:""));
			this.contextMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,clickMenuItem);
			
			delayTime=5;
			this.addEventListener(Event.ENTER_FRAME,initDelay);
		}
		private function clickMenuItem(event:ContextMenuEvent):void{
			System.setClipboard(getHTMLCode());
		}
		public function getHTMLCode(src:String=null):String{
			if(src){
			}else{
				var urlArr:Array=this.loaderInfo.url.replace(/^(.*)\?.*$/,"$1").split("/");
				//do{
				var url1:String=urlArr.pop();
				var url2:String=urlArr.pop();
				//}while(url2=="[[DYNAMIC]]");
				src=url2+"/"+url1;
			}
			return '<script src="http://www.wanmei.com/public/js/swfobject.js" type="text/javascript"></script>\n'+
				'<div id="containerID"></div>\n'+
				'<script type="text/javascript">\n'+
				'	addSWF("'+src+'","containerID",'+wid+','+hei+',{xml:"'+getXML().toXMLString().replace(/"/g,"'")+'"});\n'+
				'</script>\n';
		}
		public function getXML():XML{
			var xml:XML=<xml/>;
			if(href){
				xml.@href=href;
				if(target){
					xml.@target=target;
				}
			}
			if(js){
				xml.@js=js;
			}
			return xml;
		}
		private function initDelay(event:Event):void{
			if(--delayTime<=0){
			}else{
				return;
			}
			this.removeEventListener(Event.ENTER_FRAME,initDelay);
			
			if(
				this.loaderInfo.parameters.href
				||
				this.loaderInfo.parameters.target
				||
				this.loaderInfo.parameters.js
			){
				if(this.loaderInfo.parameters.href){
					href=this.loaderInfo.parameters.href;
				}
				if(this.loaderInfo.parameters.target){
					target=this.loaderInfo.parameters.target;
				}
				if(this.loaderInfo.parameters.js){
					js=this.loaderInfo.parameters.js;
				}
				initBtn();
			}else if(this.loaderInfo.parameters.xml){
				if(this.loaderInfo.parameters.xml.indexOf("<")==0){
					initXML(this.loaderInfo.parameters.xml);
				}else{
					xmlLoader=new URLLoader();
					xmlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
				}
			}else{
				initBtn();
			}
		}
		private function loadXMLComplete(event:Event):void{
			xmlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
			initXML(xmlLoader.data);
			xmlLoader=null;
		}
		private function initXML(xmlStr:String):void{
			var xml:XML;
			try{
				xml=new XML(xmlStr);
				if(xml.name().toString()){
				}else{
					xml=null;
				}
			}catch(e:Error){
				xml=null;
			}
			if(xml){
				if(xml.@href.toString()){
					href=xml.@href.toString();
					if(xml.@target.toString()){
						target=xml.@target.toString();
					}
				}
				if(xml.@js.toString()){
					js=xml.@js.toString();
				}
				initBtn();
			}else{
				throw new Error("xml 格式不正确：xmlStr="+xmlStr);
			}
		}
		private function initBtn():void{
			if(href){
				btn.hrefXML=<xml href={href} target={target||"_blank"}/>;
			}else if(js){
				btn.hrefXML=<xml js={js}/>;
			}
		}
	}
}