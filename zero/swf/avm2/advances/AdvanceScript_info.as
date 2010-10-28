/***
AdvanceScript_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 21:05:48
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//The script_info entry is used to define characteristics of an ActionScript 3.0 script.
//script_info
//{
//	u30 init
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The init field is an index into the method array of the abcFile. It identifies a function that is to be
//invoked prior to any other code in this script.
//它确定一个函数，要
//调用任何其他代码之前在此脚本

//The value of trait_count is the number of entries in the trait array. The trait array is the set of traits
//defined by the script.

package zero.swf.avm2.advances{
	import zero.swf.avm2.Script_info;
	import zero.swf.avm2.Traits_info;
	
	public class AdvanceScript_info extends Advance{
		
		private static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("init",Member.METHOD),
			new Member("traits_info",Member.TRAITS_INFO,{isList:true}),
		]);
		
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		
		public var init:AdvanceMethod;
		public var traits_infoV:Vector.<AdvanceTraits_info>;
		
		public function AdvanceScript_info(){
		}
		
		public function initByInfo(_infoId:int,script_info:Script_info):void{
			infoId=_infoId;
			
			initByInfo_fun(script_info,memberV);
		}
		public function toInfoId():int{
			var script_info:Script_info=new Script_info();
			
			toInfo_fun(script_info,memberV);
			
			//--
			AdvanceABC.currInstance.abcFile.script_infoV.push(script_info);
			return AdvanceABC.currInstance.abcFile.script_infoV.length-1;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=toXML_fun(memberV);
			
			xml.@infoId=infoId;
			return xml;
		}
		public function initByXML(xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			initByXML_fun(xml,memberV);
		}
		}//end of CONFIG::toXMLAndInitByXML
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