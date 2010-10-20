/***
Constant_pool 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 22:02:57 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The constant pool is a block of array-based entries(entry 条目) that reflect the constants used by all methods.
//Each of the count entries (for example, int_count) must be one more than the number of entries in the corresponding
//array, 
//每个条目数组的 count 都是比数组长度多1(1表示0,2表示1,...因为0表示了特别的意义，下面有提及)
//and the first entry in the array is element "1". 
//For all constant pools, the index "0" has a special meaning,
//typically a sensible default value. For example, the "0" entry is used to represent the empty sting (""), the any
//namespace, or the any type (*) depending on the context it is used in. When "0" has a special meaning it is
//described in the text below.

//cpool_info
//{
//	u30 			int_count
//	s32 			integer[int_count]
//	u30 			uint_count
//	u32 			uinteger[uint_count]
//	u30 			double_count
//	d64 			double[double_count]
//	u30 			string_count
//	string_info 	string[string_count]
//	u30 			namespace_count
//	namespace_info 	namespace[namespace_count]
//	u30 			ns_set_count
//	ns_set_info 	ns_set[ns_set_count]
//	u30 			multiname_count
//	multiname_info 	multiname[multiname_count]
//}

//The value of int_count is the number of entries in the integer array, plus one. The integer array
//holds integer constants referenced by the bytecode. The "0" entry of the integer array is not present in
//the abcFile; it represents the zero value for the purposes of providing values for optional parameters and
//field initialization.

//The value of uint_count is the number of entries in the uinteger array, plus one. The uinteger array
//holds unsigned integer constants referenced by the bytecode. The "0" entry of the uinteger array is not
//present in the abcFile; it represents the zero value for the purposes of providing values for optional
//parameters and field initialization.

//The value of double_count is the number of entries in the double array, plus one. The double array
//holds IEEE double-precision floating point constants referenced by the bytecode. 
//The "0" entry of the double array is not present in the abcFile; it represents the NaN (Not-a-Number) value for the purposes of providing values for optional parameters and field initialization.
//0 代表 NaN	

//The value of string_count is the number of entries in the string array, plus one. The string array
//holds UTF-8 encoded strings referenced by the compiled code and by many other parts of the abcFile.
//In addition to describing string constants in programs, string data in the constant pool are used in the
//description of names of many kinds. Entry "0" of the string array is not present in the abcFile; it
//represents the empty string in most contexts but is also used to represent the "any" name in others
//(known as "*" in ActionScript).

//The value of namespace_count is the number of entries in the namespace array, plus one. The
//namespace array describes the namespaces used by the bytecode and also for names of many kinds. Entry
//"0" of the namespace array is not present in the abcFile; it represents the "any" namespace (known as
//"*" in ActionScript).

//The value of ns_set_count is the number of entries in the ns_set array, plus one. The ns_set array
//describes namespace sets used in the descriptions of multinames. The "0" entry of the ns_set array is not
//present in the abcFile.

//The value of multiname_count is the number of entries in the multiname array, plus one. The
//multiname array describes names used by the bytecode. The "0" entry of the multiname array is not
//present in the abcFile.
package zero.swf.avm2{
	import zero.swf.avm2.Namespace_info;
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.vmark.MultinameKind;
	import zero.swf.avm2.multiname.Multiname_info;
	import flash.utils.Endian;
	import flash.utils.ByteArray;
	public class Constant_pool extends AVM2Obj{
		public var integerV:Vector.<int>;
		public var uintegerV:Vector.<int>;
		public var doubleV:Vector.<Number>;
		public var stringV:Vector.<String>;
		public var namespace_infoV:Vector.<Namespace_info>;
		public var ns_set_infoV:Vector.<Ns_set_info>;
		public var multiname_infoV:Vector.<Multiname_info>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			data.endian=Endian.LITTLE_ENDIAN;
			//#offsetpp
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var integer_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					integer_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				integer_count=data[offset++];
			}
			//
			integerV=new Vector.<int>(integer_count);
			for(var i:int=1;i<integer_count;i++){
				//#offsetpp
			
				if(data[offset]>>>7){
					if(data[offset+1]>>>7){
						if(data[offset+2]>>>7){
							if(data[offset+3]>>>7){
								integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
							}else{
								integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
							}
						}else{
							integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
						}
					}else{
						integerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);
					}
				}else{
					integerV[i]=data[offset++];
				}
				//
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var uinteger_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					uinteger_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				uinteger_count=data[offset++];
			}
			//
			uintegerV=new Vector.<int>(uinteger_count);
			for(i=1;i<uinteger_count;i++){
				//#offsetpp
			
				if(data[offset]>>>7){
					if(data[offset+1]>>>7){
						if(data[offset+2]>>>7){
							if(data[offset+3]>>>7){
								uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
							}else{
								uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
							}
						}else{
							uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
						}
					}else{
						uintegerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);
					}
				}else{
					uintegerV[i]=data[offset++];
				}
				//
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var double_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					double_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				double_count=data[offset++];
			}
			//
			doubleV=new Vector.<Number>(double_count);
			data.position=offset;
			for(i=1;i<double_count;i++){
				doubleV[i]=data.readDouble();
			}
			offset=data.position;
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var string_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					string_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				string_count=data[offset++];
			}
			//
			stringV=new Vector.<String>(string_count);
			for(i=1;i<string_count;i++){
				//#offsetpp
			
				if(data[offset]>>>7){
					if(data[offset+1]>>>7){
						if(data[offset+2]>>>7){
							if(data[offset+3]>>>7){
								var get_str_size:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
							}else{
								get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
							}
						}else{
							get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
						}
					}else{
						get_str_size=(data[offset++]&0x7f)|(data[offset++]<<7);
					}
				}else{
					get_str_size=data[offset++];
				}
				
				//处理 "\x00"
				var get_str_end_offset:int=offset+get_str_size;
				var get_str_str:String="";
				do{
					if(data[offset]){
						data.position=offset;
						var get_str_sub_str:String=data.readUTFBytes(get_str_end_offset-offset);
						var get_str_data:ByteArray=new ByteArray();
						get_str_data.writeUTFBytes(get_str_sub_str);
						get_str_str+=get_str_sub_str;
						offset+=get_str_data.length;
					}else{
						get_str_str+="\x00";
						offset++;
					}
				}while(offset<get_str_end_offset);
				if(offset==get_str_end_offset){
				}else{
					offset=get_str_end_offset;
					throw new Error("get_str_data.length="+get_str_data.length+",get_str_size="+get_str_size+",get_str_str=\""+get_str_str+"\"");
					//trace("get_str_data.length="+get_str_data.length+",get_str_size="+get_str_size+",get_str_str=\""+get_str_str+"\"");
				}
				stringV[i]=get_str_str;
				//
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var namespace_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							namespace_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						namespace_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					namespace_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				namespace_info_count=data[offset++];
			}
			//
			namespace_infoV=new Vector.<Namespace_info>(namespace_info_count);
			for(i=1;i<namespace_info_count;i++){
				//#offsetpp
			
				namespace_infoV[i]=new Namespace_info();
				offset=namespace_infoV[i].initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var ns_set_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							ns_set_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						ns_set_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					ns_set_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				ns_set_info_count=data[offset++];
			}
			//
			ns_set_infoV=new Vector.<Ns_set_info>(ns_set_info_count);
			for(i=1;i<ns_set_info_count;i++){
				//#offsetpp
			
				ns_set_infoV[i]=new Ns_set_info();
				offset=ns_set_infoV[i].initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var multiname_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							multiname_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						multiname_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					multiname_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				multiname_info_count=data[offset++];
			}
			//
			multiname_infoV=new Vector.<Multiname_info>(multiname_info_count);
			for(i=1;i<multiname_info_count;i++){
				var kind:int=data[offset++];
				//#offsetpp
			
				multiname_infoV[i]=new MultinameKind.classV[kind]();
				offset=multiname_infoV[i].initByData(data,offset,endOffset);
				multiname_infoV[i].kind=kind;
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data.endian=Endian.LITTLE_ENDIAN;
			var integer_count:int=integerV.length;
			//#offsetpp
			var offset:int=0;
			if(integer_count>>>7){
				if(integer_count>>>14){
					if(integer_count>>>21){
						if(integer_count>>>28){
							data[offset++]=(integer_count&0x7f)|0x80;
							data[offset++]=((integer_count>>>7)&0x7f)|0x80;
							data[offset++]=((integer_count>>>14)&0x7f)|0x80;
							data[offset++]=((integer_count>>>21)&0x7f)|0x80;
							data[offset++]=integer_count>>>28;
						}else{
							data[offset++]=(integer_count&0x7f)|0x80;
							data[offset++]=((integer_count>>>7)&0x7f)|0x80;
							data[offset++]=((integer_count>>>14)&0x7f)|0x80;
							data[offset++]=integer_count>>>21;
						}
					}else{
						data[offset++]=(integer_count&0x7f)|0x80;
						data[offset++]=((integer_count>>>7)&0x7f)|0x80;
						data[offset++]=integer_count>>>14;
					}
				}else{
					data[offset++]=(integer_count&0x7f)|0x80;
					data[offset++]=integer_count>>>7;
				}
			}else{
				data[offset++]=integer_count;
			}
			//
			//#offsetpp
			
			var i:int=0;
			for each(var integer:int in integerV){
				if(i<1){
					i++;
					continue;
				}
				//#offsetpp
			
				if(integer>>>7){
					if(integer>>>14){
						if(integer>>>21){
							if(integer>>>28){
								data[offset++]=(integer&0x7f)|0x80;
								data[offset++]=((integer>>>7)&0x7f)|0x80;
								data[offset++]=((integer>>>14)&0x7f)|0x80;
								data[offset++]=((integer>>>21)&0x7f)|0x80;
								data[offset++]=integer>>>28;
							}else{
								data[offset++]=(integer&0x7f)|0x80;
								data[offset++]=((integer>>>7)&0x7f)|0x80;
								data[offset++]=((integer>>>14)&0x7f)|0x80;
								data[offset++]=integer>>>21;
							}
						}else{
							data[offset++]=(integer&0x7f)|0x80;
							data[offset++]=((integer>>>7)&0x7f)|0x80;
							data[offset++]=integer>>>14;
						}
					}else{
						data[offset++]=(integer&0x7f)|0x80;
						data[offset++]=integer>>>7;
					}
				}else{
					data[offset++]=integer;
				}
				//
			}
			var uinteger_count:int=uintegerV.length;
			//#offsetpp
			
			if(uinteger_count>>>7){
				if(uinteger_count>>>14){
					if(uinteger_count>>>21){
						if(uinteger_count>>>28){
							data[offset++]=(uinteger_count&0x7f)|0x80;
							data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;
							data[offset++]=((uinteger_count>>>14)&0x7f)|0x80;
							data[offset++]=((uinteger_count>>>21)&0x7f)|0x80;
							data[offset++]=uinteger_count>>>28;
						}else{
							data[offset++]=(uinteger_count&0x7f)|0x80;
							data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;
							data[offset++]=((uinteger_count>>>14)&0x7f)|0x80;
							data[offset++]=uinteger_count>>>21;
						}
					}else{
						data[offset++]=(uinteger_count&0x7f)|0x80;
						data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;
						data[offset++]=uinteger_count>>>14;
					}
				}else{
					data[offset++]=(uinteger_count&0x7f)|0x80;
					data[offset++]=uinteger_count>>>7;
				}
			}else{
				data[offset++]=uinteger_count;
			}
			//
			//#offsetpp
			
			i=0;
			for each(var uinteger:int in uintegerV){
				if(i<1){
					i++;
					continue;
				}
				//#offsetpp
			
				if(uinteger>>>7){
					if(uinteger>>>14){
						if(uinteger>>>21){
							if(uinteger>>>28){
								data[offset++]=(uinteger&0x7f)|0x80;
								data[offset++]=((uinteger>>>7)&0x7f)|0x80;
								data[offset++]=((uinteger>>>14)&0x7f)|0x80;
								data[offset++]=((uinteger>>>21)&0x7f)|0x80;
								data[offset++]=uinteger>>>28;
							}else{
								data[offset++]=(uinteger&0x7f)|0x80;
								data[offset++]=((uinteger>>>7)&0x7f)|0x80;
								data[offset++]=((uinteger>>>14)&0x7f)|0x80;
								data[offset++]=uinteger>>>21;
							}
						}else{
							data[offset++]=(uinteger&0x7f)|0x80;
							data[offset++]=((uinteger>>>7)&0x7f)|0x80;
							data[offset++]=uinteger>>>14;
						}
					}else{
						data[offset++]=(uinteger&0x7f)|0x80;
						data[offset++]=uinteger>>>7;
					}
				}else{
					data[offset++]=uinteger;
				}
				//
			}
			var double_count:int=doubleV.length;
			//#offsetpp
			
			if(double_count>>>7){
				if(double_count>>>14){
					if(double_count>>>21){
						if(double_count>>>28){
							data[offset++]=(double_count&0x7f)|0x80;
							data[offset++]=((double_count>>>7)&0x7f)|0x80;
							data[offset++]=((double_count>>>14)&0x7f)|0x80;
							data[offset++]=((double_count>>>21)&0x7f)|0x80;
							data[offset++]=double_count>>>28;
						}else{
							data[offset++]=(double_count&0x7f)|0x80;
							data[offset++]=((double_count>>>7)&0x7f)|0x80;
							data[offset++]=((double_count>>>14)&0x7f)|0x80;
							data[offset++]=double_count>>>21;
						}
					}else{
						data[offset++]=(double_count&0x7f)|0x80;
						data[offset++]=((double_count>>>7)&0x7f)|0x80;
						data[offset++]=double_count>>>14;
					}
				}else{
					data[offset++]=(double_count&0x7f)|0x80;
					data[offset++]=double_count>>>7;
				}
			}else{
				data[offset++]=double_count;
			}
			//
			//#offsetpp
			
			i=0;
			data.position=offset;
			for each(var double:Number in doubleV){
				if(i<1){
					i++;
					continue;
				}
				data.writeDouble(double);
			}
			offset=data.length;
			var string_count:int=stringV.length;
			//#offsetpp
			
			if(string_count>>>7){
				if(string_count>>>14){
					if(string_count>>>21){
						if(string_count>>>28){
							data[offset++]=(string_count&0x7f)|0x80;
							data[offset++]=((string_count>>>7)&0x7f)|0x80;
							data[offset++]=((string_count>>>14)&0x7f)|0x80;
							data[offset++]=((string_count>>>21)&0x7f)|0x80;
							data[offset++]=string_count>>>28;
						}else{
							data[offset++]=(string_count&0x7f)|0x80;
							data[offset++]=((string_count>>>7)&0x7f)|0x80;
							data[offset++]=((string_count>>>14)&0x7f)|0x80;
							data[offset++]=string_count>>>21;
						}
					}else{
						data[offset++]=(string_count&0x7f)|0x80;
						data[offset++]=((string_count>>>7)&0x7f)|0x80;
						data[offset++]=string_count>>>14;
					}
				}else{
					data[offset++]=(string_count&0x7f)|0x80;
					data[offset++]=string_count>>>7;
				}
			}else{
				data[offset++]=string_count;
			}
			//
			//#offsetpp
			
			i=0;
			for each(var string:String in stringV){
				if(i<1){
					i++;
					continue;
				}
				var set_str_data:ByteArray=new ByteArray();
				set_str_data.writeUTFBytes(string);
				var set_str_size:int=set_str_data.length;
				if(set_str_size>>>7){
					if(set_str_size>>>14){
						if(set_str_size>>>21){
							if(set_str_size>>>28){
								data[offset++]=(set_str_size&0x7f)|0x80;
								data[offset++]=((set_str_size>>>7)&0x7f)|0x80;
								data[offset++]=((set_str_size>>>14)&0x7f)|0x80;
								data[offset++]=((set_str_size>>>21)&0x7f)|0x80;
								data[offset++]=set_str_size>>>28;
							}else{
								data[offset++]=(set_str_size&0x7f)|0x80;
								data[offset++]=((set_str_size>>>7)&0x7f)|0x80;
								data[offset++]=((set_str_size>>>14)&0x7f)|0x80;
								data[offset++]=set_str_size>>>21;
							}
						}else{
							data[offset++]=(set_str_size&0x7f)|0x80;
							data[offset++]=((set_str_size>>>7)&0x7f)|0x80;
							data[offset++]=set_str_size>>>14;
						}
					}else{
						data[offset++]=(set_str_size&0x7f)|0x80;
						data[offset++]=set_str_size>>>7;
					}
				}else{
					data[offset++]=set_str_size;
				}
				data.position=offset;
				data.writeBytes(set_str_data);
				offset=data.length;
				//
			}
			var namespace_info_count:int=namespace_infoV.length;
			//#offsetpp
			
			if(namespace_info_count>>>7){
				if(namespace_info_count>>>14){
					if(namespace_info_count>>>21){
						if(namespace_info_count>>>28){
							data[offset++]=(namespace_info_count&0x7f)|0x80;
							data[offset++]=((namespace_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((namespace_info_count>>>14)&0x7f)|0x80;
							data[offset++]=((namespace_info_count>>>21)&0x7f)|0x80;
							data[offset++]=namespace_info_count>>>28;
						}else{
							data[offset++]=(namespace_info_count&0x7f)|0x80;
							data[offset++]=((namespace_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((namespace_info_count>>>14)&0x7f)|0x80;
							data[offset++]=namespace_info_count>>>21;
						}
					}else{
						data[offset++]=(namespace_info_count&0x7f)|0x80;
						data[offset++]=((namespace_info_count>>>7)&0x7f)|0x80;
						data[offset++]=namespace_info_count>>>14;
					}
				}else{
					data[offset++]=(namespace_info_count&0x7f)|0x80;
					data[offset++]=namespace_info_count>>>7;
				}
			}else{
				data[offset++]=namespace_info_count;
			}
			//
			//#offsetpp
			
			i=0;
			data.position=offset;
			for each(var namespace_info:Namespace_info in namespace_infoV){
				if(i<1){
					i++;
					continue;
				}
				data.writeBytes(namespace_info.toData());
			}
			offset=data.length;
			var ns_set_info_count:int=ns_set_infoV.length;
			//#offsetpp
			
			if(ns_set_info_count>>>7){
				if(ns_set_info_count>>>14){
					if(ns_set_info_count>>>21){
						if(ns_set_info_count>>>28){
							data[offset++]=(ns_set_info_count&0x7f)|0x80;
							data[offset++]=((ns_set_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((ns_set_info_count>>>14)&0x7f)|0x80;
							data[offset++]=((ns_set_info_count>>>21)&0x7f)|0x80;
							data[offset++]=ns_set_info_count>>>28;
						}else{
							data[offset++]=(ns_set_info_count&0x7f)|0x80;
							data[offset++]=((ns_set_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((ns_set_info_count>>>14)&0x7f)|0x80;
							data[offset++]=ns_set_info_count>>>21;
						}
					}else{
						data[offset++]=(ns_set_info_count&0x7f)|0x80;
						data[offset++]=((ns_set_info_count>>>7)&0x7f)|0x80;
						data[offset++]=ns_set_info_count>>>14;
					}
				}else{
					data[offset++]=(ns_set_info_count&0x7f)|0x80;
					data[offset++]=ns_set_info_count>>>7;
				}
			}else{
				data[offset++]=ns_set_info_count;
			}
			//
			//#offsetpp
			
			i=0;
			data.position=offset;
			for each(var ns_set_info:Ns_set_info in ns_set_infoV){
				if(i<1){
					i++;
					continue;
				}
				data.writeBytes(ns_set_info.toData());
			}
			offset=data.length;
			var multiname_info_count:int=multiname_infoV.length;
			//#offsetpp
			
			if(multiname_info_count>>>7){
				if(multiname_info_count>>>14){
					if(multiname_info_count>>>21){
						if(multiname_info_count>>>28){
							data[offset++]=(multiname_info_count&0x7f)|0x80;
							data[offset++]=((multiname_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((multiname_info_count>>>14)&0x7f)|0x80;
							data[offset++]=((multiname_info_count>>>21)&0x7f)|0x80;
							data[offset++]=multiname_info_count>>>28;
						}else{
							data[offset++]=(multiname_info_count&0x7f)|0x80;
							data[offset++]=((multiname_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((multiname_info_count>>>14)&0x7f)|0x80;
							data[offset++]=multiname_info_count>>>21;
						}
					}else{
						data[offset++]=(multiname_info_count&0x7f)|0x80;
						data[offset++]=((multiname_info_count>>>7)&0x7f)|0x80;
						data[offset++]=multiname_info_count>>>14;
					}
				}else{
					data[offset++]=(multiname_info_count&0x7f)|0x80;
					data[offset++]=multiname_info_count>>>7;
				}
			}else{
				data[offset++]=multiname_info_count;
			}
			//
			//#offsetpp
			
			i=0;
			for each(var multiname_info:Multiname_info in multiname_infoV){
				if(i<1){
					i++;
					continue;
				}
				data[offset++]=multiname_info.kind;
				data.position=offset;
				data.writeBytes(multiname_info.toData());
				offset=data.length;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Constant_pool>
				<list vNames="integerV" count={integerV.length}/>
				<list vNames="uintegerV" count={uintegerV.length}/>
				<list vNames="doubleV" count={doubleV.length}/>
				<list vNames="stringV" count={stringV.length}/>
				<list vNames="namespace_infoV" count={namespace_infoV.length}/>
				<list vNames="ns_set_infoV" count={ns_set_infoV.length}/>
				<list vNames="multiname_infoV" count={multiname_infoV.length}/>
			</Constant_pool>;
			var listXML:XML=xml.list[0];
			var i:int=0;
			for each(var integer:int in integerV){
				if(i<1){
					i++;
					continue;
				}
				listXML.appendChild(<integer value={integer}/>);
			}
			listXML=xml.list[1];
			i=0;
			for each(var uinteger:int in uintegerV){
				if(i<1){
					i++;
					continue;
				}
				listXML.appendChild(<uinteger value={uinteger}/>);
			}
			listXML=xml.list[2];
			i=0;
			for each(var double:Number in doubleV){
				if(i<1){
					i++;
					continue;
				}
				listXML.appendChild(<double value={double}/>);
			}
			listXML=xml.list[3];
			i=0;
			for each(var string:String in stringV){
				if(i<1){
					i++;
					continue;
				}
				listXML.appendChild(<string value={string/*要求10.1.52.14或以上的播放器 或 2.0.2.12610 以上的 air 才能正确的处理 "\x00"*/}/>);
			}
			listXML=xml.list[4];
			i=0;
			for each(var namespace_info:Namespace_info in namespace_infoV){
				if(i<1){
					i++;
					continue;
				}
				var itemXML:XML=<namespace_info/>;
				itemXML.appendChild(namespace_info.toXML());
				listXML.appendChild(itemXML);
			}
			listXML=xml.list[5];
			i=0;
			for each(var ns_set_info:Ns_set_info in ns_set_infoV){
				if(i<1){
					i++;
					continue;
				}
				itemXML=<ns_set_info/>;
				itemXML.appendChild(ns_set_info.toXML());
				listXML.appendChild(itemXML);
			}
			listXML=xml.list[6];
			i=0;
			for each(var multiname_info:Multiname_info in multiname_infoV){
				if(i<1){
					i++;
					continue;
				}
				itemXML=<multiname_info kind={MultinameKind.kindV[multiname_info.kind]}/>;
				itemXML.appendChild(multiname_info.toXML());
				listXML.appendChild(itemXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var listXML:XML=xml.list[0];
			var integerXMLList:XMLList=listXML.integer;
			
			if(integerXMLList.length()){
			var i:int=0;
			integerV=new Vector.<int>(integerXMLList.length()+1);
			for each(var integerXML:XML in integerXMLList){
				i++;
				integerV[i]=int(integerXML.@value.toString());
			}
			}else{
				integerV=new Vector.<int>();
			}
			
			listXML=xml.list[1];
			var uintegerXMLList:XMLList=listXML.uinteger;
			
			if(uintegerXMLList.length()){
			i=0;
			uintegerV=new Vector.<int>(uintegerXMLList.length()+1);
			for each(var uintegerXML:XML in uintegerXMLList){
				i++;
				uintegerV[i]=int(uintegerXML.@value.toString());
			}
			}else{
				uintegerV=new Vector.<int>();
			}
			
			listXML=xml.list[2];
			var doubleXMLList:XMLList=listXML.double;
			
			if(doubleXMLList.length()){
			i=0;
			doubleV=new Vector.<Number>(doubleXMLList.length()+1);
			for each(var doubleXML:XML in doubleXMLList){
				i++;
				doubleV[i]=Number(doubleXML.@value.toString());
			}
			}else{
				doubleV=new Vector.<Number>();
			}
			
			listXML=xml.list[3];
			var stringXMLList:XMLList=listXML.string;
			
			if(stringXMLList.length()){
			i=0;
			stringV=new Vector.<String>(stringXMLList.length()+1);
			for each(var stringXML:XML in stringXMLList){
				i++;
				stringV[i]=stringXML.@value.toString();
			}
			}else{
				stringV=new Vector.<String>();
			}
			
			listXML=xml.list[4];
			var namespace_infoXMLList:XMLList=listXML.namespace_info;
			
			if(namespace_infoXMLList.length()){
			i=0;
			namespace_infoV=new Vector.<Namespace_info>(namespace_infoXMLList.length()+1);
			for each(var namespace_infoXML:XML in namespace_infoXMLList){
				i++;
				namespace_infoV[i]=new Namespace_info();
				namespace_infoV[i].initByXML(namespace_infoXML.children()[0]);
			}
			}else{
				namespace_infoV=new Vector.<Namespace_info>();
			}
			
			listXML=xml.list[5];
			var ns_set_infoXMLList:XMLList=listXML.ns_set_info;
			
			if(ns_set_infoXMLList.length()){
			i=0;
			ns_set_infoV=new Vector.<Ns_set_info>(ns_set_infoXMLList.length()+1);
			for each(var ns_set_infoXML:XML in ns_set_infoXMLList){
				i++;
				ns_set_infoV[i]=new Ns_set_info();
				ns_set_infoV[i].initByXML(ns_set_infoXML.children()[0]);
			}
			}else{
				ns_set_infoV=new Vector.<Ns_set_info>();
			}
			
			listXML=xml.list[6];
			var multiname_infoXMLList:XMLList=listXML.multiname_info;
			
			if(multiname_infoXMLList.length()){
			i=0;
			multiname_infoV=new Vector.<Multiname_info>(multiname_infoXMLList.length()+1);
			for each(var multiname_infoXML:XML in multiname_infoXMLList){
				i++;
				var kind:int=MultinameKind[multiname_infoXML.@kind.toString()];
				multiname_infoV[i]=new MultinameKind.classV[kind]();
				multiname_infoV[i].initByXML(multiname_infoXML.children()[0]);
				multiname_infoV[i].kind=kind;
			}
			}else{
				multiname_infoV=new Vector.<Multiname_info>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
