/***
Method_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月19日 14:52:15 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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


//This entry may be present only if the HAS_PARAM_NAMES flag is set in flags.
package zero.swf.avm2{
	import zero.swf.vmarks.MethodFlags;
	import zero.swf.avm2.Option_info;
	import flash.utils.ByteArray;
	public class Method_info extends AVM2Obj{
		public var param_count:int;						//u30
		public var return_type:int;						//u30
		public var param_typeV:Vector.<int>;
		public var name:int;							//u30
		public var flags:int;							//u8
		public var option_info:Option_info;
		public var param_nameV:Vector.<int>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							param_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							param_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						param_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					param_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				param_count=data[offset++];
			}
			//
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					return_type=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				return_type=data[offset++];
			}
			//
			//#offsetpp
			
			param_typeV=new Vector.<int>(param_count);
			for(var i:int=0;i<param_count;i++){
				//#offsetpp
			
				if(data[offset]>>>7){
					if(data[offset+1]>>>7){
						if(data[offset+2]>>>7){
							if(data[offset+3]>>>7){
								param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
							}else{
								param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
							}
						}else{
							param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
						}
					}else{
						param_typeV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);
					}
				}else{
					param_typeV[i]=data[offset++];
				}
				//
			}
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					name=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				name=data[offset++];
			}
			//
			flags=data[offset++];
			//#offsetpp
			
			if(flags&MethodFlags.HAS_OPTIONAL){
				//#offsetpp
			
				option_info=new Option_info();
				offset=option_info.initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			if(flags&MethodFlags.HAS_PARAM_NAMES){
				//#offsetpp
			
				param_nameV=new Vector.<int>(param_count);
				for(i=0;i<param_count;i++){
					//#offsetpp
			
					if(data[offset]>>>7){
						if(data[offset+1]>>>7){
							if(data[offset+2]>>>7){
								if(data[offset+3]>>>7){
									param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
								}else{
									param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
								}
							}else{
								param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
							}
						}else{
							param_nameV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);
						}
					}else{
						param_nameV[i]=data[offset++];
					}
					//
				}
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			//#offsetpp
			var offset:int=0;
			if(param_count>>>7){
				if(param_count>>>14){
					if(param_count>>>21){
						if(param_count>>>28){
							data[offset++]=(param_count&0x7f)|0x80;
							data[offset++]=((param_count>>>7)&0x7f)|0x80;
							data[offset++]=((param_count>>>14)&0x7f)|0x80;
							data[offset++]=((param_count>>>21)&0x7f)|0x80;
							data[offset++]=param_count>>>28;
						}else{
							data[offset++]=(param_count&0x7f)|0x80;
							data[offset++]=((param_count>>>7)&0x7f)|0x80;
							data[offset++]=((param_count>>>14)&0x7f)|0x80;
							data[offset++]=param_count>>>21;
						}
					}else{
						data[offset++]=(param_count&0x7f)|0x80;
						data[offset++]=((param_count>>>7)&0x7f)|0x80;
						data[offset++]=param_count>>>14;
					}
				}else{
					data[offset++]=(param_count&0x7f)|0x80;
					data[offset++]=param_count>>>7;
				}
			}else{
				data[offset++]=param_count;
			}
			//
			//#offsetpp
			
			if(return_type>>>7){
				if(return_type>>>14){
					if(return_type>>>21){
						if(return_type>>>28){
							data[offset++]=(return_type&0x7f)|0x80;
							data[offset++]=((return_type>>>7)&0x7f)|0x80;
							data[offset++]=((return_type>>>14)&0x7f)|0x80;
							data[offset++]=((return_type>>>21)&0x7f)|0x80;
							data[offset++]=return_type>>>28;
						}else{
							data[offset++]=(return_type&0x7f)|0x80;
							data[offset++]=((return_type>>>7)&0x7f)|0x80;
							data[offset++]=((return_type>>>14)&0x7f)|0x80;
							data[offset++]=return_type>>>21;
						}
					}else{
						data[offset++]=(return_type&0x7f)|0x80;
						data[offset++]=((return_type>>>7)&0x7f)|0x80;
						data[offset++]=return_type>>>14;
					}
				}else{
					data[offset++]=(return_type&0x7f)|0x80;
					data[offset++]=return_type>>>7;
				}
			}else{
				data[offset++]=return_type;
			}
			//
			//#offsetpp
			
			for each(var param_type:int in param_typeV){
				//#offsetpp
			
				if(param_type>>>7){
					if(param_type>>>14){
						if(param_type>>>21){
							if(param_type>>>28){
								data[offset++]=(param_type&0x7f)|0x80;
								data[offset++]=((param_type>>>7)&0x7f)|0x80;
								data[offset++]=((param_type>>>14)&0x7f)|0x80;
								data[offset++]=((param_type>>>21)&0x7f)|0x80;
								data[offset++]=param_type>>>28;
							}else{
								data[offset++]=(param_type&0x7f)|0x80;
								data[offset++]=((param_type>>>7)&0x7f)|0x80;
								data[offset++]=((param_type>>>14)&0x7f)|0x80;
								data[offset++]=param_type>>>21;
							}
						}else{
							data[offset++]=(param_type&0x7f)|0x80;
							data[offset++]=((param_type>>>7)&0x7f)|0x80;
							data[offset++]=param_type>>>14;
						}
					}else{
						data[offset++]=(param_type&0x7f)|0x80;
						data[offset++]=param_type>>>7;
					}
				}else{
					data[offset++]=param_type;
				}
				//
			}
			//#offsetpp
			
			if(name>>>7){
				if(name>>>14){
					if(name>>>21){
						if(name>>>28){
							data[offset++]=(name&0x7f)|0x80;
							data[offset++]=((name>>>7)&0x7f)|0x80;
							data[offset++]=((name>>>14)&0x7f)|0x80;
							data[offset++]=((name>>>21)&0x7f)|0x80;
							data[offset++]=name>>>28;
						}else{
							data[offset++]=(name&0x7f)|0x80;
							data[offset++]=((name>>>7)&0x7f)|0x80;
							data[offset++]=((name>>>14)&0x7f)|0x80;
							data[offset++]=name>>>21;
						}
					}else{
						data[offset++]=(name&0x7f)|0x80;
						data[offset++]=((name>>>7)&0x7f)|0x80;
						data[offset++]=name>>>14;
					}
				}else{
					data[offset++]=(name&0x7f)|0x80;
					data[offset++]=name>>>7;
				}
			}else{
				data[offset++]=name;
			}
			//
			data[offset++]=flags;
			//#offsetpp
			
			if(option_info){
				data.position=offset;
				data.writeBytes(option_info.toData());
				offset=data.length;
			}
			//#offsetpp
			
			if(param_nameV){
				//#offsetpp
			
				for each(var param_name:int in param_nameV){
					//#offsetpp
			
					if(param_name>>>7){
						if(param_name>>>14){
							if(param_name>>>21){
								if(param_name>>>28){
									data[offset++]=(param_name&0x7f)|0x80;
									data[offset++]=((param_name>>>7)&0x7f)|0x80;
									data[offset++]=((param_name>>>14)&0x7f)|0x80;
									data[offset++]=((param_name>>>21)&0x7f)|0x80;
									data[offset++]=param_name>>>28;
								}else{
									data[offset++]=(param_name&0x7f)|0x80;
									data[offset++]=((param_name>>>7)&0x7f)|0x80;
									data[offset++]=((param_name>>>14)&0x7f)|0x80;
									data[offset++]=param_name>>>21;
								}
							}else{
								data[offset++]=(param_name&0x7f)|0x80;
								data[offset++]=((param_name>>>7)&0x7f)|0x80;
								data[offset++]=param_name>>>14;
							}
						}else{
							data[offset++]=(param_name&0x7f)|0x80;
							data[offset++]=param_name>>>7;
						}
					}else{
						data[offset++]=param_name;
					}
					//
				}
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Method_info
				param_count={param_count}
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
			>
				<list vNames="param_typeV" count={param_typeV.length}/>
				<option_info/>
				<list vNames="param_nameV"/>
			</Method_info>;
			var listXML:XML=xml.list[0];
			for each(var param_type:int in param_typeV){
				listXML.appendChild(<param_type value={param_type}/>);
			}
			if(option_info){
				xml.option_info.appendChild(option_info.toXML());
			}else{
				delete xml.option_info;
			}
			if(param_nameV){
				listXML=xml.list[1];
				for each(var param_name:int in param_nameV){
					listXML.appendChild(<param_name value={param_name}/>);
				}
				xml.list[1].@count=param_nameV.length;
			}else{
				delete xml.list[1];
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			param_count=int(xml.@param_count.toString());
			return_type=int(xml.@return_type.toString());
			var listXML:XML=xml.list[0];
			var param_typeXMLList:XMLList=listXML.param_type;
			var i:int=-1;
			param_typeV=new Vector.<int>(param_typeXMLList.length());
			for each(var param_typeXML:XML in param_typeXMLList){
				i++;
				param_typeV[i]=int(param_typeXML.@value.toString());
			}
			name=int(xml.@name.toString());
			
			flags=0;
			for each(var flagsStr:String in xml.@flags.toString().split("|")){
				flags|=MethodFlags[flagsStr];
			}
			
			if(xml.option_info.length()==1){
				option_info=new Option_info();
				option_info.initByXML(xml.option_info.children()[0]);
			}
			if(xml.list.length()>1){
				listXML=xml.list[1];
				var param_nameXMLList:XMLList=listXML.param_name;
				i=-1;
				param_nameV=new Vector.<int>(param_nameXMLList.length());
				for each(var param_nameXML:XML in param_nameXMLList){
					i++;
					param_nameV[i]=int(param_nameXML.@value.toString());
				}
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
