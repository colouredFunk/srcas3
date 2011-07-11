/***
AVM2Codes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:28:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import zero.BytesAndStr16;
	import zero.Outputer;
	import zero.ZeroCommon;

	public class AVM2Codes{
		private var hexArr:Array;//只用于 toXML 20110528
		public var codeArr:Array;
		//
		public function initByInfo(
			data:ByteArray,
			exception_infoV:Vector.<Exception_info>,
			integerV:Vector.<int>,
			uintegerV:Vector.<int>,
			doubleV:Vector.<Number>,
			stringV:Vector.<String>,
			allNsV:Vector.<ABCNamespace>,
			allMultinameV:Vector.<ABCMultiname>,
			allMethodV:Vector.<ABCMethod>,
			classV:Vector.<ABCClass>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			
			var labelId:int=0;
			var labelMarkArr:Array=new Array();
			var codeByOffsetArr:Array=new Array();
			if(_initByDataOptions&&_initByDataOptions.ABCFileGetHexArr){
				var hexByOffsetArr:Array=new Array();
			}
			var code:*;
			
			var labelMark:AVM2LabelMark;
			var u30_1:int,u30_2:int,jumpOffset:int,jumpPos:int,i:int;
			
			var offset:int=0;
			var endOffset:int=data.length;
			
			var exceptionArr:Array=new Array();
			
			while(offset<endOffset){
				var pos:int=offset;
				var op:int=data[offset++];
				var opDataType:String=AVM2Ops.opDataTypeV[op];
				
				if(opDataType){
					if(opDataType==AVM2Ops.dataType_u8){
						codeByOffsetArr[pos]=op;
					}else{
						switch(opDataType){
							case AVM2Ops.dataType_u8_u8:
								
								//AVM2Ops.type_u8_u8__value_byte
								code=new AVM2Code(op,data[offset++]);
							break;
							case AVM2Ops.dataType_u8_u30:
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
								//u30_1
								switch(AVM2Ops.opTypeV[op]){
									case AVM2Ops.type_u8_u30__value_int:
									case AVM2Ops.type_u8_u30__scope:
									case AVM2Ops.type_u8_u30__slot:
									case AVM2Ops.type_u8_u30__register:
									case AVM2Ops.type_u8_u30__args:
										code=new AVM2Code(op,u30_1);
									break;
									case AVM2Ops.type_u8_u30__int:
										code=new AVM2Code(op,integerV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__uint:
										code=new AVM2Code(op,uintegerV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__double:
										code=new AVM2Code(op,doubleV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__string:
										code=new AVM2Code(op,stringV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__namespace_info:
										code=new AVM2Code(op,allNsV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__multiname_info:
										code=new AVM2Code(op,allMultinameV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__method:
										//只有 newfunction
										code=new AVM2Code(op,allMethodV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__class:
										code=new AVM2Code(op,classV[u30_1]);
									break;
									case AVM2Ops.type_u8_u30__exception_info:
										var exception:ABCException=exceptionArr[u30_1];
										if(exception){
											Outputer.output("重复使用的 exception","brown");
										}else{
											var exception_info:Exception_info=exception_infoV[u30_1];
											
											exceptionArr[u30_1]=exception=new ABCException();
											exception.initByInfo(exception_info,allMultinameV,_initByDataOptions);
											
											labelMark=labelMarkArr[exception_info.from];
											if(labelMark){
											}else{
												labelMarkArr[exception_info.from]=labelMark=new AVM2LabelMark();
												labelMark.labelId=labelId++;
											}
											exception.from=labelMark;
											
											labelMark=labelMarkArr[exception_info.to];
											if(labelMark){
											}else{
												labelMarkArr[exception_info.to]=labelMark=new AVM2LabelMark();
												labelMark.labelId=labelId++;
											}
											exception.to=labelMark;
											
											labelMark=labelMarkArr[exception_info.target];
											if(labelMark){
											}else{
												labelMarkArr[exception_info.target]=labelMark=new AVM2LabelMark();
												labelMark.labelId=labelId++;
											}
											exception.target=labelMark;
										}
										code=new AVM2Code(op,exception);
									break;
									case AVM2Ops.type_u8_u30__finddef:
										throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
									break;
								}
							break;
							case AVM2Ops.dataType_u8_u30_u30:
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
								//u30_1
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
								//u30_2
								switch(AVM2Ops.opTypeV[op]){
									case AVM2Ops.type_u8_u30_u30__register_register:
										code=new AVM2Code(op,{
											register1:u30_1,
											register2:u30_2
										});
									break;	
									case AVM2Ops.type_u8_u30_u30__multiname_info_args:
										code=new AVM2Code(op,{
											multiname:allMultinameV[u30_1],
											args:u30_2
										});
									break;
									case AVM2Ops.type_u8_u30_u30__method_args:
										//code=new AVM2Code(op,{
										//	method:advanceABC.getInfoByIdAndMemberType(u30_1,Member.METHOD),
										//	args:u30_2
										//});
										Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
										code=new ByteArray();
										code.writeBytes(data,pos,offset-pos);
										Outputer.output("对未知代码使用 ByteArray 进行记录："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
									break;
								}
							break;
							case AVM2Ops.dataType_u8_s24:
								
								//AVM2Ops.type_u8_s24__branch
								jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
								if(jumpOffset&0x00800000){jumpOffset|=0xff000000}//最高位为1,表示负数
								
								jumpPos=offset+jumpOffset;
								if(jumpPos<0||jumpPos>endOffset){
									if(lastCodeIsReturn(codeByOffsetArr)){
										Outputer.output("return 后面的异常跳转，已忽略 offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset,"green");
										continue;
									}
									Outputer.output("dataType_u8_s24 可能是扰码: offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset+", 跳转命令只允许跳至代码开头和代码末尾之间的位置","brown");
									
									//if(jumpPos<0){
									//	throw new Error("哈哈");
									//}
									
									//if(jumpPos<0){
									//	jumpPos=0;
									//}else{
										jumpPos=endOffset;
									//}
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
									
									//throw new Error("哈哈");
								}
								labelMark=labelMarkArr[jumpPos];
								if(labelMark){
								}else{
									labelMarkArr[jumpPos]=labelMark=new AVM2LabelMark();
									labelMark.labelId=labelId++;
								}
								code=new AVM2Code(op,labelMark);
							break;
							case AVM2Ops.dataType_u8_s24_u30_s24List:
								
								//AVM2Ops.type_u8_s24_u30_s24List__lookupswitch
								
								//The base location is the address of the lookupswitch instruction itself.
								var lookupswitch_startOffset:int=offset-1;
								
								jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
								if(jumpOffset&0x00800000){jumpOffset|=0xff000000}//最高位为1,表示负数
								
								jumpPos=lookupswitch_startOffset+jumpOffset;
								
								if(jumpPos<0||jumpPos>endOffset){
									Outputer.output("dataType_u8_s24_u30_s24List default_offset 可能是扰码: offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset+", 跳转命令只允许跳至代码开头和代码末尾之间的位置","brown");
									
									//if(jumpPos<0){
									//	throw new Error("哈哈");
									//}
									
									//if(jumpPos<0){
									//	jumpPos=0;
									//}else{
										jumpPos=endOffset;
									//}
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
									
									//throw new Error("哈哈");
								}
								labelMark=labelMarkArr[jumpPos];
								if(labelMark){
								}else{
									labelMarkArr[jumpPos]=labelMark=new AVM2LabelMark();
									labelMark.labelId=labelId++;
								}
								code=new AVM2Code(op,{default_offset:labelMark});
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var case_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_count=data[offset++];}
								//case_count
								
								case_count++;
								code.value.case_offsetV=new Vector.<AVM2LabelMark>(case_count);
								for(i=0;i<case_count;i++){
									//AVM2Ops.type_u8_s24_u30_s24List__lookupswitch
									jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
									if(jumpOffset&0x00800000){jumpOffset|=0xff000000}//最高位为1,表示负数
									
									jumpPos=lookupswitch_startOffset+jumpOffset;
									
									if(jumpPos<0||jumpPos>endOffset){
										Outputer.output("dataType_u8_s24_u30_s24List case_offset 可能是扰码: offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset+", 跳转命令只允许跳至代码开头和代码末尾之间的位置","brown");
										
										//if(jumpPos<0){
										//	throw new Error("哈哈");
										//}
										
										//if(jumpPos<0){
										//	jumpPos=0;
										//}else{
											jumpPos=endOffset;
										//}
										Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
										
										//throw new Error("哈哈");
									}
									labelMark=labelMarkArr[jumpPos];
									if(labelMark){
									}else{
										labelMarkArr[jumpPos]=labelMark=new AVM2LabelMark();
										labelMark.labelId=labelId++;
									}
									code.value.case_offsetV[i]=labelMark;
								}
							break;
							case AVM2Ops.dataType_u8_u8_u30_u8_u30:
								
								//AVM2Ops.type_u8_u8_u30_u8_u30__debug
								code=new AVM2Code(op,{debug_type:data[offset++]});
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var debug_index:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{debug_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{debug_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{debug_index=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{debug_index=data[offset++];}
								//debug_index
								
								code.value.index=stringV[debug_index];
								
								code.value.reg=data[offset++];
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){code.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{code.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{code.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{code.value.extra=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{code.value.extra=data[offset++];}
								//code.value.extra
							break;
							default:
								throw new Error("未知 opDataType: "+opDataType+", op="+code.op);
							break;
						}
						codeByOffsetArr[pos]=code;
					}
					if(hexByOffsetArr){
						hexByOffsetArr[pos]=BytesAndStr16.bytes2str16(data,pos,offset-pos);
					}
				}else{
					code=new ByteArray();
					code[0]=op;
					codeByOffsetArr[pos]=code;
					Outputer.output("对未知代码使用 ByteArray 进行记录："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
					Outputer.outputError("未知 op: "+op);
				}
			}
			
			//trace("offset="+offset+",endOffset="+endOffset);
			if(offset==endOffset){
			}else{
				trace("offset="+offset+",endOffset="+endOffset);
			}
			
			if(hexByOffsetArr){
				hexArr=new Array();
			}
			codeArr=new Array();
			var codeId:int=-1;
			//endOffset++;
			for(offset=0;offset<=endOffset;offset++){
				if(labelMarkArr[offset]){
					codeId++;
					codeArr[codeId]=labelMarkArr[offset];
				}
				if(codeByOffsetArr[offset]){
					codeId++;
					if(hexArr){
						hexArr[codeId]=hexByOffsetArr[offset];
					}
					codeArr[codeId]=codeByOffsetArr[offset];
				}
			}
		}
		private function lastCodeIsReturn(codeByOffsetArr:Array):Boolean{
			var prevCodeOffset:int=codeByOffsetArr.length-1;
			while(--prevCodeOffset>=0){
				if(codeByOffsetArr[prevCodeOffset]){
					switch(codeByOffsetArr[prevCodeOffset]){
						case AVM2Ops.throw_:
						case AVM2Ops.returnvoid:
						case AVM2Ops.returnvalue:
							return true;
						break;
					}
					return false;
				}
			}
			return false;
		}
		public function getInfo_product(productMark:ProductMark):void{
			for each(var code:* in codeArr){
				//trace("code="+code);
				if(code is AVM2LabelMark){
				}else if(code is ByteArray){
				}else{
					if(code is int){
					}else if(code is AVM2Code){
						var opDataType:String=AVM2Ops.opDataTypeV[code.op];
						if(opDataType==AVM2Ops.dataType_u8){
							//throw new Error("请直接用 int");
						}else{
							switch(opDataType){
								case AVM2Ops.dataType_u8_u8:
								break;
								case AVM2Ops.dataType_u8_u30:
									switch(AVM2Ops.opTypeV[code.op]){
										case AVM2Ops.type_u8_u30__value_int:
										case AVM2Ops.type_u8_u30__scope:
										case AVM2Ops.type_u8_u30__slot:
										case AVM2Ops.type_u8_u30__register:
										case AVM2Ops.type_u8_u30__args:
										break;
										case AVM2Ops.type_u8_u30__int:
											productMark.productInteger(code.value);
										break;
										case AVM2Ops.type_u8_u30__uint:
											productMark.productUinteger(code.value);
										break;
										case AVM2Ops.type_u8_u30__double:
											productMark.productDouble(code.value);
										break;
										case AVM2Ops.type_u8_u30__string:
											productMark.productString(code.value);
										break;
										case AVM2Ops.type_u8_u30__namespace_info:
											productMark.productNs(code.value);
										break;
										case AVM2Ops.type_u8_u30__multiname_info:
											productMark.productMultiname(code.value);
										break;
										case AVM2Ops.type_u8_u30__method:
											//只有 newfunction
											productMark.productMethod(code.value);
										break;
										case AVM2Ops.type_u8_u30__class:
											//已在 ABCClasses.toData 里 product 过了
										break;
										case AVM2Ops.type_u8_u30__exception_info:
											(code.value as ABCException).getInfo_product(productMark);
										break;
										case AVM2Ops.type_u8_u30__finddef:
											//throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
										break;
									}
								break;
								case AVM2Ops.dataType_u8_u30_u30:
									switch(AVM2Ops.opTypeV[code.op]){
										case AVM2Ops.type_u8_u30_u30__register_register:
										break;
										case AVM2Ops.type_u8_u30_u30__multiname_info_args:
											productMark.productMultiname(code.value.multiname);
										break;
										case AVM2Ops.type_u8_u30_u30__method_args:
											//u30_1=advanceABC.getIdByInfoAndMemberType(code.value.method,Member.METHOD),
											//u30_2=code.value.args;
											Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
										break;
									}
								break;
								case AVM2Ops.dataType_u8_s24:
								break;
								case AVM2Ops.dataType_u8_s24_u30_s24List:
								break;
								case AVM2Ops.dataType_u8_u8_u30_u8_u30:
									productMark.productString(code.value.index);
								break;
								default:
									//throw new Error("未知 opDataType: "+opDataType+", op="+code.op);
								break;
							}
						}
					}else{
						throw new Error("未知 code: "+code);
					}
				}
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Array{
			var data:ByteArray=new ByteArray();
			
			var posMarkArr:Array=new Array();//记录 branch, newcatch, lookupswitch 的位置及相关的 label 位置
			
			var offset:int=0;
			
			var u30_1:int,u30_2:int,jumpOffset:int;
			
			var labelMark:AVM2LabelMark;
			
			var exceptionIdDict:Dictionary=new Dictionary();
			var exception:ABCException;
			var exception_info:Exception_info;
			var exception_infoV:Vector.<Exception_info>=new Vector.<Exception_info>();
			
			for each(var code:* in codeArr){
				//trace("code="+code);
				if(code is AVM2LabelMark){
					(code as AVM2LabelMark).pos=offset;
				}else if(code is ByteArray){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
					data.position=offset;
					data.writeBytes(code,0,code.length);
					offset=data.length;
				}else{
					if(code is int){
						data[offset++]=code;
					}else if(code is AVM2Code){
						var opDataType:String=AVM2Ops.opDataTypeV[code.op];
						if(opDataType==AVM2Ops.dataType_u8){
							throw new Error("请直接用 int");
						}else{
							data[offset++]=code.op;
							switch(opDataType){
								case AVM2Ops.dataType_u8_u8:
									
									//AVM2Ops.type_u8_u8__value_byte
									data[offset++]=code.value;
								break;
								case AVM2Ops.dataType_u8_u30:
									switch(AVM2Ops.opTypeV[code.op]){
										case AVM2Ops.type_u8_u30__value_int:
										case AVM2Ops.type_u8_u30__scope:
										case AVM2Ops.type_u8_u30__slot:
										case AVM2Ops.type_u8_u30__register:
										case AVM2Ops.type_u8_u30__args:
											u30_1=code.value;
										break;
										case AVM2Ops.type_u8_u30__int:
											u30_1=productMark.getIntegerId(code.value);
										break;
										case AVM2Ops.type_u8_u30__uint:
											u30_1=productMark.getUintegerId(code.value);
										break;
										case AVM2Ops.type_u8_u30__double:
											u30_1=productMark.getDoubleId(code.value);
										break;
										case AVM2Ops.type_u8_u30__string:
											u30_1=productMark.getStringId(code.value);
										break;
										case AVM2Ops.type_u8_u30__namespace_info:
											u30_1=productMark.getNsId(code.value);
										break;
										case AVM2Ops.type_u8_u30__multiname_info:
											u30_1=productMark.getMultinameId(code.value);
										break;
										case AVM2Ops.type_u8_u30__method:
											//只有 newfunction
											u30_1=productMark.getMethodId(code.value);
										break;
										case AVM2Ops.type_u8_u30__class:
											u30_1=productMark.getClassId(code.value);
										break;
										case AVM2Ops.type_u8_u30__exception_info:
											exception=code.value;
											if(exceptionIdDict[exception]>-1){
												Outputer.output("重复使用的 exception","brown");
											}else{
												exceptionIdDict[exception]=exception_infoV.length;
												exception_infoV[exception_infoV.length]=exception.getInfo(productMark,_toDataOptions);
											}
											u30_1=exceptionIdDict[exception];
											posMarkArr[offset]=code;
										break;
										case AVM2Ops.type_u8_u30__finddef:
											throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
										break;
									}
									
									if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
									//u30_1
								break;
								case AVM2Ops.dataType_u8_u30_u30:
									switch(AVM2Ops.opTypeV[code.op]){
										case AVM2Ops.type_u8_u30_u30__register_register:
											u30_1=code.value.register1;
											u30_2=code.value.register2;
										break;
										case AVM2Ops.type_u8_u30_u30__multiname_info_args:
											u30_1=productMark.getMultinameId(code.value.multiname),
											u30_2=code.value.args;
										break;
										case AVM2Ops.type_u8_u30_u30__method_args:
											//u30_1=advanceABC.getIdByInfoAndMemberType(code.value.method,Member.METHOD),
											//u30_2=code.value.args;
											Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
										break;
									}
									if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
									//u30_1
									
									if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
									//u30_2
								break;
								
								case AVM2Ops.dataType_u8_s24:
									
									//AVM2Ops.type_u8_s24__branch
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									data[offset++]=0x00;
									posMarkArr[offset]=code.value;
								break;
								
								case AVM2Ops.dataType_u8_s24_u30_s24List:
									//AVM2Ops.type_u8_s24_u30_s24List__lookupswitch
									
									//The base location is the address of the lookupswitch instruction itself.
									posMarkArr[offset-1]=code;
									
									code.value.default_offset_startPos=offset;
									
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									data[offset++]=0x00;
									
									var case_count:int=code.value.case_offsetV.length-1;
									if(case_count>>>7){if(case_count>>>14){if(case_count>>>21){if(case_count>>>28){data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=((case_count>>>21)&0x7f)|0x80;data[offset++]=case_count>>>28;}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=case_count>>>21;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=case_count>>>14;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=case_count>>>7;}}else{data[offset++]=case_count;}
									//case_count
									
									code.value.case_offset_startPos=offset;
									for each(labelMark in code.value.case_offsetV){
										//先用 0 占位，后面一次性写入
										data[offset++]=0x00;
										data[offset++]=0x00;
										data[offset++]=0x00;
									}
								break;
								
								case AVM2Ops.dataType_u8_u8_u30_u8_u30:
									
									//AVM2Ops.type_u8_u8_u30_u8_u30__debug
									data[offset++]=code.value.debug_type;
									
									var debug_index:int=productMark.getStringId(code.value.index);
									
									if(debug_index>>>7){if(debug_index>>>14){if(debug_index>>>21){if(debug_index>>>28){data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=((debug_index>>>14)&0x7f)|0x80;data[offset++]=((debug_index>>>21)&0x7f)|0x80;data[offset++]=debug_index>>>28;}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=((debug_index>>>14)&0x7f)|0x80;data[offset++]=debug_index>>>21;}}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=debug_index>>>14;}}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=debug_index>>>7;}}else{data[offset++]=debug_index;}
									//debug_index
									
									data[offset++]=code.value.reg;
									
									if(code.value.extra>>>7){if(code.value.extra>>>14){if(code.value.extra>>>21){if(code.value.extra>>>28){data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=((code.value.extra>>>14)&0x7f)|0x80;data[offset++]=((code.value.extra>>>21)&0x7f)|0x80;data[offset++]=code.value.extra>>>28;}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=((code.value.extra>>>14)&0x7f)|0x80;data[offset++]=code.value.extra>>>21;}}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=code.value.extra>>>14;}}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=code.value.extra>>>7;}}else{data[offset++]=code.value.extra;}
									//code.value.extra
								break;
								
								default:
									throw new Error("未知 opDataType: "+opDataType+", op="+code.op);
								break;
							}
						}
					}else{
						throw new Error("未知 code: "+code);
					}
				}
				
				//import zero.BytesAndStr16;
				//trace(BytesAndStr16.bytes2str16(data,0,data.length));
			}
			
			var endOffset:int=data.length;
			for(offset=0;offset<=endOffset;offset++){
				if(posMarkArr[offset]){
					if(posMarkArr[offset] is AVM2LabelMark){
						labelMark=posMarkArr[offset];
						jumpOffset=labelMark.pos-offset;
						data[offset-3]=jumpOffset;
						data[offset-2]=jumpOffset>>8;
						data[offset-1]=jumpOffset>>16;
					}else{
						code=posMarkArr[offset];
						if(code.op==AVM2Ops.newcatch){
							exception=code.value;
							exception_info=exception_infoV[exceptionIdDict[exception]];
							exception_info.from=exception.from.pos;
							exception_info.to=exception.to.pos;
							exception_info.target=exception.target.pos;
						}else if(code.op==AVM2Ops.lookupswitch){
							var case_offset:int;
							
							labelMark=code.value.default_offset;
							jumpOffset=labelMark.pos-offset;
							case_offset=code.value.default_offset_startPos;
							data[case_offset++]=jumpOffset;
							data[case_offset++]=jumpOffset>>8;
							data[case_offset++]=jumpOffset>>16;
							case_offset=code.value.case_offset_startPos;
							for each(labelMark in code.value.case_offsetV){
								jumpOffset=labelMark.pos-offset;
								data[case_offset++]=jumpOffset;
								data[case_offset++]=jumpOffset>>8;
								data[case_offset++]=jumpOffset>>16;
							}
						}else{
							throw new Error("发现 posMarkArr 里的奇怪的 code, code.op="+code.op);
						}
					}
				}
			}
			
			return [data,exception_infoV];
		}
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var labelMark:AVM2LabelMark,infoXML:XML;
			
			var exceptionXMLDict:Dictionary=new Dictionary();
			var exceptionMark:Object=new Object();
			
			if(codeArr.length){
				var codesStr:String="";
				if(hexArr){
					var codeId:int=-1;
				}
				for each(var code:* in codeArr){
					if(hexArr){
						codeId++;
						if(hexArr[codeId]){
							codesStr+="\t\t\t\t\t//"+hexArr[codeId]+"\n";
						}
					}
					if(code is AVM2LabelMark){
						codesStr+="\t\t\t\tlabel"+(code as AVM2LabelMark).labelId+":\n";
					}else if(code is ByteArray){
						Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
						codesStr+="\t\t\t\t\t"+BytesAndStr16.bytes2str16(code,0,code.length)+"\n";
					}else{
						if(code is int){
							codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code];
						}else if(code is AVM2Code){
							codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op];
							var opType:String=AVM2Ops.opTypeV[code.op];
							
							if(opType==AVM2Ops.type_u8){
								throw new Error("请直接用 int");
							}else{
								switch(opType){
									case AVM2Ops.type_u8_u8__value_byte:
									case AVM2Ops.type_u8_u30__value_int:
									case AVM2Ops.type_u8_u30__scope:
									case AVM2Ops.type_u8_u30__slot:
									case AVM2Ops.type_u8_u30__register:
									case AVM2Ops.type_u8_u30__args:
									case AVM2Ops.type_u8_u30__int:
									case AVM2Ops.type_u8_u30__uint:
									case AVM2Ops.type_u8_u30__double:
										codesStr+=" "+code.value;
									break;
									case AVM2Ops.type_u8_u30__string:
										codesStr+=" \""+ZeroCommon.esc_xattr(code.value)+"\"";
									break;
									case AVM2Ops.type_u8_u30__namespace_info:
										if(_toXMLOptions.AVM2UseMarkStr){
											codesStr+=" "+(code.value as ABCNamespace).toMarkStrAndMark(markStrs);
										}else{
											codesStr+=" "+(code.value as ABCNamespace).toXMLAndMark(markStrs,"ns",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"");
										}
									break;
									case AVM2Ops.type_u8_u30__multiname_info:
										if(_toXMLOptions.AVM2UseMarkStr){
											codesStr+=" "+(code.value as ABCMultiname).toMarkStrAndMark(markStrs);
										}else{
											codesStr+=" "+(code.value as ABCMultiname).toXMLAndMark(markStrs,"multiname",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")
										}
									break;
									case AVM2Ops.type_u8_u30__method:
										//只有 newfunction
										var method:ABCMethod=code.value;
										if(markStrs.markStrDict[method]){
											Outputer.output("重复使用的 method","brown");
											Outputer.output("如引用的是 iinit 或 cinit 或 init 或 trait 里的 method 将可能不正常","brown");
										}
										var methodXML:XML=method.toXMLAndMark(markStrs,"","method",_toXMLOptions);
										var methodMarkStr:String=markStrs.markStrDict[method];
										codesStr+=" "+methodMarkStr;
										methodXML.@methodMarkStr=methodMarkStr;
										markStrs.newfunctionXMLV.push(methodXML);
									break;
									case AVM2Ops.type_u8_u30__class:
										var class_name:ABCMultiname=(code.value as ABCClass).name;
										if(_toXMLOptions.AVM2UseMarkStr){
											codesStr+=" "+class_name.toMarkStrAndMark(markStrs);
										}else{
											codesStr+=" "+class_name.toXMLAndMark(markStrs,"class_name",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")
										}
									break;
									case AVM2Ops.type_u8_u30__exception_info:
										var exception:ABCException=code.value;
										var exceptionXML:XML=exceptionXMLDict[exception];
										if(exceptionXML){
											Outputer.output("重复使用的 exception","brown");
										}else{
											exceptionXML=exception.toXMLAndMark(markStrs,"exception",_toXMLOptions);
											
											var exceptionMarkStr:String=exceptionXML.toXMLString().replace(/\s*\n\s*/g,"");
											
											//计算 copyId
											if(exceptionMark["~"+exceptionMarkStr]){
												var copyId:int=1;
												while(exceptionMark["~"+exceptionMarkStr+"("+(++copyId)+")"]){};
												exceptionMarkStr+="("+copyId+")";
												
												exceptionXML.@copyId=copyId;
											}
											//
											
											exceptionMark["~"+exceptionMarkStr]=exception;
											exceptionXMLDict[exception]=exceptionXML;
										}
										codesStr+=" "+exceptionXML.toXMLString().replace(/\s*\n\s*/g,"");
									break;
									case AVM2Ops.type_u8_u30__finddef:
										throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
									break;
									
									case AVM2Ops.type_u8_u30_u30__register_register:
										codesStr+=" "+code.value.register1+" "+code.value.register2;
									break;
									case AVM2Ops.type_u8_u30_u30__multiname_info_args:
										if(_toXMLOptions.AVM2UseMarkStr){
											codesStr+=" "+(code.value.multiname as ABCMultiname).toMarkStrAndMark(markStrs)+" "+code.value.args;
										}else{
											codesStr+=" "+(code.value.multiname as ABCMultiname).toXMLAndMark(markStrs,"multiname",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+" "+code.value.args;
										}
									break;
									case AVM2Ops.type_u8_u30_u30__method_args:
										Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
									break;
									
									case AVM2Ops.type_u8_s24__branch:
										codesStr+=" label"+code.value.labelId;
									break;
									
									case AVM2Ops.type_u8_s24_u30_s24List__lookupswitch:
										codesStr+=" label"+code.value.default_offset.labelId;
										for each(labelMark in code.value.case_offsetV){
											codesStr+=" label"+labelMark.labelId;
										}
									break;
									
									case AVM2Ops.type_u8_u8_u30_u8_u30__debug:
										codesStr+=" "+code.value.debug_type+" \""+ZeroCommon.esc_xattr(code.value.index)+"\" "+code.value.reg+" "+code.value.extra;//- -
									break;
									
									default:
										throw new Error("未处理, op="+code.op+", opType="+opType);
									break;
								}
							}
						}else{
							throw new Error("未知 code: "+code);
						}
						codesStr+="\n";
					}
				}
				
				return new XML("<"+xmlName+"><![CDATA[\n"+
					codesStr
					+"\t\t\t\t]]></"+xmlName+">");
			}
			return <{xmlName}/>;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var codeStrArr:Array=xml.toString().replace(/^\s*|\s*$/g,"").split("\n");
			var codeId:int=-1;
			codeArr=new Array();
			var code:AVM2Code;
			
			var codeStr:String;
			var i:int=codeStrArr.length;
			var labelMarkMark:Object=new Object();
			var labelMark:AVM2LabelMark;
			
			var execResult:Array;
			
			var exceptionXMLDict:Dictionary=new Dictionary();
			var exceptionMark:Object=new Object();
			
			while(--i>=0){
				codeStrArr[i]=codeStr=codeStrArr[i].replace(/^\s*|\s*$/g,"");
				if(codeStr){
					if(codeStr.indexOf("//")==0){
						//注解
						codeStrArr.splice(i,1);
					}
				}else{
					//空白
					codeStrArr.splice(i,1);
				}
				if(/^label(\d+):$/.test(codeStr)){
					if(labelMarkMark[codeStr]){
						throw new Error("重复的 labelMark: "+codeStr);
					}
					labelMarkMark[codeStr]=labelMark=new AVM2LabelMark();
					labelMark.labelId=int(codeStr.replace(/label(\d+):/,"$1"));
				}
			}
			for each(codeStr in codeStrArr){
				
				//trace("codeStr="+codeStr);
				
				if(/^label(\d+):$/.test(codeStr)){
					codeArr[++codeId]=labelMarkMark[codeStr];
				}else if((codeStr+" ").search(/[0-9a-fA-F]{2}\s+/)==0){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+codeStr,"brown");
					codeArr[++codeId]=BytesAndStr16.str162bytes(codeStr);
				}else{
					var pos:int=codeStr.search(/\s+/);
					var opStr:String;
					if(pos==-1){
						opStr=codeStr;
					}else{
						opStr=codeStr.substr(0,pos);
					}
					if(AVM2Ops[opStr]>=0){
						var op:int=AVM2Ops[opStr];
						var opType:String=AVM2Ops.opTypeV[op];
						
						//trace("op="+op+",opType="+opType);
						
						if(opType==AVM2Ops.type_u8){
							codeArr[++codeId]=op;
						}else{
							codeStr=codeStr.substr(pos).replace(/^\s*|\s*$/g,"");
							switch(opType){
								case AVM2Ops.type_u8_u8__value_byte:
								case AVM2Ops.type_u8_u30__value_int:
								case AVM2Ops.type_u8_u30__scope:
								case AVM2Ops.type_u8_u30__slot:
								case AVM2Ops.type_u8_u30__register:
								case AVM2Ops.type_u8_u30__args:
								case AVM2Ops.type_u8_u30__int:
								case AVM2Ops.type_u8_u30__uint:
									code=new AVM2Code(op,int(codeStr.replace(/\s+/g,"")));//支持 16进制的整数表示
								break;
								case AVM2Ops.type_u8_u30__double:
									code=new AVM2Code(op,Number(codeStr.replace(/\s+/g,"")));
								break;
								case AVM2Ops.type_u8_u30__string:
									code=new AVM2Code(op,ZeroCommon.unesc_xattr(codeStr.substr(1,codeStr.length-2)));
								break;
								case AVM2Ops.type_u8_u30__namespace_info:
									if(/^<.*>$/.test(codeStr)){
										code=new AVM2Code(op,ABCNamespace.xml2ns(markStrs,new XML(codeStr),_initByXMLOptions));
									}else{
										code=new AVM2Code(op,ABCNamespace.markStr2ns(markStrs,codeStr));
									}
								break;
								case AVM2Ops.type_u8_u30__multiname_info:
									if(/^<.*>$/.test(codeStr)){
										code=new AVM2Code(op,ABCMultiname.xml2multiname(markStrs,new XML(codeStr),_initByXMLOptions));
									}else{
										code=new AVM2Code(op,ABCMultiname.markStr2multiname(markStrs,codeStr));
									}
								break;
								case AVM2Ops.type_u8_u30__method:
									//只有 newfunction
									//trace("codeStr="+codeStr,markStrs.methodMark["~"+codeStr]);
									code=new AVM2Code(op,markStrs.methodMark["~"+codeStr]);
								break;
								case AVM2Ops.type_u8_u30__class:
									var class_name:ABCMultiname;
									if(/^<.*>$/.test(codeStr)){
										class_name=ABCMultiname.xml2multiname(markStrs,new XML(codeStr),_initByXMLOptions);
									}else{
										class_name=ABCMultiname.markStr2multiname(markStrs,codeStr);
									}
									code=new AVM2Code(op,markStrs.classDict[class_name]);
									if(code.value){
									}else{
										throw new Error("找不到 "+class_name.toMarkStrAndMark(markStrs)+" 对应的 ABCClass，请检查 ABCClasses.initByXML()");
									}
								break;
								case AVM2Ops.type_u8_u30__exception_info:
									var exceptionXML:XML=new XML(codeStr);
									
									var exceptionMarkStr:String=exceptionXML.toXMLString().replace(/\s*\n\s*/g,"");
									
									var exception:ABCException=exceptionMark["~"+exceptionMarkStr];
									if(exception){
										Outputer.output("重复使用的 exception","brown");
									}else{
										exceptionMark["~"+exceptionMarkStr]=exception=new ABCException();
										exception.initByXMLAndMark(markStrs,exceptionXML,_initByXMLOptions);
										exception.from=labelMarkMark[exceptionXML.@from.toString()+":"];
										
										if(exception.from){
										}else{
											throw new Error("找不到对应的 exception.from: "+codeStr);
										}
										
										exception.to=labelMarkMark[exceptionXML.@to.toString()+":"];
										if(exception.to){
										}else{
											throw new Error("找不到对应的 exception.to: "+codeStr);
										}
										
										exception.target=labelMarkMark[exceptionXML.@target.toString()+":"];
										if(exception.target){
										}else{
											throw new Error("找不到对应的 exception.target: "+codeStr);
										}
									}
									code=new AVM2Code(op,exception);
								break;
								case AVM2Ops.type_u8_u30__finddef:
									throw new Error("恭喜你，你发现了一个 "+opStr+" 的例子！");
								break;
								
								case AVM2Ops.type_u8_u30_u30__register_register:
									execResult=/^(\w+)\s+(\w+)$/.exec(codeStr);
									if(execResult[0]==codeStr){
										code=new AVM2Code(op,{
											register1:int(execResult[1]),
											register2:int(execResult[2])
										});
									}else{
										throw new Error("codeStr="+codeStr);
									}
								break;
								case AVM2Ops.type_u8_u30_u30__multiname_info_args:
									execResult=/^(.*)\s+(\w+)$/.exec(codeStr);
									if(execResult[0]==codeStr){
										code=new AVM2Code(op,{
											args:int(execResult[2])
										});
										if(/^<.*>$/.test(execResult[1])){
											code.value.multiname=ABCMultiname.xml2multiname(markStrs,new XML(execResult[1]),_initByXMLOptions);
										}else{
											code.value.multiname=ABCMultiname.markStr2multiname(markStrs,execResult[1]);
										}
									}else{
										throw new Error("不合法的 codeStr: "+codeStr);
									}
								break;
								case AVM2Ops.type_u8_u30_u30__method_args:
									//callmethod,callstatic
									Outputer.outputError("恭喜你，你发现了一个 "+opStr+" 的例子！");
								break;
								case AVM2Ops.type_u8_s24__branch:
									labelMark=labelMarkMark[codeStr+":"];
									if(labelMark){
										code=new AVM2Code(op,labelMark);
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
								break;
								case AVM2Ops.type_u8_s24_u30_s24List__lookupswitch:
									var matchArr:Array=codeStr.match(/label\d+/g);
									var matchStr:String=matchArr.shift();
									labelMark=labelMarkMark[matchStr+":"];
									if(labelMark){
										code=new AVM2Code(op,{default_offset:labelMark});
									}else{
										throw new Error("找不到对应的 labelMark: "+matchStr);
									}
									code.value.case_offsetV=new Vector.<AVM2LabelMark>();
									i=0;
									for each(matchStr in matchArr){
										labelMark=labelMarkMark[matchStr+":"];
										if(labelMark){
											code.value.case_offsetV[i++]=labelMark;
										}else{
											throw new Error("找不到对应的 labelMark: "+matchStr);
										}
									}
								break;
								case AVM2Ops.type_u8_u8_u30_u8_u30__debug:
									execResult=/^(\w+)\s+"(.*)"\s+(\w+)\s+(\w+)$/.exec(codeStr);
									if(execResult[0]==codeStr){
										code=new AVM2Code(op,{
											debug_type:int(execResult[1]),
											index:ZeroCommon.unesc_xattr(execResult[2]),//- -
											reg:int(execResult[3]),
											extra:int(execResult[4])
										});
									}else{
										throw new Error("不合法的 codeStr: "+codeStr);
									}
								break;
								default:
									throw new Error("未处理, op="+code.op+", opType="+opType);
								break;
							}
							codeArr[++codeId]=code;
						}
					}else{
						throw new Error("未知 codeStr: "+codeStr);
					}
				}
				
				//trace("code="+codeArr[codeId]);
				//trace("--------------------------------------");
			}
		}
		}//end of CONFIG::USE_XML
	}
}

