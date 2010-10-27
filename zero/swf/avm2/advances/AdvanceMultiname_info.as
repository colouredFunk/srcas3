/***
AdvanceMultiname_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月24日 15:25:27
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//A multiname_info entry is a variable length item that is used to define multiname entities used by the
//bytecode. There are many kinds of multinames. The kind field acts as a tag: its value determines how the
//loader should see the variable-length data field. The layout of the contents of the data field under a particular
//kind is described below by the multiname_kind_ structures.

//			multiname_info
//			{
//				u8 kind
//				u8 data[]
//			}

//Multiname Kind 		Value
//CONSTANT_QName 		0x07
//CONSTANT_QNameA 		0x0D
//CONSTANT_RTQName 		0x0F
//CONSTANT_RTQNameA 	0x10
//CONSTANT_RTQNameL 	0x11
//CONSTANT_RTQNameLA 	0x12
//CONSTANT_Multiname 	0x09
//CONSTANT_MultinameA 	0x0E
//CONSTANT_MultinameL 	0x1B
//CONSTANT_MultinameLA 	0x1C
//Those constants ending in "A" (such as CONSTANT_QNameA) represent the names of attributes.

// (ns(一个namespace)或ns_set(多个namespace)) 和 name (一个字符串) 组成的复合结构
package zero.swf.avm2.advances{
	import zero.swf.avm2.Multiname_info;
	import zero.swf.vmarks.MultinameKind;
	
	public class AdvanceMultiname_info extends Advance{
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		
		public var kind:int;
		
		public var ns:AdvanceNamespace_info;
		public var name:String;
		
		public var ns_set:AdvanceNs_set_info;
		
		public var TypeDefinition:AdvanceMultiname_info;
		public var ParamV:Vector.<AdvanceMultiname_info>;
		
		//
		public function AdvanceMultiname_info(){
		}
		public function initByInfo(_infoId:int,multiname_info:Multiname_info):void{
			infoId=_infoId;
			
			kind=multiname_info.kind;
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					//multiname_kind_QName
					//{
					//	u30 ns
					//	u30 name
					//}
					
					//The ns and name fields are indexes into the namespace and string arrays of the constant_pool entry,
					//respectively. A value of zero for the ns field indicates the any ("*") namespace, and a value of zero for the name
					//field indicates the any ("*") name.
					//ns是在 constant_pool.namespace_info_v 中的id
					//name是在 constant_pool.string_v 中的id
					//ns或name如果是 0 则表示 "*"
					
					name=AdvanceABC.currInstance.getInfoByIdAndVName(multiname_info.name,AdvanceABC.STRING);
					
					ns=AdvanceABC.currInstance.getInfoByIdAndVName(multiname_info.ns,AdvanceABC.NAMESPACE_INFO);
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					//multiname_kind_Multiname
					//{
					//	u30 name
					//	u30 ns_set
					//}
					
					//The name field is an index into the string array, and the ns_set field is an index into the ns_set array. A
					//value of zero for the name field indicates the any ("*") name. The value of ns_set cannot be zero.
					//name是在 constant_pool.string_v 中的id
					//ns_set是在 constant_pool.ns_set_info_v 中的id
					//name如果是 0 则表示 "*"
					//ns_set不能是 0
					
					name=AdvanceABC.currInstance.getInfoByIdAndVName(multiname_info.name,AdvanceABC.STRING);
					
					ns_set=AdvanceABC.currInstance.getInfoByIdAndVName(multiname_info.ns_set,AdvanceABC.NS_SET_INFO);
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					//multiname_kind_RTQName
					//{
					//	u30 name
					//}
					
					//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
					//name是在 constant_pool.string_v 中的id
					//name如果是 0 则表示 "*"
					
					name=AdvanceABC.currInstance.getInfoByIdAndVName(multiname_info.name,AdvanceABC.STRING);
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					//multiname_kind_RTQNameL
					//{
					//}
					
					//This kind has no associated data.
					//什么都没有...
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					//multiname_kind_MultinameL
					//{
					//	u30 ns_set
					//}
					
					//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
					//ns_set是在 constant_pool.ns_set_info_v 中的id
					//ns_set不能是 0
					
					ns_set=AdvanceABC.currInstance.getInfoByIdAndVName(multiname_info.ns_set,AdvanceABC.NS_SET_INFO);
				break;
				case MultinameKind.GenericName:
					//0x1D can be considered a GenericName multiname, and is declared as such: 
					
					//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
					
					//Where 
					//[TypeDefinition] is a U30 into the multiname table 
					//[ParamCount] is a U8 (U30?) of how many parameters there are 
					//[ParamX] is a U30 into the multiname table. 
					
					TypeDefinition=AdvanceABC.currInstance.getInfoByIdAndVName(multiname_info.TypeDefinition,AdvanceABC.MULTINAME_INFO);
					
					AdvanceABC.currInstance.getInfoVByIdsAndVName(this,multiname_info,"ParamV",AdvanceABC.MULTINAME_INFO);
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
		}
		public function toInfoId():int{
			var multiname_info:Multiname_info=new Multiname_info();
			multiname_info.kind=kind;
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					multiname_info.ns=AdvanceABC.currInstance.getIdByInfoAndVName(ns,AdvanceABC.NAMESPACE_INFO);
					
					multiname_info.name=AdvanceABC.currInstance.getIdByInfoAndVName(name,AdvanceABC.STRING);
					
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					multiname_info.name=AdvanceABC.currInstance.getIdByInfoAndVName(name,AdvanceABC.STRING);
					
					multiname_info.ns_set=AdvanceABC.currInstance.getIdByInfoAndVName(ns_set,AdvanceABC.NS_SET_INFO);
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					multiname_info.name=AdvanceABC.currInstance.getIdByInfoAndVName(name,AdvanceABC.STRING);
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					multiname_info.ns_set=AdvanceABC.currInstance.getIdByInfoAndVName(ns_set,AdvanceABC.NS_SET_INFO);
					
				break;
				case MultinameKind.GenericName:
					multiname_info.TypeDefinition=AdvanceABC.currInstance.getIdByInfoAndVName(TypeDefinition,AdvanceABC.MULTINAME_INFO);
					
					AdvanceABC.currInstance.getIdsByInfoVAndVName(this,multiname_info,"ParamV",AdvanceABC.MULTINAME_INFO);
					
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			
			//--
			AdvanceABC.currInstance.abcFile.multiname_infoV.push(multiname_info);
			return AdvanceABC.currInstance.abcFile.multiname_infoV.length-1;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<AdvanceMultiname_info infoId={infoId}
				kind={MultinameKind.kindV[kind]}
			/>;
			
			var infoXML:XML;
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					infoXML=<ns/>;
					infoXML.appendChild(ns.toXML());
					xml.appendChild(infoXML);
					xml.@name=name;
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					xml.@name=name;
					infoXML=<ns_set/>;
					infoXML.appendChild(ns_set.toXML());
					xml.appendChild(infoXML);
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					xml.@name=name;
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					//
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					infoXML=<ns_set/>;
					infoXML.appendChild(ns_set.toXML());
					xml.appendChild(infoXML);
				break;
				case MultinameKind.GenericName:
					infoXML=<TypeDefinition/>;
					infoXML.appendChild(TypeDefinition.toXML());
					xml.appendChild(infoXML);
					
					xml.appendChild(AdvanceABC.currInstance.getInfoListXMLByInfoVAndVName(this,"Param",AdvanceABC.MULTINAME_INFO));
					
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			
			return xml;
		}
		public function initByXML(xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			kind=MultinameKind[xml.@kind.toString()];
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					ns=AdvanceABC.currInstance.getInfoByXMLAndVName(xml.ns.children()[0],AdvanceABC.NAMESPACE_INFO);
					name=xml.@name.toString();
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					name=xml.@name.toString();
					ns_set=AdvanceABC.currInstance.getInfoByXMLAndVName(xml.ns_set.children()[0],AdvanceABC.NS_SET_INFO);
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					name=xml.@name.toString();
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					//
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					ns_set=AdvanceABC.currInstance.getInfoByXMLAndVName(xml.ns_set.children()[0],AdvanceABC.NS_SET_INFO);
				break;
				case MultinameKind.GenericName:
					TypeDefinition=AdvanceABC.currInstance.getInfoByXMLAndVName(xml.TypeDefinition.children()[0],AdvanceABC.MULTINAME_INFO);
					
					AdvanceABC.currInstance.getInfoVByInfoListXMLAndVName(this,"Param",xml,AdvanceABC.MULTINAME_INFO);
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
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