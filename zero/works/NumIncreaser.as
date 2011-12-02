/***
NumIncreaser
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月2日 09:48:40
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
	import flash.ui.*;
	import flash.utils.*;
	
	public class NumIncreaser extends Sprite{
		private static const ranArr:Array=[1,2,1,1,1,1,1,3,2,3,1,1,2,1,2,1,1,2,2,1,3,2,2,2,2,2,1,2,1,2,2,2,1,2,1,2,1,2,1,1,2,1,1,2,1,1,1,2,1,2,2,2,2,1,2,3,1,1,2,1,2,2,2,1,1,1,2,2,2,1,1,1,2,2,2,2,2,2,1,2,2,2,2,2,1,1,2,2,2,1,2,2,2,1,1,2,1,2,1,1];
		
		private var serverDate:ServerDate;
		private var startDate:Date;
		private var timeUpDate:Date;
		private var startNum:int;
		private var endNum:int;
		
		private var arrSum:int;
		private var dateSum:int;
		private var k:Number;
		
		private var txt:TextField;
		
		private var version:String="";
		private var wid:int=-1;
		private var hei:int=-1;
		private var size:int=-1;
		private var isBold:Boolean=false;
		
		[Inspectable(name="起始时间",defaultValue="2011-10-17 16:15:00")]
		public var set_startTime:String="2011-10-17 16:15:00";
		
		[Inspectable(name="终结时间",defaultValue="2012-12-21 15:14:35")]
		public var set_endTime:String="2012-12-21 15:14:35";
		
		[Inspectable(name="起始人数",defaultValue=0)]
		public var set_startNum:int=0;
		
		[Inspectable(name="终结人数",defaultValue=1000000)]
		public var set_endNum:int=1000000;
		
		private var delayTime:int;
		
		private var xmlLoader:URLLoader;
		
		public var bg:Sprite;
		
		public function NumIncreaser(){
			
			var i:int;
			var _txt:*;
			
			i=this.numChildren;
			while(--i>=0){
				_txt=this.getChildAt(i);
				if(
					_txt is TextField
					//||
					//getQualifiedClassName(_txt).indexOf("TxtEffects")>-1
				){
					txt=_txt;
					break;
				}
			}
			
			if(txt){
			}else{
				throw new Error("找不到 txt");
			}
			
			txt.autoSize=TextFieldAutoSize.CENTER;
			txt.text="";
			
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
			return <xml startTime={set_startTime} endTime={set_endTime} startNum={set_startNum} endNum={set_endNum}/>;
		}
		private function initDelay(event:Event):void{
			if(--delayTime<=0){
			}else{
				return;
			}
			this.removeEventListener(Event.ENTER_FRAME,initDelay);
			
			if(
				this.loaderInfo.parameters.startTime
				||
				this.loaderInfo.parameters.endTime
				||
				this.loaderInfo.parameters.startNum
				||
				this.loaderInfo.parameters.endNum
			){
				if(this.loaderInfo.parameters.startTime){
					set_startTime=this.loaderInfo.parameters.startTime;
				}
				if(this.loaderInfo.parameters.endTime){
					set_endTime=this.loaderInfo.parameters.endTime;
				}
				if(int(this.loaderInfo.parameters.startNum)>0){
					set_startNum=int(this.loaderInfo.parameters.startNum);
				}
				if(int(this.loaderInfo.parameters.endNum)>0){
					set_endNum=int(this.loaderInfo.parameters.endNum);
				}
				initServerDate();
			}else if(this.loaderInfo.parameters.xml){
				if(this.loaderInfo.parameters.xml.indexOf("<")==0){
					initXML(this.loaderInfo.parameters.xml);
				}else{
					xmlLoader=new URLLoader();
					xmlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
				}
			}else{
				initServerDate();
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
				if(xml.@startTime.toString()){
					set_startTime=xml.@startTime.toString();
				}
				if(xml.@endTime.toString()){
					set_endTime=xml.@endTime.toString();
				}
				if(int(xml.@startNum.toString())>0){
					set_startNum=int(xml.@startNum.toString());
				}
				if(int(xml.@endNum.toString())>0){
					set_endNum=int(xml.@endNum.toString());
				}
				initServerDate();
			}else{
				throw new Error("xml 格式不正确：xmlStr="+xmlStr);
			}
		}
		private function initServerDate():void{
			serverDate=new ServerDate();
			serverDate.init(initServerDateComplete);
		}
		private function initServerDateComplete():void{
			start(
				serverDate,
				set_startTime,
				set_endTime,
				set_startNum,
				set_endNum
			);
		}
		
		public function start(_serverDate:ServerDate,_startDate:*,_timeUpDate:*,_startNum:int=0,_endNum:int=100000):void{
			this.removeEventListener(Event.ENTER_FRAME,init);
			this.removeEventListener(Event.ENTER_FRAME,initDelay);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			if(xmlLoader){
				xmlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
				xmlLoader=null;
			}
			
			showNum(88888888);
			var b:Rectangle=txt.getBounds(this);
			txt.x+=(wid-b.width)/2-b.x;
			txt.y+=(hei-b.height)/2-b.y;
			txt.text="";
			
			if(_startDate is Date){
			}else{
				_startDate=getDateByDateStr(_startDate);
			}
			if(_timeUpDate is Date){
			}else{
				_timeUpDate=getDateByDateStr(_timeUpDate);
			}
			startDate=_startDate;
			timeUpDate=_timeUpDate;
			
			var i:int;
			
			arrSum=0;
			for(i=0;i<100;i++){
				arrSum+=ranArr[i];
			}
			dateSum=arrSum*864;
			
			startNum=_startNum;
			endNum=_endNum;
			k=(endNum-startNum)/getNum((timeUpDate.time-startDate.time)/1000);
			//trace("k="+k);
			
			if(_serverDate){
				serverDate=_serverDate;
				selfInitServerDateComplete();
			}else{
				serverDate=new ServerDate();
				serverDate.init(selfInitServerDateComplete);
			}
			
		}
		private function selfInitServerDateComplete():void{
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			
			var currTime:int=serverDate.getDate().time/1000;
			
			if(currTime<startDate.time/1000){
				currTime=startDate.time/1000;
			}else if(currTime>timeUpDate.time/1000){
				currTime=timeUpDate.time/1000;
			}
			
			var dTime:int=currTime-startDate.time/1000;
			if(dTime>0){
			}else{
				dTime=0;
			}
			
			//if(txt is TextField){
			//	txt.text=int(startNum+getNum(dTime)*k);
			//}else{
			//	txt.value=int(startNum+getNum(dTime)*k);
			//}
			
			showNum(int(startNum+getNum(dTime)*k));
			
		}
		private function showNum(num:int):void{
			var htmlText:String=num.toString();
			if(size>0){
				htmlText='<font size="'+size+'">'+htmlText+'</font>';
			}
			if(isBold){
				htmlText="<b>"+htmlText+"</b>";
			}
			txt.htmlText=htmlText;
		}
		private function getNum(dTime:int):int{
			var num:int=int(dTime/86400)*dateSum;
			dTime=dTime%86400;
			num+=int(dTime/100)*arrSum;
			dTime=dTime%100;
			for(var i:int=0;i<dTime;i++){
				num+=ranArr[i];
			}
			return num;
		}
	}
}