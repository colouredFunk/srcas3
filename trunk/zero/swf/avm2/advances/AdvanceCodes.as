/***
AdvanceCodes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:28:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import flash.utils.ByteArray;
	
	import zero.Outputer;
	import zero.swf.avm2.advances.AdvanceABC;
	import zero.swf.avm2.advances.AdvanceMultiname_info;
	import zero.swf.avm2.advances.Member;
	

	public class AdvanceCodes{
		public var codeV:Vector.<BaseCode>;
		public function AdvanceCodes(){
		}
		public function initByInfo(
			data:ByteArray,
			exception_infoV:Vector.<AdvanceException_info>
		):void{
			
			var labelId:int=0;
			var labelMarkArr:Array=new Array();
			var codeByOffsetArr:Array=new Array();
			
			var offset:int=0;
			var endOffset:int=data.length;
			
			var advanceCode:AdvanceCode,labelMark:LabelMark,exception_info:AdvanceException_info;
			var u30_1:int,u30_2:int,jumpOffset:int,jumpPos:int;
			
			while(offset<endOffset){
				advanceCode=new AdvanceCode(data[offset]);
				codeByOffsetArr[offset]=advanceCode;
				offset++;
				
				var opDataType:String=Op.opDataTypeV[advanceCode.op];
				
				if(opDataType){
					if(opDataType==Op.dataType_u8){
					}else{
						switch(opDataType){
							case Op.dataType_u8_u8:
								
								//Op.type_u8_u8__value_byte
								advanceCode.value=data[offset++];
							break;
							case Op.dataType_u8_u30:
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
								//u30_1
								switch(Op.opTypeV[advanceCode.op]){
									case Op.type_u8_u30__value_int:
									case Op.type_u8_u30__scope:
									case Op.type_u8_u30__slot:
									case Op.type_u8_u30__register:
									case Op.type_u8_u30__args:
										advanceCode.value=u30_1;
									break;
									case Op.type_u8_u30__int:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.INTEGER);
									break;
									case Op.type_u8_u30__uint:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.UINTEGER);
									break;
									case Op.type_u8_u30__double:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.DOUBLE);
									break;
									case Op.type_u8_u30__string:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.STRING);
									break;
									case Op.type_u8_u30__namespace_info:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.NAMESPACE_INFO);
									break;
									case Op.type_u8_u30__multiname_info:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.MULTINAME_INFO);
									break;
									case Op.type_u8_u30__method:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.METHOD);
									break;
									case Op.type_u8_u30__class:
										advanceCode.value=AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.CLASS);
									break;
									case Op.type_u8_u30__exception_info:
										advanceCode.value={
											exception_info:exception_infoV[u30_1]
										};
										
										labelMark=labelMarkArr[advanceCode.value.exception_info.from];
										if(labelMark){
										}else{
											labelMarkArr[advanceCode.value.exception_info.from]=labelMark=new LabelMark();
											labelMark.labelId=labelId++;
										}
										advanceCode.value.from=labelMark;
										
										labelMark=labelMarkArr[advanceCode.value.exception_info.to];
										if(labelMark){
										}else{
											labelMarkArr[advanceCode.value.exception_info.to]=labelMark=new LabelMark();
											labelMark.labelId=labelId++;
										}
										advanceCode.value.to=labelMark;
										
										labelMark=labelMarkArr[advanceCode.value.exception_info.target];
										if(labelMark){
										}else{
											labelMarkArr[advanceCode.value.exception_info.target]=labelMark=new LabelMark();
											labelMark.labelId=labelId++;
										}
										advanceCode.value.target=labelMark;
										
									break;
									case Op.type_u8_u30__finddef:
										throw new Error("未处理, op="+advanceCode.op+", opType="+Op.opTypeV[advanceCode.op]);
									break;
								}
							break;
							case Op.dataType_u8_u30_u30:
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
								//u30_1
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
								//u30_2
								switch(Op.opTypeV[advanceCode.op]){
									case Op.type_u8_u30_u30__register_register:
										advanceCode.value={
											register1:u30_1,
											register2:u30_2
										}
									break;	
									case Op.type_u8_u30_u30__multiname_info_args:
										advanceCode.value={
											multiname_info:AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.MULTINAME_INFO),
											args:u30_2
										}
									break;
									case Op.type_u8_u30_u30__method_args:
										advanceCode.value={
											method:AdvanceABC.currInstance.getInfoByIdAndMemberType(u30_1,Member.METHOD),
											args:u30_2
										}
									break;
								}
							break;
							case Op.dataType_u8_s24:
								
								//Op.type_u8_s24__branch
								jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
								if(jumpOffset&0x00008000){jumpOffset|=0xffff0000}//最高位为1,表示负数
								
								jumpPos=offset+jumpOffset;
								if(jumpPos<0||jumpPos>endOffset){
									if(lastCodeIsReturn(codeByOffsetArr)){
										codeByOffsetArr.pop();
										Outputer.output("return 后面的异常跳转，已忽略 offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset,"green");
										continue;
									}
									Outputer.output("dataType_u8_s24 可能是扰码: offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset+", 跳转命令只允许跳至代码开头和代码末尾之间的位置","brown");
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
								advanceCode.value=labelMark;
							break;
							case Op.dataType_u8_s24_u30_s24List:
								
								//Op.type_u8_s24_u30_s24List__lookupswitch
								
								//The base location is the address of the lookupswitch instruction itself.
								var lookupswitch_startOffset:int=offset-1;
								
								jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
								if(jumpOffset&0x00008000){jumpOffset|=0xffff0000}//最高位为1,表示负数
								
								jumpPos=lookupswitch_startOffset+jumpOffset;
								
								if(jumpPos<0||jumpPos>endOffset){
									Outputer.output("dataType_u8_s24_u30_s24List default_offset 可能是扰码: offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset+", 跳转命令只允许跳至代码开头和代码末尾之间的位置","brown");
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
								advanceCode.value={default_offset:labelMark};
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var case_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_count=data[offset++];}
								//case_count
								
								case_count++;
								advanceCode.value.case_offsetV=new Vector.<LabelMark>(case_count);
								for(var i:int=0;i<case_count;i++){
									//Op.type_u8_s24_u30_s24List__lookupswitch
									jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
									if(jumpOffset&0x00008000){jumpOffset|=0xffff0000}//最高位为1,表示负数
									
									jumpPos=lookupswitch_startOffset+jumpOffset;
									
									if(jumpPos<0||jumpPos>endOffset){
										Outputer.output("dataType_u8_s24_u30_s24List case_offset 可能是扰码: offset="+offset+", jumpPos="+jumpPos+", endOffset="+endOffset+", 跳转命令只允许跳至代码开头和代码末尾之间的位置","brown");
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
									advanceCode.value.case_offsetV[i]=labelMark;
								}
							break;
							case Op.dataType_u8_u8_u30_u8_u30:
								
								//Op.type_u8_u8_u30_u8_u30__debug
								advanceCode.value={debug_type:data[offset++]};
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var debug_index:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{debug_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{debug_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{debug_index=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{debug_index=data[offset++];}
								//debug_index
								
								advanceCode.value.index=AdvanceABC.currInstance.getInfoByIdAndMemberType(debug_index,Member.STRING);
								
								advanceCode.value.reg=data[offset++];
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){advanceCode.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{advanceCode.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{advanceCode.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{advanceCode.value.extra=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{advanceCode.value.extra=data[offset++];}
								//advanceCode.value.extra
							break;
							default:
								throw new Error("未知 opDataType: "+opDataType+", op="+advanceCode.op);
							break;
						}
					}
				}else{
					throw new Error("未知 op: "+advanceCode.op);
				}
			}
			
			//trace("offset="+offset+",endOffset="+endOffset);
			if(offset===endOffset){
				
			}else{
				throw new Error("offset="+offset+",endOffset="+endOffset);
			}
			
			codeV=new Vector.<BaseCode>();
			var codeId:int=0;
			//endOffset++;
			for(offset=0;offset<=endOffset;offset++){
				if(labelMarkArr[offset]){
					codeV[codeId++]=labelMarkArr[offset];
				}
				if(codeByOffsetArr[offset]){
					codeV[codeId++]=codeByOffsetArr[offset];
				}
			}
		}
		private function lastCodeIsReturn(codeByOffsetArr:Array):Boolean{
			var prevCodeOffset:int=codeByOffsetArr.length-1;
			while(--prevCodeOffset>=0){
				if(codeByOffsetArr[prevCodeOffset]){
					switch(codeByOffsetArr[prevCodeOffset].op){
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
		public function toData(exception_infoV:Vector.<AdvanceException_info>):ByteArray{
			var data:ByteArray=new ByteArray();
			
			var posMarkArr:Array=new Array();//记录 branch, newcatch, lookupswitch 的位置及相关的 label 位置
			
			var offset:int=0;
			
			var u30_1:int,u30_2:int,jumpOffset:int;
			
			var advanceCode:AdvanceCode,labelMark:LabelMark;
			
			for each(var baseCode:BaseCode in codeV){
				if(baseCode is LabelMark){
					(baseCode as LabelMark).pos=offset;
				}else{
					advanceCode=baseCode as AdvanceCode;
					data[offset++]=advanceCode.op;
					
					var opDataType:String=Op.opDataTypeV[advanceCode.op];
					
					if(opDataType==Op.dataType_u8){
					}else{
						switch(opDataType){
							case Op.dataType_u8_u8:
								
								//Op.type_u8_u8__value_byte
								data[offset++]=advanceCode.value;
							break;
							case Op.dataType_u8_u30:
								switch(Op.opTypeV[advanceCode.op]){
									case Op.type_u8_u30__value_int:
									case Op.type_u8_u30__scope:
									case Op.type_u8_u30__slot:
									case Op.type_u8_u30__register:
									case Op.type_u8_u30__args:
										u30_1=advanceCode.value;
									break;
									case Op.type_u8_u30__int:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.INTEGER);
									break;
									case Op.type_u8_u30__uint:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.UINTEGER);
									break;
									case Op.type_u8_u30__double:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.DOUBLE);
									break;
									case Op.type_u8_u30__string:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.STRING);
									break;
									case Op.type_u8_u30__namespace_info:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.NAMESPACE_INFO);
									break;
									case Op.type_u8_u30__multiname_info:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.MULTINAME_INFO);
									break;
									case Op.type_u8_u30__method:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.METHOD);
									break;
									case Op.type_u8_u30__class:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value,Member.CLASS);
									break;
									case Op.type_u8_u30__exception_info:
										u30_1=exception_infoV.length;
										exception_infoV[u30_1]=advanceCode.value.exception_info;
										posMarkArr[offset]=advanceCode;
									break;
									case Op.type_u8_u30__finddef:
										throw new Error("未处理, op="+advanceCode.op+", opType="+Op.opTypeV[advanceCode.op]);
									break;
								}
								
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							case Op.dataType_u8_u30_u30:
								switch(Op.opTypeV[advanceCode.op]){
									case Op.type_u8_u30_u30__register_register:
										u30_1=advanceCode.value.register1;
										u30_2=advanceCode.value.register2;
									break;
									case Op.type_u8_u30_u30__multiname_info_args:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value.multiname_info,Member.MULTINAME_INFO),
										u30_2=advanceCode.value.args;
									break;
									case Op.type_u8_u30_u30__method_args:
										u30_1=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value.method,Member.METHOD),
										u30_2=advanceCode.value.args;
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
								posMarkArr[offset]=advanceCode.value;
							break;
							
							case Op.dataType_u8_s24_u30_s24List:
								//Op.type_u8_s24_u30_s24List__lookupswitch
								
								//The base location is the address of the lookupswitch instruction itself.
								posMarkArr[offset-1]=advanceCode;
								
								advanceCode.value.default_offset_startPos=offset;
								
								//先用 0 占位，后面一次性写入
								data[offset++]=0x00;
								data[offset++]=0x00;
								data[offset++]=0x00;
								
								var case_count:int=advanceCode.value.case_offsetV.length-1;
								if(case_count>>>7){if(case_count>>>14){if(case_count>>>21){if(case_count>>>28){data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=((case_count>>>21)&0x7f)|0x80;data[offset++]=case_count>>>28;}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=case_count>>>21;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=case_count>>>14;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=case_count>>>7;}}else{data[offset++]=case_count;}
								//case_count
								
								advanceCode.value.case_offset_startPos=offset;
								for each(labelMark in advanceCode.value.case_offsetV){
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									data[offset++]=0x00;
								}
							break;
							
							case Op.dataType_u8_u8_u30_u8_u30:
								
								//Op.type_u8_u8_u30_u8_u30__debug
								data[offset++]=advanceCode.value.debug_type;
								
								var debug_index:int=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.value.index,Member.STRING);
								
								if(debug_index>>>7){if(debug_index>>>14){if(debug_index>>>21){if(debug_index>>>28){data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=((debug_index>>>14)&0x7f)|0x80;data[offset++]=((debug_index>>>21)&0x7f)|0x80;data[offset++]=debug_index>>>28;}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=((debug_index>>>14)&0x7f)|0x80;data[offset++]=debug_index>>>21;}}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=debug_index>>>14;}}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=debug_index>>>7;}}else{data[offset++]=debug_index;}
								//debug_index
								
								data[offset++]=advanceCode.value.reg;
								
								if(advanceCode.value.extra>>>7){if(advanceCode.value.extra>>>14){if(advanceCode.value.extra>>>21){if(advanceCode.value.extra>>>28){data[offset++]=(advanceCode.value.extra&0x7f)|0x80;data[offset++]=((advanceCode.value.extra>>>7)&0x7f)|0x80;data[offset++]=((advanceCode.value.extra>>>14)&0x7f)|0x80;data[offset++]=((advanceCode.value.extra>>>21)&0x7f)|0x80;data[offset++]=advanceCode.value.extra>>>28;}else{data[offset++]=(advanceCode.value.extra&0x7f)|0x80;data[offset++]=((advanceCode.value.extra>>>7)&0x7f)|0x80;data[offset++]=((advanceCode.value.extra>>>14)&0x7f)|0x80;data[offset++]=advanceCode.value.extra>>>21;}}else{data[offset++]=(advanceCode.value.extra&0x7f)|0x80;data[offset++]=((advanceCode.value.extra>>>7)&0x7f)|0x80;data[offset++]=advanceCode.value.extra>>>14;}}else{data[offset++]=(advanceCode.value.extra&0x7f)|0x80;data[offset++]=advanceCode.value.extra>>>7;}}else{data[offset++]=advanceCode.value.extra;}
								//advanceCode.value.extra
							break;
							
							default:
								throw new Error("未知 opDataType: "+opDataType+", op="+advanceCode.op);
							break;
						}
					}
				}
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
						advanceCode=posMarkArr[offset];
						if(advanceCode.op==Op.newcatch){
							advanceCode.value.exception_info.from=advanceCode.value.from.pos;
							advanceCode.value.exception_info.to=advanceCode.value.to.pos;
							advanceCode.value.exception_info.target=advanceCode.value.target.pos;
						}else if(advanceCode.op==Op.lookupswitch){
							var case_offset:int;
							
							labelMark=advanceCode.value.default_offset;
							jumpOffset=labelMark.pos-offset;
							case_offset=advanceCode.value.default_offset_startPos;
							data[case_offset++]=jumpOffset;
							data[case_offset++]=jumpOffset>>8;
							data[case_offset++]=jumpOffset>>16;
							case_offset=advanceCode.value.case_offset_startPos;
							for each(labelMark in advanceCode.value.case_offsetV){
								jumpOffset=labelMark.pos-offset;
								data[case_offset++]=jumpOffset;
								data[case_offset++]=jumpOffset>>8;
								data[case_offset++]=jumpOffset>>16;
							}
						}else{
							throw new Error("发现 posMarkArr 里的奇怪的 advanceCode, advanceCode.op="+advanceCode.op);
						}
					}
				}
			}
			
			return data;
		}
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var advanceCode:AdvanceCode,labelMark:LabelMark;
			var stringXML:XML=<string/>;//用来转换字符串的
			//var specialXMLMark:Object=new Object();//用来记录一些实在不适合在汇编码里显示的东西，例如匿名函数
			if(codeV.length){
				var codesStr:String="";
				for each(var baseCode:BaseCode in codeV){
					if(baseCode is LabelMark){
						codesStr+="\t\t\t\tlabel"+(baseCode as LabelMark).labelId+":\n";
					}else{
						advanceCode=baseCode as AdvanceCode;
						codesStr+="\t\t\t\t\t"+Op.opNameV[advanceCode.op];
						var opType:String=Op.opTypeV[advanceCode.op];
						
						if(opType==Op.type_u8){
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
									codesStr+=" "+advanceCode.value;
								break;
								case Op.type_u8_u30__string:
									stringXML.@value=advanceCode.value;
									codesStr+=" "+stringXML.toXMLString().replace(/<string value=(".*")\/>/,"$1").replace(/>/g,"&gt;");//- -
								break;
								case Op.type_u8_u30__namespace_info:
									codesStr+=" "+advanceCode.value.toXML("namespace_info").toXMLString().replace(/[\r\n]+/g,"");
								break;
								case Op.type_u8_u30__multiname_info:
									codesStr+=" "+advanceCode.value.toXML("multiname_info").toXMLString().replace(/[\r\n]+/g,"");
								break;
								case Op.type_u8_u30__method:
									stringXML.@value=advanceCode.value.toXML("method").toXMLString();
									codesStr+=" "+stringXML.toXMLString().replace(/<string value=(".*")\/>/,"$1").replace(/>/g,"&gt;");//- -
								break;
								case Op.type_u8_u30__class:
									codesStr+=" "+advanceCode.value.getMarkKey();
								break;
								case Op.type_u8_u30__exception_info:
									codesStr+=" "+advanceCode.value.exception_info.toXML("exception_info").toXMLString().replace(/[\r\n]+/g,"")+" from:label"+advanceCode.value.from.labelId+" to:label"+advanceCode.value.to.labelId+" target:label"+advanceCode.value.target.labelId;
								break;
								case Op.type_u8_u30__finddef:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								case Op.type_u8_u30_u30__register_register:
									codesStr+=" "+advanceCode.value.register1+" "+advanceCode.value.register2;
								break;
								case Op.type_u8_u30_u30__multiname_info_args:
									codesStr+=" "+advanceCode.value.multiname_info.toXML("multiname_info").toXMLString().replace(/[\r\n]+/g,"")+" "+advanceCode.value.args;
								break;
								case Op.type_u8_u30_u30__method_args:
									stringXML.@value=advanceCode.value.method.toXML("method").toXMLString();
									codesStr+=" "+stringXML.toXMLString().replace(/<string value=(".*")\/>/,"$1").replace(/>/g,"&gt;")+" "+advanceCode.value.args;//- -
								break;
								
								case Op.type_u8_s24__branch:
									codesStr+=" label"+advanceCode.value.labelId;
								break;
								
								case Op.type_u8_s24_u30_s24List__lookupswitch:
									codesStr+=" label"+advanceCode.value.default_offset.labelId;
									for each(labelMark in advanceCode.value.case_offsetV){
										codesStr+=" label"+labelMark.labelId;
									}
								break;
								
								case Op.type_u8_u8_u30_u8_u30__debug:
									codesStr+=" "+advanceCode.value.debug_type+" "+stringXML.toXMLString().replace(/<string value=(".*")\/>/,"$1").replace(/>/g,"&gt;")+" "+advanceCode.value.reg+" "+advanceCode.value.extra;//- -
								break;
								
								default:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
							}
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
		public function initByXML(xml:XML):void{
			var codeStrArr:Array=xml.toString().split("\n");
			var codeId:int=-1;
			codeV=new Vector.<BaseCode>();
			var advanceCode:AdvanceCode;
			
			var codeStr:String;
			var i:int=codeStrArr.length;
			var labelMarkMark:Object=new Object();
			var labelMark:LabelMark;
			var matchArr:Array,matchStr:String,numStrArr:Array;
			
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
				if(/label(\d+):/.test(codeStr)){
					if(labelMarkMark[codeStr]){
						throw new Error("重复的 labelMark: "+codeStr);
					}
					labelMarkMark[codeStr]=labelMark=new LabelMark();
					labelMark.labelId=int(codeStr.replace(/label(\d+):/,"$1"));
				}//else if(exceptionPosMarkReg.test(str)){
				//	if(exceptionPosMarkMark[str]){
				//		throw new Error("重复的 exceptionPosMark: "+str);
				//	}
				//	exceptionPosMarkMark[str]=exceptionPosMark=new ExceptionPosMark();
				//	exceptionPosMark.markId=int(str.replace(exceptionPosMarkReg,"$1"));
				//}
			}
			for each(codeStr in codeStrArr){
				if(/label(\d+):/.test(codeStr)){
					codeV[++codeId]=labelMarkMark[codeStr];
				}else{
					var pos:int=codeStr.search(/\s+/);
					var opStr:String;
					if(pos==-1){
						opStr=codeStr;
					}else{
						opStr=codeStr.substr(0,pos);
					}
					if(Op.ops[opStr]>=0){
						codeV[++codeId]=advanceCode=new AdvanceCode(Op.ops[opStr]);
						
						var opType:String=Op.opTypeV[advanceCode.op];
						
						if(opType==Op.type_u8){
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
									advanceCode.value=int(codeStr.replace(/\s+/g,""));//支持 16进制的整数表示
								break;
								case Op.type_u8_u30__double:
									advanceCode.value=Number(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__string:
									advanceCode.value=new XML("<string value="+codeStr+"/>").@value.toString();//- -
								break;
								case Op.type_u8_u30__namespace_info:
									advanceCode.value=AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr),Member.NAMESPACE_INFO);
								break;
								case Op.type_u8_u30__multiname_info:
									advanceCode.value=AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr),Member.MULTINAME_INFO);
								break;
								case Op.type_u8_u30__method:
									advanceCode.value=AdvanceABC.currInstance.getInfoByXMLAndMemberType(
										new XML(
											new XML("<string value="+codeStr+"/>").@value.toString()
										),Member.METHOD
									);
								break;
								case Op.type_u8_u30__class:
									advanceCode.value=AdvanceABC.currInstance.getInfoByMarkKeyAndMemberType(codeStr,Member.CLASS);
								break;
								case Op.type_u8_u30__exception_info:
									advanceCode.value={exception_info:new AdvanceException_info()};
									
									matchArr=codeStr.match(/from:label\d+\s+to:label\d+\s+target:label\d+$/);
									numStrArr=matchArr[0].replace(/from|to|target|label|:/g,"").split(/\s+/);
									
									advanceCode.value.from=labelMarkMark["label"+numStrArr[0]+":"];
									if(advanceCode.value.from){
									}else{
										throw new Error("找不到对应的 advanceCode.value.from: "+codeStr);
									}
									
									advanceCode.value.to=labelMarkMark["label"+numStrArr[1]+":"];
									if(advanceCode.value.to){
									}else{
										throw new Error("找不到对应的 advanceCode.value.to: "+codeStr);
									}
									
									advanceCode.value.target=labelMarkMark["label"+numStrArr[2]+":"];
									if(advanceCode.value.target){
									}else{
										throw new Error("找不到对应的 advanceCode.value.target: "+codeStr);
									}
									
									advanceCode.value.exception_info.initByXML(new XML(codeStr.replace(/from:label\d+\s+to:label\d+\s+target:label\d+$/,"")));
								break;
								case Op.type_u8_u30__finddef:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								case Op.type_u8_u30_u30__register_register:
									matchArr=codeStr.match(/\w+/g);
									advanceCode.value={
										register1:int(matchArr[0]),
										register2:int(matchArr[1])
									}
								break;
								case Op.type_u8_u30_u30__multiname_info_args:
									pos=codeStr.search(/\s+\d+$/);//不支持 16进制的整数表示
									if(pos>0){
										advanceCode.value={
											multiname_info:AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr.substr(0,pos)),Member.MULTINAME_INFO),
											args:int(codeStr.substr(pos).replace(/\D+/g,""))//不支持 16进制的整数表示
										}
									}else{
										throw new Error("找不到 args: "+codeStr);
									}
								break;
								case Op.type_u8_u30_u30__method_args:
									pos=codeStr.search(/\s+\d+$/);//不支持 16进制的整数表示
									if(pos>0){
										advanceCode.value={
											method:AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr.substr(0,pos)),Member.METHOD),
											args:int(codeStr.substr(pos).replace(/\D+/g,""))//不支持 16进制的整数表示
										}
									}else{
										throw new Error("找不到 args: "+codeStr);
									}
								break;
								case Op.type_u8_s24__branch:
									labelMark=labelMarkMark[codeStr+":"];
									if(labelMark){
										advanceCode.value=labelMark;
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
								break;
								case Op.type_u8_s24_u30_s24List__lookupswitch:
									matchArr=codeStr.match(/label\d+/g);
									matchStr=matchArr.shift();
									labelMark=labelMarkMark[matchStr+":"];
									if(labelMark){
										advanceCode.value={default_offset:labelMark};
									}else{
										throw new Error("找不到对应的 labelMark: "+matchStr);
									}
									advanceCode.value.case_offsetV=new Vector.<LabelMark>();
									i=0;
									for each(matchStr in matchArr){
										labelMark=labelMarkMark[matchStr+":"];
										if(labelMark){
											advanceCode.value.case_offsetV[i++]=labelMark;
										}else{
											throw new Error("找不到对应的 labelMark: "+matchStr);
										}
									}
								break;
								case Op.type_u8_u8_u30_u8_u30__debug:
									matchArr=codeStr.match(/".*"/);
									numStrArr=codeStr.replace(matchArr[0],"").split(/\s+/);
									advanceCode.value={
										debug_type:int(numStrArr[0]),
										index:new XML("<string value="+matchArr[0]+"/>").@value.toString(),//- -
										reg:int(numStrArr[1]),
										extra:int(numStrArr[2])
									}
								break;
								default:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
							}
						}
					}else{
						throw new Error("未知 codeStr: "+codeStr);
					}
				}
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