/***
ABCMethod
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 13:38:25
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
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

package zero.swf.avm2{
	import flash.utils.Dictionary;
	
	import zero.ComplexString;
	import zero.swf.BytesData;

	public class ABCMethod{
		public var return_type:ABCMultiname;
		public var param_typeV:Vector.<ABCMultiname>;
		public var name:String;
		public var NeedArguments:Boolean;
		public var NeedActivation:Boolean;
		public var NeedRest:Boolean;
		public var SetDxns:Boolean;
		public var optionV:Vector.<ABCConstantItem>;
		public var param_nameV:Vector.<String>;
		public var max_stack:int;
		public var local_count:int;
		public var init_scope_depth:int;
		public var max_scope_depth:int;
		public var codes:AVM2Codes;
		public var traitV:Vector.<ABCTrait>;
		//
		public function initByInfo(
			method_info:Method_info,
			method_body_info:Method_body_info,
			integerV:Vector.<int>,
			uintegerV:Vector.<int>,
			doubleV:Vector.<Number>,
			stringV:Vector.<String>,
			allNsV:Vector.<ABCNamespace>,
			allMultinameV:Vector.<ABCMultiname>,
			allMethodV:Vector.<ABCMethod>,
			allMetadataV:Vector.<ABCMetadata>,
			classV:Vector.<ABCClass>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			var i:int;
			
			//The return_type field is an index into the multiname array of the constant pool; the name at that entry
			//provides the name of the return type of this method. A zero value denotes the any ("*") type.
			//return_type 是在 constant_pool.multiname_info_v 中的id
			return_type=allMultinameV[method_info.return_type];//allMultinameV[0]==null
			
			//Each entry in the param_type array is an index into the multiname
			//array of the constant pool; the name at that entry provides the name of the type of the corresponding
			//formal parameter. A zero value denotes the any ("*") type.
			//param_type 是在 constant_pool.multiname_info_v 中的id
			//0 表示 任意类型 "*"
			i=-1;
			param_typeV=new Vector.<ABCMultiname>();
			for each(var param_type:int in method_info.param_typeV){
				i++;
				param_typeV[i]=allMultinameV[param_type];//allMultinameV[0]==null
			}
			
			//The name field is an index into the string array of the constant pool; the string at that entry provides the
			//name of this method. If the index is zero, this method has no name.
			//name 是在 constant_pool.string_v 中的id
			//0 表示 method没有名字(不是函数名而是类似DoABC的Name的一个没有什么意义的东西)
			name=stringV[method_info.name];//stringV[0]==null
			
			//The flag field is a bit vector that provides additional information about the method. The bits are
			//described by the following table. (Bits not described in the table should all be set to zero.)
			//Name 				Value 	Meaning
			//NEED_ARGUMENTS 	0x01 	Suggests to the run-time that an "arguments" object (as specified by the ActionScript 3.0 Language Reference) be created. Must not be used together with NEED_REST. See Chapter 3.
			//NEED_ACTIVATION 	0x02 	Must be set if this method uses the newactivation opcode.
			//NEED_REST 		0x04 	This flag creates an ActionScript 3.0 rest arguments array. Must not be used with NEED_ARGUMENTS. See Chapter 3.
			//HAS_OPTIONAL 		0x08 	Must be set if this method has optional parameters and the options field is present in this method_info structure.
			//SET_DXNS 			0x40 	Must be set if this method uses the dxns or dxnslate opcodes.
			//HAS_PARAM_NAMES 	0x80 	Must be set when the param_names field is present in this method_info structure.
			NeedArguments=method_info.NeedArguments;
			NeedActivation=method_info.NeedActivation;
			NeedRest=method_info.NeedRest;
			SetDxns=method_info.SetDxns;
			
			//This entry may be present only if the HAS_OPTIONAL flag is set in flags.
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
			if(method_info.option_detailV){
				if(method_info.option_detailV.length){
					i=-1;
					optionV=new Vector.<ABCConstantItem>();
					for each(var option_detail:Option_detail in method_info.option_detailV){
						i++;
						optionV[i]=new ABCConstantItem();
						optionV[i].initByInfo(
							option_detail.kind,
							option_detail.val,
							integerV,
							uintegerV,
							doubleV,
							stringV,
							allNsV,
							_initByDataOptions
						);
					}
				}else{
					optionV=null;
				}
			}else{
				optionV=null;
			}
			
			//The param_names entry is available only when the HAS_PARAM_NAMES bit is set in the flags. Each param_info
			//element of the array is an index into the constant pool's string array. The parameter name entry exists solely
			//for external tool use and is not used by the AVM2.
			if(method_info.param_nameV){
				if(method_info.param_nameV.length){
					i=-1;
					param_nameV=new Vector.<String>();
					for each(var param_name:int in method_info.param_nameV){
						i++;
						param_nameV[i]=stringV[param_name];//stringV[0]==null
					}
				}
			}else{
				param_nameV=null;
			}
			
			if(method_body_info){
				//The max_stack field is maximum number of evaluation stack slots used at any point during the execution
				//of this body.
				max_stack=method_body_info.max_stack;
				
				//The local_count field is the index of the highest-numbered local register this method will use, plus one.
				local_count=method_body_info.local_count;
				
				//The init_scope_depth field defines the minimum scope depth, relative to max_scope_depth, that may
				//be accessed within the method.
				init_scope_depth=method_body_info.init_scope_depth;
				
				//The max_scope_depth field defines the maximum scope depth that may be accessed within the method.
				//The difference between max_scope_depth and init_scope_depth determines the size of the local scope
				//stack.
				max_scope_depth=method_body_info.max_scope_depth;
				
				//The value of exception_count is the number of elements in the exception array. The exception array
				//associates exception handlers with ranges of instructions within the code array (see below).
				
				//The value of code_length is the number of bytes in the code array. The code array holds AVM2
				//instructions for this method body. The AVM2 instruction set is defined in Section 2.5.
				codes=new AVM2Codes();
				codes.initByInfo(
					method_body_info.codes.toData(null),
					method_body_info.exception_infoV,
					integerV,
					uintegerV,
					doubleV,
					stringV,
					allNsV,
					allMultinameV,
					allMethodV,
					classV,
					_initByDataOptions
				);
				
				
				import flash.utils.ByteArray;
				import zero.BytesAndStr16;
				import zero.output;
				import zero.swf.codes.*;
				
				var paramLocalNum:int,code:*;
				
				if(_initByDataOptions.removeAVM2JunkCodes){//20110906
					if(codes.codeArr.length){
						
						var oldCodeArr:Array=codes.codeArr;
						
						paramLocalNum=param_typeV.length+1;
						if(NeedArguments||NeedRest){
							paramLocalNum++;
						}
						
						codes.codeArr=_initByDataOptions.removeAVM2JunkCodes(codes.codeArr,paramLocalNum,_initByDataOptions.removeAVM2JunkCodesFun);
						if(codes.hexArr){
							var newHexArr:Array=new Array();
							var codeId:int=-1;
							for each(code in codes.codeArr){
								codeId++;
								switch(code.constructor){
									case LabelMark:
										break;
									case Array:
									case ByteArray:
										//throw new Error("暂不支持");
									break;
									case Code:
										newHexArr[codeId]=codes.hexArr[oldCodeArr.indexOf(code)];
									break;
									default://int
										newHexArr[codeId]=BytesAndStr16._16V[code];
									break;
								}
							}
							codes.hexArr=newHexArr;
						}
					}
				}
				if(_initByDataOptions.autoCountLocalCountAndMaxStack){//20111104
					if(codes.codeArr.length){
						
						paramLocalNum=param_typeV.length+1;
						if(NeedArguments||NeedRest){
							paramLocalNum++;
						}
						
						var real_local_count:int=paramLocalNum;
						
						if(real_local_count<1){
							real_local_count=1;
						}
						
						for each(code in codes.codeArr){
							switch(code.constructor){
								case LabelMark:
								break;
								case Array:
								case ByteArray:
									//throw new Error("暂不支持");
								break;
								case Code:
									switch(code.op){
										case AVM2Ops.getlocal:
										case AVM2Ops.setlocal:
										case AVM2Ops.inclocal:
										case AVM2Ops.declocal:
										case AVM2Ops.inclocal_i:
										case AVM2Ops.declocal_i:
										case AVM2Ops.kill:
											if(real_local_count<=code.value){
												real_local_count=code.value+1;
											}
										break;
										case AVM2Ops.hasnext2:
											if(real_local_count<=code.value.register1){
												real_local_count=code.value.register1+1;
											}
											if(real_local_count<=code.value.register2){
												real_local_count=code.value.register2+1;
											}
										break;
										case AVM2Ops.debug:
											if(real_local_count<=code.value.reg){
												real_local_count=code.value.reg+1;
											}
										break;
										default:
											//
										break;
									}
								break;
								default://int
									switch(code){
										//case AVM2Ops.getlocal0:
										//case AVM2Ops.setlocal0:
										//	if(real_local_count<=0){
										//		real_local_count=1;
										//	}
										//break;
										case AVM2Ops.getlocal1:
										case AVM2Ops.setlocal1:
											if(real_local_count<=1){
												real_local_count=2;
											}
										break;
										case AVM2Ops.getlocal2:
										case AVM2Ops.setlocal2:
											if(real_local_count<=2){
												real_local_count=3;
											}
										break;
										case AVM2Ops.getlocal3:
										case AVM2Ops.setlocal3:
											if(real_local_count<=3){
												real_local_count=4;
											}
										break;
										default:
											//
										break;
									}
								break;
							}
						}
						
						if(local_count>real_local_count){
							output("local_count="+local_count+" > real_local_count="+real_local_count+"，已修正","brown");
							local_count=real_local_count;
						}else if(local_count<real_local_count){
							output("local_count="+local_count+" < real_local_count="+real_local_count+"，已修正","brown");
							local_count=real_local_count;
						}
					}
				}
				
				//The value of trait_count is the number of elements in the trait array. The trait array contains all
				//the traits for this method body (see above for more information on traits).
				i=-1;
				traitV=new Vector.<ABCTrait>();
				for each(var traits_info:Traits_info in method_body_info.traits_infoV){
					i++;
					traitV[i]=new ABCTrait();
					traitV[i].initByInfo(
						traits_info,
						integerV,
						uintegerV,
						doubleV,
						stringV,
						allNsV,
						allMultinameV,
						allMethodV,
						allMetadataV,
						classV,
						_initByDataOptions
					);
				}
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//The return_type field is an index into the multiname array of the constant pool; the name at that entry
			//provides the name of the return type of this method. A zero value denotes the any ("*") type.
			//return_type 是在 constant_pool.multiname_info_v 中的id
			productMark.productMultiname(return_type);
			
			//Each entry in the param_type array is an index into the multiname
			//array of the constant pool; the name at that entry provides the name of the type of the corresponding
			//formal parameter. A zero value denotes the any ("*") type.
			//param_type 是在 constant_pool.multiname_info_v 中的id
			//0 表示 任意类型 "*"
			for each(var param_type:ABCMultiname in param_typeV){
				productMark.productMultiname(param_type);
			}
			
			//The name field is an index into the string array of the constant pool; the string at that entry provides the
			//name of this method. If the index is zero, this method has no name.
			//name 是在 constant_pool.string_v 中的id
			//0 表示 method没有名字(不是函数名而是类似DoABC的Name的一个没有什么意义的东西)
			productMark.productString(name);
			
			//This entry may be present only if the HAS_OPTIONAL flag is set in flags.
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
			if(optionV){
				for each(var option:ABCConstantItem in optionV){
					option.getInfo_product(productMark);
				}
			}
			
			//The param_names entry is available only when the HAS_PARAM_NAMES bit is set in the flags. Each param_info
			//element of the array is an index into the constant pool's string array. The parameter name entry exists solely
			//for external tool use and is not used by the AVM2.
			if(param_nameV){
				for each(var param_name:String in param_nameV){
					productMark.productString(param_name);
				}
			}
			
			if(codes){
				//The max_stack field is maximum number of evaluation stack slots used at any point during the execution
				//of this body.
				
				//The local_count field is the index of the highest-numbered local register this method will use, plus one.
				
				//The init_scope_depth field defines the minimum scope depth, relative to max_scope_depth, that may
				//be accessed within the method.
				
				//The max_scope_depth field defines the maximum scope depth that may be accessed within the method.
				//The difference between max_scope_depth and init_scope_depth determines the size of the local scope
				//stack.
				
				//The value of exception_count is the number of elements in the exception array. The exception array
				//associates exception handlers with ranges of instructions within the code array (see below).
				
				//The value of code_length is the number of bytes in the code array. The code array holds AVM2
				//instructions for this method body. The AVM2 instruction set is defined in Section 2.5.
				codes.getInfo_product(productMark);
				
				//The value of trait_count is the number of elements in the trait array. The trait array contains all
				//the traits for this method body (see above for more information on traits).
				for each(var trait:ABCTrait in traitV){
					trait.getInfo_product(productMark);
				}
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Array{
			var i:int,arr:Array;
			
			var method_info:Method_info=new Method_info();
			
			//The return_type field is an index into the multiname array of the constant pool; the name at that entry
			//provides the name of the return type of this method. A zero value denotes the any ("*") type.
			//return_type 是在 constant_pool.multiname_info_v 中的id
			method_info.return_type=productMark.getMultinameId(return_type);
			
			//Each entry in the param_type array is an index into the multiname
			//array of the constant pool; the name at that entry provides the name of the type of the corresponding
			//formal parameter. A zero value denotes the any ("*") type.
			//param_type 是在 constant_pool.multiname_info_v 中的id
			//0 表示 任意类型 "*"
			i=-1;
			method_info.param_typeV=new Vector.<int>();
			for each(var param_type:ABCMultiname in param_typeV){
				i++;
				method_info.param_typeV[i]=productMark.getMultinameId(param_type);
			}
			
			//The name field is an index into the string array of the constant pool; the string at that entry provides the
			//name of this method. If the index is zero, this method has no name.
			//name 是在 constant_pool.string_v 中的id
			//0 表示 method没有名字(不是函数名而是类似DoABC的Name的一个没有什么意义的东西)
			method_info.name=productMark.getStringId(name);
			
			//The flag field is a bit vector that provides additional information about the method. The bits are
			//described by the following table. (Bits not described in the table should all be set to zero.)
			//Name 				Value 	Meaning
			//NEED_ARGUMENTS 	0x01 	Suggests to the run-time that an "arguments" object (as specified by the ActionScript 3.0 Language Reference) be created. Must not be used together with NEED_REST. See Chapter 3.
			//NEED_ACTIVATION 	0x02 	Must be set if this method uses the newactivation opcode.
			//NEED_REST 		0x04 	This flag creates an ActionScript 3.0 rest arguments array. Must not be used with NEED_ARGUMENTS. See Chapter 3.
			//HAS_OPTIONAL 		0x08 	Must be set if this method has optional parameters and the options field is present in this method_info structure.
			//SET_DXNS 			0x40 	Must be set if this method uses the dxns or dxnslate opcodes.
			//HAS_PARAM_NAMES 	0x80 	Must be set when the param_names field is present in this method_info structure.
			method_info.NeedArguments=NeedArguments;
			method_info.NeedActivation=NeedActivation;
			method_info.NeedRest=NeedRest;
			method_info.SetDxns=SetDxns;
			
			//This entry may be present only if the HAS_OPTIONAL flag is set in flags.
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
			if(optionV){
				if(optionV.length){
					i=-1;
					method_info.option_detailV=new Vector.<Option_detail>();
					for each(var option:ABCConstantItem in optionV){
						i++;
						method_info.option_detailV[i]=new Option_detail();
						arr=option.getInfo(productMark,_toDataOptions);
						method_info.option_detailV[i].val=arr[1];
						method_info.option_detailV[i].kind=arr[0];
					}
				}else{
					method_info.option_detailV=null;
				}
			}else{
				method_info.option_detailV=null;
			}
			
			//The param_names entry is available only when the HAS_PARAM_NAMES bit is set in the flags. Each param_info
			//element of the array is an index into the constant pool's string array. The parameter name entry exists solely
			//for external tool use and is not used by the AVM2.
			if(param_nameV){
				if(param_nameV.length){
					i=-1;
					method_info.param_nameV=new Vector.<int>();
					for each(var param_name:String in param_nameV){
						i++;
						method_info.param_nameV[i]=productMark.getStringId(param_name);
					}
				}else{
					method_info.param_nameV=null;
				}
			}else{
				method_info.param_nameV=null;
			}
			
			var method_body_info:Method_body_info;
			if(codes){
				method_body_info=new Method_body_info();
				
				method_body_info.method=productMark.getMethodId(this);
				
				//The max_stack field is maximum number of evaluation stack slots used at any point during the execution
				//of this body.
				method_body_info.max_stack=max_stack;
				
				//The local_count field is the index of the highest-numbered local register this method will use, plus one.
				method_body_info.local_count=local_count;
				
				//The init_scope_depth field defines the minimum scope depth, relative to max_scope_depth, that may
				//be accessed within the method.
				method_body_info.init_scope_depth=init_scope_depth;
				
				//The max_scope_depth field defines the maximum scope depth that may be accessed within the method.
				//The difference between max_scope_depth and init_scope_depth determines the size of the local scope
				//stack.
				method_body_info.max_scope_depth=max_scope_depth;
				
				//The value of code_length is the number of bytes in the code array. The code array holds AVM2
				//instructions for this method body. The AVM2 instruction set is defined in Section 2.5.
				arr=codes.getInfo(productMark,_toDataOptions);
				method_body_info.codes=new BytesData();
				method_body_info.codes.initByData(arr[0],0,arr[0].length,null);
				
				//The value of exception_count is the number of elements in the exception array. The exception array
				//associates exception handlers with ranges of instructions within the code array (see below).
				method_body_info.exception_infoV=arr[1];
				
				//The value of trait_count is the number of elements in the trait array. The trait array contains all
				//the traits for this method body (see above for more information on traits).
				i=-1;
				method_body_info.traits_infoV=new Vector.<Traits_info>();
				for each(var trait:ABCTrait in traitV){
					i++;
					method_body_info.traits_infoV[i]=trait.getInfo(productMark,_toDataOptions);
				}
			}else{
				method_body_info=null;
			}
			
			return [method_info,method_body_info];
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,methodNameMarkStr:String,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			
			//主要用作 AVM2Codes.toXMLAndMark() 时获取 markStr
			if(markStrs.markStrDict[this]){
			}else{
				var methodMarkStr:String="function";
				if(methodNameMarkStr){
					methodMarkStr+=" "+methodNameMarkStr;
				}
				methodMarkStr+="()";
				
				if(name is String){
					if(name){
						methodMarkStr+=" "+ComplexString.ext.escape(name);
					}
				}else{
					methodMarkStr+="(name=undefined)";
				}
				
				//计算 copyId
				if(markStrs.methodMark["~"+methodMarkStr]){
					var copyId:int=1;
					while(markStrs.methodMark["~"+methodMarkStr+"("+(++copyId)+")"]){};
					methodMarkStr+="("+copyId+")";
				}
				//
				
				markStrs.methodMark["~"+methodMarkStr]=this;
				markStrs.markStrDict[this]=methodMarkStr;
			}
			//
			
			var xml:XML=<{xmlName}/>;
			
			if(return_type){
				xml.appendChild(return_type.toXMLAndMark(markStrs,"return_type",_toXMLOptions));
			}
			
			if(param_typeV.length){
				var param_typeListXML:XML=<param_typeList count={param_typeV.length}/>
				for each(var param_type:ABCMultiname in param_typeV){
					if(param_type){
						param_typeListXML.appendChild(param_type.toXMLAndMark(markStrs,"param_type",_toXMLOptions));
					}else{
						param_typeListXML.appendChild(<param_type/>);
					}
				}
				xml.appendChild(param_typeListXML);
			}
			
			if(name is String){
				xml.@name=name;
			}
			
			xml.@NeedArguments=NeedArguments;
			xml.@NeedActivation=NeedActivation;
			xml.@NeedRest=NeedRest;
			xml.@SetDxns=SetDxns;
					
			if(optionV){
				if(optionV.length){
					var optionListXML:XML=<optionList count={optionV.length}/>
					for each(var option:ABCConstantItem in optionV){
						optionListXML.appendChild(option.toXMLAndMark(markStrs,"option",_toXMLOptions));
					}
					xml.appendChild(optionListXML);
				}
			}
			
			if(param_nameV){
				if(param_nameV.length){
					var param_nameListXML:XML=<param_nameList count={param_nameV.length}/>
					for each(var param_name:String in param_nameV){
						if(param_name is String){
							param_nameListXML.appendChild(<param_name value={param_name}/>);
						}else{
							param_nameListXML.appendChild(<param_name/>);
						}
					}
					xml.appendChild(param_nameListXML);
				}
			}
			
			if(codes){
				xml.@max_stack=max_stack;
				
				xml.@local_count=local_count;
				
				xml.@init_scope_depth=init_scope_depth;
				
				xml.@max_scope_depth=max_scope_depth;
				
				xml.appendChild(codes.toXMLAndMark(markStrs,"codes",_toXMLOptions));
				
				if(traitV.length){
					var traitListXML:XML=<traitList count={traitV.length}/>
					for each(var trait:ABCTrait in traitV){
						traitListXML.appendChild(trait.toXMLAndMark(markStrs,"trait",_toXMLOptions));
					}
					xml.appendChild(traitListXML);
				}
			}
			
			return xml;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var i:int;
			
			var return_typeXML:XML=xml.return_type[0];
			if(return_typeXML){
				return_type=ABCMultiname.xml2multiname(markStrs,return_typeXML,_initByXMLOptions);
			}else{
				return_type=null;
			}
			
			i=-1;
			param_typeV=new Vector.<ABCMultiname>();
			for each(var param_typeXML:XML in xml.param_typeList.param_type){
				i++;
				if(param_typeXML.toXMLString()=="<param_type/>"){
					param_typeV[i]=null;
				}else{
					param_typeV[i]=ABCMultiname.xml2multiname(markStrs,param_typeXML,_initByXMLOptions);
				}
			}
			
			var nameXML:XML=xml.@name[0];
			if(nameXML){
				name=nameXML.toString();
			}else{
				name=null;
			}
			
			NeedArguments=(xml.@NeedArguments.toString()=="true");
			NeedActivation=(xml.@NeedActivation.toString()=="true");
			NeedActivation=(xml.@NeedActivation.toString()=="true");
			NeedRest=(xml.@NeedRest.toString()=="true");
			
			var optionXMLList:XMLList=xml.optionList.option;
			if(optionXMLList.length()){
				i=-1;
				optionV=new Vector.<ABCConstantItem>();
				for each(var optionXML:XML in optionXMLList){
					i++;
					optionV[i]=new ABCConstantItem();
					optionV[i].initByXMLAndMark(markStrs,optionXML,_initByXMLOptions);
				}
			}else{
				optionV=null;
			}
			
			var param_nameXMLList:XMLList=xml.param_nameList.param_name;
			if(param_nameXMLList.length()){
				i=-1;
				param_nameV=new Vector.<String>();
				for each(var param_nameXML:XML in param_nameXMLList){
					i++;
					if(param_nameXML.toXMLString()=="<param_name/>"){
						param_nameV[i]=null;
					}else{
						param_nameV[i]=param_nameXML.@value.toString();
					}
				}
			}else{
				param_nameV=null;
			}
			
			var codesXML:XML=xml.codes[0];
			if(codesXML){
				max_stack=int(xml.@max_stack.toString());
				
				local_count=int(xml.@local_count.toString());
				
				init_scope_depth=int(xml.@init_scope_depth.toString());
				
				max_scope_depth=int(xml.@max_scope_depth.toString());
				
				codes=new AVM2Codes();
				codes.initByXMLAndMark(markStrs,codesXML,_initByXMLOptions);
				
				i=-1;
				traitV=new Vector.<ABCTrait>();
				for each(var traitXML:XML in xml.traitList.trait){
					i++;
					traitV[i]=new ABCTrait();
					traitV[i].initByXMLAndMark(markStrs,traitXML,_initByXMLOptions);
				}
			}
		}
		}//end of CONFIG::USE_XML
	}
}	