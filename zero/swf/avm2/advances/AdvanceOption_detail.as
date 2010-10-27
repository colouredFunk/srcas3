/***
AdvanceOption_detail 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月26日 19:07:28
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//option_detail
//{
//	u30 val
//	u8 kind
//}

//Each optional value consists of a kind field that denotes the type of value represented, and a val field that is an
//index into one of the array entries of the constant pool. The correct array is selected based on the kind.
//Constant Kind 				Value 	Entry
//CONSTANT_Int 					0x03 	integer
//CONSTANT_UInt 				0x04 	uinteger
//CONSTANT_Double 				0x06 	double
//CONSTANT_Utf8 				0x01 	string
//CONSTANT_True 				0x0B 	-
//CONSTANT_False 				0x0A 	-
//CONSTANT_Null 				0x0C 	-
//CONSTANT_Undefined 			0x00 	-
//CONSTANT_Namespace 			0x08 	namespace
//CONSTANT_PackageNamespace 	0x16 	namespace
//CONSTANT_PackageInternalNs 	0x17 	Namespace
//CONSTANT_ProtectedNamespace 	0x18 	Namespace
//CONSTANT_ExplicitNamespace 	0x19 	Namespace
//CONSTANT_StaticProtectedNs 	0x1A 	Namespace
//CONSTANT_PrivateNs 			0x05 	namespace

//很像 Trait_slot 的 vindex 和 vkind 合起

package zero.swf.avm2.advances{
	import zero.swf.avm2.Option_detail;
	import zero.swf.vmarks.ConstantKind;
	
	public class AdvanceOption_detail extends Advance{
		public var val:*;
		public var kind:int;
		
		public function AdvanceOption_detail(){
		}
		
		public function initByInfo(option_detail:Option_detail):void{
			kind=option_detail.kind;
			AdvanceABC.currInstance.getConstValueByIdAndKind(this,"val",option_detail.val,kind);
		}
		public function toInfo():Option_detail{
			var option_detail:Option_detail=new Option_detail();
			
			option_detail.kind=kind;
			option_detail.val=AdvanceABC.currInstance.getIdByKindAndConstValue(kind,val);
			
			return option_detail;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<AdvanceOption_detail
				kind={ConstantKind.kindV[kind]}
			/>;
			
			AdvanceABC.currInstance.getXMLByKindAndConstValue("val",xml,kind,val);
			
			return xml;
		}
		public function initByXML(xml:XML):void{
			kind=ConstantKind[xml.@kind.toString()];
			
			AdvanceABC.currInstance.getConstValueByXMLAndKind(this,"val",xml,kind);
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