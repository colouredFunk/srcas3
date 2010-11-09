/***
Codes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 10:45:54 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2{
	import flash.utils.ByteArray;
	public class Codes{
		public var codeV:Vector.<Code>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var codeId:int=-1;
			codeV=new Vector.<Code>();
			var code:Code;
			while(offset<endOffset){
				codeId++;
				
				codeV[codeId]=code=new Code();
				code.offset=offset;
				code.op=data[offset++];
				
				var opDataType:String=Op.opDataTypeV[code.op];
				
				if(opDataType){
					if(opDataType==Op.dataType_u8){
					}else{
						switch(opDataType){
							case Op.dataType_u8_u8:
								code.value=data[offset++];
							break;
							case Op.dataType_u8_u30:
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){code.value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{code.value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{code.value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{code.value=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{code.value=data[offset++];}
								//code.value
							break;
							case Op.dataType_u8_u30_u30:
								code.value={}
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){code.value.u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{code.value.u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{code.value.u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{code.value.u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{code.value.u30=data[offset++];}
								//code.value.u30
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){code.value.u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{code.value.u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{code.value.u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{code.value.u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{code.value.u30_2=data[offset++];}
								//code.value.u30_2
							break;
							case Op.dataType_u8_s24:
								code.value=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
								if(code.value&0x00008000){code.value|=0xffff0000}//最高位为1,表示负数
							break;
							case Op. dataType_u8_s24_u30_s24List:
								code.value={}
								code.value.default_offset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
								if(code.value.default_offset&0x00008000){code.value.default_offset|=0xffff0000}//最高位为1,表示负数
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var case_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_count=data[offset++];}
								//case_count
								
								case_count++;
								code.value.case_offsetV=new Vector.<int>(case_count);
								for(var i:int=0;i<case_count;i++){
									code.value.case_offsetV[i]=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
									if(code.value.case_offsetV[i]&0x00008000){code.value.case_offsetV[i]|=0xffff0000}//最高位为1,表示负数
								}
							break;
							case Op.dataType_u8_u8_u30_u8_u30:
								code.value={}
								code.value.debug_type=data[offset++];
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){code.value.index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{code.value.index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{code.value.index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{code.value.index=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{code.value.index=data[offset++];}
								//code.value.index
								
								code.value.reg=data[offset++];
								
								if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){code.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{code.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{code.value.extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{code.value.extra=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{code.value.extra=data[offset++];}
								//code.value.extra
							break;
							default:
								throw new Error("未知 opDataType: "+opDataType+", op="+code.op);
								//trace("未知 opDataType: "+opDataType+", op="+code.op);
								//return endOffset;
							break;
						}
					}
				}else{
					throw new Error("未知 op: "+code.op);
				}
			}
			
			if(offset==endOffset){
				
			}else{
				throw new Error("offset="+offset+", endOffset="+endOffset);
				//trace("offset="+offset+", endOffset="+endOffset);
			}
			return endOffset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			
			var offset:int=0;
			for each(var code:Code in codeV){
				data[offset++]=code.op;
				
				var opDataType:String=Op.opDataTypeV[code.op];
				
				if(opDataType==Op.dataType_u8){
				}else{
					switch(opDataType){
						case Op.dataType_u8_u8:
							data[offset++]=code.value;
						break;
						case Op.dataType_u8_u30:
							if(code.value>>>7){if(code.value>>>14){if(code.value>>>21){if(code.value>>>28){data[offset++]=(code.value&0x7f)|0x80;data[offset++]=((code.value>>>7)&0x7f)|0x80;data[offset++]=((code.value>>>14)&0x7f)|0x80;data[offset++]=((code.value>>>21)&0x7f)|0x80;data[offset++]=code.value>>>28;}else{data[offset++]=(code.value&0x7f)|0x80;data[offset++]=((code.value>>>7)&0x7f)|0x80;data[offset++]=((code.value>>>14)&0x7f)|0x80;data[offset++]=code.value>>>21;}}else{data[offset++]=(code.value&0x7f)|0x80;data[offset++]=((code.value>>>7)&0x7f)|0x80;data[offset++]=code.value>>>14;}}else{data[offset++]=(code.value&0x7f)|0x80;data[offset++]=code.value>>>7;}}else{data[offset++]=code.value;}
							//code.value
						break;
						case Op.dataType_u8_u30_u30:
							if(code.value.u30>>>7){if(code.value.u30>>>14){if(code.value.u30>>>21){if(code.value.u30>>>28){data[offset++]=(code.value.u30&0x7f)|0x80;data[offset++]=((code.value.u30>>>7)&0x7f)|0x80;data[offset++]=((code.value.u30>>>14)&0x7f)|0x80;data[offset++]=((code.value.u30>>>21)&0x7f)|0x80;data[offset++]=code.value.u30>>>28;}else{data[offset++]=(code.value.u30&0x7f)|0x80;data[offset++]=((code.value.u30>>>7)&0x7f)|0x80;data[offset++]=((code.value.u30>>>14)&0x7f)|0x80;data[offset++]=code.value.u30>>>21;}}else{data[offset++]=(code.value.u30&0x7f)|0x80;data[offset++]=((code.value.u30>>>7)&0x7f)|0x80;data[offset++]=code.value.u30>>>14;}}else{data[offset++]=(code.value.u30&0x7f)|0x80;data[offset++]=code.value.u30>>>7;}}else{data[offset++]=code.value.u30;}
							//code.value.u30
							
							if(code.value.u30_2>>>7){if(code.value.u30_2>>>14){if(code.value.u30_2>>>21){if(code.value.u30_2>>>28){data[offset++]=(code.value.u30_2&0x7f)|0x80;data[offset++]=((code.value.u30_2>>>7)&0x7f)|0x80;data[offset++]=((code.value.u30_2>>>14)&0x7f)|0x80;data[offset++]=((code.value.u30_2>>>21)&0x7f)|0x80;data[offset++]=code.value.u30_2>>>28;}else{data[offset++]=(code.value.u30_2&0x7f)|0x80;data[offset++]=((code.value.u30_2>>>7)&0x7f)|0x80;data[offset++]=((code.value.u30_2>>>14)&0x7f)|0x80;data[offset++]=code.value.u30_2>>>21;}}else{data[offset++]=(code.value.u30_2&0x7f)|0x80;data[offset++]=((code.value.u30_2>>>7)&0x7f)|0x80;data[offset++]=code.value.u30_2>>>14;}}else{data[offset++]=(code.value.u30_2&0x7f)|0x80;data[offset++]=code.value.u30_2>>>7;}}else{data[offset++]=code.value.u30_2;}
							//code.value.u30_2
						break;
						case Op.dataType_u8_s24:
							data[offset++]=code.value;
							data[offset++]=code.value>>8;
							data[offset++]=code.value>>16;
						break;
						case Op. dataType_u8_s24_u30_s24List:
							data[offset++]=code.value.default_offset;
							data[offset++]=code.value.default_offset>>8;
							data[offset++]=code.value.default_offset>>16;
							
							var case_count:int=code.value.case_offsetV.length-1;
							if(case_count>>>7){if(case_count>>>14){if(case_count>>>21){if(case_count>>>28){data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=((case_count>>>21)&0x7f)|0x80;data[offset++]=case_count>>>28;}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=case_count>>>21;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=case_count>>>14;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=case_count>>>7;}}else{data[offset++]=case_count;}
							//case_count
							
							for each(var case_offset:int in code.value.case_offsetV){
								data[offset++]=case_offset;
								data[offset++]=case_offset>>8;
								data[offset++]=case_offset>>16;
							}
						break;
						case Op.dataType_u8_u8_u30_u8_u30:
							data[offset++]=code.value.debug_type;
							
							if(code.value.index>>>7){if(code.value.index>>>14){if(code.value.index>>>21){if(code.value.index>>>28){data[offset++]=(code.value.index&0x7f)|0x80;data[offset++]=((code.value.index>>>7)&0x7f)|0x80;data[offset++]=((code.value.index>>>14)&0x7f)|0x80;data[offset++]=((code.value.index>>>21)&0x7f)|0x80;data[offset++]=code.value.index>>>28;}else{data[offset++]=(code.value.index&0x7f)|0x80;data[offset++]=((code.value.index>>>7)&0x7f)|0x80;data[offset++]=((code.value.index>>>14)&0x7f)|0x80;data[offset++]=code.value.index>>>21;}}else{data[offset++]=(code.value.index&0x7f)|0x80;data[offset++]=((code.value.index>>>7)&0x7f)|0x80;data[offset++]=code.value.index>>>14;}}else{data[offset++]=(code.value.index&0x7f)|0x80;data[offset++]=code.value.index>>>7;}}else{data[offset++]=code.value.index;}
							//code.value.index
							
							data[offset++]=code.value.reg;
							
							if(code.value.extra>>>7){if(code.value.extra>>>14){if(code.value.extra>>>21){if(code.value.extra>>>28){data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=((code.value.extra>>>14)&0x7f)|0x80;data[offset++]=((code.value.extra>>>21)&0x7f)|0x80;data[offset++]=code.value.extra>>>28;}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=((code.value.extra>>>14)&0x7f)|0x80;data[offset++]=code.value.extra>>>21;}}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=code.value.extra>>>14;}}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=code.value.extra>>>7;}}else{data[offset++]=code.value.extra;}
							//code.value.extra
						break;
						default:
							throw new Error("未知 opDataType: "+opDataType+", op="+code.op);
							//trace("未知 opDataType: "+opDataType+", op="+code.op);
						break;
					}
				}
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			if(codeV.length){
				var codesStr:String="";
				for each(var code:Code in codeV){
					codesStr+="\t\t\t\t\t"+Op.opNameV[code.op];
					
					var opDataType:String=Op.opDataTypeV[code.op];
					
					if(opDataType==Op.dataType_u8){
					}else{
						switch(opDataType){
							case Op.dataType_u8_u8:
								codesStr+=" "+code.value;
							break;
							case Op.dataType_u8_u30:
								codesStr+=" "+code.value;
							break;
							case Op.dataType_u8_u30_u30:
								codesStr+=" "+code.value.u30+","+code.value.u30_2;
							break;
							case Op.dataType_u8_s24:
								codesStr+=" "+code.value;
							break;
							case Op. dataType_u8_s24_u30_s24List:
								codesStr+=" "+code.value.default_offset+","+code.value.case_offsetV;
							break;
							case Op.dataType_u8_u8_u30_u8_u30:
								codesStr+=" "+code.value.debug_type+","+code.value.index+","+code.value.reg+","+code.value.extra;
							break;
							default:
								throw new Error("未知 opDataType: "+opDataType+", op="+code.op);
								//trace("未知 opDataType: "+opDataType+", op="+code.op);
							break;
						}
					}
					codesStr+="\n";
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
			codeV=new Vector.<Code>();
			var code:Code;
			for each(var codeStr:String in codeStrArr){
				var _codeStr:String=codeStr.replace(/^\s*|\s*$/g,"");
				if(_codeStr){
					if(_codeStr.indexOf("//")==0){
						continue;
					}
					var codeArr:Array=_codeStr.split(/\s+/);
					if(Op.ops[codeArr[0]]>=0){
						codeId++;
						
						codeV[codeId]=code=new Code();
						code.op=Op.ops[codeArr[0]];
						
						var opDataType:String=Op.opDataTypeV[code.op];
						
						if(opDataType==Op.dataType_u8){
						}else{
							codeArr=codeArr[1].split(/[,\s]+/);
							switch(opDataType){
								case Op.dataType_u8_u8:
								case Op.dataType_u8_u30:
								case Op.dataType_u8_s24:
									code.value=int(codeArr[0]);
								break;
								case Op.dataType_u8_u30_u30:
									code.value={
										u30:int(codeArr[0]),
										u30_2:int(codeArr[1])
									}
								break;
								case Op. dataType_u8_s24_u30_s24List:
									code.value={
										default_offset:int(codeArr.shift()),
										case_offsetV:new Vector.<int>()
									}
									var i:int=-1;
									for each(var case_offset_str:String in codeArr){
										i++;
										code.value.case_offsetV[i]=int(case_offset_str);
									}
								break;
								case Op.dataType_u8_u8_u30_u8_u30:
									code.value={
										debug_type:int(codeArr[0]),
										index:int(codeArr[1]),
										reg:int(codeArr[2]),
										extra:int(codeArr[3])
									}
								break;
								default:
									throw new Error("未知 opDataType: "+opDataType+", op="+code.op);
									//trace("未知 opDataType: "+opDataType+", op="+code.op);
								break;
							}
						}
					}else{
						throw new Error("未知 _codeStr: "+_codeStr);
					}
				}
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
