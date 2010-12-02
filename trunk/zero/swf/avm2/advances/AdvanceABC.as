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
package zero.swf.avm2.advances{
	import flash.utils.*;
	
	import zero.swf.avm2.ABCFile;
	import zero.swf.avm2.AVM2Obj;
	import zero.swf.avm2.Class_info;
	import zero.swf.avm2.Instance_info;
	import zero.swf.avm2.Metadata_info;
	import zero.swf.avm2.Method_body_info;
	import zero.swf.avm2.Method_info;
	import zero.swf.avm2.Multiname_info;
	import zero.swf.avm2.Namespace_info;
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.avm2.Script_info;
	import zero.swf.vmarks.ConstantKind;
	
	public class AdvanceABC extends Advance{
		private static var firstInitResult:*=MemberClasses.firstInit();//- -
		
		public static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("minor_version"),
			new Member("major_version"),
			new Member("clazz",Member.CLAZZ,{isList:true}),
			new Member("script_info",Member.SCRIPT_INFO,{isList:true})
		]);
		
		private function getDefaultInfo0s():void{
			//- -
			namespace_infoV[0]=null;
			ns_set_infoV[0]=null;
			multiname_infoV[0]=AdvanceDefaultMultiname_info.instance;
		}
		
		public var abcFile:ABCFile;
		
		public var minor_version:int;
		public var major_version:int;
		
		private var dicts:Object;
		
		public var integerV:Vector.<int>;
		public var uintegerV:Vector.<int>;
		public var doubleV:Vector.<Number>;
		public var stringV:Vector.<String>;
		public var namespace_infoV:Vector.<AdvanceNamespace_info>;
		public var ns_set_infoV:Vector.<AdvanceNs_set_info>;
		public var multiname_infoV:Vector.<AdvanceMultiname_info>;
		public var metadata_infoV:Vector.<AdvanceMetadata_info>;
		public var methodV:Vector.<AdvanceMethod>;
		public var clazzV:Vector.<AdvanceClass>;
		public var script_infoV:Vector.<AdvanceScript_info>;
		
		private var method_body_info_arr:Array;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var abcFile:ABCFile=new ABCFile();
			offset=abcFile.initByData(data,offset,endOffset);
			initByABCFile(abcFile);
			return offset;
		}
		public function initByABCFile(_abcFile:ABCFile):void{
			//trace("initByABCFile========================================");
			abcFile=_abcFile;
			
			minor_version=abcFile.minor_version;
			major_version=abcFile.major_version;
			
			var i:int;
			
			//为各级 getInfoByIdAndMemberType 作准备
			//test_total_new=0;
			
			var memberType:String;
			
			i=-1;
			for each(memberType in Member.typeV){
				i++;
				if(Member.fromABCFileMark[memberType]){
					if(Member.directMark[memberType]){
						this[memberType+"V"]=abcFile[memberType+"V"];
					}else if(memberType==Member.METHOD){
						this[memberType+"V"]=new MemberClasses.vClassV[i](abcFile.method_infoV.length);
					}else if(memberType==Member.CLAZZ||memberType==Member.SCRIPT_INFO){
					}else{
						this[memberType+"V"]=new MemberClasses.vClassV[i](abcFile[memberType+"V"].length);
					}
				}
			}
			
			stringV[0]="";
			getDefaultInfo0s();
			
			method_body_info_arr=new Array();
			for each(var method_body_info:Method_body_info in abcFile.method_body_infoV){
				method_body_info_arr[method_body_info.method]=method_body_info;
			}
			
			clazzV=new Vector.<AdvanceClass>(abcFile.instance_infoV.length);
			script_infoV=new Vector.<AdvanceScript_info>(abcFile.script_infoV.length);
			//准备完毕
			
			i=-1;
			for each(var instance_info:Instance_info in abcFile.instance_infoV){
				i++;
				getInfoByIdAndMemberType(i,Member.CLAZZ);
			}
			i=-1;
			for each(var script_info:Script_info in abcFile.script_infoV){
				i++;
				getInfoByIdAndMemberType(i,Member.SCRIPT_INFO);
			}
			
			
			method_body_info_arr=null;
			
			/*
			for each(memberType in Member.typeV){
				if(Member.fromABCFileMark[memberType]){
					if(memberType==Member.CLAZZ||memberType==Member.SCRIPT_INFO){
					}else{
						this[memberType+"V"]=null;
					}
				}
			}
			*/
			abcFile=null;
		}
		public function getInfoByIdAndMemberType(id:int,memberType:String):*{
			if(id==0){
				if(
					memberType==Member.INTEGER
					||
					memberType==Member.UINTEGER
					||
					memberType==Member.DOUBLE
				){
					throw new RangeError("id="+id+" 超出范围, "+memberType);
					return null;
				}/*else{
					if(memberType==STRING){
						return "";
					}else if(
						memberType==NAMESPACE_INFO
						||
						memberType==NS_SET_INFO
					){
						return null;
					}else if(memberType==MULTINAME_INFO){
						return null;//?
					}
				}
				*/
			}
			if(id>=0){
				var v:*=this[memberType+"V"];
				if(id<v.length){
					if(Member.directMark[memberType]){
						return v[id];
					}
					
					var info:*=v[id];
					if(info){
						
					}else{
						//"先里后外"，所以先 initByInfo() 或 initByInfos() 然后 v[id]=info
						info=new MemberClasses[memberType]();
						if(memberType==Member.METHOD){
							info.initByInfos(this,abcFile.method_infoV[id],method_body_info_arr[id]);
						}else if(memberType==Member.CLAZZ){
							info.initByInfos(this,abcFile.instance_infoV[id],abcFile.class_infoV[id]);
						}else{
							info.initByInfo(this,abcFile[memberType+"V"][id]);
						}
						v[id]=info;
					}
					return info;
				}
			}
			throw new RangeError("id="+id+" 超出范围, "+memberType+"V.length="+v.length);
			return null;
		}
		
		public function getInfoVByIdsAndMemberType(advance:Advance,avm2Obj:AVM2Obj,infoVName:String,memberType:String):void{
			var idV:Vector.<int>=avm2Obj[infoVName];
			var infoV:*=advance[infoVName]=new MemberClasses[memberType+"VClass"](idV.length);
			var i:int=-1;
			for each(var id:int in idV){
				i++;
				infoV[i]=getInfoByIdAndMemberType(id,memberType);
			}
		}
		//
		
		public function toData():ByteArray{
			var abcFile:ABCFile=new ABCFile();
			getABCFile(abcFile);
			var data:ByteArray=new ByteArray();
			data.writeBytes(abcFile.toData());
			return data;
		}
		public function getABCFile(_abcFile:ABCFile):void{
			//trace("getABCFile========================================");
			abcFile=_abcFile;
			
			abcFile.minor_version=minor_version;
			abcFile.major_version=major_version;
			
			var i:int;
			
			//为各级 getIdByInfoAndMemberType 作准备
			//test_total_new=0;
			
			var memberType:String;
			
			dicts=new Object();
			for each(memberType in Member.typeV){
				if(Member.fromABCFileMark[memberType]){
					dicts[memberType]=new Dictionary();
				}
			}
			
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
			//准备完毕
			
			//
			for each(var clazz:AdvanceClass in clazzV){
				getIdByInfoAndMemberType(clazz,Member.CLAZZ);
			}
			for each(var script_info:AdvanceScript_info in script_infoV){
				getIdByInfoAndMemberType(script_info,Member.SCRIPT_INFO);
			}
			//
			
			if(abcFile.integerV.length>1){
			}else{
				abcFile.integerV=new Vector.<int>();
			}
			if(abcFile.uintegerV.length>1){
			}else{
				abcFile.uintegerV=new Vector.<int>();
			}
			if(abcFile.doubleV.length>1){
			}else{
				abcFile.doubleV=new Vector.<Number>();
			}
			if(abcFile.stringV.length>1){
			}else{
				abcFile.stringV=new Vector.<String>();
			}
			if(abcFile.namespace_infoV.length>1){
			}else{
				abcFile.namespace_infoV=new Vector.<Namespace_info>();
			}
			if(abcFile.ns_set_infoV.length>1){
			}else{
				abcFile.ns_set_infoV=new Vector.<Ns_set_info>();
			}
			if(abcFile.multiname_infoV.length>1){
			}else{
				abcFile.multiname_infoV=new Vector.<Multiname_info>();
			}
			
			abcFile=null;
			
			dicts=null;
		}
		
		public function getIdByInfoAndMemberType(info:*,memberType:String):int{
			var dict:Dictionary=dicts[memberType];
			
			if(Member.directMark[memberType]){
				if(info===null||info===undefined){
					throw new Error("info="+info);
				}else{
					if(dict["~"+info]){
						//因为可能 info=="prototype" 之类，所以要加 "~"
						//因为 constant_pool 里的数组都是从1开始，所以只要 if(id) 即可
					}else{
						dict["~"+info]=abcFile[memberType+"V"].length;
						abcFile[memberType+"V"][dict["~"+info]]=info;
					}
					return dict["~"+info];
				}
			}else{
				if(info){
					if(dict[info]>=0){
					}else{
						dict[info]=info.toInfoId(this);
					}
					return dict[info];
				}
				throw new Error("info="+info);
			}
		
			return -1;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			//trace("toXML========================================");
			
			var infoMark:InfoMark=new InfoMark();
			var xml:XML=toXMLAndMark(infoMark);
			xml.setName(xmlName);
			xml["@class"]="AdvanceABC";
			if(infoMark.specialMarkStrV.length){
				var specialsXML:XML=<specials count={infoMark.specialMarkStrV.length}/>;
				for each(var specialMarkStr:String in infoMark.specialMarkStrV){
					var specialXML:XML=<special markStr={specialMarkStr}/>;
					specialXML.appendChild(infoMark.specialXMLs["~"+specialMarkStr]);
					specialsXML.appendChild(specialXML);
				}
				xml.appendChild(specialsXML);
			}
			return xml;
		}
		
		/*
		override public function toXMLAndMark(infoMark:InfoMark):XML{
			var xml:XML=super.toXMLAndMark(infoMark);
			throw new Error("查看 infoMark 是否正常");
			return xml;
		}
		//*/
		
		/*
		override public function initByXMLAndMark(infoMark:InfoMark,xml:XML):void{
			super.initByXMLAndMark(infoMark,xml);
			throw new Error("查看 infoMark 是否正常");
		}
		//*/
		
		
		public function initByXML(xml:XML):void{
			//trace("initByXML========================================");
			
			//为各级 getInfoByXMLAndMemberType 作准备
			
			///*
			var i:int=-1;
			var memberType:String;
			for each(memberType in Member.typeV){
				i++;
				if(Member.fromABCFileMark[memberType]){
					if(Member.directMark[memberType]){
					}else if(Member.idStartFrom1Mark[memberType]){
						this[memberType+"V"]=new MemberClasses.vClassV[i](1);
					}else{
						this[memberType+"V"]=new MemberClasses.vClassV[i]();
					}
				}
			}
			//*/
			
			getDefaultInfo0s();
			
			var infoMark:InfoMark=new InfoMark();
			var specialsXML:XML=xml.specials[0];
			if(specialsXML){
				for each(var specialXML:XML in specialsXML.special){
					infoMark.addSpecialXML(specialXML.@markStr.toString(),specialXML.children()[0]);
				}
			}
			
			//准备完毕
			
			//initByXML_fun(new InfoMark(),xml,memberV);
			initByXMLAndMark(infoMark,xml);
			
			//trace("methodV="+methodV);
			
			/*
			for each(memberType in Member.typeV){
				if(Member.fromABCFileMark[memberType]){
					if(memberType==Member.CLAZZ||memberType==Member.SCRIPT_INFO){
					}else{
						this[memberType+"V"]=null;
					}
				}
			}
			*/
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
