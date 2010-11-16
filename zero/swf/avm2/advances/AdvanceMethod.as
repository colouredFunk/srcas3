/***
AdvanceMethod 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 21:00:10
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

//The method_body entry holds the AVM2 instructions that are associated with a particular method or
//function body. Some of the fields in this entry declare the maximum amount of resources the body will
//consume during execution. These declarations allow the AVM2 to anticipate the requirements of the method
//without analyzing the method body prior to execution. The declarations also serve as promises about the
//resource boundary within which the method has agreed to remain.3
//There can be fewer method bodies in the method_body table than than there are method signatures in the
//method table—some methods have no bodies. Therefore the method_body contains a reference to the method
//it belongs to, and other parts of the abcFile always reference the method table, not the method_body table.
//3 Any code loaded from an untrusted source will be examined in order to verify that the code stays within
//the declared limits.

//method_body
//{
//	u30 method
//	u30 max_stack
//	u30 local_count
//	u30 init_scope_depth
//	u30 max_scope_depth
//	u30 code_length
//	u8 code[code_length]
//	u30 exception_count
//	exception_info exception[exception_count]
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The method field is an index into the method array of the abcFile; it identifies the method signature with
//which this body is to be associated.

//The max_stack field is maximum number of evaluation stack slots used at any point during the execution
//of this body.

//The local_count field is the index of the highest-numbered local register this method will use, plus one.

//The init_scope_depth field defines the minimum scope depth, relative to max_scope_depth, that may
//be accessed within the method.

//The max_scope_depth field defines the maximum scope depth that may be accessed within the method.
//The difference between max_scope_depth and init_scope_depth determines the size of the local scope
//stack.

//The value of code_length is the number of bytes in the code array. The code array holds AVM2
//instructions for this method body. The AVM2 instruction set is defined in Section 2.5.

//The value of exception_count is the number of elements in the exception array. The exception array
//associates exception handlers with ranges of instructions within the code array (see below).

//The value of trait_count is the number of elements in the trait array. The trait array contains all
//the traits for this method body (see above for more information on traits).

package zero.swf.avm2.advances{
	import flash.utils.ByteArray;
	
	import zero.swf.BytesData;
	import zero.swf.avm2.Exception_info;
	import zero.swf.avm2.Method_body_info;
	import zero.swf.avm2.Method_info;
	import zero.swf.avm2.Option_detail;
	import zero.swf.avm2.Traits_info;
	import zero.swf.vmarks.MethodFlags;
	
	public class AdvanceMethod extends Advance{
		
		private static const Method_info_memberV:Vector.<Member>=Vector.<Member>([
			new Member("return_type",Member.MULTINAME_INFO),
			new Member("param_type",Member.MULTINAME_INFO,{isList:true}),
			new Member("name",Member.STRING),
			new Member("flags",null,{flagClass:MethodFlags}),
			new Member("option_detail",Member.OPTION_DETIAL,{isList:true,curr:Member.CURR_CASE}),
			new Member("param_name",Member.STRING,{isList:true,curr:Member.CURR_CASE})
		]);
		
		private static const Method_body_info_memberV:Vector.<Member>=Vector.<Member>([
			new Member("max_stack"),
			new Member("local_count"),
			new Member("init_scope_depth"),
			new Member("max_scope_depth"),
			//new Member("exception_info",Member.EXCEPTION_INFO,{isList:true}),
			new Member("traits_info",Member.TRAITS_INFO,{isList:true})
		]);
		
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		
		public var return_type:AdvanceMultiname_info;
		public var param_typeV:Vector.<AdvanceMultiname_info>;
		public var name:String;
		public var flags:int;
		public var option_detailV:Vector.<AdvanceOption_detail>;
		public var param_nameV:Vector.<String>;
		
		public var max_stack:int;
		public var local_count:int;
		public var init_scope_depth:int;
		public var max_scope_depth:int;
		public var codes:AdvanceCodes;
		//public var exception_infoV:Vector.<AdvanceException_info>;
		public var traits_infoV:Vector.<AdvanceTraits_info>;
		
		public function AdvanceMethod(){
		}
		
		public function clone():AdvanceMethod{
			var method:AdvanceMethod=new AdvanceMethod();
			
			method.infoId=infoId;
			method.return_type=return_type;
			method.param_typeV=param_typeV;
			method.name=name;
			method.flags=flags;
			method.option_detailV=option_detailV;
			method.param_nameV=param_nameV;
			method.max_stack=max_stack;
			method.local_count=local_count;
			method.init_scope_depth=init_scope_depth;
			method.max_scope_depth=max_scope_depth;
			method.codes=codes;
			method.traits_infoV=traits_infoV;
			
			return method;
		}
		
		public function initByInfos(_infoId:int,method_info:Method_info,method_body_info:Method_body_info):void{
			infoId=_infoId;
			
			initByInfo_fun(method_info,Method_info_memberV,method_info.flags&MethodFlags.HAS_OPTIONAL,method_info.flags&MethodFlags.HAS_PARAM_NAMES);
			
			if(method_body_info){
				//如果是接口则 method_body_info==null
				
				initByInfo_fun(method_body_info,Method_body_info_memberV);
				
				var exception_infoV:Vector.<AdvanceException_info>=new Vector.<AdvanceException_info>();
				var i:int=-1;
				for each(var exception_info:Exception_info in method_body_info.exception_infoV){
					i++;
					exception_infoV[i]=new AdvanceException_info();
					exception_infoV[i].initByInfo(exception_info);
				}
				codes=new AdvanceCodes();
				codes.initByInfo(method_body_info.codes.toData(),exception_infoV);
			}
		}
		
		public function toInfoId():int{
			var method_info:Method_info=new Method_info();
			
			toInfo_fun(method_info,Method_info_memberV);
			
			var methodId:int=AdvanceABC.currInstance.abcFile.method_infoV.length;
			AdvanceABC.currInstance.abcFile.method_infoV[methodId]=method_info;
			
			if(codes){
				var method_body_info:Method_body_info=new Method_body_info();
				
				toInfo_fun(method_body_info,Method_body_info_memberV);
				
				method_body_info.method=methodId;
				//trace("methodId="+methodId);
				
				var exception_infoV:Vector.<AdvanceException_info>=new Vector.<AdvanceException_info>();
				
				var codesData:ByteArray=codes.toData(exception_infoV);
				
				method_body_info.exception_infoV=new Vector.<Exception_info>();
				var i:int=-1;
				for each(var exception_info:AdvanceException_info in exception_infoV){
					i++;
					method_body_info.exception_infoV[i]=exception_info.toInfo();
				}
				
				method_body_info.codes=new BytesData();
				method_body_info.codes.initByData(codesData,0,codesData.length);
				
				AdvanceABC.currInstance.abcFile.method_body_infoV.push(method_body_info);
			}
			
			return methodId;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=toXML_fun(Method_info_memberV,xmlName);
			
			if(codes){
				toXML_fun(Method_body_info_memberV,xml);
				
				xml.appendChild(codes.toXML("codes"));
			}
			
			xml.@infoId=infoId;
			return xml;
		}
		public function initByXML(xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			initByXML_fun(xml,Method_info_memberV);
			
			var codesXML:XML=xml.codes[0];
			
			if(codesXML){
				
				initByXML_fun(xml,Method_body_info_memberV);
				
				codes=new AdvanceCodes();
				codes.initByXML(codesXML);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}