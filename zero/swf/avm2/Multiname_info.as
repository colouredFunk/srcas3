/***
Multiname_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月19日 23:00:39（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
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

//multiname_kind_RTQName
//{
//	u30 name
//}

//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
//name是在 constant_pool.string_v 中的id
//name如果是 0 则表示 "*"

//multiname_kind_RTQNameL
//{
//}

//This kind has no associated data.
//什么都没有...

//multiname_kind_MultinameL
//{
//	u30 ns_set
//}

//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
//ns_set是在 constant_pool.ns_set_info_v 中的id
//ns_set不能是 0

//0x1D can be considered a GenericName multiname, and is declared as such: 

//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 

//Where 
//[TypeDefinition] is a U30 into the multiname table 
//[ParamCount] is a U8 (U30?) of how many parameters there are 
//[ParamX] is a U30 into the multiname table. 
package zero.swf.avm2{
	import zero.swf.avm2.MultinameKinds;
	import flash.utils.ByteArray;
	public class Multiname_info/*{*/implements I_zero_swf_CheckCodesRight{
		public var kind:int;							//u8
		//QName，QNameA				u30_1 表现为：ns，u30_2 表现为：name
		//Multiname，MultinameA		u30_1 表现为：name，u30_2 表现为：ns_set
		//RTQName，RTQNameA			u30_1 表现为：name，u30_2 不使用
		//RTQNameL，RTQNameLA		u30_1 不使用，u30_2 不使用
		//MultinameL，MultinameLA	u30_1 表现为：ns_set，u30_2 不使用
		//GenericName				u30_1 表现为：TypeDefinition，u30_2 不使用
		public var u30_1:int;							//u30
		public var u30_2:int;							//u30
		//ParamV 仅用于 GenericName
		public var ParamV:Vector.<int>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			kind=data[offset];
			
			++offset;
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
					//u30_1
			
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
					//u30_2
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
					//u30_1
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
					//u30_1
				break;
				case MultinameKinds.GenericName:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
					//u30_1
			
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
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=kind;
			
			var offset:int=1;
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
					//u30_1
			
					if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
					//u30_2
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
					//u30_1
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
					//u30_1
				break;
				case MultinameKinds.GenericName:
					if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
					//u30_1
			
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
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="Multiname_info"
				kind={MultinameKinds.kindV[kind]}
			/>;
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					xml.@u30_1=u30_1;
					xml.@u30_2=u30_2;
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					xml.@u30_1=u30_1;
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					xml.@u30_1=u30_1;
				break;
				case MultinameKinds.GenericName:
					xml.@u30_1=u30_1;
					if(ParamV.length){
						var listXML:XML=<ParamList count={ParamV.length}/>
						for each(var Param:int in ParamV){
							listXML.appendChild(<Param value={Param}/>);
						}
						xml.appendChild(listXML);
					}
				break;
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			kind=MultinameKinds[xml.@kind.toString()];
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					u30_1=int(xml.@u30_1.toString());
					u30_2=int(xml.@u30_2.toString());
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					u30_1=int(xml.@u30_1.toString());
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					u30_1=int(xml.@u30_1.toString());
				break;
				case MultinameKinds.GenericName:
					u30_1=int(xml.@u30_1.toString());
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
		}//end of CONFIG::USE_XML
	}
}
