/***
Log 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 15:41:19
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.utils.*;
	
	import zero.air.FileAndStr;
	
	public class Log{
		private static var xml:XML;
		public static function init(xmlName:String):void{
			xml=new XML("<"+xmlName+"/>");
		}
		public static function log(id:int,msg:String):void{
			xml.appendChild(<log id={id} msg={msg}/>);
		}
		public static function output():void{
			FileAndStr.writeStrToFile(xml.toXMLString(),new File(File.applicationDirectory.nativePath+"/"+xml.name().toString()+".xml"));
		}
	}
}

