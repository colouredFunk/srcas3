/***
AdvanceABC 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 12:39:52 
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
	import zero.swf.avm2.ABCFile;
	import zero.swf.avm2.Class_info;
	import zero.swf.avm2.Instance_info;
	import zero.swf.avm2.Metadata_info;
	import zero.swf.avm2.Method_body_info;
	import zero.swf.avm2.Method_info;
	import zero.swf.avm2.Multiname_info;
	import zero.swf.avm2.Namespace_info;
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.avm2.Script_info;
	
	public class AdvanceABC extends Advance{
		public static var currInstance:AdvanceABC;
		
		private function reset():void{
			test_total=0;
			currInstance=this;
			
			test_total=0;
			
			currInstance=this;
			
			namespace_infoMark=new Object();
			ns_set_infoMark=new Object();
			multiname_infoMark=new Object();
			namespace_infoV=new Vector.<AdvanceNamespace_info>(1);
			ns_set_infoV=new Vector.<AdvanceNs_set_info>(1);
			multiname_infoV=new Vector.<AdvanceMultiname_info>(1);
		}
		private function clear():void{
			var i:int;
			
			i=0;
			for each(var namespace_info:AdvanceNamespace_info in namespace_infoV){
				if(i<1){
					i++;
					continue;
				}
				namespace_info.realInfoId=-1;
			}
			i=0;
			for each(var ns_set_info:AdvanceNs_set_info in ns_set_infoV){
				if(i<1){
					i++;
					continue;
				}
				ns_set_info.realInfoId=-1;
			}
			i=0;
			for each(var multiname_info:AdvanceMultiname_info in multiname_infoV){
				if(i<1){
					i++;
					continue;
				}
				multiname_info.realInfoId=-1;
			}
			
			currInstance=null;
			namespace_infoMark=null;
			ns_set_infoMark=null;
			multiname_infoMark=null;
			namespace_infoV=null;
			ns_set_infoV=null;
			multiname_infoV=null;
		}
		
		public var abcFile:ABCFile;
		
		public var stringMark:Object;
		
		public var minor_version:int;					//direct
		public var major_version:int;					//direct
		
		private var namespace_infoMark:Object;
		private var ns_set_infoMark:Object;
		private var multiname_infoMark:Object;
		
		public var namespace_infoV:Vector.<AdvanceNamespace_info>;
		public var ns_set_infoV:Vector.<AdvanceNs_set_info>;
		public var multiname_infoV:Vector.<AdvanceMultiname_info>;
		
		public var classV:Vector.<AdvanceClass>;
		
		//
		public function getStringById(id:int):String{
			if(id<1){
				return "";
			}
			if(id<abcFile.stringV.length){
				return abcFile.stringV[id];
			}
			throw new Error("id="+id+" 超出范围, abcFile.stringV.length="+abcFile.stringV.length);
			return null;
		}
		public function getNamespace_infoById(id:int):AdvanceNamespace_info{
			if(id<1){
				return null;
			}
			if(id<namespace_infoV.length){
				return namespace_infoV[id];
			}
			throw new Error("id="+id+" 超出范围, namespace_infoV.length="+namespace_infoV.length);
			return null;
		}
		public function getNs_set_infoById(id:int):AdvanceNs_set_info{
			if(id<1){
				return null;
			}
			if(id<ns_set_infoV.length){
				return ns_set_infoV[id];
			}
			throw new Error("id="+id+" 超出范围, ns_set_infoV.length="+ns_set_infoV.length);
			return null;
		}
		public function getMultiname_infoById(id:int):AdvanceMultiname_info{
			if(id<1){
				return null;
			}
			if(id<multiname_infoV.length){
				return multiname_infoV[id];
			}
			throw new Error("id="+id+" 超出范围, multiname_infoV.length="+multiname_infoV.length);
			return null;
		}
		public function initByInfo(_abcFile:ABCFile):void{
			trace("initByInfo========================================");
			abcFile=_abcFile;
			reset();
			
			minor_version=abcFile.minor_version;
			major_version=abcFile.major_version;
			
			var i:int;
			
			var multiname_info:Multiname_info;
			var instance_info:Instance_info;
			
			//var clazz:AdvanceClass;
			
			i=-1;
			for each(var namespace_info:Namespace_info in abcFile.namespace_infoV){
				if(++i<1){
					continue;
				}
				namespace_infoV[i]=new AdvanceNamespace_info();
				namespace_infoV[i].initByInfo(i,namespace_info);
			}
			
			i=-1;
			for each(var ns_set_info:Ns_set_info in abcFile.ns_set_infoV){
				if(++i<1){
					continue;
				}
				ns_set_infoV[i]=new AdvanceNs_set_info();
				ns_set_infoV[i].initByInfo(i,ns_set_info);
			}
			
			i=-1;
			for each(multiname_info in abcFile.multiname_infoV){
				if(++i<1){
					continue;
				}
				multiname_infoV[i]=new AdvanceMultiname_info();
			}
			//考虑到 GenericName 会引用某个 Multiname_info，所以先全部 new AdvanceMultiname_info() 再全部 initByInfo(multiname_info)：
			i=-1;
			for each(multiname_info in abcFile.multiname_infoV){
				if(++i<1){
					continue;
				}
				multiname_infoV[i].initByInfo(i,multiname_info);
			}
			
			i=-1;
			classV=new Vector.<AdvanceClass>(abcFile.instance_infoV.length);
			for each(instance_info in abcFile.instance_infoV){
				i++;
				classV[i]=new AdvanceClass();
			}
			//
			i=-1;
			for each(instance_info in abcFile.instance_infoV){
				i++;
				classV[i].initByInfos(instance_info,abcFile.class_infoV[i]);
			}
			
			clear();
		}
		public function toInfo(_abcFile:ABCFile):void{
			trace("toInfo========================================");
			abcFile=_abcFile;
			reset();
			
			abcFile.minor_version=minor_version;
			abcFile.major_version=major_version;
			
			abcFile.integerV=new Vector.<int>();
			abcFile.uintegerV=new Vector.<int>();
			abcFile.doubleV=new Vector.<Number>();
			abcFile.stringV=new Vector.<String>();
			abcFile.namespace_infoV=new Vector.<Namespace_info>();
			abcFile.ns_set_infoV=new Vector.<Ns_set_info>();
			abcFile.multiname_infoV=new Vector.<Multiname_info>();
			abcFile.method_infoV=new Vector.<Method_info>();
			abcFile.metadata_infoV=new Vector.<Metadata_info>();
			abcFile.instance_infoV=new Vector.<Instance_info>();
			abcFile.class_infoV=new Vector.<Class_info>();
			abcFile.script_infoV=new Vector.<Script_info>();
			abcFile.method_body_infoV=new Vector.<Method_body_info>();
			
			var i:int;
			
			i=-1;
			for each(var clazz:AdvanceClass in classV){
				i++;
				var instance_info:Instance_info=new Instance_info();
				var class_info:Class_info=new Class_info();
				clazz.toInfos(instance_info,class_info);
				abcFile.instance_infoV[i]=instance_info;
				abcFile.class_infoV[i]=class_info;
			}
			
			i=-1;
			for each(var namespace_info:AdvanceNamespace_info in namespace_infoV){
				if(++i<1){
					continue;
				}
				abcFile.namespace_infoV[i]=namespace_info.toInfo();
			}
			
			i=-1;
			for each(var ns_set_info:AdvanceNs_set_info in ns_set_infoV){
				if(++i<1){
					continue;
				}
				abcFile.ns_set_infoV[i]=ns_set_info.toInfo();
			}
			
			i=-1;
			for each(var multiname_info:AdvanceMultiname_info in multiname_infoV){
				if(++i<1){
					continue;
				}
				abcFile.multiname_infoV[i]=multiname_info.toInfo();
			}
			
			clear();
		}
		
		public function getNamespace_infoId(namespace_info:AdvanceNamespace_info):int{
			if(namespace_info.realInfoId==-1){
				namespace_info.realInfoId=namespace_infoV.length;
				namespace_infoV[namespace_infoV.length]=namespace_info;
			}
			return namespace_info.realInfoId;
		}
		public function getNs_set_infoId(ns_set_info:AdvanceNs_set_info):int{
			if(ns_set_info.realInfoId==-1){
				ns_set_info.realInfoId=ns_set_infoV.length;
				ns_set_infoV[ns_set_infoV.length]=ns_set_info;
			}
			return ns_set_info.realInfoId;
		}
		public function getMultiname_infoId(multiname_info:AdvanceMultiname_info):int{
			if(multiname_info.realInfoId==-1){
				multiname_info.realInfoId=multiname_infoV.length;
				multiname_infoV[multiname_infoV.length]=multiname_info;
			}
			return multiname_info.realInfoId;
		}

		////
	CONFIG::toXMLAndInitByXML {
		public function getNamespace_infoByXML(xml:XML):AdvanceNamespace_info{
			var key:String=xml.toXMLString();
			var namespace_info:AdvanceNamespace_info=namespace_infoMark[key];
			if(namespace_info){
			}else{
				namespace_info=new AdvanceNamespace_info();
				namespace_info.initByXML(xml);
				namespace_infoV[namespace_infoV.length]=namespace_info;
			}
			return namespace_info;
		}
		public function getNs_set_infoByXML(xml:XML):AdvanceNs_set_info{
			var key:String=xml.toXMLString();
			var ns_set_info:AdvanceNs_set_info=ns_set_infoMark[key];
			if(ns_set_info){
			}else{
				ns_set_info=new AdvanceNs_set_info();
				ns_set_info.initByXML(xml);
				ns_set_infoV[ns_set_infoV.length]=ns_set_info;
			}
			return ns_set_info;
		}
		public function getMultiname_infoByXML(xml:XML):AdvanceMultiname_info{
			var key:String=xml.toXMLString();
			var multiname_info:AdvanceMultiname_info=multiname_infoMark[key];
			if(multiname_info){
			}else{
				multiname_info=new AdvanceMultiname_info();
				multiname_info.initByXML(xml);
				multiname_infoV[multiname_infoV.length]=multiname_info;
			}
			return multiname_info;
		}
		public function toXML():XML{
			trace("toXML========================================");
			reset();
			
			var xml:XML=<AdvanceABC
				minor_version={minor_version}
				major_version={major_version}
			>
				<classes/>
			</AdvanceABC>;
			
			var classesXML:XML=xml.classes[0];
			classesXML.@count=classV.length;
			for each(var clazz:AdvanceClass in classV){
				classesXML.appendChild(clazz.toXML());
			}
			
			clear();
			
			return xml;
		}
		public function initByXML(xml:XML):void{
			trace("initByXML========================================");
			reset();
			
			minor_version=int(xml.@minor_version.toString());
			major_version=int(xml.@major_version.toString());
			
			var i:int;
			var AdvanceClassXML:XML;
			
			var AdvanceClassXMLList:XMLList=xml.classes[0].AdvanceClass;
			classV=new Vector.<AdvanceClass>(AdvanceClassXMLList.length());
			i=-1;
			for each(AdvanceClassXML in AdvanceClassXMLList){
				i++;
				classV[i]=new AdvanceClass();
			}
			i=-1;
			for each(AdvanceClassXML in AdvanceClassXMLList){
				i++;
				classV[i].initByXML(AdvanceClassXML);
			}
			
			clear();
		}
	}//end of CONFIG::toXMLAndInitByXML
	}
}
