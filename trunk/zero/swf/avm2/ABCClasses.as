/***
ABCClasses
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月16日 10:15:45（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
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
package zero.swf.avm2{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class ABCClasses/*{*/implements I_zero_swf_CheckCodesRight{
		public var minor_version:int;					//direct
		public var major_version:int;					//direct
		
		private var classV:Vector.<ABCClass>;
		private var scriptV:Vector.<ABCScript>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			var abcFile:ABCFile=new ABCFile();
			offset=abcFile.initByData(data,offset,endOffset,_initByDataOptions);
			
			////
			minor_version=abcFile.minor_version;
			major_version=abcFile.major_version;
			
			////
			var i:int,count:int;
			
			////
			i=0;
			var allNsV:Vector.<ABCNamespace>=new Vector.<ABCNamespace>(1);
			allNsV[0]=null;
			count=abcFile.namespace_infoV.length;
			while(++i<count){
				allNsV[i]=new ABCNamespace();
				allNsV[i].initByInfo(
					abcFile.namespace_infoV[i],
					abcFile.stringV,
					_initByDataOptions
				);
			}
			
			i=0;
			var allNs_setV:Vector.<ABCNs_set>=new Vector.<ABCNs_set>(1);
			allNs_setV[0]=null;
			count=abcFile.ns_set_infoV.length;
			while(++i<count){
				allNs_setV[i]=new ABCNs_set();
				allNs_setV[i].initByInfo(
					abcFile.ns_set_infoV[i],
					allNsV,
					_initByDataOptions
				);
			}
			
			i=0;
			var allMultinameV:Vector.<ABCMultiname>=new Vector.<ABCMultiname>();
			allMultinameV[0]=null;
			count=abcFile.multiname_infoV.length;
			while(++i<count){
				allMultinameV[i]=new ABCMultiname();
			}
			i=0;
			count=abcFile.multiname_infoV.length;
			while(++i<count){
				allMultinameV[i].initByInfo(
					abcFile.multiname_infoV[i],
					abcFile.stringV,
					allNsV,
					allNs_setV,
					allMultinameV,
					_initByDataOptions
				);
			}
			
			i=-1;
			var allMethodV:Vector.<ABCMethod>=new Vector.<ABCMethod>();
			for each(var method_info:Method_info in abcFile.method_infoV){
				i++;
				allMethodV[i]=new ABCMethod();
			}
			var method_body_infoArr:Array=new Array();
			for each(var method_body_info:Method_body_info in abcFile.method_body_infoV){
				method_body_infoArr[method_body_info.method]=method_body_info;
			}
			
			i=-1;
			var allMetadataV:Vector.<ABCMetadata>=new Vector.<ABCMetadata>();
			for each(var metadata_info:Metadata_info in abcFile.metadata_infoV){
				i++;
				allMetadataV[i]=new ABCMetadata();
				allMetadataV[i].initByInfo(
					metadata_info,
					abcFile.stringV,
					_initByDataOptions
				);
			}
			
			i=-1;
			classV=new Vector.<ABCClass>();
			for each(var instance_info:Instance_info in abcFile.instance_infoV){
				i++;
				classV[i]=new ABCClass();
			}
			
			i=-1;
			for each(var method:ABCMethod in allMethodV){
				i++;
				method.initByInfo(
					abcFile.method_infoV[i],
					method_body_infoArr[i],
					abcFile.integerV,
					abcFile.uintegerV,
					abcFile.doubleV,
					abcFile.stringV,
					allNsV,
					allMultinameV,
					allMethodV,
					allMetadataV,
					classV,
					_initByDataOptions
				);
			}
			
			i=-1;
			for each(var clazz:ABCClass in classV){
				i++;
				clazz.initByInfo(
					abcFile.instance_infoV[i],
					abcFile.class_infoV[i],
					abcFile.integerV,
					abcFile.uintegerV,
					abcFile.doubleV,
					abcFile.stringV,
					allNsV,
					allMultinameV,
					allMethodV,
					allMetadataV,
					classV,
					_initByDataOptions
				);
			}
			
			i=-1;
			scriptV=new Vector.<ABCScript>();
			for each(var script_info:Script_info in abcFile.script_infoV){
				i++;
				scriptV[i]=new ABCScript();
				scriptV[i].initByInfo(
					script_info,
					abcFile.integerV,
					abcFile.uintegerV,
					abcFile.doubleV,
					abcFile.stringV,
					allNsV,
					allMultinameV,
					allMethodV,
					allMetadataV,
					classV,
					_initByDataOptions
				);
			}
			
			///
			return offset;
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var abcFile:ABCFile=new ABCFile();
			
			////
			abcFile.minor_version=minor_version;
			abcFile.major_version=major_version;
			
			abcFile.integerV=new Vector.<int>(1);
			abcFile.uintegerV=new Vector.<int>(1);
			abcFile.doubleV=new Vector.<Number>(1);
			abcFile.stringV=new Vector.<String>(1);
			abcFile.namespace_infoV=new Vector.<Namespace_info>(1);
			abcFile.ns_set_infoV=new Vector.<Ns_set_info>(1);
			abcFile.multiname_infoV=new Vector.<Multiname_info>(1);
			abcFile.method_infoV=new Vector.<Method_info>();
			
			abcFile.metadata_infoV=new Vector.<Metadata_info>();
			abcFile.instance_infoV=new Vector.<Instance_info>();
			abcFile.class_infoV=new Vector.<Class_info>();
			abcFile.script_infoV=new Vector.<Script_info>();
			abcFile.method_body_infoV=new Vector.<Method_body_info>();
			
			var i:int,arr:Array,clazz:ABCClass,script:ABCScript;
			
			//-----
			var productMark:ProductMark=new ProductMark();
			
			i=-1;
			for each(clazz in classV){
				i++;
				productMark.productClass(clazz,i);
			}
			for each(script in scriptV){
				script.getInfo_product(productMark);
			}
			
			productMark.calIds();
			
			//-----
			i=0;
			for each(var integer:int in productMark.integerV){
				i++;
				abcFile.integerV[i]=integer;
			}
			i=0;
			for each(var uinteger:int in productMark.uintegerV){
				i++;
				abcFile.uintegerV[i]=uinteger;
			}
			i=0;
			for each(var double:Number in productMark.doubleV){
				i++;
				abcFile.doubleV[i]=double;
			}
			i=0;
			for each(var string:String in productMark.stringV){
				i++;
				abcFile.stringV[i]=string;
			}
			i=0;
			for each(var ns:ABCNamespace in productMark.nsV){
				i++;
				abcFile.namespace_infoV[i]=ns.getInfo(productMark,_toDataOptions);
			}
			i=0;
			for each(var ns_set:ABCNs_set in productMark.ns_setV){
				i++;
				abcFile.ns_set_infoV[i]=ns_set.getInfo(productMark,_toDataOptions);
			}
			i=0;
			for each(var multiname:ABCMultiname in productMark.multinameV){
				i++;
				abcFile.multiname_infoV[i]=multiname.getInfo(productMark,_toDataOptions);
			}
			i=-1;
			for each(var method:ABCMethod in productMark.methodV){
				i++;
				arr=method.getInfo(productMark,_toDataOptions);
				abcFile.method_infoV[i]=arr[0];
				abcFile.method_body_infoV[i]=arr[1];
			}
			i=-1;
			for each(var metadata:ABCMetadata in productMark.metadataV){
				i++;
				abcFile.metadata_infoV[i]=metadata.getInfo(productMark,_toDataOptions);
			}
			i=-1;
			for each(clazz in classV){
				i++;
				arr=clazz.getInfo(productMark,_toDataOptions);
				abcFile.instance_infoV[i]=arr[0];
				abcFile.class_infoV[i]=arr[1];
			}
			i=-1;
			for each(script in scriptV){
				i++;
				abcFile.script_infoV[i]=script.getInfo(productMark,_toDataOptions);
			}
			
			return abcFile.toData(_toDataOptions);
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="ABCClasses"
				minor_version={minor_version}
				major_version={major_version}
			/>;
			
			var markStrs:MarkStrs=new MarkStrs();
			
			if(classV.length){
				var classListXML:XML=<classList count={classV.length}/>
				for each(var clazz:ABCClass in classV){
					classListXML.appendChild(clazz.toXMLAndMark(markStrs,"class",_toXMLOptions));
				}
				xml.appendChild(classListXML);
			}
			
			if(scriptV.length){
				var scriptListXML:XML=<scriptList count={scriptV.length}/>
				for each(var script:ABCScript in scriptV){
					scriptListXML.appendChild(script.toXMLAndMark(markStrs,"script",_toXMLOptions));
				}
				xml.appendChild(scriptListXML);
			}
			
			if(markStrs.newfunctionXMLV.length){
				var newfunctionListXML:XML=<newfunctionList count={markStrs.newfunctionXMLV.length}/>
				for each(var newfunctionXML:XML in markStrs.newfunctionXMLV){
					newfunctionListXML.appendChild(newfunctionXML);
				}
				xml.appendChild(newfunctionListXML);
			}
			
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			var i:int;
			
			minor_version=int(xml.@minor_version.toString());
			major_version=int(xml.@major_version.toString());
			
			var markStrs:MarkStrs=new MarkStrs();
			
			var methodXML:XML;
			for each(methodXML in xml.newfunctionList.method){
				markStrs.methodMark["~"+methodXML.@methodMarkStr.toString()]=new ABCMethod();
			}
			for each(methodXML in xml.newfunctionList.method){
				markStrs.methodMark["~"+methodXML.@methodMarkStr.toString()].initByXMLAndMark(markStrs,methodXML,_initByXMLOptions);
			}
			
			i=-1;
			classV=new Vector.<ABCClass>();
			for each(var classXML:XML in xml.classList["class"]){
				i++;
				classV[i]=new ABCClass();
				classV[i].initByXMLAndMark(markStrs,classXML,_initByXMLOptions);
				
				//给后面的 ABCTrait.initByXMLAndMark() 时 索引 classi 用
				//如 ABCTrait.initByXMLAndMark() 时未标记对应的 classi 将出错
				//更严谨的应该是先遍历一遍 ABCClass 们初始化所有的 ABCClass 的 name 并标记到 classDict，然后再重头遍历一遍 ABCClass 们执行 ABCTrait.initByXMLAndMark()
				var class_name:ABCMultiname=classV[i].name;
				if(markStrs.classDict[class_name]){
					throw new Error("重名的 class："+class_name.toMarkStrAndMark(markStrs));
				}else{
					markStrs.classDict[class_name]=classV[i];
				}
				//
			}
			
			i=-1;
			scriptV=new Vector.<ABCScript>();
			for each(var scriptXML:XML in xml.scriptList.script){
				i++;
				scriptV[i]=new ABCScript();
				scriptV[i].initByXMLAndMark(markStrs,scriptXML,_initByXMLOptions);
			}
		}
		}//end of CONFIG::USE_XML
	}
}
