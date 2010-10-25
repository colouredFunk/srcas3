/***
AdvanceABCFile 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月24日 21:55:58 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.avm2.advance{
	import zero.swf.avm2.Namespace_info;
	import zero.swf.avm2.advance.AdvanceNamespace_info;
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.avm2.advance.AdvanceNs_set_info;
	import zero.swf.avm2.multinames.Multiname_info;
	import zero.swf.avm2.advance.multinames.AdvanceMultiname_info;
	import flash.utils.ByteArray;
	import zero.swf.avm2.ABCFile;
	public class AdvanceABCFile extends Advance{
		public var minor_version:int;					//direct
		public var major_version:int;					//direct
		public var namespace_infoV:Vector.<AdvanceNamespace_info>;
		public var ns_set_infoV:Vector.<AdvanceNs_set_info>;
		public var multiname_infoV:Vector.<AdvanceMultiname_info>;
		//
		public function initByInfo(info:ABCFile):void{
			currAdvanceABCFile=this;
			abcFile=info;
			minor_version=info.minor_version;
			major_version=info.major_version;
			var count:int=info.namespace_infoV.length;
			namespace_infoV=new Vector.<AdvanceNamespace_info>(count);
			for(var i:int=1;i<count;i++){
				namespace_infoV[i]=new AdvanceNamespace_info();
				namespace_infoV[i].initByInfo(info.namespace_infoV[i]);
			}
			count=info.ns_set_infoV.length;
			ns_set_infoV=new Vector.<AdvanceNs_set_info>(count);
			for(i=1;i<count;i++){
				ns_set_infoV[i]=new AdvanceNs_set_info();
				ns_set_infoV[i].initByInfo(info.ns_set_infoV[i]);
			}
			count=info.multiname_infoV.length;
			multiname_infoV=new Vector.<AdvanceMultiname_info>(count);
			for(i=1;i<count;i++){
				multiname_infoV[i]=new AdvanceMultiname_info();
				multiname_infoV[i].initByInfo(info.multiname_infoV[i]);
			}
		}
		public function toInfo():ABCFile{
			var info:ABCFile=new ABCFile();
			info.minor_version=minor_version;
			info.major_version=major_version;
			var count:int=namespace_infoV.length;
			info.namespace_infoV=new Vector.<Namespace_info>(count);
			var i:int=0;
			for each(var namespace_info:AdvanceNamespace_info in namespace_infoV){
				if(i++<1){
					continue;
				}
				info.namespace_infoV[i]=namespace_info.toInfo();
			}
			count=ns_set_infoV.length;
			info.ns_set_infoV=new Vector.<Ns_set_info>(count);
			i=0;
			for each(var ns_set_info:AdvanceNs_set_info in ns_set_infoV){
				if(i++<1){
					continue;
				}
				info.ns_set_infoV[i]=ns_set_info.toInfo();
			}
			count=multiname_infoV.length;
			info.multiname_infoV=new Vector.<Multiname_info>(count);
			i=0;
			for each(var multiname_info:AdvanceMultiname_info in multiname_infoV){
				if(i++<1){
					continue;
				}
				info.multiname_infoV[i]=multiname_info.toInfo();
			}
			return info;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<AdvanceABCFile
				minor_version={minor_version}
				major_version={major_version}
			>
				<namespace_infoList/>
				<ns_set_infoList/>
				<multiname_infoList/>
			</AdvanceABCFile>;
			
			if(namespace_infoV.length){
				var listXML:XML=xml.namespace_infoList[0];
				listXML.@count=namespace_infoV.length;
				var i:int=0;
				for each(var namespace_info:AdvanceNamespace_info in namespace_infoV){
					if(i<1){
						i++;
						continue;
					}
					var itemXML:XML=<namespace_info/>;
					itemXML.appendChild(namespace_info.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.namespace_infoList;
			}
			if(ns_set_infoV.length){
				listXML=xml.ns_set_infoList[0];
				listXML.@count=ns_set_infoV.length;
				i=0;
				for each(var ns_set_info:AdvanceNs_set_info in ns_set_infoV){
					if(i<1){
						i++;
						continue;
					}
					itemXML=<ns_set_info/>;
					itemXML.appendChild(ns_set_info.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.ns_set_infoList;
			}
			if(multiname_infoV.length){
				listXML=xml.multiname_infoList[0];
				listXML.@count=multiname_infoV.length;
				i=0;
				for each(var multiname_info:AdvanceMultiname_info in multiname_infoV){
					if(i<1){
						i++;
						continue;
					}
					itemXML=<multiname_info/>;
					itemXML.appendChild(multiname_info.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.multiname_infoList;
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			minor_version=int(xml.@minor_version.toString());
			major_version=int(xml.@major_version.toString());
			if(xml.namespace_infoList.length()){
				var listXML:XML=xml.namespace_infoList[0];
				var namespace_infoXMLList:XMLList=listXML.namespace_info;
			
				if(namespace_infoXMLList.length()){
					var i:int=0;
					namespace_infoV=new Vector.<AdvanceNamespace_info>(namespace_infoXMLList.length()+1);
					for each(var namespace_infoXML:XML in namespace_infoXMLList){
						i++;
						namespace_infoV[i]=new AdvanceNamespace_info();
						namespace_infoV[i].initByXML(namespace_infoXML.children()[0]);
					}
				}else{
					namespace_infoV=new Vector.<AdvanceNamespace_info>();
				}
			}else{
				namespace_infoV=new Vector.<AdvanceNamespace_info>();
			}
			if(xml.ns_set_infoList.length()){
				listXML=xml.ns_set_infoList[0];
				var ns_set_infoXMLList:XMLList=listXML.ns_set_info;
			
				if(ns_set_infoXMLList.length()){
					i=0;
					ns_set_infoV=new Vector.<AdvanceNs_set_info>(ns_set_infoXMLList.length()+1);
					for each(var ns_set_infoXML:XML in ns_set_infoXMLList){
						i++;
						ns_set_infoV[i]=new AdvanceNs_set_info();
						ns_set_infoV[i].initByXML(ns_set_infoXML.children()[0]);
					}
				}else{
					ns_set_infoV=new Vector.<AdvanceNs_set_info>();
				}
			}else{
				ns_set_infoV=new Vector.<AdvanceNs_set_info>();
			}
			if(xml.multiname_infoList.length()){
				listXML=xml.multiname_infoList[0];
				var multiname_infoXMLList:XMLList=listXML.multiname_info;
			
				if(multiname_infoXMLList.length()){
					i=0;
					multiname_infoV=new Vector.<AdvanceMultiname_info>(multiname_infoXMLList.length()+1);
					for each(var multiname_infoXML:XML in multiname_infoXMLList){
						i++;
						multiname_infoV[i]=new AdvanceMultiname_info();
						multiname_infoV[i].initByXML(multiname_infoXML.children()[0]);
					}
				}else{
					multiname_infoV=new Vector.<AdvanceMultiname_info>();
				}
			}else{
				multiname_infoV=new Vector.<AdvanceMultiname_info>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
