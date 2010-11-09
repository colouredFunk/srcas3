/***
AdvanceCodes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:28:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import zero.swf.avm2.Code;
	import zero.swf.avm2.Codes;
	import zero.swf.avm2.Op;
	import zero.swf.avm2.advances.AdvanceABC;
	import zero.swf.avm2.advances.AdvanceMultiname_info;
	import zero.swf.avm2.advances.Member;
	

	public class AdvanceCodes{
		public var codeV:Vector.<AdvanceCode>;
		public function AdvanceCodes(){
		}
		public function initByInfo(codes:Codes):void{
			if(codes.codeV.length){
				var codesStartOffset:int=codes.codeV[0].offset;
				var codesEndOffset:int=codes.codeV[codes.codeV.length-1].offset;
				var codesLength:int=codesEndOffset-codesStartOffset+1;
				LabelMark.reset();
				var codeByOffsetArr:Array=new Array();
				
				var advanceCode:AdvanceCode,labelMark:LabelMark;
				for each(var code:Code in codes.codeV){
					advanceCode=new AdvanceCode();
					codeByOffsetArr[code.offset-codesStartOffset]=advanceCode;
					advanceCode.op=code.op;
					
					var opType:String=Op.opTypeV[advanceCode.op];
					
					if(opType){
						if(opType==Op.type_u8){
						}else{
							switch(opType){
								case Op.type_u8_u8__value_byte:
									advanceCode.value=code.value;
								break;
								
								case Op.type_u8_u30__value_int:
									advanceCode.value=code.value;
								break;
								case Op.type_u8_u30__scope:
									advanceCode.scope=code.value;
								break;
								case Op.type_u8_u30__slot:
									advanceCode.slot=code.value;
								break;
								case Op.type_u8_u30__register:
									advanceCode.register=code.value;
								break;
								case Op.type_u8_u30__args:
									advanceCode.args=code.value;
								break;
								case Op.type_u8_u30__int:
									advanceCode.integer=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.INTEGER);
								break;
								case Op.type_u8_u30__uint:
									advanceCode.uinteger=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.UINTEGER);
								break;
								case Op.type_u8_u30__double:
									advanceCode.double=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.DOUBLE);
								break;
								case Op.type_u8_u30__string:
									advanceCode.string=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.STRING);
								break;
								case Op.type_u8_u30__namespace_info:
									advanceCode.namespace_info=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.NAMESPACE_INFO);
								break;
								case Op.type_u8_u30__multiname_info:
									advanceCode.multiname_info=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.MULTINAME_INFO);
								break;
								case Op.type_u8_u30__method:
									advanceCode.method=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.METHOD);
								break;
								case Op.type_u8_u30__class:
									advanceCode.clazz=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value,Member.CLASS);
								break;
								case Op.type_u8_u30__exception_info:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								case Op.type_u8_u30__finddef:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								case Op.type_u8_u30_u30__register_register:
									advanceCode.register=code.value.u30;
									advanceCode.register2=code.value.u30_2;
								break;	
								case Op.type_u8_u30_u30__multiname_info_args:
									advanceCode.multiname_info=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value.u30,Member.MULTINAME_INFO);
									advanceCode.args=code.value.u30_2;
								break;
								case Op.type_u8_u30_u30__method_args:
									advanceCode.namespace_info=AdvanceABC.currInstance.getInfoByIdAndMemberType(code.value.u30,Member.NAMESPACE_INFO);
									advanceCode.args=code.value.u30_2;
								break;
									
								case Op.type_u8_s24__branch:
									advanceCode.labelMark=LabelMark.getLabelByOffsetAndLength(code.offset-codesStartOffset+4+code.value,codesLength);
								break;
									
								case Op.type_u8_s24_u30_s24List__lookupswitch:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
									
								case Op.type_u8_u8_u30_u8_u30__debug:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								default:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
							}
						}
					}else{
						throw new Error("未知 op: "+advanceCode.op);
					}
				}
				
				
				var L:int=codeByOffsetArr.length;
				if(L<LabelMark.labelArr.length){
					L=LabelMark.labelArr.length;
				}
				//if(L<ExceptionPosMark.exceptionPosArr.length){
				//	L=ExceptionPosMark.exceptionPosArr.length;
				//}
				
				codeV=new Vector.<AdvanceCode>();
				var codeId:int=0;
				for(var codesOffset:int=0;codesOffset<L;codesOffset++){
					if(LabelMark.labelArr[codesOffset]){
						codeV[codeId++]=LabelMark.labelArr[codesOffset];
					}
					if(codeByOffsetArr[codesOffset]){
						codeV[codeId++]=codeByOffsetArr[codesOffset];
					}
				}
			}
		}
		public function toInfo():Codes{
			var codes:Codes=new Codes();
			codes.codeV=new Vector.<Code>();
			var codeId:int=-1;
			var code:Code;
			for each(var advanceCode:AdvanceCode in codeV){
				if(advanceCode is LabelMark){
					trace("未处理");
				}else{
					codes.codeV[++codeId]=code=new Code();
					code.op=advanceCode.op;
					
					var opType:String=Op.opTypeV[advanceCode.op];
					
					if(opType==Op.type_u8){
					}else{
						switch(opType){
							case Op.type_u8_u8__value_byte:
								code.value=advanceCode.value;
							break;
							
							case Op.type_u8_u30__value_int:
								code.value=advanceCode.value;
							break;
							case Op.type_u8_u30__scope:
								code.value=advanceCode.scope;
							break;
							case Op.type_u8_u30__slot:
								code.value=advanceCode.slot;
							break;
							case Op.type_u8_u30__register:
								code.value=advanceCode.register;
							break;
							case Op.type_u8_u30__args:
								code.value=advanceCode.args;
							break;
							case Op.type_u8_u30__int:
								code.value=advanceCode.integer;
							break;
							case Op.type_u8_u30__uint:
								code.value=advanceCode.uinteger;
							break;
							case Op.type_u8_u30__double:
								code.value=advanceCode.double;
							break;
							case Op.type_u8_u30__string:
								code.value=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.string,Member.STRING);
							break;
							case Op.type_u8_u30__namespace_info:
								code.value=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.namespace_info,Member.NAMESPACE_INFO);
							break;
							case Op.type_u8_u30__multiname_info:
								code.value=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.multiname_info,Member.MULTINAME_INFO);
							break;
							case Op.type_u8_u30__method:
								code.value=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.method,Member.METHOD);
							break;
							case Op.type_u8_u30__class:
								code.value=AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.clazz,Member.CLASS);
							break;
							case Op.type_u8_u30__exception_info:
								throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
							break;
							case Op.type_u8_u30__finddef:
								throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
							break;
							
							case Op.type_u8_u30_u30__register_register:
								code.value={
									u30:advanceCode.register,
									u30_2:advanceCode.register2
								}
							break;
							case Op.type_u8_u30_u30__multiname_info_args:
								code.value={
									u30:AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.multiname_info,Member.MULTINAME_INFO),
									u30_2:advanceCode.args
								}
							break;
							case Op.type_u8_u30_u30__method_args:
								code.value={
									u30:AdvanceABC.currInstance.getIdByInfoAndMemberType(advanceCode.method,Member.METHOD),
									u30_2:advanceCode.args
								}
							break;
							
							case Op.type_u8_s24__branch:
								code.value=0;
								trace("未处理");
							break;
							
							case Op.type_u8_s24_u30_s24List__lookupswitch:
								throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
							break;
							
							case Op.type_u8_u8_u30_u8_u30__debug:
								throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
							break;
							
							default:
								throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
							break;
						}
					}
				}
			}
			return codes;
		}
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			if(codeV.length){
				var codesStr:String="";
				for each(var advanceCode:AdvanceCode in codeV){
					if(advanceCode is LabelMark){
						codesStr+="\t\t\t\tlabel"+(advanceCode as LabelMark).markId+":\n";
					}else{
						codesStr+="\t\t\t\t\t"+Op.opNameV[advanceCode.op];
						var opType:String=Op.opTypeV[advanceCode.op];
						
						if(opType==Op.type_u8){
						}else{
							switch(opType){
								case Op.type_u8_u8__value_byte:
									codesStr+=" "+advanceCode.value;
								break;
								
								case Op.type_u8_u30__value_int:
									codesStr+=" "+advanceCode.value;
									break;
								case Op.type_u8_u30__scope:
									codesStr+=" "+advanceCode.scope;
									break;
								case Op.type_u8_u30__slot:
									codesStr+=" "+advanceCode.slot;
									break;
								case Op.type_u8_u30__register:
									codesStr+=" "+advanceCode.register;
									break;
								case Op.type_u8_u30__args:
									codesStr+=" (param count:"+advanceCode.args+")";
									break;
								case Op.type_u8_u30__int:
									codesStr+=" "+advanceCode.integer;
								break;
								case Op.type_u8_u30__uint:
									codesStr+=" "+advanceCode.uinteger;
								break;
								case Op.type_u8_u30__double:
									codesStr+=" "+advanceCode.double;
								break;
								case Op.type_u8_u30__string:
									codesStr+=" \""+(<xml value={advanceCode.string}/>).@value.toString()+"\"";
									break;
								case Op.type_u8_u30__namespace_info:
									codesStr+=" "+advanceCode.namespace_info.toXML("namespace_info").toXMLString().replace(/[\r\n]+/g,"");
								break;
								case Op.type_u8_u30__multiname_info:
									codesStr+=" "+advanceCode.multiname_info.toXML("multiname_info").toXMLString().replace(/[\r\n]+/g,"");
									break;
								case Op.type_u8_u30__method:
									codesStr+=" "+advanceCode.method.toXML("method").toXMLString().replace(/[\r\n]+/g,"");
								break;
								case Op.type_u8_u30__class:
									codesStr+=" "+advanceCode.clazz.getMarkKey();
								break;
								case Op.type_u8_u30__exception_info:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								case Op.type_u8_u30__finddef:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								case Op.type_u8_u30_u30__register_register:
									codesStr+=" "+advanceCode.register+" "+advanceCode.register2;
								break;
								case Op.type_u8_u30_u30__multiname_info_args:
									codesStr+=" "+advanceCode.multiname_info.toXML("multiname_info").toXMLString().replace(/[\r\n]+/g,"")+" (param count:"+advanceCode.args+")";
								break;
								case Op.type_u8_u30_u30__method_args:
									codesStr+=" "+advanceCode.method.toXML("method").toXMLString().replace(/[\r\n]+/g,"")+" (param count:"+advanceCode.args+")";
								break;
								
								case Op.type_u8_s24__branch:
									codesStr+=" label"+advanceCode.labelMark.markId;
								break;
								
								case Op.type_u8_s24_u30_s24List__lookupswitch:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								case Op.type_u8_u8_u30_u8_u30__debug:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
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
			codeV=new Vector.<AdvanceCode>();
			var advanceCode:AdvanceCode;
			
			var codeStr:String;
			var i:int=codeStrArr.length;
			var labelMarkMark:Object=new Object();
			var labelMark:LabelMark;
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
					labelMark.markId=int(codeStr.replace(/label(\d+):/,"$1"));
				}/*else if(exceptionPosMarkReg.test(str)){
					if(exceptionPosMarkMark[str]){
						throw new Error("重复的 exceptionPosMark: "+str);
					}
					exceptionPosMarkMark[str]=exceptionPosMark=new ExceptionPosMark();
					exceptionPosMark.markId=int(str.replace(exceptionPosMarkReg,"$1"));
				}*/
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
						codeV[++codeId]=advanceCode=new AdvanceCode();
						advanceCode.op=Op.ops[opStr];
						
						var opType:String=Op.opTypeV[advanceCode.op];
						
						if(opType==Op.type_u8){
						}else{
							codeStr=codeStr.substr(pos).replace(/^\s*|\s*$/g,"");
							switch(opType){
								case Op.type_u8_u8__value_byte:
									advanceCode.value=int(codeStr.replace(/\s+/g,""));
								break;
								
								case Op.type_u8_u30__value_int:
									advanceCode.value=int(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__scope:
									advanceCode.scope=int(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__slot:
									advanceCode.slot=int(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__register:
									advanceCode.register=int(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__args:
									advanceCode.args=int(codeStr.replace(/\s*\(param count:(.*?)\)\s*/,"$1"));
								break;
								case Op.type_u8_u30__int:
									advanceCode.integer=int(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__uint:
									advanceCode.uinteger=int(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__double:
									advanceCode.double=Number(codeStr.replace(/\s+/g,""));
								break;
								case Op.type_u8_u30__string:
									advanceCode.string=codeStr.replace(/\s*"(.*)"\s*/,"$1");
								break;
								case Op.type_u8_u30__namespace_info:
									advanceCode.namespace_info=AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr),Member.NAMESPACE_INFO);
								break;
								case Op.type_u8_u30__multiname_info:
									advanceCode.multiname_info=AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr),Member.MULTINAME_INFO);
								break;
								case Op.type_u8_u30__method:
									advanceCode.method=AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr),Member.METHOD);
								break;
								case Op.type_u8_u30__class:
									advanceCode.clazz=AdvanceABC.currInstance.getInfoByMarkKeyAndMemberType(codeStr,Member.CLASS);
								break;
								case Op.type_u8_u30__exception_info:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								case Op.type_u8_u30__finddef:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								case Op.type_u8_u30_u30__register_register:
									var matchArr:Array=codeStr.match(/\w+/g);
									advanceCode.register=int(matchArr[0]);
									advanceCode.register2=int(matchArr[1]);
								break;
								case Op.type_u8_u30_u30__multiname_info_args:
									pos=codeStr.search(/\s*\(param count:(.*?)\)\s*/);
									if(pos>0){
										advanceCode.multiname_info=AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr.substr(0,pos)),Member.MULTINAME_INFO);
										advanceCode.args=int(codeStr.substr(pos).replace(/\s*\(param count:(.*?)\)\s*/,"$1"));
									}else{
										throw new Error("pos="+pos);
									}
								break;
								case Op.type_u8_u30_u30__method_args:
									pos=codeStr.search(/\s*\(param count:(.*?)\)\s*/);
									if(pos>0){
										advanceCode.method=AdvanceABC.currInstance.getInfoByXMLAndMemberType(new XML(codeStr.substr(0,pos)),Member.METHOD);
										advanceCode.args=int(codeStr.substr(pos).replace(/\s*\(param count:(.*?)\)\s*/,"$1"));
									}else{
										throw new Error("pos="+pos);
									}
								break;
								
								case Op.type_u8_s24__branch:
									labelMark=labelMarkMark[codeStr+":"];
									if(labelMark){
										advanceCode.labelMark=labelMark;
									}else{
										throw new Error("labelMark="+labelMark);
									}
								break;
								
								case Op.type_u8_s24_u30_s24List__lookupswitch:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
								break;
								
								case Op.type_u8_u8_u30_u8_u30__debug:
									throw new Error("未处理, op="+advanceCode.op+", opType="+opType);
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