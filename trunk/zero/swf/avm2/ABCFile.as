﻿/***
ABCFile 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月18日 15:38:50 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.avm2{
	import zero.swf.avm2.Namespace_info;
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.avm2.Multiname_info;
	import zero.swf.avm2.Method_info;
	import zero.swf.avm2.Metadata_info;
	import zero.swf.avm2.Instance_info;
	import zero.swf.avm2.Class_info;
	import zero.swf.avm2.Script_info;
	import zero.swf.avm2.Method_body_info;
	import flash.utils.Endian;
	import flash.utils.ByteArray;
	public class ABCFile extends AVM2Obj{
		public var minor_version:int;					//UI16
		public var major_version:int;					//UI16
		public var integerV:Vector.<int>;
		public var uintegerV:Vector.<int>;
		public var doubleV:Vector.<Number>;
		public var stringV:Vector.<String>;
		public var namespace_infoV:Vector.<Namespace_info>;
		public var ns_set_infoV:Vector.<Ns_set_info>;
		public var multiname_infoV:Vector.<Multiname_info>;
		public var method_infoV:Vector.<Method_info>;
		public var metadata_infoV:Vector.<Metadata_info>;
		public var instance_infoV:Vector.<Instance_info>;
		public var class_infoV:Vector.<Class_info>;
		public var script_infoV:Vector.<Script_info>;
		public var method_body_infoV:Vector.<Method_body_info>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			data.endian=Endian.LITTLE_ENDIAN;
			minor_version=data[offset]|(data[offset+1]<<8);
			major_version=data[offset+2]|(data[offset+3]<<8);
			offset+=4;
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var integer_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integer_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integer_count=data[offset++];}
			//integer_count
			integerV=new Vector.<int>(integer_count);
			for(var i:int=1;i<integer_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integerV[i]=data[offset++];}
				//integerV[i]
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var uinteger_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uinteger_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uinteger_count=data[offset++];}
			//uinteger_count
			uintegerV=new Vector.<int>(uinteger_count);
			for(i=1;i<uinteger_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uintegerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uintegerV[i]=data[offset++];}
				//uintegerV[i]
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var double_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{double_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{double_count=data[offset++];}
			//double_count
			doubleV=new Vector.<Number>(double_count);
			data.position=offset;
			for(i=1;i<double_count;i++){
				doubleV[i]=data.readDouble();
			}
			offset=data.position;
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var string_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{string_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{string_count=data[offset++];}
			//string_count
			stringV=new Vector.<String>(string_count);
			for(i=1;i<string_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var get_str_size:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{get_str_size=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{get_str_size=data[offset++];}
				//get_str_size
				
				if(get_str_size){
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
						//throw new Error("get_str_data.length="+get_str_data.length+",get_str_size="+get_str_size+",get_str_str=\""+get_str_str+"\"");
						import zero.Outputer;
						Outputer.output("get_str_data.length="+get_str_data.length+",get_str_size="+get_str_size+",get_str_str=\""+get_str_str+"\"","brown");
					}
					stringV[i]=get_str_str;
				}else{
					stringV[i]="";
				}
				//
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var namespace_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{namespace_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{namespace_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{namespace_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{namespace_info_count=data[offset++];}
			//namespace_info_count
			namespace_infoV=new Vector.<Namespace_info>(namespace_info_count);
			for(i=1;i<namespace_info_count;i++){
			
				namespace_infoV[i]=new Namespace_info();
				offset=namespace_infoV[i].initByData(data,offset,endOffset);
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var ns_set_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ns_set_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ns_set_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ns_set_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ns_set_info_count=data[offset++];}
			//ns_set_info_count
			ns_set_infoV=new Vector.<Ns_set_info>(ns_set_info_count);
			for(i=1;i<ns_set_info_count;i++){
			
				ns_set_infoV[i]=new Ns_set_info();
				offset=ns_set_infoV[i].initByData(data,offset,endOffset);
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var multiname_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{multiname_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{multiname_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{multiname_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{multiname_info_count=data[offset++];}
			//multiname_info_count
			multiname_infoV=new Vector.<Multiname_info>(multiname_info_count);
			for(i=1;i<multiname_info_count;i++){
			
				multiname_infoV[i]=new Multiname_info();
				offset=multiname_infoV[i].initByData(data,offset,endOffset);
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var method_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{method_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{method_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{method_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{method_count=data[offset++];}
			//method_count
			method_infoV=new Vector.<Method_info>(method_count);
			for(i=0;i<method_count;i++){
			
				method_infoV[i]=new Method_info();
				offset=method_infoV[i].initByData(data,offset,endOffset);
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var metadata_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{metadata_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{metadata_count=data[offset++];}
			//metadata_count
			metadata_infoV=new Vector.<Metadata_info>(metadata_count);
			for(i=0;i<metadata_count;i++){
			
				metadata_infoV[i]=new Metadata_info();
				offset=metadata_infoV[i].initByData(data,offset,endOffset);
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var class_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{class_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{class_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{class_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{class_count=data[offset++];}
			//class_count
			instance_infoV=new Vector.<Instance_info>(class_count);
			for(i=0;i<class_count;i++){
			
				instance_infoV[i]=new Instance_info();
				offset=instance_infoV[i].initByData(data,offset,endOffset);
			}
			
			class_infoV=new Vector.<Class_info>(class_count);
			for(i=0;i<class_count;i++){
			
				class_infoV[i]=new Class_info();
				offset=class_infoV[i].initByData(data,offset,endOffset);
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var script_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{script_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{script_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{script_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{script_count=data[offset++];}
			//script_count
			script_infoV=new Vector.<Script_info>(script_count);
			for(i=0;i<script_count;i++){
			
				script_infoV[i]=new Script_info();
				offset=script_infoV[i].initByData(data,offset,endOffset);
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var method_body_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{method_body_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{method_body_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{method_body_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{method_body_count=data[offset++];}
			//method_body_count
			method_body_infoV=new Vector.<Method_body_info>(method_body_count);
			for(i=0;i<method_body_count;i++){
			
				method_body_infoV[i]=new Method_body_info();
				offset=method_body_infoV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
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
				var set_str_data:ByteArray=new ByteArray();
				set_str_data.writeUTFBytes(string);
				var set_str_size:int=set_str_data.length;
				if(set_str_size>>>7){if(set_str_size>>>14){if(set_str_size>>>21){if(set_str_size>>>28){data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=((set_str_size>>>21)&0x7f)|0x80;data[offset++]=set_str_size>>>28;}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=set_str_size>>>21;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=set_str_size>>>14;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=set_str_size>>>7;}}else{data[offset++]=set_str_size;}
				//set_str_size
				data.position=offset;
				data.writeBytes(set_str_data);
				offset=data.length;
				set_str_size
			}
			var namespace_info_count:int=namespace_infoV.length;
			
			if(namespace_info_count>>>7){if(namespace_info_count>>>14){if(namespace_info_count>>>21){if(namespace_info_count>>>28){data[offset++]=(namespace_info_count&0x7f)|0x80;data[offset++]=((namespace_info_count>>>7)&0x7f)|0x80;data[offset++]=((namespace_info_count>>>14)&0x7f)|0x80;data[offset++]=((namespace_info_count>>>21)&0x7f)|0x80;data[offset++]=namespace_info_count>>>28;}else{data[offset++]=(namespace_info_count&0x7f)|0x80;data[offset++]=((namespace_info_count>>>7)&0x7f)|0x80;data[offset++]=((namespace_info_count>>>14)&0x7f)|0x80;data[offset++]=namespace_info_count>>>21;}}else{data[offset++]=(namespace_info_count&0x7f)|0x80;data[offset++]=((namespace_info_count>>>7)&0x7f)|0x80;data[offset++]=namespace_info_count>>>14;}}else{data[offset++]=(namespace_info_count&0x7f)|0x80;data[offset++]=namespace_info_count>>>7;}}else{data[offset++]=namespace_info_count;}
			//namespace_info_count
			
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
			
			if(ns_set_info_count>>>7){if(ns_set_info_count>>>14){if(ns_set_info_count>>>21){if(ns_set_info_count>>>28){data[offset++]=(ns_set_info_count&0x7f)|0x80;data[offset++]=((ns_set_info_count>>>7)&0x7f)|0x80;data[offset++]=((ns_set_info_count>>>14)&0x7f)|0x80;data[offset++]=((ns_set_info_count>>>21)&0x7f)|0x80;data[offset++]=ns_set_info_count>>>28;}else{data[offset++]=(ns_set_info_count&0x7f)|0x80;data[offset++]=((ns_set_info_count>>>7)&0x7f)|0x80;data[offset++]=((ns_set_info_count>>>14)&0x7f)|0x80;data[offset++]=ns_set_info_count>>>21;}}else{data[offset++]=(ns_set_info_count&0x7f)|0x80;data[offset++]=((ns_set_info_count>>>7)&0x7f)|0x80;data[offset++]=ns_set_info_count>>>14;}}else{data[offset++]=(ns_set_info_count&0x7f)|0x80;data[offset++]=ns_set_info_count>>>7;}}else{data[offset++]=ns_set_info_count;}
			//ns_set_info_count
			
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
			
			if(multiname_info_count>>>7){if(multiname_info_count>>>14){if(multiname_info_count>>>21){if(multiname_info_count>>>28){data[offset++]=(multiname_info_count&0x7f)|0x80;data[offset++]=((multiname_info_count>>>7)&0x7f)|0x80;data[offset++]=((multiname_info_count>>>14)&0x7f)|0x80;data[offset++]=((multiname_info_count>>>21)&0x7f)|0x80;data[offset++]=multiname_info_count>>>28;}else{data[offset++]=(multiname_info_count&0x7f)|0x80;data[offset++]=((multiname_info_count>>>7)&0x7f)|0x80;data[offset++]=((multiname_info_count>>>14)&0x7f)|0x80;data[offset++]=multiname_info_count>>>21;}}else{data[offset++]=(multiname_info_count&0x7f)|0x80;data[offset++]=((multiname_info_count>>>7)&0x7f)|0x80;data[offset++]=multiname_info_count>>>14;}}else{data[offset++]=(multiname_info_count&0x7f)|0x80;data[offset++]=multiname_info_count>>>7;}}else{data[offset++]=multiname_info_count;}
			//multiname_info_count
			
			i=0;
			data.position=offset;
			for each(var multiname_info:Multiname_info in multiname_infoV){
				if(i<1){
					i++;
					continue;
				}
				data.writeBytes(multiname_info.toData());
			}
			offset=data.length;
			var method_count:int=method_infoV.length;
			
			if(method_count>>>7){if(method_count>>>14){if(method_count>>>21){if(method_count>>>28){data[offset++]=(method_count&0x7f)|0x80;data[offset++]=((method_count>>>7)&0x7f)|0x80;data[offset++]=((method_count>>>14)&0x7f)|0x80;data[offset++]=((method_count>>>21)&0x7f)|0x80;data[offset++]=method_count>>>28;}else{data[offset++]=(method_count&0x7f)|0x80;data[offset++]=((method_count>>>7)&0x7f)|0x80;data[offset++]=((method_count>>>14)&0x7f)|0x80;data[offset++]=method_count>>>21;}}else{data[offset++]=(method_count&0x7f)|0x80;data[offset++]=((method_count>>>7)&0x7f)|0x80;data[offset++]=method_count>>>14;}}else{data[offset++]=(method_count&0x7f)|0x80;data[offset++]=method_count>>>7;}}else{data[offset++]=method_count;}
			//method_count
			
			data.position=offset;
			for each(var method_info:Method_info in method_infoV){
				data.writeBytes(method_info.toData());
			}
			offset=data.length;
			var metadata_count:int=metadata_infoV.length;
			
			if(metadata_count>>>7){if(metadata_count>>>14){if(metadata_count>>>21){if(metadata_count>>>28){data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=((metadata_count>>>14)&0x7f)|0x80;data[offset++]=((metadata_count>>>21)&0x7f)|0x80;data[offset++]=metadata_count>>>28;}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=((metadata_count>>>14)&0x7f)|0x80;data[offset++]=metadata_count>>>21;}}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=metadata_count>>>14;}}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=metadata_count>>>7;}}else{data[offset++]=metadata_count;}
			//metadata_count
			
			data.position=offset;
			for each(var metadata_info:Metadata_info in metadata_infoV){
				data.writeBytes(metadata_info.toData());
			}
			offset=data.length;
			var class_count:int=instance_infoV.length;
			
			if(class_count>>>7){if(class_count>>>14){if(class_count>>>21){if(class_count>>>28){data[offset++]=(class_count&0x7f)|0x80;data[offset++]=((class_count>>>7)&0x7f)|0x80;data[offset++]=((class_count>>>14)&0x7f)|0x80;data[offset++]=((class_count>>>21)&0x7f)|0x80;data[offset++]=class_count>>>28;}else{data[offset++]=(class_count&0x7f)|0x80;data[offset++]=((class_count>>>7)&0x7f)|0x80;data[offset++]=((class_count>>>14)&0x7f)|0x80;data[offset++]=class_count>>>21;}}else{data[offset++]=(class_count&0x7f)|0x80;data[offset++]=((class_count>>>7)&0x7f)|0x80;data[offset++]=class_count>>>14;}}else{data[offset++]=(class_count&0x7f)|0x80;data[offset++]=class_count>>>7;}}else{data[offset++]=class_count;}
			//class_count
			
			data.position=offset;
			for each(var instance_info:Instance_info in instance_infoV){
				data.writeBytes(instance_info.toData());
			}
			for each(var class_info:Class_info in class_infoV){
				data.writeBytes(class_info.toData());
			}
			offset=data.length;
			var script_count:int=script_infoV.length;
			
			if(script_count>>>7){if(script_count>>>14){if(script_count>>>21){if(script_count>>>28){data[offset++]=(script_count&0x7f)|0x80;data[offset++]=((script_count>>>7)&0x7f)|0x80;data[offset++]=((script_count>>>14)&0x7f)|0x80;data[offset++]=((script_count>>>21)&0x7f)|0x80;data[offset++]=script_count>>>28;}else{data[offset++]=(script_count&0x7f)|0x80;data[offset++]=((script_count>>>7)&0x7f)|0x80;data[offset++]=((script_count>>>14)&0x7f)|0x80;data[offset++]=script_count>>>21;}}else{data[offset++]=(script_count&0x7f)|0x80;data[offset++]=((script_count>>>7)&0x7f)|0x80;data[offset++]=script_count>>>14;}}else{data[offset++]=(script_count&0x7f)|0x80;data[offset++]=script_count>>>7;}}else{data[offset++]=script_count;}
			//script_count
			
			data.position=offset;
			for each(var script_info:Script_info in script_infoV){
				data.writeBytes(script_info.toData());
			}
			offset=data.length;
			var method_body_count:int=method_body_infoV.length;
			
			if(method_body_count>>>7){if(method_body_count>>>14){if(method_body_count>>>21){if(method_body_count>>>28){data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=((method_body_count>>>7)&0x7f)|0x80;data[offset++]=((method_body_count>>>14)&0x7f)|0x80;data[offset++]=((method_body_count>>>21)&0x7f)|0x80;data[offset++]=method_body_count>>>28;}else{data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=((method_body_count>>>7)&0x7f)|0x80;data[offset++]=((method_body_count>>>14)&0x7f)|0x80;data[offset++]=method_body_count>>>21;}}else{data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=((method_body_count>>>7)&0x7f)|0x80;data[offset++]=method_body_count>>>14;}}else{data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=method_body_count>>>7;}}else{data[offset++]=method_body_count;}
			//method_body_count
			
			data.position=offset;
			for each(var method_body_info:Method_body_info in method_body_infoV){
				data.writeBytes(method_body_info.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="ABCFile"
				minor_version={minor_version}
				major_version={major_version}
			/>;
			if(integerV.length){
				var listXML:XML=<integerList count={integerV.length}/>
				var i:int=0;
				for each(var integer:int in integerV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<integer value={integer}/>);
				}
				xml.appendChild(listXML);
			}
			if(uintegerV.length){
				listXML=<uintegerList count={uintegerV.length}/>
				i=0;
				for each(var uinteger:int in uintegerV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<uinteger value={uinteger}/>);
				}
				xml.appendChild(listXML);
			}
			if(doubleV.length){
				listXML=<doubleList count={doubleV.length}/>
				i=0;
				for each(var double:Number in doubleV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<double value={double}/>);
				}
				xml.appendChild(listXML);
			}
			if(stringV.length){
				listXML=<stringList count={stringV.length}/>
				i=0;
				for each(var string:String in stringV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<string value={string/*要求10.1.52.14或以上的播放器 或 2.0.2.12610 以上的 air 才能正确的处理 "\x00"*/}/>);
				}
				xml.appendChild(listXML);
			}
			if(namespace_infoV.length){
				listXML=<namespace_infoList count={namespace_infoV.length}/>
				i=0;
				for each(var namespace_info:Namespace_info in namespace_infoV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(namespace_info.toXML("namespace_info"));
				}
				xml.appendChild(listXML);
			}
			if(ns_set_infoV.length){
				listXML=<ns_set_infoList count={ns_set_infoV.length}/>
				i=0;
				for each(var ns_set_info:Ns_set_info in ns_set_infoV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(ns_set_info.toXML("ns_set_info"));
				}
				xml.appendChild(listXML);
			}
			if(multiname_infoV.length){
				listXML=<multiname_infoList count={multiname_infoV.length}/>
				i=0;
				for each(var multiname_info:Multiname_info in multiname_infoV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(multiname_info.toXML("multiname_info"));
				}
				xml.appendChild(listXML);
			}
			if(method_infoV.length){
				listXML=<method_infoList count={method_infoV.length}/>
				for each(var method_info:Method_info in method_infoV){
					listXML.appendChild(method_info.toXML("method_info"));
				}
				xml.appendChild(listXML);
			}
			if(metadata_infoV.length){
				listXML=<metadata_infoList count={metadata_infoV.length}/>
				for each(var metadata_info:Metadata_info in metadata_infoV){
					listXML.appendChild(metadata_info.toXML("metadata_info"));
				}
				xml.appendChild(listXML);
			}
			if(instance_infoV.length){
				listXML=<instance_infoList count={instance_infoV.length}/>
				for each(var instance_info:Instance_info in instance_infoV){
					listXML.appendChild(instance_info.toXML("instance_info"));
				}
				xml.appendChild(listXML);
			}
			if(class_infoV.length){
				listXML=<class_infoList count={class_infoV.length}/>
				for each(var class_info:Class_info in class_infoV){
					listXML.appendChild(class_info.toXML("class_info"));
				}
				xml.appendChild(listXML);
			}
			if(script_infoV.length){
				listXML=<script_infoList count={script_infoV.length}/>
				for each(var script_info:Script_info in script_infoV){
					listXML.appendChild(script_info.toXML("script_info"));
				}
				xml.appendChild(listXML);
			}
			if(method_body_infoV.length){
				listXML=<method_body_infoList count={method_body_infoV.length}/>
				for each(var method_body_info:Method_body_info in method_body_infoV){
					listXML.appendChild(method_body_info.toXML("method_body_info"));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			minor_version=int(xml.@minor_version.toString());
			major_version=int(xml.@major_version.toString());
			if(xml.integerList.length()){
				var listXML:XML=xml.integerList[0];
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
			}else{
				integerV=new Vector.<int>();
			}
			if(xml.uintegerList.length()){
				listXML=xml.uintegerList[0];
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
			}else{
				uintegerV=new Vector.<int>();
			}
			if(xml.doubleList.length()){
				listXML=xml.doubleList[0];
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
			}else{
				doubleV=new Vector.<Number>();
			}
			if(xml.stringList.length()){
				listXML=xml.stringList[0];
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
			}else{
				stringV=new Vector.<String>();
			}
			if(xml.namespace_infoList.length()){
				listXML=xml.namespace_infoList[0];
				var namespace_infoXMLList:XMLList=listXML.namespace_info;
			
				if(namespace_infoXMLList.length()){
					i=0;
					namespace_infoV=new Vector.<Namespace_info>(namespace_infoXMLList.length()+1);
					for each(var namespace_infoXML:XML in namespace_infoXMLList){
						i++;
						namespace_infoV[i]=new Namespace_info();
						namespace_infoV[i].initByXML(namespace_infoXML);
					}
				}else{
					namespace_infoV=new Vector.<Namespace_info>();
				}
			}else{
				namespace_infoV=new Vector.<Namespace_info>();
			}
			if(xml.ns_set_infoList.length()){
				listXML=xml.ns_set_infoList[0];
				var ns_set_infoXMLList:XMLList=listXML.ns_set_info;
			
				if(ns_set_infoXMLList.length()){
					i=0;
					ns_set_infoV=new Vector.<Ns_set_info>(ns_set_infoXMLList.length()+1);
					for each(var ns_set_infoXML:XML in ns_set_infoXMLList){
						i++;
						ns_set_infoV[i]=new Ns_set_info();
						ns_set_infoV[i].initByXML(ns_set_infoXML);
					}
				}else{
					ns_set_infoV=new Vector.<Ns_set_info>();
				}
			}else{
				ns_set_infoV=new Vector.<Ns_set_info>();
			}
			if(xml.multiname_infoList.length()){
				listXML=xml.multiname_infoList[0];
				var multiname_infoXMLList:XMLList=listXML.multiname_info;
			
				if(multiname_infoXMLList.length()){
					i=0;
					multiname_infoV=new Vector.<Multiname_info>(multiname_infoXMLList.length()+1);
					for each(var multiname_infoXML:XML in multiname_infoXMLList){
						i++;
						multiname_infoV[i]=new Multiname_info();
						multiname_infoV[i].initByXML(multiname_infoXML);
					}
				}else{
					multiname_infoV=new Vector.<Multiname_info>();
				}
			}else{
				multiname_infoV=new Vector.<Multiname_info>();
			}
			if(xml.method_infoList.length()){
				listXML=xml.method_infoList[0];
				var method_infoXMLList:XMLList=listXML.method_info;
				i=-1;
				method_infoV=new Vector.<Method_info>(method_infoXMLList.length());
				for each(var method_infoXML:XML in method_infoXMLList){
					i++;
					method_infoV[i]=new Method_info();
					method_infoV[i].initByXML(method_infoXML);
				}
			}else{
				method_infoV=new Vector.<Method_info>();
			}
			if(xml.metadata_infoList.length()){
				listXML=xml.metadata_infoList[0];
				var metadata_infoXMLList:XMLList=listXML.metadata_info;
				i=-1;
				metadata_infoV=new Vector.<Metadata_info>(metadata_infoXMLList.length());
				for each(var metadata_infoXML:XML in metadata_infoXMLList){
					i++;
					metadata_infoV[i]=new Metadata_info();
					metadata_infoV[i].initByXML(metadata_infoXML);
				}
			}else{
				metadata_infoV=new Vector.<Metadata_info>();
			}
			if(xml.instance_infoList.length()){
				listXML=xml.instance_infoList[0];
				var instance_infoXMLList:XMLList=listXML.instance_info;
				i=-1;
				instance_infoV=new Vector.<Instance_info>(instance_infoXMLList.length());
				for each(var instance_infoXML:XML in instance_infoXMLList){
					i++;
					instance_infoV[i]=new Instance_info();
					instance_infoV[i].initByXML(instance_infoXML);
				}
			}else{
				instance_infoV=new Vector.<Instance_info>();
			}
			if(xml.class_infoList.length()){
				listXML=xml.class_infoList[0];
				var class_infoXMLList:XMLList=listXML.class_info;
				i=-1;
				class_infoV=new Vector.<Class_info>(class_infoXMLList.length());
				for each(var class_infoXML:XML in class_infoXMLList){
					i++;
					class_infoV[i]=new Class_info();
					class_infoV[i].initByXML(class_infoXML);
				}
			}else{
				class_infoV=new Vector.<Class_info>();
			}
			if(xml.script_infoList.length()){
				listXML=xml.script_infoList[0];
				var script_infoXMLList:XMLList=listXML.script_info;
				i=-1;
				script_infoV=new Vector.<Script_info>(script_infoXMLList.length());
				for each(var script_infoXML:XML in script_infoXMLList){
					i++;
					script_infoV[i]=new Script_info();
					script_infoV[i].initByXML(script_infoXML);
				}
			}else{
				script_infoV=new Vector.<Script_info>();
			}
			if(xml.method_body_infoList.length()){
				listXML=xml.method_body_infoList[0];
				var method_body_infoXMLList:XMLList=listXML.method_body_info;
				i=-1;
				method_body_infoV=new Vector.<Method_body_info>(method_body_infoXMLList.length());
				for each(var method_body_infoXML:XML in method_body_infoXMLList){
					i++;
					method_body_infoV[i]=new Method_body_info();
					method_body_infoV[i].initByXML(method_body_infoXML);
				}
			}else{
				method_body_infoV=new Vector.<Method_body_info>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
