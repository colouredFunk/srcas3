/***
Method_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//method_info
//{
//	u30 param_count
//	u30 return_type
//	u30 param_type[param_count]
//	u30 name
//	u8 flags
//	option_info options
//	param_info param_names
//}

//The param_count field is the number of formal parameters that the method supports; it also represents
//the length of the param_type array.
//param_count 是 参数名 array 的长度, 也是 参数类型 array 的长度

//The return_type field is an index into the multiname array of the constant pool; the name at that entry
//provides the name of the return type of this method. A zero value denotes the any ("*") type.
//return_type 是在 constant_pool.multiname_info_v 中的id

//Each entry in the param_type array is an index into the multiname
//array of the constant pool; the name at that entry provides the name of the type of the corresponding
//formal parameter. A zero value denotes the any ("*") type.
//param_type 是在 constant_pool.multiname_info_v 中的id
//0 表示 任意类型 "*"

//The name field is an index into the string array of the constant pool; the string at that entry provides the
//name of this method. If the index is zero, this method has no name.
//name 是在 constant_pool.string_v 中的id
//0 表示 method没有名字(不是函数名而是类似DoABC的Name的一个没有什么意义的东西)

//The flag field is a bit vector that provides additional information about the method. The bits are
//described by the following table. (Bits not described in the table should all be set to zero.)
//Name 				Value 	Meaning
//NEED_ARGUMENTS 	0x01 	Suggests to the run-time that an "arguments" object (as specified by the ActionScript 3.0 Language Reference) be created. Must not be used together with NEED_REST. See Chapter 3.
//NEED_ACTIVATION 	0x02 	Must be set if this method uses the newactivation opcode.
//NEED_REST 		0x04 	This flag creates an ActionScript 3.0 rest arguments array. Must not be used with NEED_ARGUMENTS. See Chapter 3.
//HAS_OPTIONAL 		0x08 	Must be set if this method has optional parameters and the options field is present in this method_info structure.
//SET_DXNS 			0x40 	Must be set if this method uses the dxns or dxnslate opcodes.
//HAS_PARAM_NAMES 	0x80 	Must be set when the param_names field is present in this method_info structure.

//This entry may be present only if the HAS_OPTIONAL flag is set in flags.


//The param_names entry is available only when the HAS_PARAM_NAMES bit is set in the flags. Each param_info
//element of the array is an index into the constant pool's string array. The parameter name entry exists solely
//for external tool use and is not used by the AVM2.

//The option_info entry is used to define the default values for the optional parameters of the method. The
//number of optional parameters is given by option_count, which must not be zero nor greater than the
//parameter_count field of the enclosing method_info structure.
//默认参数信息
//option_count 不能是0, 也不能大于 parameter_count

//option_info
//{
//	u30 option_count
//	option_detail option[option_count]
//}
package zero.swf.avm2{
	import zero.swf.avm2.MethodFlags;
	import zero.swf.avm2.Option_detail;
	import flash.utils.ByteArray;
	public class Method_info{//implements I_zero_swf_CheckCodesRight{
		public var return_type:int;						//u30
		public var param_typeV:Vector.<int>;
		public var name:int;							//u30
		public var flags:int;							//u8
		public var option_detailV:Vector.<Option_detail>;
		public var param_nameV:Vector.<int>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var param_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{param_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{param_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{param_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{param_count=data[offset++];}
			//param_count
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{return_type=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{return_type=data[offset++];}
			//return_type
			
			param_typeV=new Vector.<int>(param_count);
			for(var i:int=0;i<param_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{param_typeV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{param_typeV[i]=data[offset++];}
				//param_typeV[i]
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
			//name
			flags=data[offset++];
			
			if(flags&MethodFlags.HAS_OPTIONAL){
			
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var option_detail_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{option_detail_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{option_detail_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{option_detail_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{option_detail_count=data[offset++];}
				//option_detail_count
				option_detailV=new Vector.<Option_detail>(option_detail_count);
				for(i=0;i<option_detail_count;i++){
			
					option_detailV[i]=new Option_detail();
					offset=option_detailV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}
			
			if(flags&MethodFlags.HAS_PARAM_NAMES){
			
				param_nameV=new Vector.<int>(param_count);
				for(i=0;i<param_count;i++){
			
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{param_nameV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{param_nameV[i]=data[offset++];}
					//param_nameV[i]
				}
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			var param_count:int=param_typeV.length;
			if(param_count>>>7){if(param_count>>>14){if(param_count>>>21){if(param_count>>>28){data[offset++]=(param_count&0x7f)|0x80;data[offset++]=((param_count>>>7)&0x7f)|0x80;data[offset++]=((param_count>>>14)&0x7f)|0x80;data[offset++]=((param_count>>>21)&0x7f)|0x80;data[offset++]=param_count>>>28;}else{data[offset++]=(param_count&0x7f)|0x80;data[offset++]=((param_count>>>7)&0x7f)|0x80;data[offset++]=((param_count>>>14)&0x7f)|0x80;data[offset++]=param_count>>>21;}}else{data[offset++]=(param_count&0x7f)|0x80;data[offset++]=((param_count>>>7)&0x7f)|0x80;data[offset++]=param_count>>>14;}}else{data[offset++]=(param_count&0x7f)|0x80;data[offset++]=param_count>>>7;}}else{data[offset++]=param_count;}
			//param_count
			
			if(return_type>>>7){if(return_type>>>14){if(return_type>>>21){if(return_type>>>28){data[offset++]=(return_type&0x7f)|0x80;data[offset++]=((return_type>>>7)&0x7f)|0x80;data[offset++]=((return_type>>>14)&0x7f)|0x80;data[offset++]=((return_type>>>21)&0x7f)|0x80;data[offset++]=return_type>>>28;}else{data[offset++]=(return_type&0x7f)|0x80;data[offset++]=((return_type>>>7)&0x7f)|0x80;data[offset++]=((return_type>>>14)&0x7f)|0x80;data[offset++]=return_type>>>21;}}else{data[offset++]=(return_type&0x7f)|0x80;data[offset++]=((return_type>>>7)&0x7f)|0x80;data[offset++]=return_type>>>14;}}else{data[offset++]=(return_type&0x7f)|0x80;data[offset++]=return_type>>>7;}}else{data[offset++]=return_type;}
			//return_type
			
			for each(var param_type:int in param_typeV){
			
				if(param_type>>>7){if(param_type>>>14){if(param_type>>>21){if(param_type>>>28){data[offset++]=(param_type&0x7f)|0x80;data[offset++]=((param_type>>>7)&0x7f)|0x80;data[offset++]=((param_type>>>14)&0x7f)|0x80;data[offset++]=((param_type>>>21)&0x7f)|0x80;data[offset++]=param_type>>>28;}else{data[offset++]=(param_type&0x7f)|0x80;data[offset++]=((param_type>>>7)&0x7f)|0x80;data[offset++]=((param_type>>>14)&0x7f)|0x80;data[offset++]=param_type>>>21;}}else{data[offset++]=(param_type&0x7f)|0x80;data[offset++]=((param_type>>>7)&0x7f)|0x80;data[offset++]=param_type>>>14;}}else{data[offset++]=(param_type&0x7f)|0x80;data[offset++]=param_type>>>7;}}else{data[offset++]=param_type;}
				//param_type
			}
			
			if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
			//name
			data[offset++]=flags;
			
			if(flags&MethodFlags.HAS_OPTIONAL){
				var option_detail_count:int=option_detailV.length;
			
				if(option_detail_count>>>7){if(option_detail_count>>>14){if(option_detail_count>>>21){if(option_detail_count>>>28){data[offset++]=(option_detail_count&0x7f)|0x80;data[offset++]=((option_detail_count>>>7)&0x7f)|0x80;data[offset++]=((option_detail_count>>>14)&0x7f)|0x80;data[offset++]=((option_detail_count>>>21)&0x7f)|0x80;data[offset++]=option_detail_count>>>28;}else{data[offset++]=(option_detail_count&0x7f)|0x80;data[offset++]=((option_detail_count>>>7)&0x7f)|0x80;data[offset++]=((option_detail_count>>>14)&0x7f)|0x80;data[offset++]=option_detail_count>>>21;}}else{data[offset++]=(option_detail_count&0x7f)|0x80;data[offset++]=((option_detail_count>>>7)&0x7f)|0x80;data[offset++]=option_detail_count>>>14;}}else{data[offset++]=(option_detail_count&0x7f)|0x80;data[offset++]=option_detail_count>>>7;}}else{data[offset++]=option_detail_count;}
				//option_detail_count
			
				data.position=offset;
				for each(var option_detail:Option_detail in option_detailV){
					data.writeBytes(option_detail.toData(_toDataOptions));
				}
			offset=data.length;
			}
			
			if(flags&MethodFlags.HAS_PARAM_NAMES){
			
				for each(var param_name:int in param_nameV){
			
					if(param_name>>>7){if(param_name>>>14){if(param_name>>>21){if(param_name>>>28){data[offset++]=(param_name&0x7f)|0x80;data[offset++]=((param_name>>>7)&0x7f)|0x80;data[offset++]=((param_name>>>14)&0x7f)|0x80;data[offset++]=((param_name>>>21)&0x7f)|0x80;data[offset++]=param_name>>>28;}else{data[offset++]=(param_name&0x7f)|0x80;data[offset++]=((param_name>>>7)&0x7f)|0x80;data[offset++]=((param_name>>>14)&0x7f)|0x80;data[offset++]=param_name>>>21;}}else{data[offset++]=(param_name&0x7f)|0x80;data[offset++]=((param_name>>>7)&0x7f)|0x80;data[offset++]=param_name>>>14;}}else{data[offset++]=(param_name&0x7f)|0x80;data[offset++]=param_name>>>7;}}else{data[offset++]=param_name;}
					//param_name
				}
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="Method_info"
				return_type={return_type}
				name={name}
				flags={(
					"|"+MethodFlags.flagV[flags&MethodFlags.NEED_ARGUMENTS]+
					"|"+MethodFlags.flagV[flags&MethodFlags.NEED_ACTIVATION]+
					"|"+MethodFlags.flagV[flags&MethodFlags.NEED_REST]+
					"|"+MethodFlags.flagV[flags&MethodFlags.HAS_OPTIONAL]+
					"|"+MethodFlags.flagV[flags&MethodFlags.SET_DXNS]+
					"|"+MethodFlags.flagV[flags&MethodFlags.HAS_PARAM_NAMES]
				).replace(/\|null/g,"").substr(1)}
			/>;
			
			if(param_typeV.length){
				var listXML:XML=<param_typeList count={param_typeV.length}/>
				for each(var param_type:int in param_typeV){
					listXML.appendChild(<param_type value={param_type}/>);
				}
				xml.appendChild(listXML);
			}
			if(flags&MethodFlags.HAS_OPTIONAL){
				if(option_detailV.length){
					listXML=<option_detailList count={option_detailV.length}/>
					for each(var option_detail:Option_detail in option_detailV){
						listXML.appendChild(option_detail.toXML("option_detail",_toXMLOptions));
					}
					xml.appendChild(listXML);
				}
			}
			if(flags&MethodFlags.HAS_PARAM_NAMES){
				if(param_nameV.length){
					listXML=<param_nameList count={param_nameV.length}/>
					for each(var param_name:int in param_nameV){
						listXML.appendChild(<param_name value={param_name}/>);
					}
					xml.appendChild(listXML);
				}
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			return_type=int(xml.@return_type.toString());
			if(xml.param_typeList.length()){
				var listXML:XML=xml.param_typeList[0];
				var param_typeXMLList:XMLList=listXML.param_type;
				var i:int=-1;
				param_typeV=new Vector.<int>(param_typeXMLList.length());
				for each(var param_typeXML:XML in param_typeXMLList){
					i++;
					param_typeV[i]=int(param_typeXML.@value.toString());
				}
			}else{
				param_typeV=new Vector.<int>();
			}
			name=int(xml.@name.toString());
			
			flags=0;
			for each(var flagsStr:String in xml.@flags.toString().split("|")){
				flags|=MethodFlags[flagsStr];
			}
			
			if(flags&MethodFlags.HAS_OPTIONAL){
				if(xml.option_detailList.length()){
					listXML=xml.option_detailList[0];
					var option_detailXMLList:XMLList=listXML.option_detail;
					i=-1;
					option_detailV=new Vector.<Option_detail>(option_detailXMLList.length());
					for each(var option_detailXML:XML in option_detailXMLList){
						i++;
						option_detailV[i]=new Option_detail();
						option_detailV[i].initByXML(option_detailXML,_initByXMLOptions);
					}
				}else{
					option_detailV=new Vector.<Option_detail>();
				}
			}
			if(flags&MethodFlags.HAS_PARAM_NAMES){
				if(xml.param_nameList.length()){
					listXML=xml.param_nameList[0];
					var param_nameXMLList:XMLList=listXML.param_name;
					i=-1;
					param_nameV=new Vector.<int>(param_nameXMLList.length());
					for each(var param_nameXML:XML in param_nameXMLList){
						i++;
						param_nameV[i]=int(param_nameXML.@value.toString());
					}
				}else{
					param_nameV=new Vector.<int>();
				}
			}
		}
		}//end of CONFIG::USE_XML
	}
}
