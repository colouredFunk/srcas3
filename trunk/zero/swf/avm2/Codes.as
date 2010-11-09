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
	public class Codes extends AVM2Obj{
		public var codeV:Vector.<Array>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var codeId:int=-1;
			codeV=new Vector.<Array>();
			var op:int;
			while(offset<endOffset){
				codeId++;
				
				op=data[offset++];
				codeV[codeId]=[op];
				var opDataType:String=Op.opDataTypeV[op];
				if(opDataType==Op.dataType_u8){
				}else{
					switch(opDataType){
						case Op.dataType_u8_u8:
							codeV[codeId][1]=data[offset++];
						break;
						case Op.dataType_u8_u30:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeV[codeId][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{codeV[codeId][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{codeV[codeId][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{codeV[codeId][1]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{codeV[codeId][1]=data[offset++];}
							//codeV[codeId][1]
						break;
						case Op.dataType_u8_u30_u30:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeV[codeId][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{codeV[codeId][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{codeV[codeId][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{codeV[codeId][1]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{codeV[codeId][1]=data[offset++];}
							//codeV[codeId][1]
							
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeV[codeId][2]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{codeV[codeId][2]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{codeV[codeId][2]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{codeV[codeId][2]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{codeV[codeId][2]=data[offset++];}
							//codeV[codeId][2]
						break;
						case Op.dataType_u8_s24:
							codeV[codeId][1]=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
							if(codeV[codeId][1]&0x00008000){codeV[codeId][1]|=0xffff0000}//最高位为1,表示负数
						break;
						case Op. dataType_u8_s24_u30_s24List:
							codeV[codeId][1]=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
							if(codeV[codeId][1]&0x00008000){codeV[codeId][1]|=0xffff0000}//最高位为1,表示负数
							
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var case_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_count=data[offset++];}
							//case_count
							
							case_count++;
							codeV[codeId][2]=new Vector.<int>(case_count);
							for(var i:int=0;i<case_count;i++){
								codeV[codeId][2][i]=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
								if(codeV[codeId][2][i]&0x00008000){codeV[codeId][2][i]|=0xffff0000}//最高位为1,表示负数
							}
						break;
						case Op.dataType_u8_u8_u30_u8_u30:
							codeV[codeId][1]=data[offset++];
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeV[codeId][2]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{codeV[codeId][2]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{codeV[codeId][2]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{codeV[codeId][2]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{codeV[codeId][2]=data[offset++];}
							//codeV[codeId][2]
							
							codeV[codeId][3]=data[offset++];
							
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeV[codeId][4]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{codeV[codeId][4]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{codeV[codeId][4]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{codeV[codeId][4]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{codeV[codeId][4]=data[offset++];}
							//codeV[codeId][4]
						break;
						default:
							throw new Error("未知 opDataType: "+opDataType+", op="+op);
							//trace("未知 opDataType: "+opDataType+", op="+op);
							//return endOffset;
						break;
					}
				}
			}
			
			if(offset==endOffset){
				
			}else{
				throw new Error("offset="+offset+", endOffset="+endOffset);
				//trace("offset="+offset+", endOffset="+endOffset);
			}
			return endOffset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			
			var offset:int=0;
			var op:int;
			for each(var code:Array in codeV){
				op=code[0];
				data[offset++]=op;
				var opDataType:String=Op.opDataTypeV[op];
				if(opDataType==Op.dataType_u8){
				}else{
					switch(opDataType){
						case Op.dataType_u8_u8:
							data[offset++]=code[1];
						break;
						case Op.dataType_u8_u30:
							if(code[1]>>>7){if(code[1]>>>14){if(code[1]>>>21){if(code[1]>>>28){data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=((code[1]>>>7)&0x7f)|0x80;data[offset++]=((code[1]>>>14)&0x7f)|0x80;data[offset++]=((code[1]>>>21)&0x7f)|0x80;data[offset++]=code[1]>>>28;}else{data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=((code[1]>>>7)&0x7f)|0x80;data[offset++]=((code[1]>>>14)&0x7f)|0x80;data[offset++]=code[1]>>>21;}}else{data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=((code[1]>>>7)&0x7f)|0x80;data[offset++]=code[1]>>>14;}}else{data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=code[1]>>>7;}}else{data[offset++]=code[1];}
							//code[1]
						break;
						case Op.dataType_u8_u30_u30:
							if(code[1]>>>7){if(code[1]>>>14){if(code[1]>>>21){if(code[1]>>>28){data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=((code[1]>>>7)&0x7f)|0x80;data[offset++]=((code[1]>>>14)&0x7f)|0x80;data[offset++]=((code[1]>>>21)&0x7f)|0x80;data[offset++]=code[1]>>>28;}else{data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=((code[1]>>>7)&0x7f)|0x80;data[offset++]=((code[1]>>>14)&0x7f)|0x80;data[offset++]=code[1]>>>21;}}else{data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=((code[1]>>>7)&0x7f)|0x80;data[offset++]=code[1]>>>14;}}else{data[offset++]=(code[1]&0x7f)|0x80;data[offset++]=code[1]>>>7;}}else{data[offset++]=code[1];}
							//code[1]
							
							if(code[2]>>>7){if(code[2]>>>14){if(code[2]>>>21){if(code[2]>>>28){data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=((code[2]>>>7)&0x7f)|0x80;data[offset++]=((code[2]>>>14)&0x7f)|0x80;data[offset++]=((code[2]>>>21)&0x7f)|0x80;data[offset++]=code[2]>>>28;}else{data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=((code[2]>>>7)&0x7f)|0x80;data[offset++]=((code[2]>>>14)&0x7f)|0x80;data[offset++]=code[2]>>>21;}}else{data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=((code[2]>>>7)&0x7f)|0x80;data[offset++]=code[2]>>>14;}}else{data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=code[2]>>>7;}}else{data[offset++]=code[2];}
							//code[2]
						break;
						case Op.dataType_u8_s24:
							data[offset++]=code[1];
							data[offset++]=code[1]>>8;
							data[offset++]=code[1]>>16;
						break;
						case Op. dataType_u8_s24_u30_s24List:
							data[offset++]=code[1];
							data[offset++]=code[1]>>8;
							data[offset++]=code[1]>>16;
							
							var case_count:int=code[2].length-1;
							if(case_count>>>7){if(case_count>>>14){if(case_count>>>21){if(case_count>>>28){data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=((case_count>>>21)&0x7f)|0x80;data[offset++]=case_count>>>28;}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=case_count>>>21;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=case_count>>>14;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=case_count>>>7;}}else{data[offset++]=case_count;}
							//case_count
							
							for each(var case_offset:int in code[2]){
								data[offset++]=case_offset;
								data[offset++]=case_offset>>8;
								data[offset++]=case_offset>>16;
							}
						break;
						case Op.dataType_u8_u8_u30_u8_u30:
							data[offset++]=code[1];
							
							if(code[2]>>>7){if(code[2]>>>14){if(code[2]>>>21){if(code[2]>>>28){data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=((code[2]>>>7)&0x7f)|0x80;data[offset++]=((code[2]>>>14)&0x7f)|0x80;data[offset++]=((code[2]>>>21)&0x7f)|0x80;data[offset++]=code[2]>>>28;}else{data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=((code[2]>>>7)&0x7f)|0x80;data[offset++]=((code[2]>>>14)&0x7f)|0x80;data[offset++]=code[2]>>>21;}}else{data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=((code[2]>>>7)&0x7f)|0x80;data[offset++]=code[2]>>>14;}}else{data[offset++]=(code[2]&0x7f)|0x80;data[offset++]=code[2]>>>7;}}else{data[offset++]=code[2];}
							//code[2]
							
							data[offset++]=code[3];
							
							if(code[4]>>>7){if(code[4]>>>14){if(code[4]>>>21){if(code[4]>>>28){data[offset++]=(code[4]&0x7f)|0x80;data[offset++]=((code[4]>>>7)&0x7f)|0x80;data[offset++]=((code[4]>>>14)&0x7f)|0x80;data[offset++]=((code[4]>>>21)&0x7f)|0x80;data[offset++]=code[4]>>>28;}else{data[offset++]=(code[4]&0x7f)|0x80;data[offset++]=((code[4]>>>7)&0x7f)|0x80;data[offset++]=((code[4]>>>14)&0x7f)|0x80;data[offset++]=code[4]>>>21;}}else{data[offset++]=(code[4]&0x7f)|0x80;data[offset++]=((code[4]>>>7)&0x7f)|0x80;data[offset++]=code[4]>>>14;}}else{data[offset++]=(code[4]&0x7f)|0x80;data[offset++]=code[4]>>>7;}}else{data[offset++]=code[4];}
							//code[4]
						break;
						default:
							throw new Error("未知 opDataType: "+opDataType+", op="+op);
							//trace("未知 opDataType: "+opDataType+", op="+op);
						break;
					}
				}
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			if(codeV.length){
				var codesStr:String="";
				for each(var code:Array in codeV){
					codesStr+="\t\t\t\t\t"+Op.opNameV[code[0]];
					if(code.length>1){
						codesStr+=" "+code.slice(1);
					}
					codesStr+="\n";
				}
				return new XML("<"+xmlName+"><![CDATA[\n"+
					codesStr
				+"\t\t\t\t]]></"+xmlName+">");
			}
			return <{xmlName}/>;
		}
		override public function initByXML(xml:XML):void{
			var codeStrArr:Array=xml.toString().split("\n");
			var codeId:int=-1;
			codeV=new Vector.<Array>();
			var op:int;
			for each(var codeStr:String in codeStrArr){
				var _codeStr:String=codeStr.replace(/^\s*|\s*$/g,"");
				if(_codeStr){
					var codeArr:Array=_codeStr.split(/\s+/);
					if(Op.ops[codeArr[0]]>=0){
						codeId++;
						op=Op.ops[codeArr[0]];
						codeV[codeId]=[op];
						var opDataType:String=Op.opDataTypeV[op];
						if(opDataType==Op.dataType_u8){
						}else{
							codeArr=codeArr[1].split(/[,\s]+/);
							switch(opDataType){
								case Op.dataType_u8_u8:
								case Op.dataType_u8_u30:
								case Op.dataType_u8_s24:
									codeV[codeId][1]=int(codeArr[0]);
								break;
								case Op.dataType_u8_u30_u30:
									codeV[codeId][1]=int(codeArr[0]);
									codeV[codeId][2]=int(codeArr[1]);
								break;
								case Op. dataType_u8_s24_u30_s24List:
									codeV[codeId][1]=int(codeArr.shift());
									codeV[codeId][2]=new Vector.<int>();
									var i:int=-1;
									for each(var case_offset_str:String in codeArr){
										i++;
										codeV[codeId][2][i]=int(case_offset_str);
									}
								break;
								case Op.dataType_u8_u8_u30_u8_u30:
									codeV[codeId][1]=int(codeArr[0]);
									codeV[codeId][2]=int(codeArr[1]);
									codeV[codeId][3]=int(codeArr[2]);
									codeV[codeId][4]=int(codeArr[3]);
								break;
								default:
									throw new Error("未知 opDataType: "+opDataType+", op="+op);
									//trace("未知 opDataType: "+opDataType+", op="+op);
								break;
							}
						}
					}
				}
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
