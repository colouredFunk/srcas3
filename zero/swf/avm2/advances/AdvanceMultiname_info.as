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
		
		private static const QName_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("name",Member.STRING),
			new Member("ns",Member.NAMESPACE_INFO),
		]);
		
		private static const Multiname_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("name",Member.STRING),
			new Member("ns_set",Member.NS_SET_INFO),
		]);
		
		private static const RTQName_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("name",Member.STRING),
		]);
		
		private static const RTQNameL_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind})
		]);
		
		private static const MultinameL_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("ns_set",Member.NS_SET_INFO),
		]);
		
		private static const GenericName_memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:MultinameKind}),
			new Member("TypeDefinition",Member.MULTINAME_INFO),
			new Member("Param",Member.MULTINAME_INFO,{isList:true}),
		]);
		
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		//public var infoId:int;	//测试
		
		public var kind:int;
		
		public var ns:AdvanceNamespace_info;
		public var name:String;
		
		public var ns_set:AdvanceNs_set_info;
		
		public var TypeDefinition:AdvanceMultiname_info;
		public var ParamV:Vector.<AdvanceMultiname_info>;
		
		//
		public function AdvanceMultiname_info(){
		}
		
		public function initByInfo(advanceABC:AdvanceABC,_infoId:int,multiname_info:Multiname_info):void{
			infoId=_infoId;
			
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
		
		public function getMarkKey(marks:Object):String{
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					var markKey:String;
					var ns_markKey:String=getNamespace_infoMarkKey(marks,ns);
					if(ns_markKey){
						if(ns.name){
							markKey=ns_markKey+"."+name;
						}else{
							markKey=ns_markKey+name;
						}
					}else{
						markKey=name;
					}
					if(kind==MultinameKind.QName){
						return markKey;
					}
					return "["+MultinameKind.kindV[kind]+"]"+markKey;
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					
					return "["+MultinameKind.kindV[kind]+"]["+ns_set.getMarkKey(marks)+"]"+name;
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					
					return "["+MultinameKind.kindV[kind]+"]"+name;
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
					return "["+MultinameKind.kindV[kind]+"]";
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					
					return "["+MultinameKind.kindV[kind]+"]["+ns_set.getMarkKey(marks)+"]";
					
				break;
				case MultinameKind.GenericName:
					
					var ParamMarkKey:String="";
					for each(var Param:AdvanceMultiname_info in ParamV){
						ParamMarkKey+=","+Param.getMarkKey(marks);
					}
					return "["+MultinameKind.kindV[kind]+"]["+TypeDefinition.getMarkKey(marks)+"["+ParamMarkKey.substr(1)+"]]";
					
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			
			return null;
		}
		
		////
		///*
		CONFIG::toXMLAndInitByXML {
		public function toXML(marks:Object,xmlName:String):XML{
			var xml:XML;
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					
					xml=toXML_fun(marks,QName_memberV,xmlName);
					
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					
					xml=toXML_fun(marks,Multiname_memberV,xmlName);
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					
					xml=toXML_fun(marks,RTQName_memberV,xmlName);
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
					xml=toXML_fun(marks,RTQNameL_memberV,xmlName);
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					
					xml=toXML_fun(marks,MultinameL_memberV,xmlName);
					
				break;
				case MultinameKind.GenericName:
					
					xml=toXML_fun(marks,GenericName_memberV,xmlName);
					
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			
			xml.@infoId=infoId;
			return xml;
		}
		public function initByXML(marks:Object,xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			//trace("initByXML infoId="+infoId);
			
			switch(MultinameKind[xml.@kind.toString()]){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					
					initByXML_fun(marks,xml,QName_memberV);
					
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					
					initByXML_fun(marks,xml,Multiname_memberV);
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					
					initByXML_fun(marks,xml,RTQName_memberV);
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
					initByXML_fun(marks,xml,RTQNameL_memberV);
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					
					initByXML_fun(marks,xml,MultinameL_memberV);
					
				break;
				case MultinameKind.GenericName:
					
					initByXML_fun(marks,xml,GenericName_memberV);
					
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