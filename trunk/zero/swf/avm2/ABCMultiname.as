/***
ABCMultiname
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月19日 23:14:09（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//A multiname_info entry is a variable length item that is used to define multiname entities used by the
//bytecode. There are many kinds of multinames. The kind field acts as a tag: its value determines how the
//loader should see the variable-length data field. The layout of the contents of the data field under a particular
//kind is described below by the multiname_kind_ structures.
//multiname_info
//{
//u8 kind
//u8 data[]
//}
//
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
//
//Those constants ending in "A" (such as CONSTANT_QNameA) represent the names of attributes.

package zero.swf.avm2{
	import flash.utils.Dictionary;
	public class ABCMultiname{
		public var kind:int;							//direct_int
		//QName，QNameA				u30_1 表现为：ns，u30_2 表现为：name
		//Multiname，MultinameA		u30_1 表现为：name，u30_2 表现为：ns_set
		//RTQName，RTQNameA			u30_1 表现为：name，u30_2 不使用
		//RTQNameL，RTQNameLA		u30_1 不使用，u30_2 不使用
		//MultinameL，MultinameLA	u30_1 表现为：ns_set，u30_2 不使用
		//GenericName				u30_1 表现为：TypeDefinition，u30_2 不使用
		//
		
		public var ns:ABCNamespace;
		public var name:String;
		public var ns_set:ABCNs_set;
		public var TypeDefinition:ABCMultiname;
		public var ParamV:Vector.<ABCMultiname>;
		
		public function initByInfo(
			multiname_info:Multiname_info,
			stringV:Vector.<String>,
			allNsV:Vector.<ABCNamespace>,
			allNs_setV:Vector.<ABCNs_set>,
			allMultinameV:Vector.<ABCMultiname>,
			_initByDataOptions:zero_swf_InitByDataOptions
		):void{
			kind=multiname_info.kind;
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
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
					ns=allNsV[multiname_info.u30_1];//allNsV[0]==null;
					name=stringV[multiname_info.u30_2];//stringV[0]==null;
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
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
					name=stringV[multiname_info.u30_1];//stringV[0]==null;
					if(multiname_info.u30_2>0){
						ns_set=allNs_setV[multiname_info.u30_2];
					}else{
						throw new Error("multiname_info.u30_2="+multiname_info.u30_2);
					}
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					//multiname_kind_RTQName
					//{
					//	u30 name
					//}
					
					//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
					//name是在 constant_pool.string_v 中的id
					//name如果是 0 则表示 "*"
					name=stringV[multiname_info.u30_1];//stringV[0]==null;
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//multiname_kind_RTQNameL
					//{
					//}
					
					//This kind has no associated data.
					//什么都没有...
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					//multiname_kind_MultinameL
					//{
					//	u30 ns_set
					//}
					
					//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
					//ns_set是在 constant_pool.ns_set_info_v 中的id
					//ns_set不能是 0
					if(multiname_info.u30_1>0){
						ns_set=allNs_setV[multiname_info.u30_1];
					}else{
						throw new Error("multiname_info.u30_1="+multiname_info.u30_1);
					}
				break;
				case MultinameKinds.GenericName:
					//0x1D can be considered a GenericName multiname, and is declared as such: 
					
					//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
					
					//Where 
					//[TypeDefinition] is a U30 into the multiname table 
					//[ParamCount] is a U8 (U30?) of how many parameters there are 
					//[ParamX] is a U30 into the multiname table. 
					TypeDefinition=allMultinameV[multiname_info.u30_1];//allMultinameV[0]==null;
					if(multiname_info.ParamV.length){
						var i:int=-1;
						ParamV=new Vector.<ABCMultiname>();
						for each(var Param:int in multiname_info.ParamV){
							i++;
							ParamV[i]=allMultinameV[Param];//allMultinameV[0]==null;
						}
					}else{
						throw new Error("multiname_info.ParamV.length="+multiname_info.ParamV.length);
					}
				break;
				default:
					throw new Error("multiname_info.kind="+multiname_info.kind);
				break;
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
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
					productMark.productNs(ns);
					productMark.productString(name);
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
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
					productMark.productString(name);
					if(ns_set){
						productMark.productNs_set(ns_set);
					}else{
						throw new Error("ns_set="+ns_set);
					}
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					//multiname_kind_RTQName
					//{
					//	u30 name
					//}
					
					//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
					//name是在 constant_pool.string_v 中的id
					//name如果是 0 则表示 "*"
					productMark.productString(name);
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//multiname_kind_RTQNameL
					//{
					//}
					
					//This kind has no associated data.
					//什么都没有...
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					//multiname_kind_MultinameL
					//{
					//	u30 ns_set
					//}
					
					//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
					//ns_set是在 constant_pool.ns_set_info_v 中的id
					//ns_set不能是 0
					if(ns_set){
						productMark.productNs_set(ns_set);
					}else{
						throw new Error("ns_set="+ns_set);
					}
				break;
				case MultinameKinds.GenericName:
					//0x1D can be considered a GenericName multiname, and is declared as such: 
					
					//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
					
					//Where 
					//[TypeDefinition] is a U30 into the multiname table 
					//[ParamCount] is a U8 (U30?) of how many parameters there are 
					//[ParamX] is a U30 into the multiname table. 
					productMark.productMultiname(TypeDefinition);
					if(ParamV.length){
						for each(var Param:ABCMultiname in ParamV){
							productMark.productMultiname(Param);
						}
					}else{
						throw new Error("ParamV.length="+ParamV.length);
					}
				break;
				default:
					throw new Error("kind="+kind);
				break;
			}
			
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:zero_swf_ToDataOptions):Multiname_info{
			var multiname_info:Multiname_info=new Multiname_info();
			
			multiname_info.kind=kind;
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
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
					
					multiname_info.u30_1=productMark.getNsId(ns);
					multiname_info.u30_2=productMark.getStringId(name);
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
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
					
					multiname_info.u30_1=productMark.getStringId(name);
					if(ns_set){
						multiname_info.u30_2=productMark.getNs_setId(ns_set);
					}else{
						throw new Error("ns_set="+ns_set);
					}
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					//multiname_kind_RTQName
					//{
					//	u30 name
					//}
					
					//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
					//name是在 constant_pool.string_v 中的id
					//name如果是 0 则表示 "*"
					multiname_info.u30_1=productMark.getStringId(name);
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//multiname_kind_RTQNameL
					//{
					//}
					
					//This kind has no associated data.
					//什么都没有...
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					//multiname_kind_MultinameL
					//{
					//	u30 ns_set
					//}
					
					//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
					//ns_set是在 constant_pool.ns_set_info_v 中的id
					//ns_set不能是 0
					if(ns_set){
						multiname_info.u30_1=productMark.getNs_setId(ns_set);
					}else{
						throw new Error("ns_set="+ns_set);
					}
				break;
				case MultinameKinds.GenericName:
					//0x1D can be considered a GenericName multiname, and is declared as such: 
					
					//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
					
					//Where 
					//[TypeDefinition] is a U30 into the multiname table 
					//[ParamCount] is a U8 (U30?) of how many parameters there are 
					//[ParamX] is a U30 into the multiname table. 
					multiname_info.u30_1=productMark.getMultinameId(TypeDefinition);
					if(ParamV.length){
						var i:int=-1;
						multiname_info.ParamV=new Vector.<int>();
						for each(var Param:ABCMultiname in ParamV){
							i++;
							multiname_info.ParamV[i]=productMark.getMultinameId(Param);
						}
					}else{
						throw new Error("ParamV.length="+ParamV.length);
					}
				break;
				default:
					throw new Error("kind="+kind);
				break;
			}
			
			return multiname_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			if(MultinameKinds.kindV[kind]){
			}else{
				throw new Error("kind="+kind);
			}
			
			var xml:XML=markStrs.xmlDict[this];
			if(xml){
				xml=xml.copy();//保证下面的 setName 不互相影响就行
				xml.setName(xmlName);
			}else{
				var markStr:String=toMarkStrAndMark(markStrs);
				if(_toXMLOptions&&_toXMLOptions.AVM2UseMarkStr){
					xml=<{xmlName} markStr={markStr}/>;
				}else{
					xml=<{xmlName}
						kind={MultinameKinds.kindV[kind]}
					/>;
					switch(kind){
						case MultinameKinds.QName:
						case MultinameKinds.QNameA:
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
							
							if(ns){
								xml.appendChild(ns.toXMLAndMark(markStrs,"ns",_toXMLOptions));
							}
							if(name is String){
								xml.@name=name;
							}
						break;
						case MultinameKinds.Multiname:
						case MultinameKinds.MultinameA:
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
							
							if(name is String){
								xml.@name=name;
							}
							if(ns_set){
								xml.appendChild(ns_set.toXMLAndMark(markStrs,"ns_set",_toXMLOptions));
							}else{
								throw new Error("ns_set="+ns_set);
							}
						break;
						case MultinameKinds.RTQName:
						case MultinameKinds.RTQNameA:
							//multiname_kind_RTQName
							//{
							//	u30 name
							//}
							
							//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
							//name是在 constant_pool.string_v 中的id
							//name如果是 0 则表示 "*"
							if(name is String){
								xml.@name=name;
							}
						break;
						case MultinameKinds.RTQNameL:
						case MultinameKinds.RTQNameLA:
							//multiname_kind_RTQNameL
							//{
							//}
							
							//This kind has no associated data.
							//什么都没有...
						break;
						case MultinameKinds.MultinameL:
						case MultinameKinds.MultinameLA:
							//multiname_kind_MultinameL
							//{
							//	u30 ns_set
							//}
							
							//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
							//ns_set是在 constant_pool.ns_set_info_v 中的id
							//ns_set不能是 0
							if(ns_set){
								xml.appendChild(ns_set.toXMLAndMark(markStrs,"ns_set",_toXMLOptions));
							}else{
								throw new Error("ns_set="+ns_set);
							}
						break;
						case MultinameKinds.GenericName:
							//0x1D can be considered a GenericName multiname, and is declared as such: 
							
							//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
							
							//Where 
							//[TypeDefinition] is a U30 into the multiname table 
							//[ParamCount] is a U8 (U30?) of how many parameters there are 
							//[ParamX] is a U30 into the multiname table. 
							if(TypeDefinition){
								xml.appendChild(TypeDefinition.toXMLAndMark(markStrs,"TypeDefinition",_toXMLOptions));
							}
							if(ParamV.length){
								var listXML:XML=<ParamList count={ParamV.length}/>
								for each(var Param:ABCMultiname in ParamV){
									if(Param){
										listXML.appendChild(Param.toXMLAndMark(markStrs,"Param",_toXMLOptions));
									}else{
										listXML.appendChild(<Param/>);
									}
								}
								xml.appendChild(listXML);
							}else{
								throw new Error("ParamV.length="+ParamV.length);
							}
						break;
					}
					
					var copyId:int=int(markStr.replace(/^[\s\S]*\((\d+)\)$/,"$1"));
					if(copyId>1){
						xml.@copyId=copyId;
					}
				}
				markStrs.xmlDict[this]=xml;
			}
			return xml;
		}
		public function toMarkStrAndMark(markStrs:MarkStrs):String{
			if(MultinameKinds.kindV[kind]){
			}else{
				throw new Error("kind="+kind);
			}
			
			//获取 multiname 的最简 markStr(自动计算 copyId)
			var markStr:String=markStrs.markStrDict[this];
			if(markStr is String){
				return markStr;
			}
			
			markStr="["+MultinameKinds.kindV[kind]+"]";
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
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
					
					if(ns){
						markStr+=ns.toMarkStrAndMark(markStrs)+".";
					}else{
						markStr+="(ns=undefined)";
					}
					if(name is String){
						markStr+=ComplexString.escape(name);
					}else{
						markStr+="(name=undefined)";
					}
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
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
					
					if(ns_set){
						markStr+=ns_set.toMarkStrAndMark(markStrs)+".";
					}else{
						throw new Error("ns_set="+ns_set);
					}
					if(name is String){
						markStr+=ComplexString.escape(name);
					}else{
						markStr+="(name=undefined)";
					}
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					//multiname_kind_RTQName
					//{
					//	u30 name
					//}
					
					//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
					//name是在 constant_pool.string_v 中的id
					//name如果是 0 则表示 "*"
					if(name is String){
						markStr+=ComplexString.escape(name);
					}else{
						markStr+="(name=undefined)";
					}
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//multiname_kind_RTQNameL
					//{
					//}
					
					//This kind has no associated data.
					//什么都没有...
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					//multiname_kind_MultinameL
					//{
					//	u30 ns_set
					//}
					
					//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
					//ns_set是在 constant_pool.ns_set_info_v 中的id
					//ns_set不能是 0
					if(ns_set){
						markStr+=ns_set.toMarkStrAndMark(markStrs)+".";
					}else{
						throw new Error("ns_set="+ns_set);
					}
				break;
				case MultinameKinds.GenericName:
					//0x1D can be considered a GenericName multiname, and is declared as such: 
					
					//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
					
					//Where 
					//[TypeDefinition] is a U30 into the multiname table 
					//[ParamCount] is a U8 (U30?) of how many parameters there are 
					//[ParamX] is a U30 into the multiname table. 
					if(TypeDefinition){
						markStr+=TypeDefinition.toMarkStrAndMark(markStrs)+".";
					}else{
						markStr+="(TypeDefinition=undefined)";
					}
					if(ParamV.length){
						var ParamMarkStrs:String="";
						for each(var Param:ABCMultiname in ParamV){
							if(Param){
								ParamMarkStrs+=","+Param.toMarkStrAndMark(markStrs);
							}else{
								ParamMarkStrs+",(Param=undefined)";
							}
						}
						markStr+="<"+ParamMarkStrs.substr(1)+">";
					}else{
						throw new Error("ParamV.length="+ParamV.length);
					}
				break;
			}
			
			//标准化不带 copyId 的 markStr
			markStr=normalizeMarkStr(markStr);
			
			//计算 copyId
			if(markStrs.multinameMark["~"+markStr]){
				var copyId:int=1;
				while(markStrs.multinameMark["~"+markStr+"("+(++copyId)+")"]){};
				markStr+="("+copyId+")";
			}
			//
			
			markStrs.multinameMark["~"+markStr]=this;
			markStrs.markStrDict[this]=markStr;
			
			return markStr;
		}
		
		public static function xml2multiname(markStrs:MarkStrs,xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):ABCMultiname{
			return markStr2multiname(markStrs,xml2markStr(xml));
		} 
		public static function xml2markStr(xml:XML):String{
			//获取 multiname 的 xml 的最简 markStr
			if(/^<\w+ markStr=".*?"\/>$/.test(xml.toXMLString())){
				return normalizeMarkStr(xml.@markStr.toString());
			}
			
			var kindStr:String=xml.@kind.toString();
			
			var markStr:String="["+kindStr+"]";
			var nameXMLList:XMLList,ns_setXMLList:XMLList,ns_setXML:XML;
			switch(MultinameKinds[kindStr]){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
					var nsXMLList:XMLList=xml.@ns;
					if(nsXMLList.length()){
						markStr+=nsXMLList.toString()+".";
					}else{
						var nsXML:XML=xml.ns[0];
						if(nsXML){
							markStr+=ABCNamespace.xml2markStr(nsXML)+".";
						}else{
							markStr+="(ns=undefined)";
						}
					}
					
					nameXMLList=xml.@name;
					if(nameXMLList.length()){
						markStr+=ComplexString.escape(nameXMLList.toString());
					}else{
						markStr+="(name=undefined)";
					}
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					ns_setXMLList=xml.@ns_set;
					if(ns_setXMLList.length()){
						markStr+=ns_setXMLList.toString()+".";
					}else{
						ns_setXML=xml.ns_set[0];
						if(ns_setXML){
							markStr+=ABCNs_set.xml2markStr(ns_setXML)+".";
						}else{
							throw new Error("ns_setXML="+ns_setXML);
						}
					}
					
					nameXMLList=xml.@name;
					if(nameXMLList.length()){
						markStr+=ComplexString.escape(nameXMLList.toString());
					}else{
						markStr+="(name=undefined)";
					}
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					nameXMLList=xml.@name;
					if(nameXMLList.length()){
						markStr+=ComplexString.escape(nameXMLList.toString());
					}else{
						markStr+="(name=undefined)";
					}
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//什么都不用干...
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					ns_setXMLList=xml.@ns_set;
					if(ns_setXMLList.length()){
						markStr+=ns_setXMLList.toString()+".";
					}else{
						ns_setXML=xml.ns_set[0];
						if(ns_setXML){
							markStr+=ABCNs_set.xml2markStr(ns_setXML)+".";
						}else{
							throw new Error("ns_setXML="+ns_setXML);
						}
					}
				break;
				case MultinameKinds.GenericName:
					var TypeDefinitionXMLList:XMLList=xml.@TypeDefinition;
					if(TypeDefinitionXMLList.length()){
						markStr+=TypeDefinitionXMLList.toString()+".";
					}else{
						var TypeDefinitionXML:XML=xml.TypeDefinition[0];
						if(TypeDefinitionXML){
							markStr+=xml2markStr(TypeDefinitionXML)+".";
						}else{
							markStr+="(TypeDefinition=undefined)";
						}
					}
					
					var ParamListXML:XML=xml.ParamList[0];
					if(ParamListXML){
						var ParamXMLList:XMLList=ParamListXML.Param;
						if(ParamXMLList.length()){
							var ParamStrs:String="";
							for each(var ParamXML:XML in ParamXMLList){
								if(ParamXML.toXMLString()=="<Param/>"){
									ParamStrs+=",(Param=undefined)";
								}else{
									ParamStrs+=","+xml2markStr(ParamXML);
								}
							}
							markStr+="<"+ParamStrs.substr(1)+">";
						}else{
							throw new Error("ParamXMLList="+ParamXMLList);
						}
					}else{
						throw new Error("ParamListXML="+ParamListXML);
					}
				break;
				default:
					throw new Error("kindStr="+kindStr);
				break;
			}
			
			markStr+="("+int(xml.@copyId.toString())+")";
			
			return normalizeMarkStr(markStr);//标准化带 copyId 的 markStr
		}
		public static function markStr2multiname(markStrs:MarkStrs,markStr0:String):ABCMultiname{
			var multiname:ABCMultiname=markStrs.multinameMark["~"+markStr0];
			if(multiname){
			}else{
				var markStr:String=normalizeMarkStr(markStr0);
				multiname=markStrs.multinameMark["~"+markStr];
				if(multiname){
				}else{
					multiname=new ABCMultiname();
					
					var id:int,escapeMarkStr:String;
					if(markStr.indexOf("[")==0){
						//可能是 multinameKind，也可能是 QName 的  ns.kind
						id=markStr.indexOf("]");
						multiname.kind=MultinameKinds[markStr.substr(1,id-1)];
						if(multiname.kind>0){
							escapeMarkStr=GroupString.escape(markStr.substr(id+1));
						}else{
							multiname.kind=MultinameKinds.QName;
							escapeMarkStr=GroupString.escape(markStr);
						}
					}else{
						multiname.kind=MultinameKinds.QName;
						escapeMarkStr=GroupString.escape(markStr);
					}
					
					var execResult:Array;
					var dotId:int;
					
					switch(multiname.kind){
						case MultinameKinds.QName:
						case MultinameKinds.QNameA:
							if(escapeMarkStr.indexOf("(ns=undefined)")==0){
								multiname.ns=null;
								escapeMarkStr=escapeMarkStr.replace(/\(ns=undefined\)\.?/,"");
							}else{
								dotId=escapeMarkStr.lastIndexOf(".");
								if(dotId==-1){
									multiname.ns=ABCNamespace.markStr2ns(markStrs,"");
								}else{
									multiname.ns=ABCNamespace.markStr2ns(markStrs,escapeMarkStr.substr(0,dotId));
									escapeMarkStr=escapeMarkStr.substr(dotId+1);
								}
							}
							execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
							if(execResult[1]=="(name=undefined)"){
								multiname.name=null;
							}else{
								multiname.name=ComplexString.unescape(execResult[1]);
							}
							//copyId=int(execResult[2]);
						break;
						case MultinameKinds.Multiname:
						case MultinameKinds.MultinameA:
							dotId=escapeMarkStr.lastIndexOf(".");
							if(dotId==-1){
								throw new Error("dotId="+dotId);
							}else{
								multiname.ns_set=ABCNs_set.markStr2ns_set(markStrs,escapeMarkStr.substr(0,dotId));
								escapeMarkStr=escapeMarkStr.substr(dotId+1);
							}
							execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
							if(execResult[1]=="(name=undefined)"){
								multiname.name=null;
							}else{
								multiname.name=ComplexString.unescape(execResult[1]);
							}
							//copyId=int(execResult[2]);
						break;
						case MultinameKinds.RTQName:
						case MultinameKinds.RTQNameA:
							execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
							if(execResult[1]=="(name=undefined)"){
								multiname.name=null;
							}else{
								multiname.name=ComplexString.unescape(execResult[1]);
							}
							//copyId=int(execResult[2]);
						break;
						case MultinameKinds.RTQNameL:
						case MultinameKinds.RTQNameLA:
							//什么都不用干...
						break;
						case MultinameKinds.MultinameL:
						case MultinameKinds.MultinameLA:
							dotId=escapeMarkStr.lastIndexOf(".");
							if(dotId==-1){
								throw new Error("dotId="+dotId);
							}else{
								multiname.ns_set=ABCNs_set.markStr2ns_set(markStrs,escapeMarkStr.substr(0,dotId));
								escapeMarkStr=escapeMarkStr.substr(dotId+1);
							}
						break;
						case MultinameKinds.GenericName:
							execResult=/^([\s\S]*?)\.?<([\s\S]*)>(?:\((\d+)\))?$/.exec(escapeMarkStr);
							if(execResult[1]=="(TypeDefinition=undefined)"){
							}else{
								multiname.TypeDefinition=markStr2multiname(markStrs,execResult[1]);
							}
							multiname.ParamV=new Vector.<ABCMultiname>();
							for each(var ParamMarkStr:String in GroupString.separate(execResult[2])){
								if(ParamMarkStr=="(Param=undefined)"){
									multiname.ParamV.push(null);
								}else{
									multiname.ParamV.push(markStr2multiname(markStrs,ParamMarkStr));
								}
							}
							if(multiname.ParamV.length){
							}else{
								throw new Error("multiname.ParamV.length="+multiname.ParamV.length);
							}
							//copyId=int(execResult[3]);
						break;
						default:
							throw new Error("未知 multiname.kind："+multiname.kind);
						break;
					}
					
					markStrs.markStrDict[multiname]=markStr;
					markStrs.multinameMark["~"+markStr]=multiname;
				}
				markStrs.multinameMark["~"+markStr0]=multiname;
			}
			return multiname;
		}
		public static function normalizeMarkStr(markStr:String):String{
			//获取最简 markStr
			
			var multinameKind:int;
			var id:int,escapeMarkStr:String;
			if(markStr.indexOf("[")==0){
				//可能是 multinameKind，也可能是 QName 的 ns.kind
				id=markStr.indexOf("]");
				multinameKind=MultinameKinds[markStr.substr(1,id-1)];
				if(multinameKind>0){
					escapeMarkStr=GroupString.escape(markStr.substr(id+1));
				}else{
					multinameKind=MultinameKinds.QName;
					escapeMarkStr=GroupString.escape(markStr);
				}
			}else{
				multinameKind=MultinameKinds.QName;
				escapeMarkStr=GroupString.escape(markStr);
			}
			
			var execResult:Array;
			var dotId:int;
			var copyId:int;
			
			switch(multinameKind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
					if(multinameKind==MultinameKinds.QName){
						markStr="";
					}else{
						markStr="[QNameA]";
					}
					if(escapeMarkStr.indexOf("(ns=undefined)")==0){
						markStr+="(ns=undefined)";
						escapeMarkStr=escapeMarkStr.replace(/\(ns=undefined\)\.?/,"");
					}else{
						dotId=escapeMarkStr.lastIndexOf(".");
						if(dotId==-1){
						}else{
							var nss_str:String=ABCNamespace.normalizeMarkStr(escapeMarkStr.substr(0,dotId));
							if(nss_str){
								markStr+=nss_str+".";
							}
							escapeMarkStr=escapeMarkStr.substr(dotId+1);
						}
					}
					execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
					if(execResult[1]=="(name=undefined)"){
						markStr+="(name=undefined)";
					}else{
						markStr+=GroupString.unescape(execResult[1]);
					}
					copyId=int(execResult[2]);
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					markStr="["+MultinameKinds.kindV[multinameKind]+"]";
					dotId=escapeMarkStr.lastIndexOf(".");
					if(dotId==-1){
						throw new Error("dotId="+dotId);
					}else{
						markStr+=ABCNs_set.normalizeMarkStr(escapeMarkStr.substr(0,dotId))+".";
						escapeMarkStr=escapeMarkStr.substr(dotId+1);
					}
					execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
					if(execResult[1]=="(name=undefined)"){
						markStr+="(name=undefined)";
					}else{
						markStr+=GroupString.unescape(execResult[1]);
					}
					copyId=int(execResult[2]);
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					markStr="["+MultinameKinds.kindV[multinameKind]+"]";
					execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
					if(execResult[1]=="(name=undefined)"){
						markStr+="(name=undefined)";
					}else{
						markStr+=GroupString.unescape(execResult[1]);
					}
					copyId=int(execResult[2]);
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					markStr="["+MultinameKinds.kindV[multinameKind]+"]";
					execResult=/^(?:\((\d+)\))?$/.exec(escapeMarkStr);
					copyId=int(execResult[1]);
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					markStr="["+MultinameKinds.kindV[multinameKind]+"]";
					dotId=escapeMarkStr.lastIndexOf(".");
					if(dotId==-1){
						throw new Error("dotId="+dotId);
					}else{
						markStr+=ABCNs_set.normalizeMarkStr(escapeMarkStr.substr(0,dotId))+".";
						escapeMarkStr=escapeMarkStr.substr(dotId+1);
					}
					execResult=/^(?:\((\d+)\))?$/.exec(escapeMarkStr);
					copyId=int(execResult[1]);
				break;
				case MultinameKinds.GenericName:
					markStr="["+MultinameKinds.kindV[multinameKind]+"]";
					execResult=/^([\s\S]*?)\.?<([\s\S]*)>(?:\((\d+)\))?$/.exec(escapeMarkStr);
					if(execResult[1]=="(TypeDefinition=undefined)"){
						markStr+="(TypeDefinition=undefined)";
					}else{
						markStr+=normalizeMarkStr(execResult[1])+".";
					}
					var ParamMarkStrs:String="";
					for each(var ParamMarkStr:String in GroupString.separate(execResult[2])){
						if(ParamMarkStr=="(Param=undefined)"){
							ParamMarkStrs+="(Param=undefined)";
						}else{
							ParamMarkStrs+=","+normalizeMarkStr(ParamMarkStr);
						}
					}
					markStr+="<"+ParamMarkStrs.substr(1)+">";
					copyId=int(execResult[3]);
				break;
				default:
					throw new Error("multinameKind="+multinameKind);
				break;
			}
			
			if(copyId>1){
				markStr+="("+copyId+")";
			}
			
			return markStr;
		}
		}//end of CONFIG::USE_XML
	}
}
