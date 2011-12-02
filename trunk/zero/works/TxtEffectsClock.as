/***
TxtEffectsClock 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月27日 18:48:15
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	
	public class TxtEffectsClock extends Sprite{
		
		public var txt0:TxtEffects;
		public var txt1:TxtEffects;
		public var txt2:TxtEffects;
		public var txt3:TxtEffects;
		public var txt4:TxtEffects;
		
		private var serverDate:ServerDate;
		
		private var startDate:Date;
		private var timeUpDate:Date;
		
		private var version:String="";
		private var wid:int=-1;
		private var hei:int=-1;
		private var x0:int=-1;
		private var x1:int=-1;
		private var x2:int=-1;
		private var x3:int=-1;
		private var x4:int=-1;
		
		[Inspectable(name="起始时间",defaultValue="2011-10-17 16:15:00")]
		public var set_startTime:String="2011-10-17 16:15:00";
		
		[Inspectable(name="终结时间",defaultValue="2012-12-21 15:14:35")]
		public var set_endTime:String="2012-12-21 15:14:35";
		
		private var delayTime:int;
		
		private var xmlLoader:URLLoader;
		
		public function TxtEffectsClock(){
			this.addEventListener(Event.ENTER_FRAME,init);
			if(x0>0){
				txt0.x=x0;
				txt0.y=hei/2;
			}
			if(x1>0){
				txt1.x=x1;
				txt1.y=hei/2;
			}
			if(x2>0){
				txt2.x=x2;
				txt2.y=hei/2;
			}
			if(x3>0){
				txt3.x=x3;
				txt3.y=hei/2;
			}
			if(x4>0){
				txt4.x=x4;
				txt4.y=hei/2;
			}
			if(txt4){
				txt4.txt2.visible=false;
			}
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
			return <xml startTime={set_startTime} endTime={set_endTime}/>;
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
				set_endTime
			);
		}
		
		public function start(_serverDate:ServerDate,_startDate:*,_timeUpDate:*):void{
			this.removeEventListener(Event.ENTER_FRAME,init);
			this.removeEventListener(Event.ENTER_FRAME,initDelay);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			if(xmlLoader){
				xmlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
				xmlLoader=null;
			}
			
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
			if(_serverDate){
				serverDate=_serverDate;
				//selfInitServerDateComplete();
			}//else{
				//serverDate=new ServerDate();
				//serverDate.init(selfInitServerDateComplete);
			//}
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			var currTime:Number=serverDate.getDate().time;
			if(currTime<startDate.time){
				currTime=startDate.time;
			}
			var d:Number=timeUpDate.time-currTime;
			
			if(d<0){
				d=0;
			}
			var day:int=d/(24*3600*1000);
			d-=day*(24*3600*1000);
			var hours:int=d/(3600*1000);
			d-=hours*(3600*1000);
			var mins:int=d/(60*1000);
			d-=mins*(60*1000);
			var secs:int=d/1000;
			d-=secs*1000;
			var mss:int=d;
			
			if(txt0){
				txt0.value=day;
			}
			if(txt1){
				txt1.value=hours;
			}
			if(txt2){
				txt2.value=mins;
			}
			if(txt3){
				txt3.value=secs;
			}
			if(txt4){
				txt4.value=int(mss/100)*10;
			}
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/