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
	import zero.swf.vmarks.NamespaceKind;
	
	public class AdvanceMultiname_info extends Advance{
		
		public static const QName_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("name",Member.STRING),
			new Member("ns",Member.NAMESPACE_INFO),
		]);
		
		public static const Multiname_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("name",Member.STRING),
			new Member("ns_set",Member.NS_SET_INFO),
		]);
		
		public static const RTQName_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("name",Member.STRING),
		]);
		
		public static const RTQNameL_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind})
		]);
		
		public static const MultinameL_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("ns_set",Member.NS_SET_INFO),
		]);
		
		public static const GenericName_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("TypeDefinition",Member.MULTINAME_INFO),
			new Member("Param",Member.MULTINAME_INFO,{isList:true}),
		]);
		
		public var kind:int;
		
		public var ns:AdvanceNamespace_info;
		public var name:String;
		
		public var ns_set:AdvanceNs_set_info;
		
		public var TypeDefinition:AdvanceMultiname_info;
		public var ParamV:Vector.<AdvanceMultiname_info>;
		
		//
		public function AdvanceMultiname_info(){
		}
		
		public function initByInfo(advanceABC:AdvanceABC,multiname_info:Multiname_info):void{
			switch(multiname_info.kind){
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
					
					initByInfo_fun(advanceABC,multiname_info,QName_memberV);
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
					
					initByInfo_fun(advanceABC,multiname_info,Multiname_memberV);
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
					
					initByInfo_fun(advanceABC,multiname_info,RTQName_memberV);
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					//multiname_kind_RTQNameL
					//{
					//}
					
					//This kind has no associated data.
					//什么都没有...
					
					initByInfo_fun(advanceABC,multiname_info,RTQNameL_memberV);
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
					
					initByInfo_fun(advanceABC,multiname_info,MultinameL_memberV);
				break;
				case MultinameKind.GenericName:
					//0x1D can be considered a GenericName multiname, and is declared as such: 
					
					//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
					
					//Where 
					//[TypeDefinition] is a U30 into the multiname table 
					//[ParamCount] is a U8 (U30?) of how many parameters there are 
					//[ParamX] is a U30 into the multiname table. 
					
					initByInfo_fun(advanceABC,multiname_info,GenericName_memberV);
				break;
				default:
					throw new Error("未知 kind: "+multiname_info.kind);
				break;
			}
		}
		public function toInfoId(advanceABC:AdvanceABC):int{
			var multiname_info:Multiname_info=new Multiname_info();
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					
					toInfo_fun(advanceABC,multiname_info,QName_memberV);
					
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					
					toInfo_fun(advanceABC,multiname_info,Multiname_memberV);
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					
					toInfo_fun(advanceABC,multiname_info,RTQName_memberV);
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
					toInfo_fun(advanceABC,multiname_info,RTQNameL_memberV);
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					
					toInfo_fun(advanceABC,multiname_info,MultinameL_memberV);
					
				break;
				case MultinameKind.GenericName:
					
					toInfo_fun(advanceABC,multiname_info,GenericName_memberV);
					
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			
			//--
			advanceABC.abcFile.multiname_infoV.push(multiname_info);
			return advanceABC.abcFile.multiname_infoV.length-1;
		}
		
		////
		///*
		CONFIG::toXMLAndInitByXML {
		override public function toXMLAndMark(infoMark:InfoMark):XML{
			var xml:XML;
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					
					xml=toXML_fun(infoMark,QName_memberV);
					
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					
					xml=toXML_fun(infoMark,Multiname_memberV);
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					
					xml=toXML_fun(infoMark,RTQName_memberV);
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
					xml=toXML_fun(infoMark,RTQNameL_memberV);
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					
					xml=toXML_fun(infoMark,MultinameL_memberV);
					
				break;
				case MultinameKind.GenericName:
					
					xml=toXML_fun(infoMark,GenericName_memberV);
					
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			
			return xml;
		}
		override public function initByXMLAndMark(infoMark:InfoMark,xml:XML):void{
			switch(MultinameKind[xml.@kind.toString()]){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					
					initByXML_fun(infoMark,xml,QName_memberV);
					
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					
					initByXML_fun(infoMark,xml,Multiname_memberV);
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					
					initByXML_fun(infoMark,xml,RTQName_memberV);
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
					initByXML_fun(infoMark,xml,RTQNameL_memberV);
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					
					initByXML_fun(infoMark,xml,MultinameL_memberV);
					
				break;
				case MultinameKind.GenericName:
					
					initByXML_fun(infoMark,xml,GenericName_memberV);
					
				break;
				default:
					throw new Error("未知 kind: "+xml.@kind.toString());
				break;
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
		//*/
	}
}