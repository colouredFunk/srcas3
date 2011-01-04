/***
InfoMark 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月20日 21:31:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class InfoMark{
		public var namespace_info:Object;
		public var ns_set_info:Object;
		public var multiname_info:Object;
		//
		public var method:Object;
		//public var metadata_info:Object;//不可能复用的结构
		public var clazz:Object;
		//public var script_info:Object;//不可能复用的结构
		//
		
		//public var traits_info:Object;//不可能复用的结构
		//public var option_detial:Object;//不可能复用的结构
		//public var item_info:Object;//不可能复用的结构
		//public var exception_info:Object;
		
		public var markStrDict:Dictionary;
		public var xmlDict:Dictionary;
		
		public var specialXMLs:Object;
		public var specialMarkStrV:Vector.<String>;
		
		public function InfoMark(){
			markStrDict=new Dictionary();
			markStrDict[AdvanceDefaultMultiname_info.instance]="*";
			
			xmlDict=new Dictionary();
			xmlDict[AdvanceDefaultMultiname_info.instance]=<AdvanceDefaultMultiname_info kind="*"/>;
			
			namespace_info=new Object();
			ns_set_info=new Object();
			multiname_info=new Object();
			//
			method=new Object();
			//metadata_info=new Object();
			clazz=new Object();
			//script_info=new Object();
			//
			
			//traits_info=new Object();
			//option_detial=new Object();
			//item_info=new Object();
			//exception_info=new Object();
			
			multiname_info["~*"]=AdvanceDefaultMultiname_info.instance;
			
			specialXMLs=new Object();
			specialMarkStrV=new Vector.<String>();
		}
		
		public function addSpecialXML(markStr:String,specialXML:XML):void{
			if(specialXMLs["~"+markStr]){
				//throw new Error("重复的 markStr: "+markStr);
				return;
			}
			specialXMLs["~"+markStr]=specialXML;
			specialMarkStrV.push(markStr);
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