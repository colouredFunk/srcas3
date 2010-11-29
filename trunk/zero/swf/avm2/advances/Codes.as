/***
Codes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:28:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import flash.utils.ByteArray;
	
	import zero.Outputer;
	import zero.Xattr;
	import zero.swf.avm2.advances.AdvanceABC;
	import zero.swf.avm2.advances.AdvanceMultiname_info;
	import zero.swf.avm2.advances.Member;
	

	public class Codes extends Advance{
		public var codeArr:Array;
		public function Codes(){
		}
		public function initByInfo(
			advanceABC:AdvanceABC,
			data:ByteArray,
			exception_infoV:Vector.<AdvanceException_info>
		):void{
			
			var labelId:int=0;
			var labelMarkArr:Array=new Array();
			var codeByOffsetArr:Array=new Array();
			var code:*;
			
			var offset:int=0;
			var endOffset:int=data.length;
			
			var labelMark:LabelMark,exception_info:AdvanceException_info;
			var u30_1:int,u30_2:int,jumpOffset:int,jumpPos:int,i:int;
			
			while(offset<endOffset){
				var pos:int=offset;
				var op:int=data[offset++];
				var opDataType:String=Op.opDataTypeV[op];
				
				if(opDataType){
					if(opDataType==Op.dataType_u8){
						codeByOffsetArr[pos]=op;
					}else{
						switch(opDataType){
							case Op.dataType_u8_u8:
								
								//Op.type_u8_u8__value_byte
								code=new Code(op,data[offset++]);
							break;
							case Op.dataType_u8_u30:
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
								//u30_1
								try{
									switch(Op.opTypeV[op]){
										case Op.type_u8_u30__value_int:
										case Op.type_u8_u30__scope:
										case Op.type_u8_u30__slot:
										case Op.type_u8_u30__register:
										case Op.type_u8_u30__args:
											code=new Code(op,u30_1);
										break;
										case Op.type_u8_u30__int:
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.INTEGER));
										break;
										case Op.type_u8_u30__uint:
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.UINTEGER));
										break;
										case Op.type_u8_u30__double:
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.DOUBLE));
										break;
										case Op.type_u8_u30__string:
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.STRING));
										break;
										case Op.type_u8_u30__namespace_info:
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.NAMESPACE_INFO));
										break;
										case Op.type_u8_u30__multiname_info:
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.MULTINAME_INFO));
										break;
										case Op.type_u8_u30__method:
											//只有 newfunction
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.METHOD));
										break;
										case Op.type_u8_u30__class:
											code=new Code(op,advanceABC.getInfoByIdAndMemberType(u30_1,Member.CLAZZ));
										break;
										case Op.type_u8_u30__exception_info:
											code=new Code(op,{
												exception_info:exception_infoV[u30_1]
											});
											
											labelMark=labelMarkArr[code.value.exception_info.from];
											if(labelMark){
											}else{
												labelMarkArr[code.value.exception_info.from]=labelMark=new LabelMark();
												labelMark.labelId=labelId++;
											}
											code.value.from=labelMark;
											
											labelMark=labelMarkArr[code.value.exception_info.to];
											if(labelMark){
											}else{
												labelMarkArr[code.value.exception_info.to]=labelMark=new LabelMark();
												labelMark.labelId=labelId++;
											}
											code.value.to=labelMark;
											
											labelMark=labelMarkArr[code.value.exception_info.target];
											if(labelMark){
											}else{
												labelMarkArr[code.value.exception_info.target]=labelMark=new LabelMark();
												labelMark.labelId=labelId++;
											}
											code.value.target=labelMark;
											
										break;
										case Op.type_u8_u30__finddef:
											throw new Error("恭喜你，你发现了一个 "+Op.opNameV[op]+" 的例子！");
										break;
									}
								}catch(e:Error){
									if(e is RangeError){
										code=new Array();
										for(i=pos;i<offset;i++){
											code[code.length]=data[i];
										}
									}
									Outputer.outputError("e="+e);
								}
							break;
							case Op.dataType_u8_u30_u30:
								try{
									if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
									//u30_1
									
									if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
									//u30_2
									switch(Op.opTypeV[op]){
										case Op.type_u8_u30_u30__register_register:
											code=new Code(op,{
												register1:u30_1,
												register2:u30_2
											});
										break;	
										case Op.type_u8_u30_u30__multiname_info_args:
											code=new Code(op,{
												multiname_info:advanceABC.getInfoByIdAndMemberType(u30_1,Member.MULTINAME_INFO),
												args:u30_2
											});
										break;
										case Op.type_u8_u30_u30__method_args:
											//code=new Code(op,{
											//	method:advanceABC.getInfoByIdAndMemberType(u30_1,Member.METHOD),
											//	args:u30_2
											//});
											Outputer.outputError("恭喜你，你发现了一个 "+Op.opNameV[op]+" 的例子！");
											code=new Array();
											for(i=pos;i<offset;i++){
												code[code.length]=data[i];
											}
										break;
									}
								}catch(e:Error){
									if(e is RangeError){
										code=new Array();
										for(i=pos;i<offset;i++){
											code[code.length]=data[i];
										}
									}
									Outputer.outputError("e="+e);
								}
							break;
							case Op.dataType_u8_s24:
								
								//Op.type_u8_s24__branch
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
									labelMarkArr[jumpPos]=labelMark=new LabelMark();
									labelMark.labelId=labelId++;
								}
								code=new Code(op,labelMark);
							break;
							case Op.dataType_u8_s24_u30_s24List:
								
								//Op.type_u8_s24_u30_s24List__lookupswitch
								
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
									labelMarkArr[jumpPos]=labelMark=new LabelMark();
									labelMark.labelId=labelId++;
								}
								code=new Code(op,{default_offset:labelMark});
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var case_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_count=data[offset++];}
								//case_count
								
								case_count++;
								code.value.case_offsetV=new Vector.<LabelMark>(case_count);
								for(i=0;i<case_count;i++){
									//Op.type_u8_s24_u30_s24List__lookupswitch
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
										labelMarkArr[jumpPos]=labelMark=new LabelMark();
										labelMark.labelId=labelId++;
									}
									code.value.case_offsetV[i]=labelMark;
								}
							break;
							case Op.dataType_u8_u8_u30_u8_u30:
								
								//Op.type_u8_u8_u30_u8_u30__debug
								code=new Code(op,{debug_type:data[offset++]});
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var debug_index:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{debug_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{debug_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{debug_index=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{debug_index=data[offset++];}
								//debug_index
								
								code.value.index=advanceABC.getInfoByIdAndMemberType(debug_index,Member.STRING);
								
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
				}else{
					throw new Error("未知 op: "+op);
				}
			}
			
			//trace("offset="+offset+",endOffset="+endOffset);
			if(offset===endOffset){
				
			}else{
				trace("offset="+offset+",endOffset="+endOffset);
			}
			
			codeArr=new Array();
			var codeId:int=0;
			//endOffset++;
			for(offset=0;offset<=endOffset;offset++){
				if(labelMarkArr[offset]){
					codeArr[codeId++]=labelMarkArr[offset];
				}
				if(codeByOffsetArr[offset]){
					codeArr[codeId++]=codeByOffsetArr[offset];
				}
			}
		}
		private function lastCodeIsReturn(codeByOffsetArr:Array):Boolean{
			var prevCodeOffset:int=codeByOffsetArr.length-1;
			while(--prevCodeOffset>=0){
				if(codeByOffsetArr[prevCodeOffset]){
					switch(codeByOffsetArr[prevCodeOffset]){
						case Op.throw_:
						case Op.returnvoid:
						case Op.returnvalue:
							return true;
						break;
					}
					return false;
				}
			}
			return false;
		}
		public function toData(advanceABC:AdvanceABC,exception_infoV:Vector.<AdvanceException_info>):ByteArray{
			var data:ByteArray=new ByteArray();
			
			var posMarkArr:Array=new Array();//记录 branch, newcatch, lookupswitch 的位置及相关的 label 位置
			
			var offset:int=0;
			
			var u30_1:int,u30_2:int,jumpOffset:int;
			
			var labelMark:LabelMark;
			
			for each(var code:* in codeArr){
				//trace("code="+code);
				if(code is LabelMark){
					(code as LabelMark).pos=offset;
				}else if(code is Array){
					for each(var directCode:int in code){
						data[offset++]=directCode;
					}
				}else{
					if(code is int){
						data[offset++]=code;
					}else if(code is Code){
						var opDataType:String=Op.opDataTypeV[code.op];
						if(opDataType==Op.dataType_u8){
							throw new Error("请直接用 int");
						}else{
							data[offset++]=code.op;
							switch(opDataType){
								case Op.dataType_u8_u8:
									
									//Op.type_u8_u8__value_byte
									data[offset++]=code.value;
								break;
								case Op.dataType_u8_u30:
									switch(Op.opTypeV[code.op]){
										case Op.type_u8_u30__value_int:
										case Op.type_u8_u30__scope:
										case Op.type_u8_u30__slot:
										case Op.type_u8_u30__register:
										case Op.type_u8_u30__args:
											u30_1=code.value;
										break;
										case Op.type_u8_u30__int:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.INTEGER);
										break;
										case Op.type_u8_u30__uint:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.UINTEGER);
										break;
										case Op.type_u8_u30__double:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.DOUBLE);
										break;
										case Op.type_u8_u30__string:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.STRING);
										break;
										case Op.type_u8_u30__namespace_info:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.NAMESPACE_INFO);
										break;
										case Op.type_u8_u30__multiname_info:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.MULTINAME_INFO);
										break;
										case Op.type_u8_u30__method:
											//只有 newfunction
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.METHOD);
										break;
										case Op.type_u8_u30__class:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value,Member.CLAZZ);
										break;
										case Op.type_u8_u30__exception_info:
											u30_1=exception_infoV.length;
											exception_infoV[u30_1]=code.value.exception_info;
											posMarkArr[offset]=code;
										break;
										case Op.type_u8_u30__finddef:
											throw new Error("恭喜你，你发现了一个 "+Op.opNameV[code.op]+" 的例子！");
										break;
									}
									
									if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
									//u30_1
								break;
								case Op.dataType_u8_u30_u30:
									switch(Op.opTypeV[code.op]){
										case Op.type_u8_u30_u30__register_register:
											u30_1=code.value.register1;
											u30_2=code.value.register2;
										break;
										case Op.type_u8_u30_u30__multiname_info_args:
											u30_1=advanceABC.getIdByInfoAndMemberType(code.value.multiname_info,Member.MULTINAME_INFO),
											u30_2=code.value.args;
										break;
										case Op.type_u8_u30_u30__method_args:
											//u30_1=advanceABC.getIdByInfoAndMemberType(code.value.method,Member.METHOD),
											//u30_2=code.value.args;
											Outputer.outputError("恭喜你，你发现了一个 "+Op.opNameV[code.op]+" 的例子！");
										break;
									}
									if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
									//u30_1
									
									if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
									//u30_2
								break;
								
								case Op.dataType_u8_s24:
									
									//Op.type_u8_s24__branch
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									data[offset++]=0x00;
									posMarkArr[offset]=code.value;
								break;
								
								case Op.dataType_u8_s24_u30_s24List:
									//Op.type_u8_s24_u30_s24List__lookupswitch
									
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
								
								case Op.dataType_u8_u8_u30_u8_u30:
									
									//Op.type_u8_u8_u30_u8_u30__debug
									data[offset++]=code.value.debug_type;
									
									var debug_index:int=advanceABC.getIdByInfoAndMemberType(code.value.index,Member.STRING);
									
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
					if(posMarkArr[offset] is LabelMark){
						labelMark=posMarkArr[offset];
						jumpOffset=labelMark.pos-offset;
						data[offset-3]=jumpOffset;
						data[offset-2]=jumpOffset>>8;
						data[offset-1]=jumpOffset>>16;
					}else{
						code=posMarkArr[offset];
						if(code.op==Op.newcatch){
							code.value.exception_info.from=code.value.from.pos;
							code.value.exception_info.to=code.value.to.pos;
							code.value.exception_info.target=code.value.target.pos;
						}else if(code.op==Op.lookupswitch){
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
			
			return data;
		}
		////
		CONFIG::toXMLAndInitByXML {
			
		override public function toXMLAndMark(infoMark:InfoMark):XML{
			var labelMark:LabelMark,infoXML:XML;
			//var specialXMLMark:Object=new Object();//用来记录一些实在不适合在汇编码里显示的东西，例如匿名函数
			if(codeArr.length){
				var codesStr:String="";
				for each(var code:* in codeArr){
					if(code is LabelMark){
						codesStr+="\t\t\t\tlabel"+(code as LabelMark).labelId+":\n";
					}else if(code is Array){
						codesStr+="\t\t\t\t\t"+code.join(" ")+"\n";
					}else{
						if(code is int){
							codesStr+="\t\t\t\t\t"+Op.opNameV[code];
						}else if(code is Code){
							codesStr+="\t\t\t\t\t"+Op.opNameV[code.op];
							var opType:String=Op.opTypeV[code.op];
							
							if(opType==Op.type_u8){
								throw new Error("请直接用 int");
							}else{
								switch(opType){
									case Op.type_u8_u8__value_byte:
									case Op.type_u8_u30__value_int:
									case Op.type_u8_u30__scope:
									case Op.type_u8_u30__slot:
									case Op.type_u8_u30__register:
									case Op.type_u8_u30__args:
									case Op.type_u8_u30__int:
									case Op.type_u8_u30__uint:
									case Op.type_u8_u30__double:
										codesStr+=" "+code.value;
									break;
									case Op.type_u8_u30__string:
										codesStr+=" \""+Xattr.esc_xattr(code.value)+"\"";
									break;
									case Op.type_u8_u30__namespace_info:
										if(useMarkKey){
											codesStr+=" "+MarkStrs.namespace_info2markStr(infoMark,code.value);
										}else{
											codesStr+=" "+MarkStrs.namespace_info2xml(infoMark,code.value).toXMLString().replace(/[\r\n]+/g,"");
										}
									break;
									case Op.type_u8_u30__multiname_info:
										if(useMarkKey){
											codesStr+=" "+MarkStrs.multiname_info2markStr(infoMark,code.value);
										}else{
											codesStr+=" "+MarkStrs.multiname_info2xml(infoMark,code.value).toXMLString().replace(/[\r\n]+/g,"")
										}
									break;
									case Op.type_u8_u30__method:
										//只有 newfunction
										var methodMarkStr:String=MarkStrs.method2markStr(infoMark,code.value);
										var methodXML:XML=MarkStrs.method2xml(infoMark,code.value);
										if(useMarkKey){
											codesStr+=" "+methodMarkStr;
											infoMark.addSpecialXML(methodMarkStr,methodXML);
										}else{
											codesStr+=" "+Xattr.esc_xattr(methodXML.toXMLString());
										}
									break;
									case Op.type_u8_u30__class:
										codesStr+=" "+MarkStrs.multiname_info2markStr(infoMark,(code.value as AdvanceClass).name);
									break;
									case Op.type_u8_u30__exception_info:
										infoXML=(code.value.exception_info as AdvanceException_info).toXMLAndMark(infoMark);
										infoXML.setName(Member.EXCEPTION_INFO);
										infoXML.@from="label"+code.value.from.labelId;
										infoXML.@to="label"+code.value.to.labelId;
										infoXML.@target="label"+code.value.target.labelId;
										codesStr+=" "+infoXML.toXMLString().replace(/[\r\n]+/g,"");
									break;
									case Op.type_u8_u30__finddef:
										throw new Error("恭喜你，你发现了一个 "+Op.opNameV[code.op]+" 的例子！");
									break;
									
									case Op.type_u8_u30_u30__register_register:
										codesStr+=" "+code.value.register1+" "+code.value.register2;
									break;
									case Op.type_u8_u30_u30__multiname_info_args:
										if(useMarkKey){
											codesStr+=" "+MarkStrs.multiname_info2markStr(infoMark,code.value.multiname_info)+" "+code.value.args;
										}else{
											codesStr+=" "+MarkStrs.multiname_info2xml(infoMark,code.value.multiname_info).toXMLString().replace(/[\r\n]+/g,"")+" "+code.value.args;
										}
									break;
									case Op.type_u8_u30_u30__method_args:
										Outputer.outputError("恭喜你，你发现了一个 "+Op.opNameV[code.op]+" 的例子！");
									break;
									
									case Op.type_u8_s24__branch:
										codesStr+=" label"+code.value.labelId;
									break;
									
									case Op.type_u8_s24_u30_s24List__lookupswitch:
										codesStr+=" label"+code.value.default_offset.labelId;
										for each(labelMark in code.value.case_offsetV){
											codesStr+=" label"+labelMark.labelId;
										}
									break;
									
									case Op.type_u8_u8_u30_u8_u30__debug:
										codesStr+=" "+code.value.debug_type+" \""+Xattr.esc_xattr(code.value.index)+"\" "+code.value.reg+" "+code.value.extra;//- -
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
				
				return new XML("<Codes><![CDATA[\n"+
					codesStr
					+"\t\t\t\t]]></Codes>");
			}
			return <Codes/>;
		}
		override public function initByXMLAndMark(infoMark:InfoMark,xml:XML):void{
			var codeStrArr:Array=xml.toString().split("\n");
			var codeId:int=-1;
			codeArr=new Array();
			var code:Code;
			
			var codeStr:String;
			var i:int=codeStrArr.length;
			var labelMarkMark:Object=new Object();
			var labelMark:LabelMark;
			
			var execResult:Array;
			
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
					labelMarkMark[codeStr]=labelMark=new LabelMark();
					labelMark.labelId=int(codeStr.replace(/label(\d+):/,"$1"));
				}
			}
			for each(codeStr in codeStrArr){
				
				//trace("codeStr="+codeStr);
				
				if(/^label(\d+):$/.test(codeStr)){
					codeArr[++codeId]=labelMarkMark[codeStr];
				}else if(codeStr.search(/(0x([0-9a-fA-F]+)|\d+)\s+/)==0){
					var numArr:Array=new Array();
					for each(var numStr:String in codeStr.split(/\s+/)){
						if(numStr){
							numArr[numArr.length]=int(numStr);
						}
					}
					codeArr[++codeId]=numArr;
				}else{
					var pos:int=codeStr.search(/\s+/);
					var opStr:String;
					if(pos==-1){
						opStr=codeStr;
					}else{
						opStr=codeStr.substr(0,pos);
					}
					if(Op.ops[opStr]>=0){
						var op:int=Op.ops[opStr];
						var opType:String=Op.opTypeV[op];
						
						//trace("op="+op+",opType="+opType);
						
						if(opType==Op.type_u8){
							codeArr[++codeId]=op;
						}else{
							codeStr=codeStr.substr(pos).replace(/^\s*|\s*$/g,"");
							switch(opType){
								case Op.type_u8_u8__value_byte:
								case Op.type_u8_u30__value_int:
								case Op.type_u8_u30__scope:
								case Op.type_u8_u30__slot:
								case Op.type_u8_u30__register:
								case Op.type_u8_u30__args:
								case Op.type_u8_u30__int:
								case Op.type_u8_u30__uint:
									code=new Code(op,int(codeStr.replace(/\s+/g,"")));//支持 16进制的整数表示
								break;
								case Op.type_u8_u30__double:
									code=new Code(op,Number(codeStr.replace(/\s+/g,"")));
								break;
								case Op.type_u8_u30__string:
									code=new Code(op,Xattr.unesc_xattr(codeStr.substr(1,codeStr.length-2)));
								break;
								case Op.type_u8_u30__namespace_info:
									if(/^<.*>$/.test(codeStr)){
										code=new Code(op,MarkStrs.xml2namespace_info(infoMark,new XML(codeStr)));
									}else{
										code=new Code(op,MarkStrs.markStr2namespace_info(infoMark,codeStr));
									}
								break;
								case Op.type_u8_u30__multiname_info:
									if(/^<.*>$/.test(codeStr)){
										code=new Code(op,MarkStrs.xml2multiname_info(infoMark,new XML(codeStr)));
									}else{
										code=new Code(op,MarkStrs.markStr2multiname_info(infoMark,codeStr));
									}
								break;
								case Op.type_u8_u30__method:
									if(/^\&lt;.*\&gt;$/.test(codeStr)){
										code=new Code(op,MarkStrs.markStr2method(infoMark,new XML(Xattr.unesc_xattr(codeStr)).toXMLString()));
									}else{
										code=new Code(op,MarkStrs.markStr2method(infoMark,codeStr));
									}
								break;
								case Op.type_u8_u30__class:
									//这里假定了之前在 AdvanceClass 里已经标记过：
									code=new Code(op,infoMark.clazz["~"+codeStr]);
									if(code.value){
									}else{
										throw new Error("code.value="+code.value);
									}
								break;
								case Op.type_u8_u30__exception_info:
									code=new Code(op,{exception_info:new AdvanceException_info()});
									var exception_infoXML:XML=new XML(codeStr);
									(code.value.exception_info as AdvanceException_info).initByXMLAndMark(
										infoMark,exception_infoXML
									);
									code.value.from=labelMarkMark[exception_infoXML.@from.toString()+":"];
									if(code.value.from){
									}else{
										throw new Error("找不到对应的 code.value.from: "+codeStr);
									}
									
									code.value.to=labelMarkMark[exception_infoXML.@to.toString()+":"];
									if(code.value.to){
									}else{
										throw new Error("找不到对应的 code.value.to: "+codeStr);
									}
									
									code.value.target=labelMarkMark[exception_infoXML.@target.toString()+":"];
									if(code.value.target){
									}else{
										throw new Error("找不到对应的 code.value.target: "+codeStr);
									}
								break;
								case Op.type_u8_u30__finddef:
									throw new Error("恭喜你，你发现了一个 "+opStr+" 的例子！");
								break;
								
								case Op.type_u8_u30_u30__register_register:
									execResult=/^(\w+)\s+(\w+)$/.exec(codeStr);
									if(execResult[0]===codeStr){
										code=new Code(op,{
											register1:int(execResult[1]),
											register2:int(execResult[2])
										});
									}else{
										throw new Error("codeStr="+codeStr);
									}
								break;
								case Op.type_u8_u30_u30__multiname_info_args:
									execResult=/^(.*)\s+(\w+)$/.exec(codeStr);
									if(execResult[0]===codeStr){
										code=new Code(op,{
											args:int(execResult[2])
										});
										if(/^<.*>$/.test(execResult[1])){
											code.value.multiname_info=MarkStrs.xml2multiname_info(infoMark,new XML(execResult[1]));
										}else{
											code.value.multiname_info=MarkStrs.markStr2multiname_info(infoMark,execResult[1]);
										}
									}else{
										throw new Error("不合法的 codeStr: "+codeStr);
									}
								break;
								case Op.type_u8_u30_u30__method_args:
									//callmethod,callstatic
									Outputer.outputError("恭喜你，你发现了一个 "+opStr+" 的例子！");
								break;
								case Op.type_u8_s24__branch:
									labelMark=labelMarkMark[codeStr+":"];
									if(labelMark){
										code=new Code(op,labelMark);
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
								break;
								case Op.type_u8_s24_u30_s24List__lookupswitch:
									var matchArr:Array=codeStr.match(/label\d+/g);
									var matchStr:String=matchArr.shift();
									labelMark=labelMarkMark[matchStr+":"];
									if(labelMark){
										code=new Code(op,{default_offset:labelMark});
									}else{
										throw new Error("找不到对应的 labelMark: "+matchStr);
									}
									code.value.case_offsetV=new Vector.<LabelMark>();
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
								case Op.type_u8_u8_u30_u8_u30__debug:
									execResult=/^(\w+)\s+"(.*)"\s+(\w+)\s+(\w+)$/.exec(codeStr);
									if(execResult[0]===codeStr){
										code=new Code(op,{
											debug_type:int(execResult[1]),
											index:Xattr.unesc_xattr(execResult[2]),//- -
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
		}//end of CONFIG::toXMLAndInitByXML
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