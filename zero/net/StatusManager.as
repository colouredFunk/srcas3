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
	
	private static var urlLoader:URLLoader;
	
	public static function loadXML(url:String):void{
		urlLoader=new URLLoader();
		urlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
		urlLoader.load(new URLRequest(url));
	}
	private static function loadXMLComplete(event:Event):void{
		var xml:XML=new XML(urlLoader.data);
		urlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
		urlLoader=null;
		init(xml);
	}
	public static function init(_xml:XML):void{
		xml=_xml;
		statusCount=0;
		statusXMLs=new Array();
		for each(var node:XML in xml.children()){
			//trace(node.toXMLString());
			switch(node.name().toString()){
				case "status":
					statusXMLs[node.@status.toString()]=node;
				break;
				default:
					StatusManager[node.name()+"XML"]=node;
				break;
			}
		}
		urlLoader=new URLLoader();
		urlLoader.dataFormat=URLLoaderDataFormat.VARIABLES;
		urlLoader.addEventListener(Event.COMPLETE,loadStatusFinished);
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR,loadStatusError);
		
		onInit();
	}
	
	
	public static function loadStatus(_onLoadStatus:Function=null,xmlName:String=null):void{
		onLoadStatus=_onLoadStatus;
		urlLoader.load(new URLRequest(getValue(xmlName||"action","url")));
	}
	private static function loadStatusFinished(event:Event):void{
		currXML=statusXMLs[urlLoader.data.status];
		if(currXML){
		}else{
			currXML=errorXML;
		}
		checkStatus();
	}
	private static function loadStatusError(event:IOErrorEvent):void{
		currXML=errorXML;
		checkStatus();
	}
	private static function checkStatus():void{
		var msg:String=currXML.@msg.toString();
		if(msg){
			msgPopUp(ReplaceVars.replace(msg,urlLoader.data),currXML.@btnLabel.toString()).callBack=runStatus;
		}else{
			runStatus(true);
		}
	}
	private static function runStatus(alertCallBackB:Boolean,noRemoveAlert:Boolean=false):void{
		if(alertCallBackB){
			GotoURL.goto(currXML,urlLoader.data);
			switch(currXML.@status.toString()){
				case "1":
					//默认是提示用户要登录
					GotoURL.goto(getValue("login"),urlLoader.data);
				break;
				case "2":
					//默认是正常状态
				break;
				default:
				break;
			}
		}
		
		if(onLoadStatus!=null){
			onLoadStatus(alertCallBackB,noRemoveAlert);
		}
		
		onStatus(currXML,statusCount++);
	}
	
	public static function getValue(xmlName:String,attName:String=null):*{
		if(attName){
			return StatusManager[xmlName+"XML"]["@"+attName].toString();
		}
		return StatusManager[xmlName+"XML"];
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