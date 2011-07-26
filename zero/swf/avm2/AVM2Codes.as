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
				
				switch(AVM2Ops.opTypeV[op]){
					//case 0x01://AVM2Ops.bkpt	//u8
					//case 0x02://AVM2Ops.nop	//u8
					//case 0x03://AVM2Ops.throw_	//u8
					//case 0x07://AVM2Ops.dxnslate	//u8
					//case 0x09://AVM2Ops.label	//u8
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
					//case 0x2a://AVM2Ops.dup	//u8
					//case 0x2b://AVM2Ops.swap	//u8
					//case 0x30://AVM2Ops.pushscope	//u8
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
					//case 0x47://AVM2Ops.returnvoid	//u8
					//case 0x48://AVM2Ops.returnvalue	//u8
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
					//case 0xc1://AVM2Ops.decrement_i	//u8
					//case 0xc4://AVM2Ops.negate_i	//u8
					//case 0xc5://AVM2Ops.add_i	//u8
					//case 0xc6://AVM2Ops.subtract_i	//u8
					//case 0xc7://AVM2Ops.multiply_i	//u8
					//case 0xd0://AVM2Ops.getlocal0	//u8
					//case 0xd1://AVM2Ops.getlocal1	//u8
					//case 0xd2://AVM2Ops.getlocal2	//u8
					//case 0xd3://AVM2Ops.getlocal3	//u8
					//case 0xd4://AVM2Ops.setlocal0	//u8
					//case 0xd5://AVM2Ops.setlocal1	//u8
					//case 0xd6://AVM2Ops.setlocal2	//u8
					//case 0xd7://AVM2Ops.setlocal3	//u8
					//case 0xf3://AVM2Ops.timestamp	//u8
					case "op":
						codeByPosArr[pos]=op;
					break;
					//case 0x24://AVM2Ops.pushbyte	//u8_u8
					case "pushbyte":
						codeByPosArr[pos]=new Code(op,data[offset++]);
						if(codeByPosArr[pos].value&0x80){codeByPosArr[pos].value|=0xffffff00}//最高位为1,表示负数
					break;
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
					//case 0x49://AVM2Ops.constructsuper	//u8_u30__args
					//case 0x53://AVM2Ops.applytype	//u8_u30__args
					//case 0x55://AVM2Ops.newobject	//u8_u30__args
					//case 0x56://AVM2Ops.newarray	//u8_u30__args
					case "int":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28));}else{codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21));}}else{codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14));}}else{codeByPosArr[pos]=new Code(op,(data[offset++]&0x7f)|(data[offset++]<<7));}}else{codeByPosArr[pos]=new Code(op,data[offset++]);}
						//codeByPosArr[pos]=new Code(op,u30_1);
					break;
					//case 0x2d://AVM2Ops.pushint	//u8_u30__int
					case "pushint":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,integerV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,integerV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,integerV[u30_1]);
					break;
					//case 0x2e://AVM2Ops.pushuint	//u8_u30__uint
					case "pushuint":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,uintegerV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,uintegerV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,uintegerV[u30_1]);
					break;
					//case 0x2f://AVM2Ops.pushdouble	//u8_u30__double
					case "pushdouble":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,doubleV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,doubleV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,doubleV[u30_1]);
					break;
					//case 0x06://AVM2Ops.dxns	//u8_u30__string
					//case 0x2c://AVM2Ops.pushstring	//u8_u30__string
					//case 0xf1://AVM2Ops.debugfile	//u8_u30__string
					case "string":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,stringV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,stringV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,stringV[u30_1]);
					break;
					//case 0x31://AVM2Ops.pushnamespace	//u8_u30__namespace_info
					case "pushnamespace":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,allNsV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,allNsV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,allNsV[u30_1]);
					break;
					//case 0x04://AVM2Ops.getsuper	//u8_u30__multiname_info
					//case 0x05://AVM2Ops.setsuper	//u8_u30__multiname_info
					//case 0x59://AVM2Ops.getdescendants	//u8_u30__multiname_info
					//case 0x5d://AVM2Ops.findpropstrict	//u8_u30__multiname_info
					//case 0x5e://AVM2Ops.findproperty	//u8_u30__multiname_info
					//case 0x60://AVM2Ops.getlex	//u8_u30__multiname_info
					//case 0x61://AVM2Ops.setproperty	//u8_u30__multiname_info
					//case 0x66://AVM2Ops.getproperty	//u8_u30__multiname_info
					//case 0x68://AVM2Ops.initproperty	//u8_u30__multiname_info
					//case 0x6a://AVM2Ops.deleteproperty	//u8_u30__multiname_info
					//case 0x80://AVM2Ops.coerce	//u8_u30__multiname_info
					//case 0x86://AVM2Ops.astype	//u8_u30__multiname_info
					//case 0xb2://AVM2Ops.istype	//u8_u30__multiname_info
					case "multiname":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,allMultinameV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,allMultinameV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,allMultinameV[u30_1]);
					break;
					//case 0x40://AVM2Ops.newfunction	//u8_u30__method
					case "newfunction":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,allMethodV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,allMethodV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,allMethodV[u30_1]);
					break;
					//case 0x58://AVM2Ops.newclass	//u8_u30__class
					case "newclass":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)]);}else{codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)]);}}else{codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)]);}}else{codeByPosArr[pos]=new Code(op,classV[(data[offset++]&0x7f)|(data[offset++]<<7)]);}}else{codeByPosArr[pos]=new Code(op,classV[data[offset++]]);}
						//codeByPosArr[pos]=new Code(op,classV[u30_1]);
					break;
					//case 0x5a://AVM2Ops.newcatch	//u8_u30__exception_info
					case "newcatch":
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
					//case 0x5f://AVM2Ops.finddef	//u8_u30__finddef
					case "finddef":
						throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
					break;
					//case 0x32://AVM2Ops.hasnext2	//u8_u30_u30__register_register
					case "hasnext2":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
						//u30_1
						
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
						//u30_2
						
						codeByPosArr[pos]=new Code(op,{
							register1:u30_1,
							register2:u30_2
						});
					break;
					//case 0x45://AVM2Ops.callsuper	//u8_u30_u30__multiname_info_args
					//case 0x46://AVM2Ops.callproperty	//u8_u30_u30__multiname_info_args
					//case 0x4a://AVM2Ops.constructprop	//u8_u30_u30__multiname_info_args
					//case 0x4c://AVM2Ops.callproplex	//u8_u30_u30__multiname_info_args
					//case 0x4e://AVM2Ops.callsupervoid	//u8_u30_u30__multiname_info_args
					//case 0x4f://AVM2Ops.callpropvoid	//u8_u30_u30__multiname_info_args
					case "multiname args":
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
						//u30_1
						
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
						//u30_2
						
						codeByPosArr[pos]=new Code(op,{
							multiname:allMultinameV[u30_1],
							args:u30_2
						});
					break;
					//case 0x43://AVM2Ops.callmethod	//u8_u30_u30__method_args
					//case 0x44://AVM2Ops.callstatic	//u8_u30_u30__method_args
					case "method args":
						//codeByPosArr[pos]=new Code(op,{
						//	method:allMethod(u30_1),
						//	args:u30_2
						//});
						throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
					break;
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
					//case 0x17://AVM2Ops.ifgt	//u8_s24__branch
					//case 0x18://AVM2Ops.ifge	//u8_s24__branch
					//case 0x19://AVM2Ops.ifstricteq	//u8_s24__branch
					//case 0x1a://AVM2Ops.ifstrictne	//u8_s24__branch
					case "branch":
						jumpOffset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
						if(jumpOffset&0x00800000){jumpOffset|=0xff000000}//最高位为1,表示负数
						jumpPos=offset+jumpOffset;
						if(jumpPos<0||jumpPos>endOffset){
							jumpPos=endOffset;
							Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
						}
						codeByPosArr[pos]=new Code(op,labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
					break;
					//case 0x1b://AVM2Ops.lookupswitch	//u8_s24_u30_s24List__lookupswitch
					case "lookupswitch":
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
					//case 0xef://AVM2Ops.debug	//u8_u8_u30_u8_u30__debug
					case "debug":
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
				if(code.constructor==Code){
					switch(AVM2Ops.opTypeV[code.op]){
						//case 0x2d://AVM2Ops.pushint	//u8_u30__int
						case "pushint":
							productMark.productInteger(code.value);
						break;
						//case 0x2e://AVM2Ops.pushuint	//u8_u30__uint
						case "pushuint":
							productMark.productUinteger(code.value);
						break;
						//case 0x2f://AVM2Ops.pushdouble	//u8_u30__double
						case "pushdouble":
							productMark.productDouble(code.value);
						break;
						//case 0x06://AVM2Ops.dxns	//u8_u30__string
						//case 0x2c://AVM2Ops.pushstring	//u8_u30__string
						//case 0xf1://AVM2Ops.debugfile	//u8_u30__string
						case "string":
							productMark.productString(code.value);
						break;
						//case 0x31://AVM2Ops.pushnamespace	//u8_u30__namespace_info
						case "pushnamespace":
							productMark.productNs(code.value);
						break;
						//case 0x04://AVM2Ops.getsuper	//u8_u30__multiname_info
						//case 0x05://AVM2Ops.setsuper	//u8_u30__multiname_info
						//case 0x59://AVM2Ops.getdescendants	//u8_u30__multiname_info
						//case 0x5d://AVM2Ops.findpropstrict	//u8_u30__multiname_info
						//case 0x5e://AVM2Ops.findproperty	//u8_u30__multiname_info
						//case 0x60://AVM2Ops.getlex	//u8_u30__multiname_info
						//case 0x61://AVM2Ops.setproperty	//u8_u30__multiname_info
						//case 0x66://AVM2Ops.getproperty	//u8_u30__multiname_info
						//case 0x68://AVM2Ops.initproperty	//u8_u30__multiname_info
						//case 0x6a://AVM2Ops.deleteproperty	//u8_u30__multiname_info
						//case 0x80://AVM2Ops.coerce	//u8_u30__multiname_info
						//case 0x86://AVM2Ops.astype	//u8_u30__multiname_info
						//case 0xb2://AVM2Ops.istype	//u8_u30__multiname_info
						case "multiname":
							productMark.productMultiname(code.value);
						break;
						//case 0x40://AVM2Ops.newfunction	//u8_u30__method
						case "newfunction":
							productMark.productMethod(code.value);
						break;
						//case 0x58://AVM2Ops.newclass	//u8_u30__class
						//case "newclass":
							//已在 ABCClasses.toData 里 product 过了
						//break;
						//case 0x5a://AVM2Ops.newcatch	//u8_u30__exception_info
						case "newcatch":
							code.value.getInfo_product(productMark);
						break;
						//case 0x5f://AVM2Ops.finddef	//u8_u30__finddef
						//case "finddef":
							//throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
						//break;
						//case 0x45://AVM2Ops.callsuper	//u8_u30_u30__multiname_info_args
						//case 0x46://AVM2Ops.callproperty	//u8_u30_u30__multiname_info_args
						//case 0x4a://AVM2Ops.constructprop	//u8_u30_u30__multiname_info_args
						//case 0x4c://AVM2Ops.callproplex	//u8_u30_u30__multiname_info_args
						//case 0x4e://AVM2Ops.callsupervoid	//u8_u30_u30__multiname_info_args
						//case 0x4f://AVM2Ops.callpropvoid	//u8_u30_u30__multiname_info_args
						case "multiname args":
							productMark.productMultiname(code.value.multiname);
						break;
						//case 0x43://AVM2Ops.callmethod	//u8_u30_u30__method_args
						//case 0x44://AVM2Ops.callstatic	//u8_u30_u30__method_args
						//case "method args":
							//Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
						//break;
						//case 0xef://AVM2Ops.debug	//u8_u8_u30_u8_u30__debug
						case "debug":
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
				switch(code.constructor){
					case LabelMark:
						code.pos=offset;
					break;
					case Array:
						//Outputer.output("使用 Array 进行记录的未知代码："+code,"brown");
						for each(var num:int in code){
							data[offset++]=num;
						}
					break;
					case ByteArray:
						Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
						data.position=offset;
						data.writeBytes(code,0,code.length);
						offset=data.length;
					break;
					case Code:
						data[offset++]=code.op;
						switch(AVM2Ops.opTypeV[code.op]){
							//case 0x24://AVM2Ops.pushbyte	//u8_u8
							case "pushbyte":
								data[offset++]=code.value;
							break;
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
							//case 0x49://AVM2Ops.constructsuper	//u8_u30__args
							//case 0x53://AVM2Ops.applytype	//u8_u30__args
							//case 0x55://AVM2Ops.newobject	//u8_u30__args
							//case 0x56://AVM2Ops.newarray	//u8_u30__args
							case "int":
								u30_1=code.value;
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x2d://AVM2Ops.pushint	//u8_u30__int
							case "pushint":
								u30_1=productMark.getIntegerId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x2e://AVM2Ops.pushuint	//u8_u30__uint
							case "pushuint":
								u30_1=productMark.getUintegerId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x2f://AVM2Ops.pushdouble	//u8_u30__double
							case "pushdouble":
								u30_1=productMark.getDoubleId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x06://AVM2Ops.dxns	//u8_u30__string
							//case 0x2c://AVM2Ops.pushstring	//u8_u30__string
							//case 0xf1://AVM2Ops.debugfile	//u8_u30__string
							case "string":
								u30_1=productMark.getStringId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x31://AVM2Ops.pushnamespace	//u8_u30__namespace_info
							case "pushnamespace":
								u30_1=productMark.getNsId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x04://AVM2Ops.getsuper	//u8_u30__multiname_info
							//case 0x05://AVM2Ops.setsuper	//u8_u30__multiname_info
							//case 0x59://AVM2Ops.getdescendants	//u8_u30__multiname_info
							//case 0x5d://AVM2Ops.findpropstrict	//u8_u30__multiname_info
							//case 0x5e://AVM2Ops.findproperty	//u8_u30__multiname_info
							//case 0x60://AVM2Ops.getlex	//u8_u30__multiname_info
							//case 0x61://AVM2Ops.setproperty	//u8_u30__multiname_info
							//case 0x66://AVM2Ops.getproperty	//u8_u30__multiname_info
							//case 0x68://AVM2Ops.initproperty	//u8_u30__multiname_info
							//case 0x6a://AVM2Ops.deleteproperty	//u8_u30__multiname_info
							//case 0x80://AVM2Ops.coerce	//u8_u30__multiname_info
							//case 0x86://AVM2Ops.astype	//u8_u30__multiname_info
							//case 0xb2://AVM2Ops.istype	//u8_u30__multiname_info
							case "multiname":
								u30_1=productMark.getMultinameId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x40://AVM2Ops.newfunction	//u8_u30__method
							case "newfunction":
								u30_1=productMark.getMethodId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x58://AVM2Ops.newclass	//u8_u30__class
							case "newclass":
								u30_1=productMark.getClassId(code.value);
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
							break;
							//case 0x5a://AVM2Ops.newcatch	//u8_u30__exception_info
							case "newcatch":
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
							//case 0x5f://AVM2Ops.finddef	//u8_u30__finddef
							case "finddef":
								throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
							break;
							//case 0x32://AVM2Ops.hasnext2	//u8_u30_u30__register_register
							case "hasnext2":
								u30_1=code.value.register1;
								u30_2=code.value.register2;
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
								
								if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
								//u30_2
							break;
							//case 0x45://AVM2Ops.callsuper	//u8_u30_u30__multiname_info_args
							//case 0x46://AVM2Ops.callproperty	//u8_u30_u30__multiname_info_args
							//case 0x4a://AVM2Ops.constructprop	//u8_u30_u30__multiname_info_args
							//case 0x4c://AVM2Ops.callproplex	//u8_u30_u30__multiname_info_args
							//case 0x4e://AVM2Ops.callsupervoid	//u8_u30_u30__multiname_info_args
							//case 0x4f://AVM2Ops.callpropvoid	//u8_u30_u30__multiname_info_args
							case "multiname args":
								u30_1=productMark.getMultinameId(code.value.multiname),
								u30_2=code.value.args;
								if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
								//u30_1
								
								if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
								//u30_2
							break;
							//case 0x43://AVM2Ops.callmethod	//u8_u30_u30__method_args
							//case 0x44://AVM2Ops.callstatic	//u8_u30_u30__method_args
							case "method args":
								Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
							break;
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
							//case 0x17://AVM2Ops.ifgt	//u8_s24__branch
							//case 0x18://AVM2Ops.ifge	//u8_s24__branch
							//case 0x19://AVM2Ops.ifstricteq	//u8_s24__branch
							//case 0x1a://AVM2Ops.ifstrictne	//u8_s24__branch
							case "branch":
								offset+=3;
								posMarkArr[offset]=code.value;
							break;
							//case 0x1b://AVM2Ops.lookupswitch	//u8_s24_u30_s24List__lookupswitch
							case "lookupswitch":
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
							//case 0xef://AVM2Ops.debug	//u8_u8_u30_u8_u30__debug
							case "debug":
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
					break;
					default://int
						data[offset++]=code;
					break;
				}
			}
			
			var endOffset:int=data.length;
			for(offset=0;offset<=endOffset;offset++){
				code=posMarkArr[offset];
				if(code){
					if(code.constructor==LabelMark){
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
					switch(code.constructor){
						case LabelMark:
							codesStr+="\t\t\t\tlabel"+code.labelId+":\n";
						break;
						case Array:
							Outputer.output("使用 Array 进行记录的未知代码："+code,"brown");
							var numStr:String="";
							for each(var num:int in code){
								numStr+=" "+BytesAndStr16._16V[num&0xff];
							}
							codesStr+="\t\t\t\t\t"+numStr.substr(1)+"\n";
						break;
						case ByteArray:
							Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
							codesStr+="\t\t\t\t\t"+BytesAndStr16.bytes2str16(code,0,code.length)+"\n";
						break;
						case Code:
							switch(AVM2Ops.opTypeV[code.op]){
								//case 0x24://AVM2Ops.pushbyte	//u8_u8
								case "pushbyte":
									
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
								//case 0x49://AVM2Ops.constructsuper	//u8_u30__args
								//case 0x53://AVM2Ops.applytype	//u8_u30__args
								//case 0x55://AVM2Ops.newobject	//u8_u30__args
								//case 0x56://AVM2Ops.newarray	//u8_u30__args
								case "int":
									
								//case 0x2d://AVM2Ops.pushint	//u8_u30__int
								case "pushint":
									
								//case 0x2e://AVM2Ops.pushuint	//u8_u30__uint
								case "pushuint":
									
								//case 0x2f://AVM2Ops.pushdouble	//u8_u30__double
								case "pushdouble":
									
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value+"\n";
								break;
								
								//case 0x06://AVM2Ops.dxns	//u8_u30__string
								//case 0x2c://AVM2Ops.pushstring	//u8_u30__string
								//case 0xf1://AVM2Ops.debugfile	//u8_u30__string
								case "string":
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" \""+ComplexString.normal.escape(code.value)+"\"\n";
								break;
								
								//case 0x31://AVM2Ops.pushnamespace	//u8_u30__namespace_info
								case "pushnamespace":
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.toMarkStrAndMark(markStrs)+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.toXMLAndMark(markStrs,"ns",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+"\n";
									}
								break;
								
								//case 0x04://AVM2Ops.getsuper	//u8_u30__multiname_info
								//case 0x05://AVM2Ops.setsuper	//u8_u30__multiname_info
								//case 0x59://AVM2Ops.getdescendants	//u8_u30__multiname_info
								//case 0x5d://AVM2Ops.findpropstrict	//u8_u30__multiname_info
								//case 0x5e://AVM2Ops.findproperty	//u8_u30__multiname_info
								//case 0x60://AVM2Ops.getlex	//u8_u30__multiname_info
								//case 0x61://AVM2Ops.setproperty	//u8_u30__multiname_info
								//case 0x66://AVM2Ops.getproperty	//u8_u30__multiname_info
								//case 0x68://AVM2Ops.initproperty	//u8_u30__multiname_info
								//case 0x6a://AVM2Ops.deleteproperty	//u8_u30__multiname_info
								//case 0x80://AVM2Ops.coerce	//u8_u30__multiname_info
								//case 0x86://AVM2Ops.astype	//u8_u30__multiname_info
								//case 0xb2://AVM2Ops.istype	//u8_u30__multiname_info
								case "multiname":
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.toMarkStrAndMark(markStrs)+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.toXMLAndMark(markStrs,"multiname",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+"\n";
									}
								break;
								
								//case 0x40://AVM2Ops.newfunction	//u8_u30__method
								case "newfunction":
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
								
								//case 0x58://AVM2Ops.newclass	//u8_u30__class
								case "newclass":
									var class_name:ABCMultiname=code.value.name;
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+class_name.toMarkStrAndMark(markStrs)+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+class_name.toXMLAndMark(markStrs,"class_name",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+"\n";
									}
								break;
								
								//case 0x5a://AVM2Ops.newcatch	//u8_u30__exception_info
								case "newcatch":
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
								
								//case 0x5f://AVM2Ops.finddef	//u8_u30__finddef
								case "finddef":
									throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
								break;
									
								//case 0x32://AVM2Ops.hasnext2	//u8_u30_u30__register_register
								case "hasnext2":
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.register1+" "+code.value.register2+"\n";
								break;
								
								//case 0x45://AVM2Ops.callsuper	//u8_u30_u30__multiname_info_args
								//case 0x46://AVM2Ops.callproperty	//u8_u30_u30__multiname_info_args
								//case 0x4a://AVM2Ops.constructprop	//u8_u30_u30__multiname_info_args
								//case 0x4c://AVM2Ops.callproplex	//u8_u30_u30__multiname_info_args
								//case 0x4e://AVM2Ops.callsupervoid	//u8_u30_u30__multiname_info_args
								//case 0x4f://AVM2Ops.callpropvoid	//u8_u30_u30__multiname_info_args
								case "multiname args":
									if(_toXMLOptions.AVM2UseMarkStr){
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.multiname.toMarkStrAndMark(markStrs)+" "+code.value.args+"\n";
									}else{
										codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions).toXMLString().replace(/\s*\n\s*/g,"")+" "+code.value.args+"\n";
									}
								break;
								
								//case 0x43://AVM2Ops.callmethod	//u8_u30_u30__method_args
								//case 0x44://AVM2Ops.callstatic	//u8_u30_u30__method_args
								case "method args":
									Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[code.op]+" 的例子！");
								break;
									
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
								//case 0x17://AVM2Ops.ifgt	//u8_s24__branch
								//case 0x18://AVM2Ops.ifge	//u8_s24__branch
								//case 0x19://AVM2Ops.ifstricteq	//u8_s24__branch
								//case 0x1a://AVM2Ops.ifstrictne	//u8_s24__branch
								case "branch":
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" label"+code.value.labelId+"\n";
								break;
									
								//case 0x1b://AVM2Ops.lookupswitch	//u8_s24_u30_s24List__lookupswitch
								case "lookupswitch":
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" label"+code.value.default_offset.labelId;
									for each(labelMark in code.value.case_offsetV){
										codesStr+=" label"+labelMark.labelId;
									}
									codesStr+="\n";
								break;
									
								//case 0xef://AVM2Ops.debug	//u8_u8_u30_u8_u30__debug
								case "debug":
									codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code.op]+" "+code.value.debug_type+" \""+ComplexString.normal.escape(code.value.index)+"\" "+code.value.reg+" "+code.value.extra+"\n";
								break;
								
								default:
									Outputer.outputError("未知 op: "+code.op);
								break;
							}
						break;
						default:
							codesStr+="\t\t\t\t\t"+AVM2Ops.opNameV[code]+"\n";
						break;
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
						switch(AVM2Ops.opTypeV[op]){
							//case 0x01://AVM2Ops.bkpt	//u8
							//case 0x02://AVM2Ops.nop	//u8
							//case 0x03://AVM2Ops.throw_	//u8
							//case 0x07://AVM2Ops.dxnslate	//u8
							//case 0x09://AVM2Ops.label	//u8
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
							//case 0x2a://AVM2Ops.dup	//u8
							//case 0x2b://AVM2Ops.swap	//u8
							//case 0x30://AVM2Ops.pushscope	//u8
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
							//case 0x47://AVM2Ops.returnvoid	//u8
							//case 0x48://AVM2Ops.returnvalue	//u8
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
							//case 0xc1://AVM2Ops.decrement_i	//u8
							//case 0xc4://AVM2Ops.negate_i	//u8
							//case 0xc5://AVM2Ops.add_i	//u8
							//case 0xc6://AVM2Ops.subtract_i	//u8
							//case 0xc7://AVM2Ops.multiply_i	//u8
							//case 0xd0://AVM2Ops.getlocal0	//u8
							//case 0xd1://AVM2Ops.getlocal1	//u8
							//case 0xd2://AVM2Ops.getlocal2	//u8
							//case 0xd3://AVM2Ops.getlocal3	//u8
							//case 0xd4://AVM2Ops.setlocal0	//u8
							//case 0xd5://AVM2Ops.setlocal1	//u8
							//case 0xd6://AVM2Ops.setlocal2	//u8
							//case 0xd7://AVM2Ops.setlocal3	//u8
							//case 0xf3://AVM2Ops.timestamp	//u8
							case "op":
								codeArr[codeId]=op;
							break;
							
							//case 0x24://AVM2Ops.pushbyte	//u8_u8
							case "pushbyte":
								
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
							//case 0x49://AVM2Ops.constructsuper	//u8_u30__args
							//case 0x53://AVM2Ops.applytype	//u8_u30__args
							//case 0x55://AVM2Ops.newobject	//u8_u30__args
							//case 0x56://AVM2Ops.newarray	//u8_u30__args
							case "int":
								
							//case 0x2d://AVM2Ops.pushint	//u8_u30__int
							case "pushint":
								
							//case 0x2e://AVM2Ops.pushuint	//u8_u30__uint
							case "pushuint":
								
								codeArr[codeId]=new Code(op,int(execResult[2]));
							break;
							
							//case 0x2f://AVM2Ops.pushdouble	//u8_u30__double
							case "pushdouble":
								codeArr[codeId]=new Code(op,Number(execResult[2]));
							break;
							
							//case 0x06://AVM2Ops.dxns	//u8_u30__string
							//case 0x2c://AVM2Ops.pushstring	//u8_u30__string
							//case 0xf1://AVM2Ops.debugfile	//u8_u30__string
							case "string":
								execResult=/^("|')([\s\S]*)\1$/.exec(execResult[2]);
								codeArr[codeId]=new Code(op,ComplexString.normal.unescape(execResult[2]));
							break;
							
							//case 0x31://AVM2Ops.pushnamespace	//u8_u30__namespace_info
							case "pushnamespace":
								if(/^<[\s\S]*>$/.test(execResult[2])){
									codeArr[codeId]=new Code(op,ABCNamespace.xml2ns(markStrs,new XML(execResult[2]),_initByXMLOptions));
								}else{
									codeArr[codeId]=new Code(op,ABCNamespace.markStr2ns(markStrs,execResult[2]));
								}
							break;
							
							//case 0x04://AVM2Ops.getsuper	//u8_u30__multiname_info
							//case 0x05://AVM2Ops.setsuper	//u8_u30__multiname_info
							//case 0x59://AVM2Ops.getdescendants	//u8_u30__multiname_info
							//case 0x5d://AVM2Ops.findpropstrict	//u8_u30__multiname_info
							//case 0x5e://AVM2Ops.findproperty	//u8_u30__multiname_info
							//case 0x60://AVM2Ops.getlex	//u8_u30__multiname_info
							//case 0x61://AVM2Ops.setproperty	//u8_u30__multiname_info
							//case 0x66://AVM2Ops.getproperty	//u8_u30__multiname_info
							//case 0x68://AVM2Ops.initproperty	//u8_u30__multiname_info
							//case 0x6a://AVM2Ops.deleteproperty	//u8_u30__multiname_info
							//case 0x80://AVM2Ops.coerce	//u8_u30__multiname_info
							//case 0x86://AVM2Ops.astype	//u8_u30__multiname_info
							//case 0xb2://AVM2Ops.istype	//u8_u30__multiname_info
							case "multiname":
								if(/^<[\s\S]*>$/.test(execResult[2])){
									codeArr[codeId]=new Code(op,ABCMultiname.xml2multiname(markStrs,new XML(execResult[2]),_initByXMLOptions));
								}else{
									codeArr[codeId]=new Code(op,ABCMultiname.markStr2multiname(markStrs,execResult[2]));
								}
							break;
							
							//case 0x40://AVM2Ops.newfunction	//u8_u30__method
							case "newfunction":
								codeArr[codeId]=new Code(op,markStrs.methodMark["~"+execResult[2]]);
							break;
							
							//case 0x58://AVM2Ops.newclass	//u8_u30__class
							case "newclass":
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
							
							//case 0x5a://AVM2Ops.newcatch	//u8_u30__exception_info
							case "newcatch":
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
							
							//case 0x5f://AVM2Ops.finddef	//u8_u30__finddef
							case "finddef":
								throw new Error("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
							break;
								
							//case 0x32://AVM2Ops.hasnext2	//u8_u30_u30__register_register
							case "hasnext2":
								execResult=/^(\w+)\s+(\w+)$/.exec(execResult[2]);
								codeArr[codeId]=new Code(op,{
									register1:int(execResult[1]),
									register2:int(execResult[2])
								});
							break;
							
							//case 0x45://AVM2Ops.callsuper	//u8_u30_u30__multiname_info_args
							//case 0x46://AVM2Ops.callproperty	//u8_u30_u30__multiname_info_args
							//case 0x4a://AVM2Ops.constructprop	//u8_u30_u30__multiname_info_args
							//case 0x4c://AVM2Ops.callproplex	//u8_u30_u30__multiname_info_args
							//case 0x4e://AVM2Ops.callsupervoid	//u8_u30_u30__multiname_info_args
							//case 0x4f://AVM2Ops.callpropvoid	//u8_u30_u30__multiname_info_args
							case "multiname args":
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
							
							//case 0x43://AVM2Ops.callmethod	//u8_u30_u30__method_args
							//case 0x44://AVM2Ops.callstatic	//u8_u30_u30__method_args
							case "method args":
								Outputer.outputError("恭喜你，你发现了一个 "+AVM2Ops.opNameV[op]+" 的例子！");
							break;
							
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
							//case 0x17://AVM2Ops.ifgt	//u8_s24__branch
							//case 0x18://AVM2Ops.ifge	//u8_s24__branch
							//case 0x19://AVM2Ops.ifstricteq	//u8_s24__branch
							//case 0x1a://AVM2Ops.ifstrictne	//u8_s24__branch
							case "branch":
								codeArr[codeId]=new Code(op,labelMarkMark[execResult[2]+":"]);
								if(codeArr[codeId].value){
								}else{
									throw new Error("找不到对应的 labelMark: "+codeStr);
								}
							break;
							
							//case 0x1b://AVM2Ops.lookupswitch	//u8_s24_u30_s24List__lookupswitch
							case "lookupswitch":
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
							
							//case 0xef://AVM2Ops.debug	//u8_u8_u30_u8_u30__debug
							case "debug":
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