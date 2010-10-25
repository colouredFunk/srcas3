/***
Multiname_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 10:18:54 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.avm2{
	import flash.utils.ByteArray;
	import zero.swf.vmarks.MultinameKind;
	
	public class Multiname_info extends AVM2Obj{
		public var kind:int;							//u8
		
		public var ns:int;								//u30
		public var name:int;							//u30
		
		public var ns_set:int;							//u30
		
		public var TypeDefinition:int;					//u30
		public var ParamV:Vector.<int>;
		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			kind=data[offset++];
			
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
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){ns=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ns=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ns=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ns=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ns=data[offset++];}
					//ns
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
					//name
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
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
					//name
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ns_set=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ns_set=data[offset++];}
					//ns_set
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
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
					//name
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
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ns_set=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ns_set=data[offset++];}
					//ns_set
				break;
				case MultinameKind.GenericName:
					//0x1D can be considered a GenericName multiname, and is declared as such: 
					
					//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 
					
					//Where 
					//[TypeDefinition] is a U30 into the multiname table 
					//[ParamCount] is a U8 (U30?) of how many parameters there are 
					//[ParamX] is a U30 into the multiname table. 
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){TypeDefinition=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{TypeDefinition=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{TypeDefinition=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{TypeDefinition=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{TypeDefinition=data[offset++];}
					//TypeDefinition
					
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var ParamCount:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ParamCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ParamCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ParamCount=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ParamCount=data[offset++];}
					//ParamCount
					ParamV=new Vector.<int>(ParamCount);
					for(var i:int=0;i<ParamCount;i++){
						
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){ParamV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ParamV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ParamV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ParamV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ParamV[i]=data[offset++];}
						//ParamV[i]
					}
				break;
			}
			
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=kind;
			
			var offset:int=1;
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					if(ns>>>7){if(ns>>>14){if(ns>>>21){if(ns>>>28){data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=((ns>>>21)&0x7f)|0x80;data[offset++]=ns>>>28;}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=ns>>>21;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=ns>>>14;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=ns>>>7;}}else{data[offset++]=ns;}
					//ns
					
					if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
					//name
					
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
					//name
					
					if(ns_set>>>7){if(ns_set>>>14){if(ns_set>>>21){if(ns_set>>>28){data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=((ns_set>>>7)&0x7f)|0x80;data[offset++]=((ns_set>>>14)&0x7f)|0x80;data[offset++]=((ns_set>>>21)&0x7f)|0x80;data[offset++]=ns_set>>>28;}else{data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=((ns_set>>>7)&0x7f)|0x80;data[offset++]=((ns_set>>>14)&0x7f)|0x80;data[offset++]=ns_set>>>21;}}else{data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=((ns_set>>>7)&0x7f)|0x80;data[offset++]=ns_set>>>14;}}else{data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=ns_set>>>7;}}else{data[offset++]=ns_set;}
					//ns_set
					
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
					//name
					
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					if(ns_set>>>7){if(ns_set>>>14){if(ns_set>>>21){if(ns_set>>>28){data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=((ns_set>>>7)&0x7f)|0x80;data[offset++]=((ns_set>>>14)&0x7f)|0x80;data[offset++]=((ns_set>>>21)&0x7f)|0x80;data[offset++]=ns_set>>>28;}else{data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=((ns_set>>>7)&0x7f)|0x80;data[offset++]=((ns_set>>>14)&0x7f)|0x80;data[offset++]=ns_set>>>21;}}else{data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=((ns_set>>>7)&0x7f)|0x80;data[offset++]=ns_set>>>14;}}else{data[offset++]=(ns_set&0x7f)|0x80;data[offset++]=ns_set>>>7;}}else{data[offset++]=ns_set;}
					//ns_set
					
				break;
				case MultinameKind.GenericName:
					if(TypeDefinition>>>7){if(TypeDefinition>>>14){if(TypeDefinition>>>21){if(TypeDefinition>>>28){data[offset++]=(TypeDefinition&0x7f)|0x80;data[offset++]=((TypeDefinition>>>7)&0x7f)|0x80;data[offset++]=((TypeDefinition>>>14)&0x7f)|0x80;data[offset++]=((TypeDefinition>>>21)&0x7f)|0x80;data[offset++]=TypeDefinition>>>28;}else{data[offset++]=(TypeDefinition&0x7f)|0x80;data[offset++]=((TypeDefinition>>>7)&0x7f)|0x80;data[offset++]=((TypeDefinition>>>14)&0x7f)|0x80;data[offset++]=TypeDefinition>>>21;}}else{data[offset++]=(TypeDefinition&0x7f)|0x80;data[offset++]=((TypeDefinition>>>7)&0x7f)|0x80;data[offset++]=TypeDefinition>>>14;}}else{data[offset++]=(TypeDefinition&0x7f)|0x80;data[offset++]=TypeDefinition>>>7;}}else{data[offset++]=TypeDefinition;}
					//TypeDefinition
					var ParamCount:int=ParamV.length;
					
					if(ParamCount>>>7){if(ParamCount>>>14){if(ParamCount>>>21){if(ParamCount>>>28){data[offset++]=(ParamCount&0x7f)|0x80;data[offset++]=((ParamCount>>>7)&0x7f)|0x80;data[offset++]=((ParamCount>>>14)&0x7f)|0x80;data[offset++]=((ParamCount>>>21)&0x7f)|0x80;data[offset++]=ParamCount>>>28;}else{data[offset++]=(ParamCount&0x7f)|0x80;data[offset++]=((ParamCount>>>7)&0x7f)|0x80;data[offset++]=((ParamCount>>>14)&0x7f)|0x80;data[offset++]=ParamCount>>>21;}}else{data[offset++]=(ParamCount&0x7f)|0x80;data[offset++]=((ParamCount>>>7)&0x7f)|0x80;data[offset++]=ParamCount>>>14;}}else{data[offset++]=(ParamCount&0x7f)|0x80;data[offset++]=ParamCount>>>7;}}else{data[offset++]=ParamCount;}
					//ParamCount
					
					for each(var Param:int in ParamV){
						
						if(Param>>>7){if(Param>>>14){if(Param>>>21){if(Param>>>28){data[offset++]=(Param&0x7f)|0x80;data[offset++]=((Param>>>7)&0x7f)|0x80;data[offset++]=((Param>>>14)&0x7f)|0x80;data[offset++]=((Param>>>21)&0x7f)|0x80;data[offset++]=Param>>>28;}else{data[offset++]=(Param&0x7f)|0x80;data[offset++]=((Param>>>7)&0x7f)|0x80;data[offset++]=((Param>>>14)&0x7f)|0x80;data[offset++]=Param>>>21;}}else{data[offset++]=(Param&0x7f)|0x80;data[offset++]=((Param>>>7)&0x7f)|0x80;data[offset++]=Param>>>14;}}else{data[offset++]=(Param&0x7f)|0x80;data[offset++]=Param>>>7;}}else{data[offset++]=Param;}
						//Param
					}
					
				break;
			}
			
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Multiname_info
				kind={MultinameKind.kindV[kind]}
			>
			</Multiname_info>;
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					xml.@ns=ns;
					xml.@name=name;
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					xml.@name=name;
					xml.@ns_set=ns_set;
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
					xml.@ns_set=ns_set;
				break;
				case MultinameKind.GenericName:
					xml.@TypeDefinition=TypeDefinition;
					if(ParamV.length){
						var listXML:XML=<ParamList/>;
						listXML.@count=ParamV.length;
						for each(var Param:int in ParamV){
							listXML.appendChild(<Param value={Param}/>);
						}
						xml.appendChild(listXML);
					}
				break;
			}
			
			return xml;
		}
		override public function initByXML(xml:XML):void{
			kind=MultinameKind[xml.@kind.toString()];
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					ns=int(xml.@ns.toString());
					name=int(xml.@name.toString());
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					name=int(xml.@name.toString());
					ns_set=int(xml.@ns_set.toString());
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					name=int(xml.@name.toString());
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					//
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					ns_set=int(xml.@ns_set.toString());
				break;
				case MultinameKind.GenericName:
					TypeDefinition=int(xml.@TypeDefinition.toString());
					if(xml.ParamList.length()){
						var listXML:XML=xml.ParamList[0];
						var ParamXMLList:XMLList=listXML.Param;
						var i:int=-1;
						ParamV=new Vector.<int>(ParamXMLList.length());
						for each(var ParamXML:XML in ParamXMLList){
							i++;
							ParamV[i]=int(ParamXML.@value.toString());
						}
					}else{
						ParamV=new Vector.<int>();
					}
				break;
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
