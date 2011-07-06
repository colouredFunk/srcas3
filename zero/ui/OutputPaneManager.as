/***
OutputPaneManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月13日 10:44:40
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import mx.core.mx_internal;
	
	public class OutputPaneManager{
		
		public var txt:*;
		public var btn:*;
		
		private var strArr:Array;
		private var timeoutId:int=-1;
		private var linkFunArr:Array;
		private var linkId:int;
		
		public function OutputPaneManager(_txt:*,_btn:*){
			txt=_txt;
			btn=_btn;
			
			txt.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			btn.addEventListener(MouseEvent.CLICK,click);
			
			linkFunArr=new Array();
			linkId=0;
			strArr=new Array();
			txt.styleSheet=new StyleSheet();
			txt.styleSheet.parseCSS((
<style type="text/css">
	<![CDATA[
		a:link {
			color: #3399ff;
			text-decoration: underline;
		}
		a:hover {
			color: #ff9933;
			text-decoration: underline;
		}
		.red 	{color: #cc0000;}
		.green 	{color: #006600;}
		.blue 	{color: #0000cc;}
		.brown	{color: #ff6600;}
		.grey	{color: #bbbbbb;}
		.pink	{color: #ff00ff;}
	]]>
</style>
			).toString());
			txt.addEventListener(TextEvent.LINK,link);
		}
		
		private function removed(event:Event):void{
			clear();
		}
		public function clear():void{
			//^_^
			
			if(txt){
				txt.removeEventListener(TextEvent.LINK,link);
				txt.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
				txt=null;
			}
			
			if(btn){
				btn.removeEventListener(MouseEvent.CLICK,click);
				btn=null;
			}
			
			linkFunArr=null;
			strArr=null;
			clearTimeout(timeoutId);
		}
		public function output(msg:String,styleOrXML:*=undefined,tail:*=null,linkFun:Function=null,immediately:Boolean=false):void{
			if(linkFun==null){
			}else{
				var tailXML:XML=<a href={"event:"+linkId}/>
				tailXML.appendChild(tail);
				linkFunArr[linkId]=linkFun;
				linkId++;
				tail=tailXML;
			}
			msg2strArr(msg,styleOrXML,tail);
			clearTimeout(timeoutId);
			if(immediately){
				updateDelay();
			}else{
				timeoutId=setTimeout(updateDelay,100);
			}
		}
		private function link(event:TextEvent):void{
			if(linkFunArr[event.text]){
				linkFunArr[event.text]();
				return;
			}
			
			var FileClass:*;
			try{
				FileClass=flash.utils.getDefinitionByName("flash.filesystem.File");
			}catch(e:Error){
				FileClass=null;
			}
			
			var id:int=event.text.indexOf(":");
			if(id>0){
				switch(event.text.substr(0,id)){
					case "file":
						if(FileClass){
							var file:*=new FileClass(event.text.substr(id+1));
							if(file.exists){
								if(new FileClass(FileClass.applicationDirectory.nativePath).getRelativePath(file) is String){
									/*
									outputError("不能直接打开 applicationDirectory 目录下的东西，尝试用浏览器打开");
									//http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118666ade46-7fe4.html#WS2A7C0A31-A6A9-42d2-8772-79166A98A085
									//You cannot use the openWithDefaultApplication() method with files located in the application directory.
									trace(decodeURI(file.url).replace("file:///",""));
									navigateToURL(new URLRequest(decodeURI(file.url).replace("file:///","")));
									*/
									outputError("不能直接打开 applicationDirectory 目录下的东西");
								}else{
									file.openWithDefaultApplication();
								}
							}else{
								outputError("目录不存在");
							}
						}else{
							outputError("不支持 File 的使用");
						}
					break;
					default:
						throw new Error("未处理的 link: "+event.text);
					break;
				}
			}
		}
		private function encodeMsg(msg:String):String{
			return msg.replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/\x00/g,"\\x00");
		}
		private function msg2strArr(msg:String,styleOrXML:*,tail:*):void{
			var execResult:Array;
			if(styleOrXML){
				var html:XML;
				switch(styleOrXML){
					case "folder and file":
					case "folder":
						msg=encodeMsg(msg);
						if(msg.indexOf("file:///")>-1){
							execResult=/^(.*?)file:\/\/\/(.*\/)(.*?)$/.exec(msg);
							
							if(execResult[0]==msg){
								msg='<span class="blue">'+execResult[1]+'file:///</span>';
								var path:String="file:///";
								for each(var subPath:String in execResult[2].match(/.*?\/+/g)){
									path+=subPath;
									msg+='<a href="event:file:'+path+'">'+subPath+'</a>';
								}
								if(execResult[3]){
									path+=execResult[3];
									msg+='<a href="event:file:'+path+'">'+execResult[3]+'</a>';
								}
							}else{
								throw new Error("msg 格式不正确");
							}
						}else if(msg.indexOf("http://")>-1){
							execResult=/^(.*?)(http:\/\/.*?)(\s*)$/.exec(msg);
							if(execResult[0]==msg){
								msg='<span class="blue">'+execResult[1]+'</span>'+
									'<a href="'+execResult[2]+'" target="_blank">'+execResult[2]+'</a>';
							}else{
								throw new Error("msg 格式不正确");
							}
						}else{
							throw new Error("msg 格式不正确");
						}
					break;
					case "file":
						throw new Error("未处理");
					break;
					default:
						if(styleOrXML is XML){
							html=styleOrXML.copy();
						}else{
							html=<span class={styleOrXML}/>
						}
						html.appendChild(msg);
						msg=html.toXMLString();
					break;
				}
			}else{
				msg=encodeMsg(msg);
			}
			if(tail){
				if(tail is XML){
					msg+="　"+tail.toXMLString();
				}else{
					msg+="　"+tail;
				}
			}
			if(strArr.length>1000){
				click(null);
				strArr[0]="输出过多自动清除...<br>";
			}
			strArr[strArr.length]=msg+"<br>";
		}
		private function updateDelay():void{
			txt.htmlText=strArr.join("");
			txt.validateNow();
			txt.verticalScrollPosition=txt.mx_internal::getTextField().numLines;
			txt.validateNow();
			/*
			txt.validateNow();
			while(txt.textHeight>this.height-50&&strArr.length>0){
			strArr.shift();
			txt.htmlText=strArr.join("");
			txt.validateNow();
			}
			*/
		}
		public function outputError(msg:String):void{
			output(msg,"red");
		}
		private function click(event:MouseEvent):void{
			txt.htmlText="";
			strArr=new Array();
		}
	}
}
		