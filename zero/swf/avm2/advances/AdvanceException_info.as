/***
AdvanceException_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月26日 21:56:04
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//The exception_info entry is used to define the range of ActionScript 3.0 instructions over which a particular
//exception handler is engaged.
//exception_info
//{
//	u30 from
//	u30 to
//	u30 target
//	u30 exc_type
//	u30 var_name
//}

//The starting position in the code field from which the exception is enabled.

//The ending position in the code field after which the exception is disabled.

//The position in the code field to which control should jump if an exception of type exc_type is
//encountered while executing instructions that lie within the region [from, to] of the code field.

//An index into the string array of the constant pool that identifies the name of the type of exception that
//is to be monitored during the reign of this handler. A value of zero means the any type ("*") and implies
//that this exception handler will catch any type of exception thrown.
//文档里是错的...不是 string_v 而是 multiname_info_v

//This index into the string array of the constant pool defines the name of the variable that is to receive
//the exception object when the exception is thrown and control is transferred to target location. If the
//value is zero then there is no name associated with the exception object.
//文档里是错的...不是 string_v 而是 multiname_info_v

package zero.swf.avm2.advances{
	import zero.swf.avm2.Exception_info;
	public class AdvanceException_info extends Advance{
		
		private static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("from"),
			new Member("to"),
			new Member("target"),
			new Member("exc_type",Member.MULTINAME_INFO),
			new Member("var_name",Member.MULTINAME_INFO)
		]);
		
		public var from:int;
		public var to:int;
		public var target:int;
		public var exc_type:AdvanceMultiname_info;
		public var var_name:AdvanceMultiname_info;
		
		public function AdvanceException_info(){
		}
		
		public function initByInfo(exception_info:Exception_info):void{
			initByInfo_fun(exception_info,memberV);
		}
		public function toInfo():Exception_info{
			var exception_info:Exception_info=new Exception_info();
			
			toInfo_fun(exception_info,memberV);
		
			return exception_info;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			return toXML_fun(memberV);
		}
		public function initByXML(xml:XML):void{
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