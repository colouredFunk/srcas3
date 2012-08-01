/***
AVM2CodesRunner
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月8日 06:28:54
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2.runners{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.swf.avm2.*;
	import zero.swf.codes.*;
	
	public class AVM2CodesRunner{
		private var stackMarkV:Vector.<StackMark>;
		public function AVM2CodesRunner(codes:AVM2Codes){
			
			var code:*,i:int,value:*,value1:*,value2:*;
			var totalCode:int=codes.codeArr.length;
			var codeId:int;
			
			codeId=-1;
			for each(code in codes.codeArr){
				codeId++;
				if(code.constructor==LabelMark){
					code.pos=codeId;
				}
			}
			
			stackMarkV=new Vector.<StackMark>();
			codeId=-1;
			for each(code in codes.codeArr){
				codeId++;
				stackMarkV[codeId]=new StackMark();
			}
			
			var stack:Array=new Array();
			var scopeStack:Array=new Array();
			
			var seed:Array=[0];
			while(seed.length){
				var newSeed:Array=new Array();
				for each(var _codeId:int in seed){
					codeId=_codeId;
					loop:while(codeId<totalCode){
						
						if(stackMarkV[codeId].add(stack,scopeStack)){
						}else{
							break loop;
						}
						
						code=codes.codeArr[codeId];
						
						trace(
							codeId,
							stackMarkV[codeId],
							(
								code.constructor==LabelMark
								?
								"labelx:"
								:
								(
									code.constructor==Code
									?
									AVM2Ops.opNameV[code.op]+" "+code.value
									:
									AVM2Ops.opNameV[code]
								)
							)
						);
						
						switch(code){
							
							//opType="op"
							//case 0x01://AVM2Ops.bkpt	//u8
							//case 0x02://AVM2Ops.nop	//u8
							case 0x03://AVM2Ops.throw_	//u8
								stack.pop();
								trace("暂时简单的 break");
								break loop;
							break;
							//case 0x07://AVM2Ops.dxnslate	//u8
							case 0x09://AVM2Ops.label	//u8
							break;
							//case 0x1c://AVM2Ops.pushwith	//u8
							//case 0x1d://AVM2Ops.popscope	//u8
							//case 0x1e://AVM2Ops.nextname	//u8
							//case 0x1f://AVM2Ops.hasnext	//u8
							//case 0x20://AVM2Ops.pushnull	//u8
							//case 0x21://AVM2Ops.pushundefined	//u8
							//case 0x23://AVM2Ops.nextvalue	//u8
							//case 0x26://AVM2Ops.pushtrue	//u8
							//case 0x27://AVM2Ops.pushfalse	//u8
							//case 0x28://AVM2Ops.pushnan	//u8
							//case 0x29://AVM2Ops.pop	//u8
							case 0x2a://AVM2Ops.dup	//u8
								value=stack.pop();
								stack.push(value,value);
							break;
							//case 0x2b://AVM2Ops.swap	//u8
							case 0x30://AVM2Ops.pushscope	//u8
								scopeStack.push(stack.pop());
							break;
							//case 0x35://AVM2Ops.li8	//u8
							//case 0x36://AVM2Ops.li16	//u8
							//case 0x37://AVM2Ops.li32	//u8
							//case 0x38://AVM2Ops.lf32	//u8
							//case 0x39://AVM2Ops.lf64	//u8
							//case 0x3a://AVM2Ops.si8	//u8
							//case 0x3b://AVM2Ops.si16	//u8
							//case 0x3c://AVM2Ops.si32	//u8
							//case 0x3d://AVM2Ops.sf32	//u8
							//case 0x3e://AVM2Ops.sf64	//u8
							case 0x47://AVM2Ops.returnvoid	//u8
								break loop;
							break;
							case 0x48://AVM2Ops.returnvalue	//u8
								stack.pop();
								break loop;
							break;
							//case 0x50://AVM2Ops.sxi1	//u8
							//case 0x51://AVM2Ops.sxi8	//u8
							//case 0x52://AVM2Ops.sxi16	//u8
							//case 0x57://AVM2Ops.newactivation	//u8
							//case 0x64://AVM2Ops.getglobalscope	//u8
							//case 0x70://AVM2Ops.convert_s	//u8
							//case 0x71://AVM2Ops.esc_xelem	//u8
							//case 0x72://AVM2Ops.esc_xattr	//u8
							//case 0x73://AVM2Ops.convert_i	//u8
							//case 0x74://AVM2Ops.convert_u	//u8
							//case 0x75://AVM2Ops.convert_d	//u8
							//case 0x76://AVM2Ops.convert_b	//u8
							//case 0x77://AVM2Ops.convert_o	//u8
							//case 0x78://AVM2Ops.checkfilter	//u8
							//case 0x81://AVM2Ops.coerce_b	//u8
							//case 0x82://AVM2Ops.coerce_a	//u8
							//case 0x83://AVM2Ops.coerce_i	//u8
							//case 0x84://AVM2Ops.coerce_d	//u8
							//case 0x85://AVM2Ops.coerce_s	//u8
							//case 0x87://AVM2Ops.astypelate	//u8
							//case 0x88://AVM2Ops.coerce_u	//u8
							//case 0x89://AVM2Ops.coerce_o	//u8
							//case 0x90://AVM2Ops.negate	//u8
							//case 0x91://AVM2Ops.increment	//u8
							//case 0x93://AVM2Ops.decrement	//u8
							//case 0x95://AVM2Ops.typeof_	//u8
							//case 0x96://AVM2Ops.not	//u8
							//case 0x97://AVM2Ops.bitnot	//u8
							//case 0xa0://AVM2Ops.add	//u8
							//case 0xa1://AVM2Ops.subtract	//u8
							//case 0xa2://AVM2Ops.multiply	//u8
							//case 0xa3://AVM2Ops.divide	//u8
							//case 0xa4://AVM2Ops.modulo	//u8
							//case 0xa5://AVM2Ops.lshift	//u8
							//case 0xa6://AVM2Ops.rshift	//u8
							//case 0xa7://AVM2Ops.urshift	//u8
							//case 0xa8://AVM2Ops.bitand	//u8
							//case 0xa9://AVM2Ops.bitor	//u8
							//case 0xaa://AVM2Ops.bitxor	//u8
							//case 0xab://AVM2Ops.equals	//u8
							//case 0xac://AVM2Ops.strictequals	//u8
							//case 0xad://AVM2Ops.lessthan	//u8
							//case 0xae://AVM2Ops.lessequals	//u8
							//case 0xaf://AVM2Ops.greaterthan	//u8
							//case 0xb0://AVM2Ops.greaterequals	//u8
							//case 0xb1://AVM2Ops.instanceof_	//u8
							//case 0xb3://AVM2Ops.istypelate	//u8
							//case 0xb4://AVM2Ops.in_	//u8
							//case 0xc0://AVM2Ops.increment_i	//u8
							case 0xc1://AVM2Ops.decrement_i	//u8
								value=stack.pop();
								stack.push(int(value)-1);
							break;
							//case 0xc4://AVM2Ops.negate_i	//u8
							//case 0xc5://AVM2Ops.add_i	//u8
							//case 0xc6://AVM2Ops.subtract_i	//u8
							//case 0xc7://AVM2Ops.multiply_i	//u8
							case 0xd0://AVM2Ops.getlocal0	//u8
								stack.push(StackValue.local0);
							break;
							//case 0xd1://AVM2Ops.getlocal1	//u8
							//case 0xd2://AVM2Ops.getlocal2	//u8
							//case 0xd3://AVM2Ops.getlocal3	//u8
							//case 0xd4://AVM2Ops.setlocal0	//u8
							//case 0xd5://AVM2Ops.setlocal1	//u8
							//case 0xd6://AVM2Ops.setlocal2	//u8
							//case 0xd7://AVM2Ops.setlocal3	//u8
							//case 0xf3://AVM2Ops.timestamp	//u8
							//break;
							
							default:
								switch(code.constructor){
									case LabelMark:
									break;
									case Code:
										switch(code.op){
											
											case 0x24://AVM2Ops.pushbyte	//u8_u8
												stack.push(code.value);
											break;
											
											//opType="int"
											//case 0x25://AVM2Ops.pushshort	//u8_u30__value_int
											//case 0xf0://AVM2Ops.debugline	//u8_u30__value_int
											//case 0xf2://AVM2Ops.bkptline	//u8_u30__value_int
											//case 0x65://AVM2Ops.getscopeobject	//u8_u30__scope
											//case 0x6c://AVM2Ops.getslot	//u8_u30__slot
											//case 0x6d://AVM2Ops.setslot	//u8_u30__slot
											//case 0x6e://AVM2Ops.getglobalslot	//u8_u30__slot
											//case 0x6f://AVM2Ops.setglobalslot	//u8_u30__slot
											//case 0x08://AVM2Ops.kill	//u8_u30__register
											//case 0x62://AVM2Ops.getlocal	//u8_u30__register
											//case 0x63://AVM2Ops.setlocal	//u8_u30__register
											//case 0x92://AVM2Ops.inclocal	//u8_u30__register
											//case 0x94://AVM2Ops.declocal	//u8_u30__register
											//case 0xc2://AVM2Ops.inclocal_i	//u8_u30__register
											//case 0xc3://AVM2Ops.declocal_i	//u8_u30__register
											//case 0x41://AVM2Ops.call	//u8_u30__args
											//case 0x42://AVM2Ops.construct	//u8_u30__args
											case 0x49://AVM2Ops.constructsuper	//u8_u30__args
												i=code.value;
												while(--i>=0){
													stack.pop();
												}
												stack.pop();
											break;
											//case 0x53://AVM2Ops.applytype	//u8_u30__args
											//case 0x55://AVM2Ops.newobject	//u8_u30__args
											//case 0x56://AVM2Ops.newarray	//u8_u30__args
											//break;
											
											//case 0x2d://AVM2Ops.pushint	//u8_u30__int
											//break;
											
											//case 0x2e://AVM2Ops.pushuint	//u8_u30__uint
											//break;
											
											//case 0x2f://AVM2Ops.pushdouble	//u8_u30__double
											//codeByPosArr[pos]=new Code(op,doubleV[u30_1]);
											//break;
											
											//opType="string"
											//case 0x06://AVM2Ops.dxns	//u8_u30__string
											case 0x2c://AVM2Ops.pushstring	//u8_u30__string
												stack.push(code.value);
											break;
											//case 0xf1://AVM2Ops.debugfile	//u8_u30__string
											//break;
											
											//case 0x31://AVM2Ops.pushnamespace	//u8_u30__namespace_info
											//break;
											
											//opType="multiname"
											//case 0x04://AVM2Ops.getsuper	//u8_u30__multiname_info
											//case 0x05://AVM2Ops.setsuper	//u8_u30__multiname_info
											//case 0x59://AVM2Ops.getdescendants	//u8_u30__multiname_info
											//case 0x5d://AVM2Ops.findpropstrict	//u8_u30__multiname_info
											//case 0x5e://AVM2Ops.findproperty	//u8_u30__multiname_info
											case 0x60://AVM2Ops.getlex	//u8_u30__multiname_info
												stack.push(StackValue.any);
											break;
											case 0x61://AVM2Ops.setproperty	//u8_u30__multiname_info
												switch(code.value.kind){
													case MultinameKinds.QName:
													case MultinameKinds.QNameA:
														stack.pop();
														stack.pop();
													break;
													case MultinameKinds.RTQNameL:
														stack.pop();
														stack.pop();
														stack.pop();
														stack.pop();
													break;
													default:
														stack.pop();
														stack.pop();
														stack.pop();
													break;
												}
											break;
											//case 0x66://AVM2Ops.getproperty	//u8_u30__multiname_info
											//case 0x68://AVM2Ops.initproperty	//u8_u30__multiname_info
											//case 0x6a://AVM2Ops.deleteproperty	//u8_u30__multiname_info
											//case 0x80://AVM2Ops.coerce	//u8_u30__multiname_info
											//case 0x86://AVM2Ops.astype	//u8_u30__multiname_info
											//case 0xb2://AVM2Ops.istype	//u8_u30__multiname_info
											//break;
											
											//case 0x40://AVM2Ops.newfunction	//u8_u30__method
											//break;
											
											//case 0x58://AVM2Ops.newclass	//u8_u30__class
											//break;
											
											//case 0x5a://AVM2Ops.newcatch	//u8_u30__exception_info
											//break;
											
											//case 0x5f://AVM2Ops.finddef	//u8_u30__finddef
											//	throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
											//break;
											
											//case 0x32://AVM2Ops.hasnext2	//u8_u30_u30__register_register
											//break;
											
											//opType="multiname args"
											//case 0x45://AVM2Ops.callsuper	//u8_u30_u30__multiname_info_args
											//case 0x46://AVM2Ops.callproperty	//u8_u30_u30__multiname_info_args
											//case 0x4a://AVM2Ops.constructprop	//u8_u30_u30__multiname_info_args
											//case 0x4c://AVM2Ops.callproplex	//u8_u30_u30__multiname_info_args
											//case 0x4e://AVM2Ops.callsupervoid	//u8_u30_u30__multiname_info_args
											//case 0x4f://AVM2Ops.callpropvoid	//u8_u30_u30__multiname_info_args
											//break;
											
											//opType="method args"
											//case 0x43://AVM2Ops.callmethod	//u8_u30_u30__method_args
											//case 0x44://AVM2Ops.callstatic	//u8_u30_u30__method_args
											//case "method args":
											//	throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
											//break;
											
											//opType="branch"
											//case 0x0c://AVM2Ops.ifnlt	//u8_s24__branch
											//case 0x0d://AVM2Ops.ifnle	//u8_s24__branch
											//case 0x0e://AVM2Ops.ifngt	//u8_s24__branch
											//case 0x0f://AVM2Ops.ifnge	//u8_s24__branch
											//case 0x10://AVM2Ops.jump	//u8_s24__branch
											//case 0x11://AVM2Ops.iftrue	//u8_s24__branch
											//case 0x12://AVM2Ops.iffalse	//u8_s24__branch
											//case 0x13://AVM2Ops.ifeq	//u8_s24__branch
											//case 0x14://AVM2Ops.ifne	//u8_s24__branch
											//case 0x15://AVM2Ops.iflt	//u8_s24__branch
											//case 0x16://AVM2Ops.ifle	//u8_s24__branch
											case 0x17://AVM2Ops.ifgt	//u8_s24__branch
												value2=stack.pop();
												value1=stack.pop();
												trace("if("+value1+">"+value2+")...");
												if(value1>value2){
													newSeed.push(code.value.pos);
													break loop;
												}
											break;
											//case 0x18://AVM2Ops.ifge	//u8_s24__branch
											//case 0x19://AVM2Ops.ifstricteq	//u8_s24__branch
											//case 0x1a://AVM2Ops.ifstrictne	//u8_s24__branch
											//break;
											
											//case 0x1b://AVM2Ops.lookupswitch	//u8_s24_u30_s24List__lookupswitch
											//break;
											
											//case 0xef://AVM2Ops.debug	//u8_u8_u30_u8_u30__debug
											//break;
											
											default:
												throw new Error("未知 op: "+code.op);
											break;
										}
									break;
									default:
										throw new Error("暂不支持 code："+code);
									break;
								}
							break;
						}
						codeId++;
					}
				}
				seed=newSeed;
			}
			
			codeId=-1;
			for each(code in codes.codeArr){
				codeId++;
				trace(
					codeId,
					stackMarkV[codeId],
					(
						code.constructor==LabelMark
						?
						"labelx:"
						:
						(
							code.constructor==Code
							?
							AVM2Ops.opNameV[code.op]+" "+code.value
							:
							AVM2Ops.opNameV[code]
						)
					)
				);
			}
		}
	}
}