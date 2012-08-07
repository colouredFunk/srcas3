/***
ABCFileWithSimpleConstant_pool
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
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

//abcFile
//{
//	u16 				minor_version

//	u16 				major_version
//	cpool_info 			constant_pool
//	u30 				method_count
//	method_info 		method[method_count]
//	u30 				metadata_count
//	metadata_info 		metadata[metadata_count]
//	u30 				class_count
//	instance_info 		instance[class_count]
//	class_info 			class[class_count]
//	u30 				script_count
//	script_info 		script[script_count]
//	u30 				method_body_count
//	method_body_info	method_body[method_body_count]
//}

//The values of major_version and minor_version are the major and minor version numbers of the
//abcFile format. A change in the minor version number signifies a change in the file format that is
//backward compatible, in the sense that an implementation of the AVM2 can still make use of a file of an
//older version. A change in the major version number denotes an incompatible adjustment to the file
//format.
//As of the publication of this overview, the major version is 46 and the minor version is 16.
//minor_version一般就是16
//major_version一般就是46

//The constant_pool is a variable length structure composed of integers, doubles, strings, namespaces,
//namespace sets, and multinames. These constants are referenced from other parts of the abcFile
//structure.
//常量池

//The value of method_count is the number of entries in the method array. Each entry in the method array
//is a variable length method_info structure. The array holds information about every method defined in
//this abcFile. The code for method bodies is held separately in the method_body array (see below).
//Some entries in method may have no body—this is the case for native methods, for example.

//The value of metadata_count is the number of entries in the metadata array. Each metadata entry is a
//metadata_info structure that maps a name to a set of string values.

//The value of class_count is the number of entries in the instance and class arrays.

//Each instance entry is a variable length instance_info structure which specifies the characteristics of
//object instances created by a particular class.

//Each class entry defines the characteristics of a class. It is used in conjunction with the instance field to
//derive a full description of an AS Class.

//The value of script_count is the number of entries in the script array.

//Each script entry is a script_info structure that defines the characteristics of a single script in this file. As explained in the
//previous chapter, the last entry in this array is the entry point for execution in the abcFile.

//The value of method_body_count is the number of entries in the method_body array. Each method_body

//entry consists of a variable length method_body_info structure which contains the instructions for an
//individual method or function.
package zero.getfonts.swf.avm2{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import zero.output;
	import zero.getfonts.swf.BytesData;
	public class ABCFileWithSimpleConstant_pool{//implements I_zero_swf_CheckCodesRight{
		public var minor_version:int;					//UI16
		public var major_version:int;					//UI16
		public var integerV:Vector.<int>;
		public var uintegerV:Vector.<int>;
		public var doubleV:Vector.<Number>;
		public var stringV:Vector.<String>;
		
		/**
		 * 目前仅在 InitByBytes 里使用
		 */		
		public var stringPosV:Vector.<int>;//20110806
		
		public var restData:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			data.endian=Endian.LITTLE_ENDIAN;
			minor_version=data[offset++]|(data[offset++]<<8);
			major_version=data[offset++]|(data[offset++]<<8);
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var integer_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integer_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integer_count=data[offset++];}
			//integer_count
			integerV=new Vector.<int>(1);
			for(var i:int=1;i<integer_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integerV[i]=data[offset++];}
				//integerV[i]
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var uinteger_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uinteger_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uinteger_count=data[offset++];}
			//uinteger_count
			uintegerV=new Vector.<int>(1);
			for(i=1;i<uinteger_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uintegerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uintegerV[i]=data[offset++];}
				//uintegerV[i]
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var double_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{double_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{double_count=data[offset++];}
			//double_count
			doubleV=new Vector.<Number>(1);
			data.position=offset;
			for(i=1;i<double_count;i++){
				doubleV[i]=data.readDouble();
			}
			offset=data.position;
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var string_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{string_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{string_count=data[offset++];}
			//string_count
			stringV=new Vector.<String>(1);
			if(_initByDataOptions&&_initByDataOptions.ABCFileGetStringPoss){
				stringPosV=new Vector.<int>(1);
			}
			for(i=1;i<string_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var get_str_size:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{get_str_size=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{get_str_size=data[offset++];}
				//get_str_size
				
				if(stringPosV){
					stringPosV[i]=offset;
				}
				if(get_str_size){
					data.position=offset;
					var get_str_str:String=data.readUTFBytes(get_str_size);
					if(get_str_str.length==get_str_size){
						//ok=true
					}else{
						var get_str_bytePos:int;
						var ok:Boolean=false;
						var get_str_data:ByteArray=new ByteArray();
						get_str_data.writeUTFBytes(get_str_str);
						if(get_str_data.length==get_str_size){
							get_str_bytePos=get_str_size;
							while(--get_str_bytePos>=0){
								if(get_str_data[get_str_bytePos]==data[offset+get_str_bytePos]){
								}else{
									break;
								}
							}
							if(get_str_bytePos==-1){
								ok=true;
							}
						}
						if(ok){
						}else{
							get_str_str="";
							var get_str_end_offset:int=offset+get_str_size;
							get_str_bytePos=offset;
							while(get_str_bytePos<get_str_end_offset){
								var get_str_byte:int=data[get_str_bytePos];
								if(get_str_byte&0x80){
									if((get_str_byte&0xf8)==0xf0){//0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
										if(
											get_str_bytePos+4<=get_str_end_offset
											&&
											(data[get_str_bytePos+1]&0xc0)==0x80
											&&
											(data[get_str_bytePos+2]&0xc0)==0x80
											&&
											(data[get_str_bytePos+3]&0xc0)==0x80
										){
											data.position=get_str_bytePos;
											get_str_str+=data.readUTFBytes(4);
											get_str_bytePos+=4;
											continue;
										}
									}else if((get_str_byte&0xf0)==0xe0){//0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
										if(
											get_str_bytePos+4<=get_str_end_offset
											&&
											(data[get_str_bytePos+1]&0xc0)==0x80
											&&
											(data[get_str_bytePos+2]&0xc0)==0x80
										){
											data.position=get_str_bytePos;
											get_str_str+=data.readUTFBytes(3);
											get_str_bytePos+=3;
											continue;
										}
									}else if((get_str_byte&0xe0)==0xc0){//0000 0080-0000 07FF | 110xxxxx 10xxxxxx
										if(
											get_str_bytePos+4<=get_str_end_offset
											&&
											(data[get_str_bytePos+1]&0xc0)==0x80
										){
											data.position=get_str_bytePos;
											get_str_str+=data.readUTFBytes(2);
											get_str_bytePos+=2;
											continue;
										}
									}
								}
								//0000 0000-0000 007F | 0xxxxxxx
								//0x00~0x7f
								get_str_str+=String.fromCharCode(get_str_byte);
								get_str_bytePos++;
							}
						}
					}
					
					//61 61 C2 A6 C2 A6 61 61 18 C3 82 C2 A6 C3 82 C2 ; aa娄娄aa.脗娄脗?
					//61 61 C2 A6 C2 A6 61 61 18 C3 82 C2 A6 C3 82 C2 ; aa娄娄aa.脗娄脗?
					
					//A6 E6 88 91 E4 BA 86 C3 82 E4 B8 AA E5 8E BB C2 ; ︽垜浜喢備釜鍘宦
					//A6 E6 88 91 E4 BA 86 C3 82 E4 B8 AA E5 8E BB C2 ; ︽垜浜喢備釜鍘宦
					
					//A6 03 7C C3 BF 03 7C C3 B0 03 7C C3 80 03 7C C2 ; ?|每.|冒.|脌.|?
					//A6 02 7C FF    02 7C F0    03 7C C3 80 03 7C C2 ; ?|每.|冒.|脌.|?
					
					//80 02 5B 00 02 2D 2D
					//80 02 5B 00 02 2D 2D
					
					stringV[i]=get_str_str;
					offset+=get_str_size;
				}else{
					stringV[i]="";
				}
			}
			
			restData=new BytesData();
			return restData.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data.endian=Endian.LITTLE_ENDIAN;
			data[0]=minor_version;
			data[1]=minor_version>>8;
			data[2]=major_version;
			data[3]=major_version>>8;
			var integer_count:int=integerV.length;
			var offset:int=4;
			if(integer_count>>>7){if(integer_count>>>14){if(integer_count>>>21){if(integer_count>>>28){data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=((integer_count>>>14)&0x7f)|0x80;data[offset++]=((integer_count>>>21)&0x7f)|0x80;data[offset++]=integer_count>>>28;}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=((integer_count>>>14)&0x7f)|0x80;data[offset++]=integer_count>>>21;}}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=integer_count>>>14;}}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=integer_count>>>7;}}else{data[offset++]=integer_count;}
			//integer_count
			
			var i:int=0;
			for each(var integer:int in integerV){
				if(i<1){
					i++;
					continue;
				}
			
				if(integer>>>7){if(integer>>>14){if(integer>>>21){if(integer>>>28){data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=((integer>>>21)&0x7f)|0x80;data[offset++]=integer>>>28;}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=integer>>>21;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=integer>>>14;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=integer>>>7;}}else{data[offset++]=integer;}
				//integer
			}
			var uinteger_count:int=uintegerV.length;
			
			if(uinteger_count>>>7){if(uinteger_count>>>14){if(uinteger_count>>>21){if(uinteger_count>>>28){data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;data[offset++]=((uinteger_count>>>14)&0x7f)|0x80;data[offset++]=((uinteger_count>>>21)&0x7f)|0x80;data[offset++]=uinteger_count>>>28;}else{data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;data[offset++]=((uinteger_count>>>14)&0x7f)|0x80;data[offset++]=uinteger_count>>>21;}}else{data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;data[offset++]=uinteger_count>>>14;}}else{data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=uinteger_count>>>7;}}else{data[offset++]=uinteger_count;}
			//uinteger_count
			
			i=0;
			for each(var uinteger:int in uintegerV){
				if(i<1){
					i++;
					continue;
				}
			
				if(uinteger>>>7){if(uinteger>>>14){if(uinteger>>>21){if(uinteger>>>28){data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=((uinteger>>>21)&0x7f)|0x80;data[offset++]=uinteger>>>28;}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=uinteger>>>21;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=uinteger>>>14;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=uinteger>>>7;}}else{data[offset++]=uinteger;}
				//uinteger
			}
			var double_count:int=doubleV.length;
			
			if(double_count>>>7){if(double_count>>>14){if(double_count>>>21){if(double_count>>>28){data[offset++]=(double_count&0x7f)|0x80;data[offset++]=((double_count>>>7)&0x7f)|0x80;data[offset++]=((double_count>>>14)&0x7f)|0x80;data[offset++]=((double_count>>>21)&0x7f)|0x80;data[offset++]=double_count>>>28;}else{data[offset++]=(double_count&0x7f)|0x80;data[offset++]=((double_count>>>7)&0x7f)|0x80;data[offset++]=((double_count>>>14)&0x7f)|0x80;data[offset++]=double_count>>>21;}}else{data[offset++]=(double_count&0x7f)|0x80;data[offset++]=((double_count>>>7)&0x7f)|0x80;data[offset++]=double_count>>>14;}}else{data[offset++]=(double_count&0x7f)|0x80;data[offset++]=double_count>>>7;}}else{data[offset++]=double_count;}
			//double_count
			
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
			
			if(string_count>>>7){if(string_count>>>14){if(string_count>>>21){if(string_count>>>28){data[offset++]=(string_count&0x7f)|0x80;data[offset++]=((string_count>>>7)&0x7f)|0x80;data[offset++]=((string_count>>>14)&0x7f)|0x80;data[offset++]=((string_count>>>21)&0x7f)|0x80;data[offset++]=string_count>>>28;}else{data[offset++]=(string_count&0x7f)|0x80;data[offset++]=((string_count>>>7)&0x7f)|0x80;data[offset++]=((string_count>>>14)&0x7f)|0x80;data[offset++]=string_count>>>21;}}else{data[offset++]=(string_count&0x7f)|0x80;data[offset++]=((string_count>>>7)&0x7f)|0x80;data[offset++]=string_count>>>14;}}else{data[offset++]=(string_count&0x7f)|0x80;data[offset++]=string_count>>>7;}}else{data[offset++]=string_count;}
			//string_count
			
			i=0;
			for each(var string:String in stringV){
				if(i<1){
					i++;
					continue;
				}
				
				if(string){
					var set_str_data:ByteArray=new ByteArray();
					
					//set_str_data.writeUTFBytes(string);
					
					//20110912
					//if(string){
					//	for each(var c:String in string.split("")){
					//		if(c.charCodeAt(0)>0xff){
					//			set_str_data.writeUTFBytes(c);
					//		}else{
					//			set_str_data.writeByte(c.charCodeAt(0));//这么写，个别字符能使 asv 显示不出来
					//		}
					//	}
					//}
					
					//20120413
					if(string.search(/[\xf0-\xff]/)>-1){
						for each(var c:String in string.split("")){
							if(/[\xf0-\xff]/.test(c)){
								set_str_data.writeByte(c.charCodeAt(0));//这么写，个别字符能使 asv 显示不出来
							}else{
								set_str_data.writeUTFBytes(c);
							}
						}
					}else{
						set_str_data.writeUTFBytes(string);
					}
					
					var set_str_size:int=set_str_data.length;
					if(set_str_size>>>7){if(set_str_size>>>14){if(set_str_size>>>21){if(set_str_size>>>28){data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=((set_str_size>>>21)&0x7f)|0x80;data[offset++]=set_str_size>>>28;}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=set_str_size>>>21;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=set_str_size>>>14;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=set_str_size>>>7;}}else{data[offset++]=set_str_size;}
					//set_str_size
					data.position=offset;
					data.writeBytes(set_str_data);
					offset=data.length;
				}else{
					data[offset++]=0x00;
				}
			}
			
			data.position=offset;
			data.writeBytes(restData.toData(_toDataOptions));
			return data;
		}
	}
}
