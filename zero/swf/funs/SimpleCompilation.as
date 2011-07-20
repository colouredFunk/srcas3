/***
SimpleCompilation
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月12日 14:01:19
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.*;
	import zero.swf.avm2.*;
	import zero.swf.codes.*;
	public class SimpleCompilation{
		public static function com(codesStr:String,simpleMultinames:SimpleMultinames):Array{
			//CONFIG::USE_XML=false 的情况下由 SimpleCompilation 提供部分功能
			
			var codeStrArr:Array=codesStr.replace(/^\s*|\s*$/g,"").split(/\s*\n\s*/);
			var codeId:int=-1;
			var codeArr:Array=new Array();
			
			var codeStr:String;
			var i:int;
			var labelMarkMark:Object=new Object();
			
			var execResult:Array;
			
			i=codeStrArr.length;
			while(--i>=0){
				codeStr=codeStrArr[i];
				if(codeStr.indexOf("//")==0){
					//注解
					codeStrArr.splice(i,1);
				}else if(/^label(\d+):$/.test(codeStr)){
					if(labelMarkMark[codeStr]){
						throw new Error("重复的 labelMark: "+codeStr);
					}
					labelMarkMark[codeStr]=new LabelMark(int(codeStr.replace(/^label(\d+):$/,"$1")));
				}
			}
			for each(codeStr in codeStrArr){
				codeId++;
				if(/^label(\d+):$/.test(codeStr)){
					codeArr[codeId]=labelMarkMark[codeStr];
				}else if((codeStr+" ").search(/[0-9a-fA-F]{2}\s+/)==0){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+codeStr,"brown");
					codeArr[codeId]=BytesAndStr16.str162bytes(codeStr);
				}else{
					execResult=/^(\w+)\s*([\s\S]*?)$/.exec(codeStr);
					if(AVM2Ops[execResult[1]]>=0){
						var op:int=AVM2Ops[execResult[1]];
						switch(op){
							case AVM2Ops.bkpt://0x01	//u8
							case AVM2Ops.nop://0x02	//u8
							case AVM2Ops.throw_://0x03	//u8
							case AVM2Ops.dxnslate://0x07	//u8
							case AVM2Ops.label://0x09	//u8
							case AVM2Ops.pushwith://0x1c	//u8
							case AVM2Ops.popscope://0x1d	//u8
							case AVM2Ops.nextname://0x1e	//u8
							case AVM2Ops.hasnext://0x1f	//u8
							case AVM2Ops.pushnull://0x20	//u8
							case AVM2Ops.pushundefined://0x21	//u8
							case AVM2Ops.nextvalue://0x23	//u8
							case AVM2Ops.pushtrue://0x26	//u8
							case AVM2Ops.pushfalse://0x27	//u8
							case AVM2Ops.pushnan://0x28	//u8
							case AVM2Ops.pop://0x29	//u8
							case AVM2Ops.dup://0x2a	//u8
							case AVM2Ops.swap://0x2b	//u8
							case AVM2Ops.pushscope://0x30	//u8
							case AVM2Ops.li8://0x35	//u8
							case AVM2Ops.li16://0x36	//u8
							case AVM2Ops.li32://0x37	//u8
							case AVM2Ops.lf32://0x38	//u8
							case AVM2Ops.lf64://0x39	//u8
							case AVM2Ops.si8://0x3a	//u8
							case AVM2Ops.si16://0x3b	//u8
							case AVM2Ops.si32://0x3c	//u8
							case AVM2Ops.sf32://0x3d	//u8
							case AVM2Ops.sf64://0x3e	//u8
							case AVM2Ops.returnvoid://0x47	//u8
							case AVM2Ops.returnvalue://0x48	//u8
							case AVM2Ops.sxi1://0x50	//u8
							case AVM2Ops.sxi8://0x51	//u8
							case AVM2Ops.sxi16://0x52	//u8
							case AVM2Ops.newactivation://0x57	//u8
							case AVM2Ops.getglobalscope://0x64	//u8
							case AVM2Ops.convert_s://0x70	//u8
							case AVM2Ops.esc_xelem://0x71	//u8
							case AVM2Ops.esc_xattr://0x72	//u8
							case AVM2Ops.convert_i://0x73	//u8
							case AVM2Ops.convert_u://0x74	//u8
							case AVM2Ops.convert_d://0x75	//u8
							case AVM2Ops.convert_b://0x76	//u8
							case AVM2Ops.convert_o://0x77	//u8
							case AVM2Ops.checkfilter://0x78	//u8
							case AVM2Ops.coerce_b://0x81	//u8
							case AVM2Ops.coerce_a://0x82	//u8
							case AVM2Ops.coerce_i://0x83	//u8
							case AVM2Ops.coerce_d://0x84	//u8
							case AVM2Ops.coerce_s://0x85	//u8
							case AVM2Ops.astypelate://0x87	//u8
							case AVM2Ops.coerce_u://0x88	//u8
							case AVM2Ops.coerce_o://0x89	//u8
							case AVM2Ops.negate://0x90	//u8
							case AVM2Ops.increment://0x91	//u8
							case AVM2Ops.decrement://0x93	//u8
							case AVM2Ops.typeof_://0x95	//u8
							case AVM2Ops.not://0x96	//u8
							case AVM2Ops.bitnot://0x97	//u8
							case AVM2Ops.add://0xa0	//u8
							case AVM2Ops.subtract://0xa1	//u8
							case AVM2Ops.multiply://0xa2	//u8
							case AVM2Ops.divide://0xa3	//u8
							case AVM2Ops.modulo://0xa4	//u8
							case AVM2Ops.lshift://0xa5	//u8
							case AVM2Ops.rshift://0xa6	//u8
							case AVM2Ops.urshift://0xa7	//u8
							case AVM2Ops.bitand://0xa8	//u8
							case AVM2Ops.bitor://0xa9	//u8
							case AVM2Ops.bitxor://0xaa	//u8
							case AVM2Ops.equals://0xab	//u8
							case AVM2Ops.strictequals://0xac	//u8
							case AVM2Ops.lessthan://0xad	//u8
							case AVM2Ops.lessequals://0xae	//u8
							case AVM2Ops.greaterthan://0xaf	//u8
							case AVM2Ops.greaterequals://0xb0	//u8
							case AVM2Ops.instanceof_://0xb1	//u8
							case AVM2Ops.istypelate://0xb3	//u8
							case AVM2Ops.in_://0xb4	//u8
							case AVM2Ops.increment_i://0xc0	//u8
							case AVM2Ops.decrement_i://0xc1	//u8
							case AVM2Ops.negate_i://0xc4	//u8
							case AVM2Ops.add_i://0xc5	//u8
							case AVM2Ops.subtract_i://0xc6	//u8
							case AVM2Ops.multiply_i://0xc7	//u8
							case AVM2Ops.getlocal0://0xd0	//u8
							case AVM2Ops.getlocal1://0xd1	//u8
							case AVM2Ops.getlocal2://0xd2	//u8
							case AVM2Ops.getlocal3://0xd3	//u8
							case AVM2Ops.setlocal0://0xd4	//u8
							case AVM2Ops.setlocal1://0xd5	//u8
							case AVM2Ops.setlocal2://0xd6	//u8
							case AVM2Ops.setlocal3://0xd7	//u8
							case AVM2Ops.timestamp://0xf3	//u8
								codeArr[codeId]=op;
							break;
							case AVM2Ops.pushbyte://0x24	//u8_u8
								
							case AVM2Ops.pushshort://0x25	//u8_u30__value_int
							case AVM2Ops.debugline://0xf0	//u8_u30__value_int
							case AVM2Ops.bkptline://0xf2	//u8_u30__value_int
							case AVM2Ops.getscopeobject://0x65	//u8_u30__scope
							case AVM2Ops.getslot://0x6c	//u8_u30__slot
							case AVM2Ops.setslot://0x6d	//u8_u30__slot
							case AVM2Ops.getglobalslot://0x6e	//u8_u30__slot
							case AVM2Ops.setglobalslot://0x6f	//u8_u30__slot
							case AVM2Ops.kill://0x08	//u8_u30__register
							case AVM2Ops.getlocal://0x62	//u8_u30__register
							case AVM2Ops.setlocal://0x63	//u8_u30__register
							case AVM2Ops.inclocal://0x92	//u8_u30__register
							case AVM2Ops.declocal://0x94	//u8_u30__register
							case AVM2Ops.inclocal_i://0xc2	//u8_u30__register
							case AVM2Ops.declocal_i://0xc3	//u8_u30__register
							case AVM2Ops.call://0x41	//u8_u30__args
							case AVM2Ops.construct://0x42	//u8_u30__args
							case AVM2Ops.constructsuper://0x49	//u8_u30__args
							case AVM2Ops.applytype://0x53	//u8_u30__args
							case AVM2Ops.newobject://0x55	//u8_u30__args
							case AVM2Ops.newarray://0x56	//u8_u30__args
								
							case AVM2Ops.pushint://0x2d	//u8_u30__int
								
							case AVM2Ops.pushuint://0x2e	//u8_u30__uint
								
								codeArr[codeId]=new Code(op,int(execResult[2]));
							break;
							case AVM2Ops.pushdouble://0x2f	//u8_u30__double
								codeArr[codeId]=new Code(op,Number(execResult[2]));
							break;
							case AVM2Ops.dxns://0x06	//u8_u30__string
							case AVM2Ops.pushstring://0x2c	//u8_u30__string
							case AVM2Ops.debugfile://0xf1	//u8_u30__string
								execResult=/^("|')([\s\S]*)\1$/.exec(execResult[2]);
								codeArr[codeId]=new Code(op,ComplexString.normal.unescape(execResult[2]));
							break;
							case AVM2Ops.pushnamespace://0x31	//u8_u30__namespace_info
								throw new Error("SimpleCompilation 不支持 "+AVM2Ops.opNameV[op]);
							break;
							case AVM2Ops.getsuper://0x04	//u8_u30__multiname_info
							case AVM2Ops.setsuper://0x05	//u8_u30__multiname_info
							case AVM2Ops.getdescendants://0x59	//u8_u30__multiname_info
							case AVM2Ops.findpropstrict://0x5d	//u8_u30__multiname_info
							case AVM2Ops.findproperty://0x5e	//u8_u30__multiname_info
							case AVM2Ops.getlex://0x60	//u8_u30__multiname_info
							case AVM2Ops.setproperty://0x61	//u8_u30__multiname_info
							case AVM2Ops.getproperty://0x66	//u8_u30__multiname_info
							case AVM2Ops.initproperty://0x68	//u8_u30__multiname_info
							case AVM2Ops.deleteproperty://0x6a	//u8_u30__multiname_info
							case AVM2Ops.coerce://0x80	//u8_u30__multiname_info
							case AVM2Ops.astype://0x86	//u8_u30__multiname_info
							case AVM2Ops.istype://0xb2	//u8_u30__multiname_info
								codeArr[codeId]=new Code(op,simpleMultinames.gen(ComplexString.normal.unescape(execResult[2])));
							break;
							case AVM2Ops.newfunction://0x40	//u8_u30__method
								throw new Error("SimpleCompilation 不支持 "+AVM2Ops.opNameV[op]);
							break;
							case AVM2Ops.newclass://0x58	//u8_u30__class
								throw new Error("SimpleCompilation 不支持 "+AVM2Ops.opNameV[op]);
							break;
							case AVM2Ops.newcatch://0x5a	//u8_u30__exception_info
								throw new Error("SimpleCompilation 不支持 "+AVM2Ops.opNameV[op]);
							break;
							case AVM2Ops.finddef://0x5f	//u8_u30__finddef
								throw new Error("SimpleCompilation 不支持 "+AVM2Ops.opNameV[op]);
							break;
							
							case AVM2Ops.hasnext2://0x32	//u8_u30_u30__register_register
								execResult=/^(\w+)\s+(\w+)$/.exec(execResult[2]);
								codeArr[codeId]=new Code(op,{
									register1:int(execResult[1]),
									register2:int(execResult[2])
								});
							break;
							case AVM2Ops.callsuper://0x45	//u8_u30_u30__multiname_info_args
							case AVM2Ops.callproperty://0x46	//u8_u30_u30__multiname_info_args
							case AVM2Ops.constructprop://0x4a	//u8_u30_u30__multiname_info_args
							case AVM2Ops.callproplex://0x4c	//u8_u30_u30__multiname_info_args
							case AVM2Ops.callsupervoid://0x4e	//u8_u30_u30__multiname_info_args
							case AVM2Ops.callpropvoid://0x4f	//u8_u30_u30__multiname_info_args
								execResult=/^([\s\S]*)\s+(\w+)$/.exec(execResult[2]);
								codeArr[codeId]=new Code(op,{
									args:int(execResult[2]),
									multiname:simpleMultinames.gen(ComplexString.normal.unescape(execResult[1]))
								});
							break;
							case AVM2Ops.callmethod://0x43	//u8_u30_u30__method_args
							case AVM2Ops.callstatic://0x44	//u8_u30_u30__method_args
								throw new Error("SimpleCompilation 不支持 "+AVM2Ops.opNameV[op]);
							break;
							case AVM2Ops.ifnlt://0x0c	//u8_s24__branch
							case AVM2Ops.ifnle://0x0d	//u8_s24__branch
							case AVM2Ops.ifngt://0x0e	//u8_s24__branch
							case AVM2Ops.ifnge://0x0f	//u8_s24__branch
							case AVM2Ops.jump://0x10	//u8_s24__branch
							case AVM2Ops.iftrue://0x11	//u8_s24__branch
							case AVM2Ops.iffalse://0x12	//u8_s24__branch
							case AVM2Ops.ifeq://0x13	//u8_s24__branch
							case AVM2Ops.ifne://0x14	//u8_s24__branch
							case AVM2Ops.iflt://0x15	//u8_s24__branch
							case AVM2Ops.ifle://0x16	//u8_s24__branch
							case AVM2Ops.ifgt://0x17	//u8_s24__branch
							case AVM2Ops.ifge://0x18	//u8_s24__branch
							case AVM2Ops.ifstricteq://0x19	//u8_s24__branch
							case AVM2Ops.ifstrictne://0x1a	//u8_s24__branch
								codeArr[codeId]=new Code(op,labelMarkMark[execResult[2]+":"]);
								if(codeArr[codeId].value){
								}else{
									throw new Error("找不到对应的 labelMark: "+codeStr);
								}
							break;
							case AVM2Ops.lookupswitch://0x1b	//u8_s24_u30_s24List__lookupswitch
								execResult=execResult[2].match(/label\d+/g);
								var matchStr:String=execResult.shift();
								var default_offset:LabelMark=labelMarkMark[matchStr+":"];
								if(default_offset){
								}else{
									throw new Error("找不到对应的 labelMark: "+matchStr);
								}
								i=-1;
								var case_offsetV:Vector.<LabelMark>=new Vector.<LabelMark>();
								for each(matchStr in execResult){
									i++;
									case_offsetV[i]=labelMarkMark[matchStr+":"];
									if(case_offsetV[i]){
									}else{
										throw new Error("找不到对应的 labelMark: "+matchStr);
									}
								}
								codeArr[codeId]=new Code(op,{
									default_offset:default_offset,
									case_offsetV:case_offsetV
								});
							break;
							case AVM2Ops.debug://0xef	//u8_u8_u30_u8_u30__debug
								execResult=/^(\w+)\s+("|')([\s\S]*)\2\s+(\w+)\s+(\w+)$/.exec(execResult[2]);
								codeArr[codeId]=new Code(op,{
									debug_type:int(execResult[1]),
									index:ComplexString.normal.unescape(execResult[3]),
									reg:int(execResult[4]),
									extra:int(execResult[5])
								});
							break;
							default:
								Outputer.outputError("未知 op: "+op);
							break;
						}
					}else{
						throw new Error("未知 codeStr: "+codeStr);
					}
				}
			}
			return codeArr;
		}
	}
}
		