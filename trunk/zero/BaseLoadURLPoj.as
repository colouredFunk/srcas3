﻿/***
BaseLoadURLPoj 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月27日 21:24:00
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	public class BaseLoadURLPoj extends MovieClip{
		private var defaultXMLPath:String;
		private var xmlVarName:String;
		
		public var urlLoader:URLLoader;
		public static var xml:XML;
		
		public function BaseLoadURLPoj(_defaultXMLPath:String=null,_xmlVarName:String="xml"){
			if(_defaultXMLPath){
				defaultXMLPath=_defaultXMLPath;
			}else{
				defaultXMLPath="xml/"+getQualifiedClassName(this).toLowerCase()+".xml";
			}
			xmlVarName=_xmlVarName;
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.visible=false;
			urlLoader=new URLLoader();
			urlLoader.load(new URLRequest((this.loaderInfo.parameters[xmlVarName]||defaultXMLPath)));
			urlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
		}
		private function loadXMLComplete(event:Event):void{
			xml=new XML(urlLoader.data);
			urlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
			this.visible=true;
			this["init"]();
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