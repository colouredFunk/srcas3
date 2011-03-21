/***
StatusManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月9日 15:32:53
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package zero.net{
import flash.events.*;
import flash.net.*;
public class StatusManager{
	public static var xml:XML;
	public static var loginStatus:String;
	//public static var normalStatus:String;
	
	public static var actionXML:XML;
	public static var errorXML:XML;
	public static var statusXMLs:Array;
	public static var currXML:XML;
	
	public static var onInit:Function;
	//public static var onError:Function;
	private static var onLoadStatus:Function;
	
	public static var msgPopUp:Function;
	public static var statusCount:int;
	public static var onStatus:Function;
	
	public static var statusName:String;
	public static var statusKey:String;
	
	public static var prevCheckStatus:Function=function():Boolean{
		return true;
	}
	
	private static var statusURLLoader:URLLoader;
	
	public static var loadedData:Object;
	
	private static var decodeFun:Function;
	
	public static function loadXML(url:String):void{
		statusURLLoader=new URLLoader();
		statusURLLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
		loadedData=null;
		statusURLLoader.load(new URLRequest(url));
	}
	private static function loadXMLComplete(event:Event):void{
		var xml:XML=new XML(statusURLLoader.data);
		statusURLLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
		statusURLLoader=null;
		init(xml);
	}
	public static function init(
		_xml:XML,
		_loginStatus:String="1",
		_statusName:String="status",
		_decodeFun:Function=null,
		statusNodeName:String=null,//20110314
		_statusKey:String=null,//20110318
		_errorXML:XML=null//20110314
	):void{
		xml=_xml;
		loginStatus=_loginStatus;
		//normalStatus=_normalStatus;
		statusName=_statusName;
		statusNodeName=statusNodeName||statusName;
		statusKey=_statusKey||statusName;
		
		decodeFun=_decodeFun||function(data:String):Object{
			var urlVariables:URLVariables=new URLVariables();
			urlVariables.decode(data);
			return urlVariables;
		};
		
		//decodeFun=_decodeFun||com.adobe.serialization.json.JSON.decode;
		
		statusCount=0;
		statusXMLs=new Array();
		for each(var node:XML in xml.children()){
			//trace(node.toXMLString());
			switch(node.name().toString()){
				case statusNodeName:
					statusXMLs[node["@"+statusName].toString()]=node;
				break;
				default:
					StatusManager[node.name()+"XML"]=node;
				break;
			}
		}
		if(_errorXML){
			errorXML=_errorXML;
		}
		
		statusURLLoader=new URLLoader();
		statusURLLoader.addEventListener(Event.COMPLETE,loadStatusFinished);
		statusURLLoader.addEventListener(IOErrorEvent.IO_ERROR,loadStatusError);
		statusURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadStatusError);
		
		if(onInit==null){
		}else{
			onInit();
		}
	}
	
	
	public static function loadStatus(_onLoadStatus:Function=null,xmlOrXMLName:*=null,varObj:Object=null):void{
		onLoadStatus=_onLoadStatus;
		var url:String="";
		if(xmlOrXMLName is XML){
			url=xmlOrXMLName.@url.toString();
		}else if(xmlOrXMLName){
			url=getValue(xmlOrXMLName,"url");
		}
		if(url){
		}else{
			url=getValue("action","url");
		}
		
		loadedData=null;
		statusURLLoader.load(RequestLoader.getRequest(url,varObj));
	}
	private static function loadStatusFinished(event:Event):void{
		trace("statusURLLoader.data="+statusURLLoader.data);
		loadedData=decodeFun(statusURLLoader.data);
		currXML=statusXMLs[loadedData[statusKey]];
		if(currXML){
		}else{
			currXML=errorXML;
		}
		checkStatus();
	}
	private static function loadStatusError(event:Event):void{
		currXML=errorXML;
		checkStatus();
	}
	private static function checkStatus():void{
		if(prevCheckStatus()){
			var msg:String=currXML.@msg.toString();
			if(msg){
				msgPopUp(ReplaceVars.replace(msg,statusURLLoader.data),currXML.@btnLabel.toString()).callBack=runStatus;
			}else{
				runStatus(true);
			}
		}
	}
	private static function runStatus(alertCallBackB:Boolean=true,noRemoveAlert:Boolean=false):void{
		if(alertCallBackB){
			GotoURL.goto(currXML,statusURLLoader.data);
			switch(currXML["@"+statusName].toString()){
				case loginStatus:
					//提示用户要登录
					var loginXML:XML=getValue("login");
					if(loginXML){
						GotoURL.goto(loginXML,statusURLLoader.data);
					}
				break;
				//case normalStatus:
					//正常状态
				//break;
				default:
				break;
			}
		}
		
		if(onLoadStatus!=null){
			onLoadStatus(alertCallBackB,noRemoveAlert);
		}
		
		if(onStatus==null){
		}else{
			onStatus(currXML,statusCount++);
		}
	}
	
	public static function getValue(xmlName:String,attName:String=null):*{
		if(StatusManager[xmlName+"XML"]){
			if(attName){
				return StatusManager[xmlName+"XML"]["@"+attName].toString();
			}
			return StatusManager[xmlName+"XML"];
		}
		trace("找不到 xml 节点, xmlName="+xmlName);
		return null;
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