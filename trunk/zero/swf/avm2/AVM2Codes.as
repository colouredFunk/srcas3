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
	import zero.ComplexString;
	import zero.Outputer;
	import zero.swf.codes.Code;
	import zero.swf.codes.LabelMark;
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
			var labelId:int=-1;
			var labelByPosArr:Array=new Array();
			var codeByPosArr:Array=new Array();
			if(_initByDataOptions&&_initByDataOptions.ABCDataGetHexArr){
				var hexByPosArr:Array=new Array();
			}
			
			var u30_1:int,u30_2:int,jumpOffset:int,jumpPos:int,i:int;
			
			var offset:int=0;
			var endOffset:int=data.length;
			
			var exceptionArr:Array=new Array();
			
			while(offset<endOffset){
				var pos:int=offset;
				var op:int=data[offset++];
				
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
						codeByPosArr[pos]=op;
					break;
					case AVM2Ops.pushbyte://0x24	//u8_u8
						codeByPosArr[pos]=new Code(op,data[offset++]);
					break;
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
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28));}else{codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21));}}else{codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14));}}else{codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|(data[offset++]<<7));}}else{codeByPosArr[pos]=new Code(op,data[offset++]);}
						//codeByPosArr[pos]=new Code(op,u30_1);
					break;
					case AVM2Ops.pushint://0x2d	//u8_u30__int
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,integerV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,integerV[u30_1]);
					break;
					case AVM2Ops.pushuint://0x2e	//u8_u30__uint
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,uintegerV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,uintegerV[u30_1]);
					break;
					case AVM2Ops.pushdouble://0x2f	//u8_u30__double
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,doubleV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,doubleV[u30_1]);
					break;
					case AVM2Ops.dxns://0x06	//u8_u30__string
					case AVM2Ops.pushstring://0x2c	//u8_u30__string
					case AVM2Ops.debugfile://0xf1	//u8_u30__string
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,stringV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,stringV[u30_1]);
					break;
					case AVM2Ops.pushnamespace://0x31	//u8_u30__namespace_info
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,allNsV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,allNsV[u30_1]);
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
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,allMultinameV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,allMultinameV[u30_1]);
					break;
					case AVM2Ops.newfunction://0x40	//u8_u30__method
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,allMethodV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,allMethodV[u30_1]);
					break;
					case AVM2Ops.newclass://0x58	//u8_u30__class
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,classV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,classV[u30_1]);
					break;
					case AVM2Ops.newcatch://0x5a	//u8_u30__exception_info
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
						//u30_1
						var exception:ABCException=exceptionArr[u30_1];
						if(exception){
							Outputer.output("重复使用的 exception","brown");
						}else{
							var exception_info:Exception_info=exception_infoV[u30_1];
							
							exceptionArr[u30_1]=exception=new ABCException();
							exception.initByInfo(exception_info,allMultinameV,_initByDataOptions);
							
							exception.from=(labelByPosArr[exception_info.from]||(labelByPosArr[exception_info.from]=new LabelMark(++labelId)));
							
							exception.to=(labelByPosArr[exception_info.to]||(labelByPosArr[exception_info.to]=new LabelMark(++labelId)));
							
							exception.target=(labelByPosArr[exception_info.target]||(labelByPosArr[exception_info.target]=new LabelMark(++labelId)));
						}
						codeByPosArr[pos]=new Code(op,exception);
					break;
					case AVM2Ops.finddef://0x5f	//u8_u30__finddef
						throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
					break;
					case AVM2Ops.hasnext2://0x32	//u8_u30_u30__register_register
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
						//u30_1
						
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
						//u30_2
						
						codeByPosArr[pos]=new Code(op,{
							register1:u30_1,
							register2:u30_2
						});
					break;
					case AVM2Ops.callsuper://0x45	//u8_u30_u30__multiname_info_args
					case AVM2Ops.callproperty://0x46	//u8_u30_u30__multiname_info_args
					case AVM2Ops.constructprop://0x4a	//u8_u30_u30__multiname_info_args
					case AVM2Ops.callproplex://0x4c	//u8_u30_u30__multiname_info_args
					case AVM2Ops.callsupervoid://0x4e	//u8_u30_u30__multiname_info_args
					case AVM2Ops.callpropvoid://0x4f	//u8_u30_u30__multiname_info_args
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
						//u30_1
						
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
						//u30_2
						
						codeByPosArr[pos]=new Code(op,{
							multiname:allMultinameV[u30_1],
							args:u30_2
						});
					break;
					case AVM2Ops.callmethod://0x43	//u8_u30_u30__method_args
					case AVM2Ops.callstatic://0x44	//u8_u30_u30__method_args
						//codeByPosArr[pos]=new Code(op,{
						//	method:allMethod(u30_1),
						//	args:u30_2
						//});
						throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
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
						jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
						if(jumpOffset&0x00800000){jumpOffset|=0xff000000}//最高位为1,表示负数
						jumpPos=offset+jumpOffset;
						if(jumpPos<0||jumpPos>endOffset){
							jumpPos=endOffset;
							Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
						}
						codeByPosArr[pos]=new Code(op,labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
					break;
					case AVM2Ops.lookupswitch://0x1b	//u8_s24_u30_s24List__lookupswitch
						//The base location is the address of the lookupswitch instruction itself.
						var lookupswitch_startOffset:int=offset-1;
						
						jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
						if(jumpOffset&0x00800000){jumpOffset|=0xff000000}//最高位为1,表示负数
						jumpPos=lookupswitch_startOffset+jumpOffset;
						if(jumpPos<0||jumpPos>endOffset){
							jumpPos=endOffset;
							Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
						}
						var default_offset:LabelMark=labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId))
						
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var case_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_count=data[offset++];}
						//case_count
						
						case_count++;
						var case_offsetV:Vector.<LabelMark>=new Vector.<LabelMark>();
						for(i=0;i<case_count;i++){
							jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
							if(jumpOffset&0x00800000){jumpOffset|=0xff000000}//最高位为1,表示负数
							jumpPos=lookupswitch_startOffset+jumpOffset;
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							case_offsetV[i]=labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId));
						}
						codeByPosArr[pos]=new Code(op,{
							default_offset:default_offset,
							case_offsetV:case_offsetV
						});
					break;
					case AVM2Ops.debug://0xef	//u8_u8_u30_u8_u30__debug
						var debug_type:int=data[offset++];
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var index:String=stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)];}else{index=stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)];}}else{index=stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)];}}else{index=stringV[(data[offset++]&0x7f)|(data[offset++]<<7)];}}else{index=stringV[data[offset++]];}
						//index=stringV[u30_1];
						
						var reg:int=data[offset++];
						
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var extra:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{extra=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{extra=data[offset++];}
						//extra
						
						codeByPosArr[pos]=new Code(op,{
							debug_type:debug_type,
							index:index,
							reg:reg,
							extra:extra
						});
					break;
					default:
						Outputer.outputError("未知 op: "+op);
					break;
				}
				if(hexByPosArr){
					hexByPosArr[pos]=BytesAndStr16.bytes2str16(data,pos,offset-pos);
				}
			}
			
			if(offset==endOffset){
			}else{
				trace("offset="+offset+",endOffset="+endOffset);
			}
			
			if(hexByPosArr){
				hexArr=new Array();
			}
			codeArr=new Array();
			var codeId:int=-1;
			
			for(offset=0;offset<=endOffset;offset++){
				if(labelByPosArr[offset]){
					codeId++;
					codeArr[codeId]=labelByPosArr[offset];
				}
				if(codeByPosArr[offset]==null){
				}else{
					codeId++;
					if(hexArr){
						hexArr[codeId]=hexByPosArr[offset];
					}
					codeArr[codeId]=codeByPosArr[offset];
				}
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			for each(var code:* in codeArr){
				if(code is Code){
					switch(code.op){
						case AVM2Ops.pushint://0x2d	//u8_u30__int
							productMark.productInteger(code.value);
						break;
						case AVM2Ops.pushuint://0x2e	//u8_u30__uint
							productMark.productUinteger(code.value);
						break;
						case AVM2Ops.pushdouble://0x2f	//u8_u30__double
							productMark.productDouble(code.value);
						break;
						case AVM2Ops.dxns://0x06	//u8_u30__string
						case AVM2Ops.pushstring://0x2c	//u8_u30__string
						case AVM2Ops.debugfile://0xf1	//u8_u30__string
							productMark.productString(code.value);
						break;
						case AVM2Ops.pushnamespace://0x31	//u8_u30__namespace_info
							productMark.productNs(code.value);
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
							productMark.productMultiname(code.value);
						break;
						case AVM2Ops.newfunction://0x40	//u8_u30__method
							productMark.productMethod(code.value);
						break;
						case AVM2Ops.newclass://0x58	//u8_u30__class
							//已在 ABCClasses.toData 里 product 过了
						break;
						case AVM2Ops.newcatch://0x5a	//u8_u30__exception_info
							(code.value as ABCException).getInfo_product(productMark);
						break;
						case AVM2Ops.finddef://0x5f	//u8_u30__finddef
							//throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
						break;
						case AVM2Ops.callsuper://0x45	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callproperty://0x46	//u8_u30_u30__multiname_info_args
						case AVM2Ops.constructprop://0x4a	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callproplex://0x4c	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callsupervoid://0x4e	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callpropvoid://0x4f	//u8_u30_u30__multiname_info_args
							productMark.productMultiname(code.value.multiname);
						break;
						case AVM2Ops.callmethod://0x43	//u8_u30_u30__method_args
						case AVM2Ops.callstatic://0x44	//u8_u30_u30__method_args
							//Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
						break;
						case AVM2Ops.debug://0xef	//u8_u8_u30_u8_u30__debug
							productMark.productString(code.value.index);
						break;
					}
				}
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Array{
			var data:ByteArray=new ByteArray();
			
			var posMarkArr:Array=new Array();//记录 branch, newcatch, lookupswitch 的位置及相关的 label 位置
			
			var offset:int=0;
			
			var u30_1:int,u30_2:int,jumpOffset:int;
			
			var labelMark:LabelMark;
			
			var exceptionIdDict:Dictionary=new Dictionary();
			var exception:ABCException;
			var exception_info:Exception_info;
			var exception_infoV:Vector.<Exception_info>=new Vector.<Exception_info>();
			
			for each(var code:* in codeArr){
				if(code is LabelMark){
					(code as LabelMark).pos=offset;
				}else if(code is ByteArray){
					//Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
				}else if(code is int){
					data[offset++]=code;
				}else if(code is Code){
					data[offset++]=code.op;
					switch(code.op){
						case AVM2Ops.pushbyte://0x24	//u8_u8
							data[offset++]=code.value;
						break;
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
							u30_1=code.value;
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.pushint://0x2d	//u8_u30__int
							u30_1=productMark.getIntegerId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.pushuint://0x2e	//u8_u30__uint
							u30_1=productMark.getUintegerId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.pushdouble://0x2f	//u8_u30__double
							u30_1=productMark.getDoubleId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.dxns://0x06	//u8_u30__string
						case AVM2Ops.pushstring://0x2c	//u8_u30__string
						case AVM2Ops.debugfile://0xf1	//u8_u30__string
							u30_1=productMark.getStringId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.pushnamespace://0x31	//u8_u30__namespace_info
							u30_1=productMark.getNsId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
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
							u30_1=productMark.getMultinameId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.newfunction://0x40	//u8_u30__method
							u30_1=productMark.getMethodId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.newclass://0x58	//u8_u30__class
							u30_1=productMark.getClassId(code.value);
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
						break;
						case AVM2Ops.newcatch://0x5a	//u8_u30__exception_info
							exception=code.value;
							if(exceptionIdDict[exception]>-1){
								Outputer.output("重复使用的 exception","brown");
							}else{
								exceptionIdDict[exception]=exception_infoV.length;
								exception_infoV[exception_infoV.length]=exception.getInfo(productMark,_toDataOptions);
							}
							u30_1=exceptionIdDict[exception];
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
							posMarkArr[offset]=code;
						break;
						case AVM2Ops.finddef://0x5f	//u8_u30__finddef
							throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
						break;
						case AVM2Ops.hasnext2://0x32	//u8_u30_u30__register_register
							u30_1=code.value.register1;
							u30_2=code.value.register2;
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
							
							if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
							//u30_2
						break;
						case AVM2Ops.callsuper://0x45	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callproperty://0x46	//u8_u30_u30__multiname_info_args
						case AVM2Ops.constructprop://0x4a	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callproplex://0x4c	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callsupervoid://0x4e	//u8_u30_u30__multiname_info_args
						case AVM2Ops.callpropvoid://0x4f	//u8_u30_u30__multiname_info_args
							u30_1=productMark.getMultinameId(code.value.multiname),
							u30_2=code.value.args;
							if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
							//u30_1
							
							if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
							//u30_2
						break;
						case AVM2Ops.callmethod://0x43	//u8_u30_u30__method_args
						case AVM2Ops.callstatic://0x44	//u8_u30_u30__method_args
							Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
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
							offset+=3;
							posMarkArr[offset]=code.value;
						break;
						case AVM2Ops.lookupswitch://0x1b	//u8_s24_u30_s24List__lookupswitch
							//The base location is the address of the lookupswitch instruction itself.
							posMarkArr[offset-1]=code;
							
							code.value.default_offset_startPos=offset;//- -
							
							offset+=3;
							
							var case_count:int=code.value.case_offsetV.length-1;
							if(case_count>>>7){if(case_count>>>14){if(case_count>>>21){if(case_count>>>28){data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=((case_count>>>21)&0x7f)|0x80;data[offset++]=case_count>>>28;}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=case_count>>>21;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=case_count>>>14;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=case_count>>>7;}}else{data[offset++]=case_count;}
							//case_count
							
							code.value.case_offset_startPos=offset;//- -
							offset+=3*(case_count+1);
						break;
						case AVM2Ops.debug://0xef	//u8_u8_u30_u8_u30__debug
							data[offset++]=code.value.debug_type;
							
							var debug_index:int=productMark.getStringId(code.value.index);
							
							if(debug_index>>>7){if(debug_index>>>14){if(debug_index>>>21){if(debug_index>>>28){data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=((debug_index>>>14)&0x7f)|0x80;data[offset++]=((debug_index>>>21)&0x7f)|0x80;data[offset++]=debug_index>>>28;}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=((debug_index>>>14)&0x7f)|0x80;data[offset++]=debug_index>>>21;}}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=((debug_index>>>7)&0x7f)|0x80;data[offset++]=debug_index>>>14;}}else{data[offset++]=(debug_index&0x7f)|0x80;data[offset++]=debug_index>>>7;}}else{data[offset++]=debug_index;}
							//debug_index
							
							data[offset++]=code.value.reg;
							
							if(code.value.extra>>>7){if(code.value.extra>>>14){if(code.value.extra>>>21){if(code.value.extra>>>28){data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=((code.value.extra>>>14)&0x7f)|0x80;data[offset++]=((code.value.extra>>>21)&0x7f)|0x80;data[offset++]=code.value.extra>>>28;}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=((code.value.extra>>>14)&0x7f)|0x80;data[offset++]=code.value.extra>>>21;}}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=((code.value.extra>>>7)&0x7f)|0x80;data[offset++]=code.value.extra>>>14;}}else{data[offset++]=(code.value.extra&0x7f)|0x80;data[offset++]=code.value.extra>>>7;}}else{data[offset++]=code.value.extra;}
							//code.value.extra
						break;
						default:
							Outputer.outputError("未知 op: "+code.op);
						break;
					}
				}else{
					throw new Error("未知 code: "+code);
				}
			}
			
			var endOffset:int=data.length;
			for(offset=0;offset<=endOffset;offset++){
				code=posMarkArr[offset];
				if(code){
					if(code is LabelMark){
						jumpOffset=code.pos-offset;
						data[offset-3]=jumpOffset;
						data[offset-2]=jumpOffset>>8;
						data[offset-1]=jumpOffset>>16;
					}else{
						switch(code.op){
							case AVM2Ops.newcatch:
								exception=code.value;
								exception_info=exception_infoV[exceptionIdDict[exception]];
								exception_info.from=exception.from.pos;
								exception_info.to=exception.to.pos;
								exception_info.target=exception.target.pos;
							break;
							case AVM2Ops.lookupswitch:
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
							break;
							default:
								throw new Error("发现 posMarkArr 里的奇怪的 code, code.op="+code.op);
							break;
						}
					}
				}
			}
			
			return [data,exception_infoV];
		}
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var labelMark:LabelMark,infoXML:XML;
			
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
					if(code is LabelMark){
						codesStr+="\t\t\t\tlabel"+(code as LabelMark).labelId+":\n";
					}else if(code is ByteArray){
						Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
						codesStr+="\t\t\t\t\t"+BytesAndStr16.bytes2str16(code,0,code.length)+"\n";
					}else{
						if(code is int){
							codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code]+"\n";
						}else if(code is Code){
							switch(code.op){
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
									
								case AVM2Ops.pushdouble://0x2f	//u8_u30__double
									
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value+"\n";
								break;
								case AVM2Ops.dxns://0x06	//u8_u30__string
								case AVM2Ops.pushstring://0x2c	//u8_u30__string
								case AVM2Ops.debugfile://0xf1	//u8_u30__string
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" \""+ComplexString.normal.escape(code.value)+"\"\n";
								break;
								case AVM2Ops.pushnamespace://0x31	//u8_u30__namespace_info
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+(code.value as ABCNamespace).toMarkStrAndMark(markStrs)+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+(code.value as ABCNamespace).toXMLAndMark(markStrs,"ns",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+"\n";
									}
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
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+(code.value as ABCMultiname).toMarkStrAndMark(markStrs)+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+(code.value as ABCMultiname).toXMLAndMark(markStrs,"multiname",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+"\n";
									}
								break;
								case AVM2Ops.newfunction://0x40	//u8_u30__method
									var method:ABCMethod=code.value;
									if(markStrs.markStrDict[method]){
										Outputer.output("重复使用的 method","brown");
										Outputer.output("如引用的是 iinit 或 cinit 或 init 或 trait 里的 method 将可能不正常","brown");
									}
									var methodXML:XML=method.toXMLAndMark(markStrs,"","method",_toXMLOptions);
									var methodMarkStr:String=markStrs.markStrDict[method];
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+methodMarkStr+"\n";
									methodXML.@methodMarkStr=methodMarkStr;
									markStrs.newfunctionXMLV.push(methodXML);
								break;
								case AVM2Ops.newclass://0x58	//u8_u30__class
									var class_name:ABCMultiname=(code.value as ABCClass).name;
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+class_name.toMarkStrAndMark(markStrs)+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+class_name.toXMLAndMark(markStrs,"class_name",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+"\n";
									}
								break;
								case AVM2Ops.newcatch://0x5a	//u8_u30__exception_info
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
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+exceptionXML.toXMLString().replace(/\s*\n\s*/g,"")+"\n";
								break;
								case AVM2Ops.finddef://0x5f	//u8_u30__finddef
									throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
								break;
									
								case AVM2Ops.hasnext2://0x32	//u8_u30_u30__register_register
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.register1+" "+code.value.register2+"\n";
								break;
								case AVM2Ops.callsuper://0x45	//u8_u30_u30__multiname_info_args
								case AVM2Ops.callproperty://0x46	//u8_u30_u30__multiname_info_args
								case AVM2Ops.constructprop://0x4a	//u8_u30_u30__multiname_info_args
								case AVM2Ops.callproplex://0x4c	//u8_u30_u30__multiname_info_args
								case AVM2Ops.callsupervoid://0x4e	//u8_u30_u30__multiname_info_args
								case AVM2Ops.callpropvoid://0x4f	//u8_u30_u30__multiname_info_args
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+(code.value.multiname as ABCMultiname).toMarkStrAndMark(markStrs)+" "+code.value.args+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+(code.value.multiname as ABCMultiname).toXMLAndMark(markStrs,"multiname",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+" "+code.value.args+"\n";
									}
								break;
								case AVM2Ops.callmethod://0x43	//u8_u30_u30__method_args
								case AVM2Ops.callstatic://0x44	//u8_u30_u30__method_args
									Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
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
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" label"+code.value.labelId+"\n";
								break;
									
								case AVM2Ops.lookupswitch://0x1b	//u8_s24_u30_s24List__lookupswitch
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" label"+code.value.default_offset.labelId;
									for each(labelMark in code.value.case_offsetV){
										codesStr+=" label"+labelMark.labelId;
									}
									codesStr+="\n";
								break;
									
								case AVM2Ops.debug://0xef	//u8_u8_u30_u8_u30__debug
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.debug_type+" \""+ComplexString.normal.escape(code.value.index)+"\" "+code.value.reg+" "+code.value.extra+"\n";
								break;
								
								default:
									Outputer.outputError("未知 op: "+code.op);
								break;
							}
						}else{
							throw new Error("未知 code: "+code);
						}
					}
				}
				
				return new XML("<"+xmlName+"><![CDATA[\n"+
					codesStr.replace(/\]\]\>/g,"\\]\\]\\>")
					+"\t\t\t\t]]></"+xmlName+">");
			}
			return <{xmlName}/>;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			//CONFIG::USE_XML=false 的情况下由 SimpleCompilation 提供部分功能
			
			var codeStrArr:Array=xml.toString().replace(/^\s*|\s*$/g,"").split(/\s*\n\s*/);
			var codeId:int=-1;
			codeArr=new Array();
			
			var codeStr:String;
			var i:int;
			var labelMarkMark:Object=new Object();
			
			var execResult:Array;
			
			var exceptionXMLDict:Dictionary=new Dictionary();
			var exceptionMark:Object=new Object();
			
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
								if(/^<[\s\S]*>$/.test(execResult[2])){
									codeArr[codeId]=new Code(op,ABCNamespace.xml2ns(markStrs,new XML(execResult[2]),_initByXMLOptions));
								}else{
									codeArr[codeId]=new Code(op,ABCNamespace.markStr2ns(markStrs,execResult[2]));
								}
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
								if(/^<[\s\S]*>$/.test(execResult[2])){
									codeArr[codeId]=new Code(op,ABCMultiname.xml2multiname(markStrs,new XML(execResult[2]),_initByXMLOptions));
								}else{
									codeArr[codeId]=new Code(op,ABCMultiname.markStr2multiname(markStrs,execResult[2]));
								}
							break;
							case AVM2Ops.newfunction://0x40	//u8_u30__method
								codeArr[codeId]=new Code(op,markStrs.methodMark["~"+execResult[2]]);
							break;
							case AVM2Ops.newclass://0x58	//u8_u30__class
								var class_name:ABCMultiname;
								if(/^<[\s\S]*>$/.test(execResult[2])){
									class_name=ABCMultiname.xml2multiname(markStrs,new XML(execResult[2]),_initByXMLOptions);
								}else{
									class_name=ABCMultiname.markStr2multiname(markStrs,execResult[2]);
								}
								codeArr[codeId]=new Code(op,markStrs.classDict[class_name]);
								if(codeArr[codeId].value){
								}else{
									throw new Error("找不到 "+class_name.toMarkStrAndMark(markStrs)+" 对应的 ABCClass，请检查 ABCClasses.initByXML()");
								}
							break;
							case AVM2Ops.newcatch://0x5a	//u8_u30__exception_info
								var exceptionXML:XML=new XML(execResult[2]);
								
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
										throw new Error("找不到对应的 exception.from: "+execResult[2]);
									}
									
									exception.to=labelMarkMark[exceptionXML.@to.toString()+":"];
									if(exception.to){
									}else{
										throw new Error("找不到对应的 exception.to: "+execResult[2]);
									}
									
									exception.target=labelMarkMark[exceptionXML.@target.toString()+":"];
									if(exception.target){
									}else{
										throw new Error("找不到对应的 exception.target: "+execResult[2]);
									}
								}
								codeArr[codeId]=new Code(op,exception);
							break;
							case AVM2Ops.finddef://0x5f	//u8_u30__finddef
								throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
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
									args:int(execResult[2])
								});
								if(/^<[\s\S]*>$/.test(execResult[1])){
									codeArr[codeId].value.multiname=ABCMultiname.xml2multiname(markStrs,new XML(execResult[1]),_initByXMLOptions);
								}else{
									codeArr[codeId].value.multiname=ABCMultiname.markStr2multiname(markStrs,execResult[1]);
								}
							break;
							case AVM2Ops.callmethod://0x43	//u8_u30_u30__method_args
							case AVM2Ops.callstatic://0x44	//u8_u30_u30__method_args
								Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
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
		}
		}//end of CONFIG::USE_XML
	}
}