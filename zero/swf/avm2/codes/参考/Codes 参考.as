/***
Codes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月28日 08:28:24
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2.AVM2Obj;
	public class Codes extends AVM2Obj{
		public static var outputMultinameAsXML:Boolean=false;
		public var codeArr:Array;
		public var exception_info_v:Vector.<Exception_info>;
		public var code_u30_catch_arr:Array;
		public function Codes(){
			
		}
		public function initByInfo(codes:BytesData,_exception_info_v:Vector.<Exception_info>):void{
			exception_info_v=_exception_info_v;
			code_u30_catch_arr=new Array();
			var data:ByteArray=new ByteArray();
			codes.getData(data);
			var offset:int=0;
			var length:int=data.length;
			var prevCodeArr:Array=new Array();
			LabelMark.reset();
			ExceptionPosMark.reset();
			
			var index:int,args:int,branchOffset:int,labelMark:LabelMark;
			var multiname_info_index:int;
			var multiname_info:ClassObj_Multiname_info;
			
			var code:*;
			while(offset<length){
				var pos:int=offset;
				var op:int=data[offset++];
				var opName:String=Op.op_v[op];
				if(opName){
					switch(op){
						case Op.op_bkpt:
						case Op.op_nop:
						case Op.op_throw:
						case Op.op_dxnslate:
						case Op.op_label:
						case Op.op_pushwith:
						case Op.op_popscope:
						case Op.op_nextname:
						case Op.op_hasnext:
						case Op.op_pushnull:
						case Op.op_pushundefined:
						case Op.op_nextvalue:
						case Op.op_pushtrue:
						case Op.op_pushfalse:
						case Op.op_pushnan:
						case Op.op_pop:
						case Op.op_dup:
						case Op.op_swap:
						case Op.op_pushscope:
						case Op.op_li8:
						case Op.op_li16:
						case Op.op_li32:
						case Op.op_lf32:
						case Op.op_lf64:
						case Op.op_si8:
						case Op.op_si16:
						case Op.op_si32:
						case Op.op_sf32:
						case Op.op_sf64:
						case Op.op_returnvoid:
						case Op.op_returnvalue:
						case Op.op_sxi1:
						case Op.op_sxi8:
						case Op.op_sxi16:
						case Op.op_newactivation:
						case Op.op_getglobalscope:
						case Op.op_convert_s:
						case Op.op_esc_xelem:
						case Op.op_esc_xattr:
						case Op.op_convert_i:
						case Op.op_convert_u:
						case Op.op_convert_d:
						case Op.op_convert_b:
						case Op.op_convert_o:
						case Op.op_checkfilter:
						case Op.op_coerce_b:
						case Op.op_coerce_a:
						case Op.op_coerce_i:
						case Op.op_coerce_d:
						case Op.op_coerce_s:
						case Op.op_astypelate:
						case Op.op_coerce_u:
						case Op.op_coerce_o:
						case Op.op_negate:
						case Op.op_increment:
						case Op.op_decrement:
						case Op.op_typeof:
						case Op.op_not:
						case Op.op_bitnot:
						case Op.op_add:
						case Op.op_subtract:
						case Op.op_multiply:
						case Op.op_divide:
						case Op.op_modulo:
						case Op.op_lshift:
						case Op.op_rshift:
						case Op.op_urshift:
						case Op.op_bitand:
						case Op.op_bitor:
						case Op.op_bitxor:
						case Op.op_equals:
						case Op.op_strictequals:
						case Op.op_lessthan:
						case Op.op_lessequals:
						case Op.op_greaterthan:
						case Op.op_greaterequals:
						case Op.op_instanceof:
						case Op.op_istypelate:
						case Op.op_in:
						case Op.op_increment_i:
						case Op.op_decrement_i:
						case Op.op_negate_i:
						case Op.op_add_i:
						case Op.op_subtract_i:
						case Op.op_multiply_i:
						case Op.op_getlocal0:
						case Op.op_getlocal1:
						case Op.op_getlocal2:
						case Op.op_getlocal3:
						case Op.op_setlocal0:
						case Op.op_setlocal1:
						case Op.op_setlocal2:
						case Op.op_setlocal3:
						case Op.op_timestamp:
							code=op;
						break;
						case Op.op_getsuper:
						case Op.op_setsuper:
						case Op.op_getdescendants:
						case Op.op_findpropstrict:
						case Op.op_findproperty:
						case Op.op_getlex:
						case Op.op_setproperty:
						case Op.op_getproperty:
						case Op.op_initproperty:
						case Op.op_deleteproperty:
						case Op.op_coerce:
						case Op.op_astype:
						case Op.op_istype:
							//INDEX u30
							multiname_info=null;
							multiname_info_index=UGetterAndSetter.getU(data,offset);
							if(multiname_info_index<multiname_info_v.length){
								multiname_info=multiname_info_v[multiname_info_index];
							}
							offset=UGetterAndSetter.offset;
							if(multiname_info){
								code=new Code_u30_Multiname();
								(code as Code_u30_Multiname).initByInfo(multiname_info);
							}else{
								code=new Code_Bad();
								(code as Code_Bad).initAsBad_u30_index(multiname_info_index,"不合法的 multiname_info");
							}
						break;
						case Op.op_dxns:
						case Op.op_pushstring:
						case Op.op_debugfile:
							//INDEX u30
							code=new Code_u30_String();
							(code as Code_u30_String).initByInfo(UGetterAndSetter.getU(data,offset));
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_kill:
						case Op.op_getlocal:
						case Op.op_setlocal:
						case Op.op_inclocal:
						case Op.op_declocal:
						case Op.op_inclocal_i:
						case Op.op_declocal_i:
							//INDEX u30
							code=new Code_u30_Register(UGetterAndSetter.getU(data,offset));
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_getslot:
						case Op.op_setslot:
						case Op.op_getglobalslot:
						case Op.op_setglobalslot:
							//INDEX u30
							code=new Code_u30_Slot(UGetterAndSetter.getU(data,offset));
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_pushint:
							//INDEX u30
							code=new Code_u30_Integer();
							(code as Code_u30_Integer).integer=abcFile.constant_pool.integer_v[UGetterAndSetter.getU(data,offset)]
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_pushuint:
							//INDEX u30
							code=new Code_u30_Uinteger();
							(code as Code_u30_Uinteger).uinteger=abcFile.constant_pool.uinteger_v[UGetterAndSetter.getU(data,offset)]
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_pushdouble:
							//INDEX u30
							code=new Code_u30_Double();
							(code as Code_u30_Double).double=abcFile.constant_pool.double_v[UGetterAndSetter.getU(data,offset)];
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_pushnamespace:
							//INDEX u30
							var namespace_info:ClassObj_Namespace_info=null;
							var namespace_info_index:int=UGetterAndSetter.getU(data,offset);
							if(namespace_info_index<namespace_info_v.length){
								namespace_info=namespace_info_v[namespace_info_index];
							}
							offset=UGetterAndSetter.offset;
							if(namespace_info){
								code=new Code_u30_Namespace();
								(code as Code_u30_Namespace).initByInfo(namespace_info);
							}else{
								code=new Code_Bad();
								(code as Code_Bad).initAsBad_u30_index(namespace_info_index,"不合法的 namespace_info");
							}
						break;
						case Op.op_newfunction:
							//INDEX u30
							code=new Code_u30_Function(UGetterAndSetter.getU(data,offset));
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_newclass:
							//INDEX u30
							var classId:int=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							if(classId<classV.length){
								code=new Code_u30_Class();
								(code as Code_u30_Class).initByInfo(classId);
							}else{
								code=new Code_Bad();
								(code as Code_Bad).initAsBad_u30_index(classId,"不合法的 class");
							}
						break;
						case Op.op_newcatch:
							//INDEX u30
							var exception_info_id:int=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							if(exception_info_v){
								var exception_info:Exception_info=exception_info_v[exception_info_id];
								code=new Code_u30_Catch();
								(code as Code_u30_Catch).initByInfo(
									exception_info_id,
									exception_info,
									ExceptionPosMark.getExceptionPosByOffsetAndLength(exception_info.from,length),
									ExceptionPosMark.getExceptionPosByOffsetAndLength(exception_info.to,length),
									ExceptionPosMark.getExceptionPosByOffsetAndLength(exception_info.target,length)
								);
								code_u30_catch_arr[exception_info_id]=code;
							}else{
								code=new Code_Bad();
								(code as Code_Bad).initAsBad_u30_index(exception_info_id,"不合法的 newcatch");
							}
						break;
						case Op.op_getscopeobject:
							//INDEX u30
							code=new Code_u30_Scope(UGetterAndSetter.getU(data,offset));
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_finddef:
							//INDEX u30
							//throw new Error("Find a global definition. TODO: What exactly does this do ? ");
							//throw new Error("未处理");
							UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							code=new Code_Bad();
							(code as Code_Bad).info="Find a global definition. TODO: What exactly does this do ?";
						break;
						case Op.op_callsuper:
						case Op.op_callproperty:
						case Op.op_constructprop:
						case Op.op_callproplex:
						case Op.op_callsupervoid:
						case Op.op_callpropvoid:
							//INDEX_ARGS u30 u30
							index=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							args=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							
							multiname_info=null;
							if(index<multiname_info_v.length){
								multiname_info=multiname_info_v[index];
							}
							if(multiname_info){
								code=new Code_u30_u30_Multiname_Args();
								(code as Code_u30_u30_Multiname_Args).initByInfo(multiname_info,args);
							}else{
								code=new Code_Bad();
								(code as Code_Bad).initAsBad_u30_u30_index_args(index,args,"不合法的 multiname_info");
							}
						break;
						case Op.op_callmethod:
						case Op.op_callstatic:
							//INDEX_ARGS u30 u30
							index=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							args=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							if(index<method_v.length){
								code=new Code_u30_u30_Callmethod();
								(code as Code_u30_u30_Callmethod).initByInfo(method_v[index],index,args);
							}else{
								code=new Code_Bad();
								(code as Code_Bad).initAsBad_u30_u30_index_args(index,args,"不合法的 method");
							}
						break;
						case Op.op_call:
						case Op.op_construct:
						case Op.op_constructsuper:
						case Op.op_applytype:
						case Op.op_newobject:
						case Op.op_newarray:
							//ARGS u30
							code=new Code_u30_Args(UGetterAndSetter.getU(data,offset));
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_ifnlt:
						case Op.op_ifnle:
						case Op.op_ifngt:
						case Op.op_ifnge:
						case Op.op_jump:
						case Op.op_iftrue:
						case Op.op_iffalse:
						case Op.op_ifeq:
						case Op.op_ifne:
						case Op.op_iflt:
						case Op.op_ifle:
						case Op.op_ifgt:
						case Op.op_ifge:
						case Op.op_ifstricteq:
						case Op.op_ifstrictne:
							//BRANCH s24
							branchOffset=S24GetterAndSetter.getS24(data,offset);
							offset=S24GetterAndSetter.offset;
							code=new Code_Branch(LabelMark.getLabelByOffsetAndLength(offset+branchOffset,length));
						break;
						
						
						case Op.op_pushbyte:
							//VALUE_BYTE u8
							code=new Code_Byte(data[offset++]);
						break;
						case Op.op_pushshort:
						case Op.op_debugline:
						case Op.op_bkptline:
							//VALUE_INT u30
							code=new Code_u30_Int(UGetterAndSetter.getU(data,offset));
							offset=UGetterAndSetter.offset;
						break;
						case Op.op_lookupswitch:
							//s24 //u30 //s24 //s24...
							var default_labelMark:LabelMark=LabelMark.getLabelByOffsetAndLength(pos+S24GetterAndSetter.getS24(data,offset),length);
							offset=S24GetterAndSetter.offset;
							var case_count:int=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							var case_labelMark_v:Vector.<LabelMark>=new Vector.<LabelMark>();
							for(var case_i:int=0;case_i<=case_count;case_i++){
								var case_LabelMark:LabelMark=LabelMark.getLabelByOffsetAndLength(pos+S24GetterAndSetter.getS24(data,offset),length);
								offset=S24GetterAndSetter.offset;
								case_labelMark_v[case_i]=case_LabelMark;
							}
							code=new Code_Lookupswitch(default_labelMark,case_labelMark_v);
						break;
						case Op.op_hasnext2:
							//uint //uint ?(后被证实是俩Register的id(u30, u30))
							var object_reg:int=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							var index_reg:int=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							code=new Code_u30_u30_Hasnext2(object_reg,index_reg);
						break;
						/*
						case Op.op_abs_jump:
							//u30 u30 (INDEX_ARGS?)
							index=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							args=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							code=new Code_u30_u30_Multiname_Args(index,args);
						break;
						*/
						case Op.op_debug:
							//ubyte //u30 //ubyte //u30
							var debug_type:int=data[offset++];
							index=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							var reg:int=data[offset++];
							var extra:int=UGetterAndSetter.getU(data,offset);
							offset=UGetterAndSetter.offset;
							code=new Code_Debug();
							code.initByInfo(debug_type,index,reg,extra);
						break;
						//0x00
						//0x0a
						//0x0b
						//0x22	//pushconstant
						//0x33
						//0x34
						//0x35
						//0x36
						//0x37
						//0x38
						//0x39
						//0x3a
						//0x3b
						//0x3c
						//0x3d
						//0x3e
						//0x3f
						//0x4b	//callsuperid
						//0x4d	//callinterface
						//0x50
						//0x51
						//0x52
						//0x54
						//0x5b
						//0x5c
						//0x67	//getpropertylate
						//0x69	//setpropertylate
						//0x6b	//deletepropertylate
						//0x79
						//0x7a
						//0x7b
						//0x7c
						//0x7d
						//0x7e
						//0x7f
						//0x8a
						//0x8b
						//0x8c
						//0x8d
						//0x8e
						//0x8f
						//0x98
						//0x99
						//0x9a	//concat
						//0x9b	//add_d
						//0x9c
						//0x9d
						//0x9e
						//0x9f
						//0xb5
						//0xb6
						//0xb7
						//0xb8
						//0xb9
						//0xba
						//0xbb
						//0xbc
						//0xbd
						//0xbe
						//0xbf
						//0xc8
						//0xc9
						//0xca
						//0xcb
						//0xcc
						//0xcd
						//0xce
						//0xcf
						//0xd8
						//0xd9
						//0xda
						//0xdb
						//0xdc
						//0xdd
						//0xde
						//0xdf
						//0xe0
						//0xe1
						//0xe2
						//0xe3
						//0xe4
						//0xe5
						//0xe6
						//0xe7
						//0xe8
						//0xe9
						//0xea
						//0xeb
						//0xec
						//0xed
						//0xf4
						//0xf5	//verifypass
						//0xf6	//alloc
						//0xf7	//_mark
						//0xf8	//wb
						//0xf9	//prologue
						//0xfa	//sendenter
						//0xfb	//doubletoatom
						//0xfc	//sweep
						//0xfd	//codegenop
						//0xfe	//verifyop
						//0xff	//decode
					}
				}else{
					code=new Code_Bad();
					(code as Code_Bad).initAsBadOp(op);
				}
				if(code is CodeObj){
					(code as CodeObj).op=op;
				}
				prevCodeArr[pos]=code;
			}
			
			var i:int=-1;
			var L:int=prevCodeArr.length;
			codeArr=new Array();
			
			if(L<LabelMark.labelArr.length){
				L=LabelMark.labelArr.length;
			}
			if(L<ExceptionPosMark.exceptionPosArr.length){
				L=ExceptionPosMark.exceptionPosArr.length;
			}
			while(++i<L){
				if(ExceptionPosMark.exceptionPosArr[i]){
					codeArr[codeArr.length]=ExceptionPosMark.exceptionPosArr[i];
				}
				if(LabelMark.labelArr[i]){
					codeArr[codeArr.length]=LabelMark.labelArr[i];
				}
				if(prevCodeArr[i]===undefined){
				}else{
					codeArr[codeArr.length]=prevCodeArr[i];
				}
			}
			
			exception_info_v=null;
			
			for each(code in codeArr){
				if(code is Code_Bad){
					trace("bad code: "+code);
				}
			}
		}
		
		/*
		private function toXML_markMultiname(
			multiname_info:ClassObj_Multiname_info,
			multinameMark:Object,
			multinamesXML:XML
		):String{
			if(multiname_info){
				var multiname_str:String=multiname_info.toString();
				if(multinameMark[multiname_str]){
					var strId:int=0;
					while(multinameMark[multiname_str+"_"+(++strId)]){}
					multiname_str+="_"+strId;
				}
				multinameMark[multiname_str]=true;
				multinamesXML.appendChild(<multiname name={multiname_str} id={multiname_info.id}/>);
				return multiname_str;
			}
			return "";
		}
		*/
		public var methodsXML:XML;
		override public function toXML(xmlName:String):XML{
			var xmlStr:String="";
			methodsXML=null;
			for each(var code:* in codeArr){
				//trace(codeArr.indexOf(code));
				if(code is BaseMark){
					xmlStr+="\n"+code.toString()+":";
				}else if(code is CodeObj){
					//import zero.BytesAndStr16;
					//xmlStr+="\n\t//0x"+BytesAndStr16._16V[(code as CodeObj).op];
					var multiname_str:String;
					var multiname_info:ClassObj_Multiname_info;
					if(code is Code_u30_Function){
						//newfunction
						if(!methodsXML){
							methodsXML=<methods info="通常是一些匿名函数"/>;
						}
						xmlStr+="\n\t"+Op.op_v[code.op]+" "+methodsXML.children().length();
						var method:ClassObj_Method=(code as Code_u30_Function).function_; 
						methodsXML.appendChild(method.toXML("method"));
					}else if(code is Code_u30_Multiname){
						multiname_info=(code as Code_u30_Multiname).multiname_info;
						if(outputMultinameAsXML){
							xmlStr+="\n\t//"+(multiname_info.toXML("multiname_info").toXMLString().replace(/\s*\n\s*/g,""));
						}
						xmlStr+="\n\t"+(code as Code_u30_Multiname).toString();
					}else if(code is Code_u30_u30_Multiname_Args){
						multiname_info=(code as Code_u30_u30_Multiname_Args).multiname_info;
						if(outputMultinameAsXML){
							xmlStr+="\n\t//"+(multiname_info.toXML("multiname_info").toXMLString().replace(/\s*\n\s*/g,""));
						}
						xmlStr+="\n\t"+(code as Code_u30_u30_Multiname_Args).toString();
					}else{
						xmlStr+="\n\t"+(code as CodeObj).toString();
					}
				}else if(code is int){
					//xmlStr+="\n\t//0x"+BytesAndStr16._16V[code];
					xmlStr+="\n\t"+Op.op_v[code];
				}else{
					xmlStr+='\n\tunknown code="'+code+'"';
				}
			}
			return new XML("<"+xmlName+"><![CDATA["+xmlStr+"\n]]></"+xmlName+">");
		}
		private function initByXML_getArgsByReg(str:String,argsReg:RegExp):int{
			if(argsReg.test(str)){
				var argsStr:String=str.replace(argsReg,"$1");
				var args:int=int(argsStr);
				if(argsStr==args.toString()){
					return args;
				}
				throw new Error("argsStr="+argsStr);
				return -1;
			}
			throw new Error("str="+str);
			return -1;
		}
		
		public static var initByXMLMark:Object;
		
		private static const fromExceptionPosReg:RegExp=/from\((exceptionPos\d+)\)/;
		private static const toExceptionPosReg:RegExp=/to\((exceptionPos\d+)\)/;
		private static const targetExceptionPosReg:RegExp=/target\((exceptionPos\d+)\)/;
		private static const sReg:RegExp=/\s+/;
		private static const ssReg:RegExp=/^\s*|\s*$/g;
		private static const argsReg:RegExp=/\(param count:(\d+)\)/;
		private static const multinameIdReg:RegExp=/\(multinameId=(\d+)\)/;
		private static const namespaceIdReg:RegExp=/\(namespaceId=(\d+)\)/;
		private static const methodIdReg:RegExp=/\(methodId=(\d+)\)/;
		private static const labelMarkReg:RegExp=/label(\d+):/;
		private static const exceptionPosMarkReg:RegExp=/exceptionPos(\d+):/;
		private static const classIdReg:RegExp=/\(classId=(\d+)\)/;
		private static const exception_infoIdReg:RegExp=/exception_infoId\((\d+)\)/;
		private static const defaultLabelReg:RegExp=/default\((label\d+)\)/;
		private static const caseLabelReg:RegExp=/case\((.*)\)/;
		private static const debugReg:RegExp=/(\d+)\s+(.*)\s+(\d+)\s+(\d+)/;
		
		private static function getPackageNameAndClassNameByStr(str:String):Array{
			var dotId:int=str.lastIndexOf(".");
			if(dotId>0){
				return [str.substr(0,dotId),str.substr(dotId+1)];
			}
			return ["",str];
		}
		private static function getMultinameInfoByStrAndMark(str:String):ClassObj_Multiname_info{
			var multinameIdMatchArr:Array=str.match(multinameIdReg);
			if(multinameIdMatchArr){
				str=multinameIdMatchArr[0].replace(multinameIdReg,"$1");
				var multinameId:int=int(str);
				if(str==multinameId.toString()){
					return multiname_info_v[multinameId];
				}
				throw new Error("str="+str);
				return null;
			}
			
			str=str.replace(ssReg,"");
			//"Multiname_info_
			//"Multiname_info_QName_length"
			//"Multiname_info_length"
			if(str.indexOf("multiname_info_")==0){
				var multiname_info:ClassObj_Multiname_info=new ClassObj_Multiname_info();
				str=str.replace("multiname_info_","");
				var strArr:Array=str.split("_");
				//trace(strArr);
				var packageNameAndClassName:Array;
				switch(strArr.length){
					case 0:
						throw new Error("strArr="+strArr);
					break;
					case 1:
						switch(strArr[0]){
							case "[]":
								multiname_info.initByXML(<multiname_info kind="MultinameL"/>);
							break;
							default:
								packageNameAndClassName=getPackageNameAndClassNameByStr(strArr[0]);
								multiname_info.initByXML(<multiname_info kind="QName"><ns kind="PackageNamespace" name={packageNameAndClassName[0]}/><name>{packageNameAndClassName[1]}</name></multiname_info>);
							break;
						}
					break;
					default:
						multiname_info.kind=MultinameKind[strArr[0]];
						switch(multiname_info.kind){
							case MultinameKind.QName:
							case MultinameKind.QNameA:
								var qName:ClassObj_QName=new ClassObj_QName();
								multiname_info.data=qName;
								switch(strArr.length){
									case 2:
										packageNameAndClassName=getPackageNameAndClassNameByStr(strArr[1]);
										qName.initByXML(<data><ns kind="PackageNamespace" name={packageNameAndClassName[0]}/><name>{packageNameAndClassName[1]}</name></data>);
									break;
									case 3:
										packageNameAndClassName=getPackageNameAndClassNameByStr(strArr[2]);
										qName.initByXML(<data><ns kind={strArr[1]} name={packageNameAndClassName[0]}/><name>{packageNameAndClassName[1]}</name></data>);
									break;
									default:
										throw new Error("无法处理的 strArr: "+strArr);
									break;
								}
							break;
							//case MultinameKind.RTQName:
							//case MultinameKind.RTQNameA:
							//break;
							//case MultinameKind.RTQNameL:
							//case MultinameKind.RTQNameLA:
							//break;
							//case MultinameKind.Multiname:
							//case MultinameKind.MultinameA:
							//break;
							//case MultinameKind.MultinameL:
							//case MultinameKind.MultinameLA:
							//	multiname_info.data=new ClassObj_MultinameL();
							//break;
							//case MultinameKind.GenericName:
							//break;
							default:
								throw new Error("未知 MultinameKind: "+multiname_info.kind);
							break;
						}
					break;
				}
				
				return getMultinameInfoByXMLAndMark(multiname_info.toXML("multiname_info"));
			}
			//尝试解析成 xml
			return getMultinameInfoByXMLAndMark(new XML(str));
		}
		public static function getMultinameInfoByXMLAndMark(multiname_infoXML:XML):ClassObj_Multiname_info{
			var initByXMLMarkKey:String=multiname_infoXML.toXMLString();
			if(initByXMLMark[initByXMLMarkKey]){
				return initByXMLMark[initByXMLMarkKey];
			}
			var multiname_info:ClassObj_Multiname_info=new ClassObj_Multiname_info();
			multiname_info.initByXML(multiname_infoXML);
			initByXMLMark[initByXMLMarkKey]=multiname_info;
			//trace("新增 multiname_info: "+multiname_info.toString());
			//trace("initByXMLMarkKey="+initByXMLMarkKey);
			return multiname_info;
		}
		
		public function initByXML(xml:XML):void{
			var strArr:Array=xml.toString().replace(/[\r\n]+/g,"\n").split("\n");
			codeArr=new Array();
			var _str:String,str:String;
			var labelMarkMark:Object=new Object();
			var exceptionPosMarkMark:Object=new Object();
			var labelMark:LabelMark,exceptionPosMark:ExceptionPosMark;
			for each(_str in strArr){
				str=_str.replace(ssReg,"");
				if(str.indexOf("//")==0){
					//注解
					continue;
				}
				if(labelMarkReg.test(str)){
					if(labelMarkMark[str]){
						throw new Error("重复的 labelMark: "+str);
					}
					labelMarkMark[str]=labelMark=new LabelMark();
					labelMark.markId=int(str.replace(labelMarkReg,"$1"));
				}else if(exceptionPosMarkReg.test(str)){
					if(exceptionPosMarkMark[str]){
						throw new Error("重复的 exceptionPosMark: "+str);
					}
					exceptionPosMarkMark[str]=exceptionPosMark=new ExceptionPosMark();
					exceptionPosMark.markId=int(str.replace(exceptionPosMarkReg,"$1"));
				}
			}
			for each(_str in strArr){
				str=_str.replace(ssReg,"");
				if(str){
					if(str.indexOf("//")==0){
						//注解
						continue;
					}
					if(labelMarkReg.test(str)){
						codeArr[codeArr.length]=labelMarkMark[str];
						continue;
					}
					if(exceptionPosMarkReg.test(str)){
						codeArr[codeArr.length]=exceptionPosMarkMark[str];
						continue;
					}
					var sId:int=str.search(sReg);
					var methodId:int;
					var argsId:int;
					var args:int;
					var op:int;
					if(sId>0){
						op=Op["op_"+str.substr(0,sId)];
						str=str.substr(sId+1).replace(ssReg,"");
						var code:CodeObj;
						switch(op){
							case Op.op_getsuper:
							case Op.op_setsuper:
							case Op.op_getdescendants:
							case Op.op_findpropstrict:
							case Op.op_findproperty:
							case Op.op_getlex:
							case Op.op_setproperty:
							case Op.op_getproperty:
							case Op.op_initproperty:
							case Op.op_deleteproperty:
							case Op.op_coerce:
							case Op.op_astype:
							case Op.op_istype:
								//INDEX u30
								var multiname_info:ClassObj_Multinane_Info=getMultinameInfoByStrAndMark(str);
								if(multiname_info){
									code=new Code_u30_Multiname();
									(code as Code_u30_Multiname).initByInfo(multiname_info);
								}else{
									code=new Code_Bad();
									(code as Code_Bad).info="不合法的 multiname_info, str="+str;
								}
							break;
							case Op.op_dxns:
							case Op.op_pushstring:
							case Op.op_debugfile:
								//INDEX u30
								code=new Code_u30_String();
								(code as Code_u30_String).string=new XML("<string value="+str+"/>").@value.toString();
							break;
							case Op.op_kill:
							case Op.op_getlocal:
							case Op.op_setlocal:
							case Op.op_inclocal:
							case Op.op_declocal:
							case Op.op_inclocal_i:
							case Op.op_declocal_i:
								//INDEX u30
								var registerId:int=int(str);
								if(str==registerId.toString()){
									code=new Code_u30_Register(registerId);
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_getslot:
							case Op.op_setslot:
							case Op.op_getglobalslot:
							case Op.op_setglobalslot:
								//INDEX u30
								var slotId:int=int(str);
								if(str==slotId.toString()){
									code=new Code_u30_Slot(slotId);
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_pushint:
								//INDEX u30
								var integer:int=int(str);
								if(str==integer.toString()){
									code=new Code_u30_Integer();
									(code as Code_u30_Integer).integer=integer;
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_pushuint:
								//INDEX u30
								var uinteger:uint=uint(str);
								if(str==uinteger.toString()){
									code=new Code_u30_Uinteger();
									(code as Code_u30_Uinteger).uinteger=uinteger;
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_pushdouble:
								//INDEX u30
								var double:Number=Number(str);
								if(str==double.toString()){
									code=new Code_u30_Double();
									(code as Code_u30_Double).double=double;
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_pushnamespace:
								//INDEX u30
								var namespaceIdMatchArr:Array=str.match(namespaceIdReg);
								if(namespaceIdMatchArr){
									str=namespaceIdMatchArr[0].replace(namespaceIdReg,"$1");
								}else{
									throw new Error("str="+str);
								}
								var namespace_info_index:int=int(str);
								if(str==namespace_info_index.toString()){
									var namespace_info:ClassObj_Namespace_info=null;
									if(namespace_info_index<namespace_info_v.length){
										namespace_info=namespace_info_v[namespace_info_index];
									}
									if(namespace_info){
										code=new Code_u30_Namespace();
										(code as Code_u30_Namespace).initByInfo(namespace_info);
									}else{
										code=new Code_Bad();
										(code as Code_Bad).info="不合法的 namespace_info, str="+str;
									}
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_newfunction:
								//INDEX u30
								methodId=int(str);
								if(str==methodId.toString()){
									code=new Code_u30_Function(int(methodsXML.method[methodId].@methodId.toString()));
									compilationMethodBody(
										(code as Code_u30_Function).function_.method_body,
										methodsXML.method[methodId].method_body[0]
									)
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_newclass:
								//INDEX u30
								str=str.match(classIdReg)[0].replace(classIdReg,"$1");
								var classId:int=int(str);
								if(str==classId.toString()){
									code=new Code_u30_Class();
									(code as Code_u30_Class).initByInfo(classId);
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_newcatch:
								//INDEX u30
								var from_ExceptionPosMark:ExceptionPosMark=exceptionPosMarkMark[str.match(fromExceptionPosReg)[0].replace(fromExceptionPosReg,"$1:")];
								if(from_ExceptionPosMark){
									var to_ExceptionPosMark:ExceptionPosMark=exceptionPosMarkMark[str.match(toExceptionPosReg)[0].replace(toExceptionPosReg,"$1:")];
									if(to_ExceptionPosMark){
										var target_ExceptionPosMark:ExceptionPosMark=exceptionPosMarkMark[str.match(targetExceptionPosReg)[0].replace(targetExceptionPosReg,"$1:")];
										if(target_ExceptionPosMark){
											str=str.match(exception_infoIdReg)[0].replace(exception_infoIdReg,"$1");
											var exception_infoId:int=int(str);
											if(str==exception_infoId.toString()){
												code=code_u30_catch_arr[exception_infoId];
												var code_u30_catch:Code_u30_Catch=code as Code_u30_Catch;
												code_u30_catch.catch_.from=from_ExceptionPosMark;
												code_u30_catch.catch_.to=to_ExceptionPosMark;
												code_u30_catch.catch_.target=target_ExceptionPosMark;
											}else{
												throw new Error("str="+str);
											}
											
										}else{
											throw new Error("targetLabelReg="+default_labelMark);
										}
									}else{
										throw new Error("toLabelReg="+default_labelMark);
									}
								}else{
									throw new Error("fromLabelReg="+default_labelMark);
								}
							break;
							case Op.op_getscopeobject:
								//INDEX u30
								var scopeId:int=int(str);
								if(str==scopeId.toString()){
									code=new Code_u30_Scope(scopeId);
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_finddef:
								//INDEX u30
								throw new Error("Find a global definition. TODO: What exactly does this do ? ");
								throw new Error("未处理");
							break;
							case Op.op_callsuper:
							case Op.op_callproperty:
							case Op.op_constructprop:
							case Op.op_callproplex:
							case Op.op_callsupervoid:
							case Op.op_callpropvoid:
								//INDEX_ARGS u30 u30
								argsId=str.search(argsReg);
								if(argsId>0){
									args=initByXML_getArgsByReg(str.substr(argsId).replace(ssReg,""),argsReg);
									code=new Code_u30_u30_Multiname_Args();
									(code as Code_u30_u30_Multiname_Args).initByInfo(
										getMultinameInfoByStrAndMark(str.replace(argsReg,"")),
										args
									);
								}else{
									throw new Error("argsId="+argsId);
								}
							break;
							case Op.op_callmethod:
							case Op.op_callstatic:
								//INDEX_ARGS u30 u30
								argsId=str.search(argsReg);
								if(argsId>0){
									args=initByXML_getArgsByReg(str.substr(argsId).replace(ssReg,""),argsReg);
									var methodIdStr:String=str.match(methodIdReg)[0].replace(methodIdReg,"$1");
									methodId=int(methodIdStr);
									if(methodId.toString()==methodIdStr){
										if(methodId<method_v.length){
											code=new Code_u30_u30_Callmethod();
											(code as Code_u30_u30_Callmethod).initByInfo(method_v[methodId],methodId,args);
										}else{
											code=new Code_Bad();
											(code as Code_Bad).initAsBad_u30_u30_index_args(methodId,args,"不合法的 method");
										}
									}else{
										throw new Error("methodId="+methodId);
									}
								}else{
									throw new Error("argsId="+argsId);
								}
							break;
							case Op.op_call:
							case Op.op_construct:
							case Op.op_constructsuper:
							case Op.op_applytype:
							case Op.op_newobject:
							case Op.op_newarray:
								//ARGS u30
								code=new Code_u30_Args(initByXML_getArgsByReg(str,argsReg));
							break;
							case Op.op_ifnlt:
							case Op.op_ifnle:
							case Op.op_ifngt:
							case Op.op_ifnge:
							case Op.op_jump:
							case Op.op_iftrue:
							case Op.op_iffalse:
							case Op.op_ifeq:
							case Op.op_ifne:
							case Op.op_iflt:
							case Op.op_ifle:
							case Op.op_ifgt:
							case Op.op_ifge:
							case Op.op_ifstricteq:
							case Op.op_ifstrictne:
								//BRANCH s24
								labelMark=labelMarkMark[str+":"];
								if(labelMark){
									code=new Code_Branch(labelMark);
								}else{
									throw new Error("labelMark="+labelMark);
								}
							break;
							case Op.op_pushbyte:
								//VALUE_BYTE u8
								code=new Code_Byte(int(str));
							break;
							case Op.op_pushshort:
							case Op.op_debugline:
							case Op.op_bkptline:
								//VALUE_INT u30
								var _int:int=int(str);
								if(str==_int.toString()){
									code=new Code_u30_Int(_int);
								}else{
									throw new Error("str="+str);
								}
							break;
							case Op.op_lookupswitch:
								//s24 //u30 //s24 //s24...
								var default_labelMark:LabelMark=labelMarkMark[str.match(defaultLabelReg)[0].replace(defaultLabelReg,"$1:")];
								if(default_labelMark){
									var caseLabelStrArr:Array=str.match(caseLabelReg)[0].replace(caseLabelReg,"$1").split(",");
									var case_labelMark_v:Vector.<LabelMark>=new Vector.<LabelMark>();
									for each(var caseLabelStr:String in caseLabelStrArr){
										var case_LabelMark:LabelMark=labelMarkMark[caseLabelStr+":"];
										if(case_LabelMark){
											case_labelMark_v[case_labelMark_v.length]=case_LabelMark;
										}else{
											throw new Error("case_LabelMark="+case_LabelMark);
										}
									}
								}else{
									throw new Error("default_labelMark="+default_labelMark);
								}
								code=new Code_Lookupswitch(default_labelMark,case_labelMark_v);
							break;
							case Op.op_hasnext2:
								//uint //uint ?(后被证实是俩Register的id(u30, u30))
								var regArr:Array=str.replace(/\s+/," ").split(" ");
								var object_regStr:String=regArr[0];
								var index_regStr:String=regArr[1];
								var object_reg:int=int(object_regStr);
								var index_reg:int=int(index_regStr);
								if(
									object_reg.toString()==object_regStr
									&&
									index_reg.toString()==index_regStr
								){
									code=new Code_u30_u30_Hasnext2(object_reg,index_reg);
								}else{
									throw new Error("object_regStr="+object_regStr+",index_regStr="+index_regStr);
								}
							break;
							/*
							case Op.op_abs_jump:
								//u30 u30 (INDEX_ARGS?)
								index=UGetterAndSetter.getU(data,offset);
								offset=UGetterAndSetter.offset;
								args=UGetterAndSetter.getU(data,offset);
								offset=UGetterAndSetter.offset;
								code=new Code_u30_u30_Multiname_Args(index,args);
							break;
							*/
							case Op.op_debug:
								//ubyte //u30 //ubyte //u30
								var debug_typeStr:String=str.replace(debugReg,"$1");
								var debug_type:int=int(debug_typeStr);
								if(debug_typeStr==debug_type.toString()){
									var string:String=str.replace(debugReg,"$2");
									string=new XML("<string value="+string+"/>").@value.toString();
									var regStr:String=str.replace(debugReg,"$3");
									var reg:int=int(regStr);
									if(regStr==reg.toString()){
										var extraStr:String=str.replace(debugReg,"$4");
										var extra:int=int(extraStr);
										if(extraStr==extra.toString()){
											code=new Code_Debug();
											var code_debug:Code_Debug=code as Code_Debug;
											code_debug.debug_type=debug_type;
											code_debug.string=string;
											code_debug.reg=reg;
											code_debug.extra=extra;
										}else{
											throw new Error("extraStr="+extraStr);
										}
									}else{
										throw new Error("regStr="+regStr);
									}
								}else{
									throw new Error("debug_typeStr="+debug_typeStr);
								}
							break;
							default:
								throw new Error("unknown op: "+op+"("+Op.op_v[op]+")");
							break;
						}
						if(code){
							code.op=op;
							codeArr[codeArr.length]=code;
						}
					}else{
						//单个的 op
						op=Op["op_"+str];
						switch(op){
							case Op.op_bkpt:
							case Op.op_nop:
							case Op.op_throw:
							case Op.op_dxnslate:
							case Op.op_label:
							case Op.op_pushwith:
							case Op.op_popscope:
							case Op.op_nextname:
							case Op.op_hasnext:
							case Op.op_pushnull:
							case Op.op_pushundefined:
							case Op.op_nextvalue:
							case Op.op_pushtrue:
							case Op.op_pushfalse:
							case Op.op_pushnan:
							case Op.op_pop:
							case Op.op_dup:
							case Op.op_swap:
							case Op.op_pushscope:
							case Op.op_li8:
							case Op.op_li16:
							case Op.op_li32:
							case Op.op_lf32:
							case Op.op_lf64:
							case Op.op_si8:
							case Op.op_si16:
							case Op.op_si32:
							case Op.op_sf32:
							case Op.op_sf64:
							case Op.op_returnvoid:
							case Op.op_returnvalue:
							case Op.op_sxi1:
							case Op.op_sxi8:
							case Op.op_sxi16:
							case Op.op_newactivation:
							case Op.op_getglobalscope:
							case Op.op_convert_s:
							case Op.op_esc_xelem:
							case Op.op_esc_xattr:
							case Op.op_convert_i:
							case Op.op_convert_u:
							case Op.op_convert_d:
							case Op.op_convert_b:
							case Op.op_convert_o:
							case Op.op_checkfilter:
							case Op.op_coerce_b:
							case Op.op_coerce_a:
							case Op.op_coerce_i:
							case Op.op_coerce_d:
							case Op.op_coerce_s:
							case Op.op_astypelate:
							case Op.op_coerce_u:
							case Op.op_coerce_o:
							case Op.op_negate:
							case Op.op_increment:
							case Op.op_decrement:
							case Op.op_typeof:
							case Op.op_not:
							case Op.op_bitnot:
							case Op.op_add:
							case Op.op_subtract:
							case Op.op_multiply:
							case Op.op_divide:
							case Op.op_modulo:
							case Op.op_lshift:
							case Op.op_rshift:
							case Op.op_urshift:
							case Op.op_bitand:
							case Op.op_bitor:
							case Op.op_bitxor:
							case Op.op_equals:
							case Op.op_strictequals:
							case Op.op_lessthan:
							case Op.op_lessequals:
							case Op.op_greaterthan:
							case Op.op_greaterequals:
							case Op.op_instanceof:
							case Op.op_istypelate:
							case Op.op_in:
							case Op.op_increment_i:
							case Op.op_decrement_i:
							case Op.op_negate_i:
							case Op.op_add_i:
							case Op.op_subtract_i:
							case Op.op_multiply_i:
							case Op.op_getlocal0:
							case Op.op_getlocal1:
							case Op.op_getlocal2:
							case Op.op_getlocal3:
							case Op.op_setlocal0:
							case Op.op_setlocal1:
							case Op.op_setlocal2:
							case Op.op_setlocal3:
							case Op.op_timestamp:
								codeArr[codeArr.length]=op;
							break;
							default:
								throw new Error("不是简单op: "+str);
							break;
						}
					}
				}
			}
		}
		/*
		public function toXML(xmlName:String):XML{
			var xml:XML=new XML("<"+xmlName+"/>");
			for each(var code:* in codeArr){
				if(code is CodeObj){
					xml.appendChild((code as IClassObj).toXML(""));
				}else if(code is int){
					xml.appendChild(new XML("<"+Op.op_v[code]+"/>"));
				}else{
					xml.appendChild(<unknown code={code}/>);
				}
			}
			return xml;
		}
		*/
		public function toInfo():*{
			var codes:BytesData=new BytesData();
			var data:ByteArray=new ByteArray();
			var code_baseBranch_v:Vector.<Code_BaseBranch>=new Vector.<Code_BaseBranch>();
			var code_baseBranch:Code_BaseBranch;
			exception_info_v=new Vector.<Exception_info>();
			for each(var code:* in codeArr){
				if(code is CodeObj){
					if(code is BaseMark){
						(code as BaseMark).pos=data.length;
					}else{
						if(code is Code_BaseBranch){
							code_baseBranch=code as Code_BaseBranch;
							code_baseBranch.pos=data.length;
							code_baseBranch_v[code_baseBranch_v.length]=code_baseBranch;
						}else if(code is Code_u30_Catch){
							var classObj_exception_info:ClassObj_Exception_info=(code as Code_u30_Catch).catch_;
							classObj_exception_info.id=exception_info_v.length;
							exception_info_v[classObj_exception_info.id]=classObj_exception_info.toInfo();
						}
						(code as ICodeObj).getData(data);
					}
				}else if(code is int){
					data[data.length]=code;
				}else{
					throw new Error(String(code));
				}
			}
			for each(code_baseBranch in code_baseBranch_v){
				code_baseBranch.writeOffsetsToPos(data);
			}
			codes.updateData(data);
			if(exception_info_v.length>0){
			}else{
				exception_info_v=null;
			}
			return codes;
		}
		public function putObjsInLists():void{}
		public function putMethodsInList():void{}
		public function putStrsInList():void{}
		public function doStrByType():void{}
		//
		public function forEachRunFun(funName:String):void{
			super.forEachRunFun(funName);
			for each(var code:* in codeArr){
				if(code is CodeObj){
					(code as CodeObj).forEachRunFun(funName);
				}else if(code is int){
					
				}else{
					throw new Error("code="+code);
				}
			}
		}
		/*
		public static function getTestData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			for(var byte:int=0;byte<256;byte++){
				data[offset++]=byte;
				var op:String=Op.op_v[byte];
				if(op){
					switch(byte){
						case Op.op_debug:
							//ubyte //u30 //ubyte //u30
							data[offset++]=0x80;
							
							data[offset++]=0x80;
							data[offset++]=0x01;
							
							data[offset++]=0x80;
							
							data[offset++]=0x80;
							data[offset++]=0x01;
						break;
						case Op.op_hasnext2:
							//uint //uint ?
							data[offset++]=0x02;
							data[offset++]=0x01;
							data[offset++]=0x00;
							data[offset++]=0x00;
							
							data[offset++]=0x02;
							data[offset++]=0x01;
							data[offset++]=0x00;
							data[offset++]=0x00;
						break;
						case Op.op_lookupswitch:
							//s24 //u30 //s24 //s24...
							data[offset++]=0x02;
							data[offset++]=0x01;
							data[offset++]=0x00;
							
							data[offset++]=0x80;
							data[offset++]=0x01;
							
							for(var i:int=0;i<0x81;i++){//0x81=(000 0000) + ((000 0001)<<7) + 1
								data[offset++]=i;
								data[offset++]=0x00;
								data[offset++]=0x00;
							}
						break;
						default:
							var node:XML=Op.op_xml[op][0];
							switch(node.@type.toString()){
								case "SIMPLE":
								case "PROFILING":
								break;
								case "INDEX":
								case "ARGS":
								case "SLOTINDEX":
								case "VALUE_INT":
									//u30
									data[offset++]=0x80;
									data[offset++]=0x01;
								break;
								case "VALUE_BYTE":
									//byte
									data[offset++]=0x80;
								break;
								case "INDEX_ARGS":
									//u30 u30
									data[offset++]=0x80;
									data[offset++]=0x01;
									
									data[offset++]=0x80;
									data[offset++]=0x01;
								break;
								case "BRANCH":
									//s24
									data[offset++]=0x80;
									data[offset++]=0x01;
									data[offset++]=0x00;
								break;
								default:
									//未知
									data[offset++]=0x00;
									data[offset++]=0x00;
									data[offset++]=0x00;
								break;
							}
						break;
					}
				}
			}
			return data;
		}
		*/
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/
