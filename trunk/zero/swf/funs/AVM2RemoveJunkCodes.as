/***
AVM2RemoveJunkCodes
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月15日 16:48:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import zero.swf.codes.*;
	import zero.swf.avm2.*;
	
	public class AVM2RemoveJunkCodes{
		public static function remove(codeArr:Array,paramLocalNum:int,removeAVM2JunkCodesFun:Function):Array{
			while(true){//迭代处理
				var lastTotalCode:int=codeArr.length;
				
				codeArr=markRemove(codeArr);
				
				codeArr=remove0Branch(codeArr);
				
				removeUnusedLabels(codeArr);
				
				codeArr=normalizePushPushSwap(codeArr);
				
				codeArr=normalizePushBooleanPushBooleanSetLocalXSetLocalY(codeArr,paramLocalNum);
				
				codeArr=normalizeJumps(codeArr);
				
				codeArr=removeOthers(codeArr);
				
				if(removeAVM2JunkCodesFun==null){
				}else{
					codeArr=removeAVM2JunkCodesFun(codeArr);
				}
				
				if(codeArr.length<lastTotalCode){
				}else{
					break;
				}
			}
			return codeArr;
		}
		private static function markRemove(codeArr:Array):Array{
			//基本的标记法清除
			var code:*,codeId:int,totalCode:int,exception:ABCException;
			
			codeId=-1;
			for each(code in codeArr){
				codeId++;
				if(code.constructor==LabelMark){
					code.pos=codeId;
				}
			}
			
			totalCode=codeArr.length;
			var mark:Array=new Array();
			var seed:Array=[0];
			//trace("markRemove");
			while(seed.length){
				while(seed.length){
					//trace("seed="+seed);
					var newSeed:Array=new Array();
					for each(var _codeId:int in seed){
						codeId=_codeId;
						loop:while(codeId<totalCode){
							if(mark[codeId]){
								break loop;
							}
							mark[codeId]=true;
							code=codeArr[codeId];
							switch(code.constructor){
								case LabelMark:
									codeId++;
								break;
								case Array:
								case ByteArray:
									codeId++;
									//throw new Error("暂不支持");
								break;
								case Code:
									switch(AVM2Ops.opTypeV[code.op]){
										case "branch":
											newSeed.push(code.value.pos);
											if(code.op==AVM2Ops.jump){
												break loop;
											}
										break;
										case "lookupswitch":
											newSeed.push(code.value.default_offset.pos);
											for each(var case_offset:LabelMark in code.value.case_offsetV){
												newSeed.push(case_offset.pos);
											}
											break loop;
										break;
										//case "newcatch:":
										//	在下面集中处理
										//break;
									}
									codeId++;
								break;
								default://int
									switch(code){
										case AVM2Ops.returnvoid:
										case AVM2Ops.returnvalue:
											break loop;
										break;
										case AVM2Ops.throw_:
											//寻找最近的 newcatch
											var throwCodeId:int=codeId;
											var newcatchCode:Code=null;
											while(++codeId<totalCode){
												code=codeArr[codeId];
												if(
													code.constructor==Code
													&&
													code.op==AVM2Ops.newcatch
												){
													newcatchCode=code;
													break;
												}
											}
											if(newcatchCode){
												exception=newcatchCode.value;
												if(throwCodeId>exception.from.pos&&throwCodeId<exception.to.pos){
													mark[exception.from.pos]=true;
													mark[exception.to.pos]=true;
													//mark[exception.target.pos]=true;
													newSeed.push(exception.target.pos);
												}
											}
											break loop;
										break;
										default:
											codeId++;
										break;
									}
								break;
							}
								
						}
					}

					seed=newSeed;
				}
				
				//集中处理 newcatch
				//搜索是否有 newcatch 跳转到的 pos
				seed=new Array();
				codeId=-1;
				for each(code in codeArr){
					codeId++;
					//if(mark[codeId]){
					//}else{
						if(
							code.constructor==Code
							&&
							code.op==AVM2Ops.newcatch
						){
							exception=code.value;
							for(_codeId=exception.from.pos+1;_codeId<exception.to.pos;_codeId++){
								if(mark[_codeId]){
									if(
										mark[exception.from.pos]
										&&
										mark[exception.to.pos]
										&&
										mark[exception.target.pos]
									){
										//
									}else{
										seed.push(
											exception.from.pos,
											exception.to.pos,
											exception.target.pos
										);
									}
									break;
								}
							}
						}
					//}
				}
			}
			
			var newCodeArr:Array=new Array();
			codeId=-1;
			for each(code in codeArr){
				codeId++;
				if(mark[codeId]){
					newCodeArr.push(code);
				}
			}
			
			return newCodeArr;
		}
		
		private static function remove0Branch(codeArr:Array):Array{
			//去掉直接跳到紧邻的code的branch
			
			var codeId:int=-1;
			var newCodeArr:Array=new Array();
			for each(var code:* in codeArr){
				codeId++;
				if(
					code.constructor==Code
					&&
					AVM2Ops.opTypeV[code.op]=="branch"
					&&
					codeArr[codeId+1]==code.value//直接跳到紧邻的code的
				){
					switch(code.op){
						case AVM2Ops.jump:
							//
							
							//newCodeArr.push(code);
							
						break;
						case AVM2Ops.iftrue:
						case AVM2Ops.iffalse:
							
							
							newCodeArr.push(
								AVM2Ops.pop
							);
							
							//newCodeArr.push(code);
							
						break;
						default:
							//case 0x0c://AVM2Ops.ifnlt	//u8_s24__branch
							//case 0x0d://AVM2Ops.ifnle	//u8_s24__branch
							//case 0x0e://AVM2Ops.ifngt	//u8_s24__branch
							//case 0x0f://AVM2Ops.ifnge	//u8_s24__branch
							//case 0x13://AVM2Ops.ifeq	//u8_s24__branch
							//case 0x14://AVM2Ops.ifne	//u8_s24__branch
							//case 0x15://AVM2Ops.iflt	//u8_s24__branch
							//case 0x16://AVM2Ops.ifle	//u8_s24__branch
							//case 0x17://AVM2Ops.ifgt	//u8_s24__branch
							//case 0x18://AVM2Ops.ifge	//u8_s24__branch
							//case 0x19://AVM2Ops.ifstricteq	//u8_s24__branch
							//case 0x1a://AVM2Ops.ifstrictne	//u8_s24__branch
							
							newCodeArr.push(
								AVM2Ops.pop,
								AVM2Ops.pop
							);
							
							//newCodeArr.push(code);
							
						break;
					}
				}else{
					newCodeArr.push(code);
				}
			}
			return newCodeArr;
		}
		
		private static function removeUnusedLabels(codeArr:Array):void{
			//去掉无指向的 labelMark
			
			var code:*;
			
			var dict:Dictionary=new Dictionary();
			for each(code in codeArr){
				if(code.constructor==Code){
					switch(AVM2Ops.opTypeV[code.op]){
						case "branch":
							dict[code.value]=true;
						break;
						case "lookupswitch":
							dict[code.value.default_offset]=true;
							for each(var case_offset:LabelMark in code.value.case_offsetV){
								dict[case_offset]=true;
							}
						break;
						case "newcatch":
							dict[code.value.from]=true;
							dict[code.value.to]=true;
							dict[code.value.target]=true;
						break;
					}
				}
			}
			
			var codeId:int=codeArr.length;
			while(--codeId>=0){
				code=codeArr[codeId];
				if(code.constructor==LabelMark){
					if(dict[code]){
					}else{
						codeArr.splice(codeId,1);
					}
				}
			}
			
			codeId=codeArr.length;
			while(--codeId>0){
				if(codeArr[codeId]==AVM2Ops.label){
					if(codeArr[codeId-1].constructor==LabelMark){
					}else{
						codeArr.splice(codeId,1);
					}
				}
			}
		}
		
		private static const pushValueArr:Array=function():Array{
			
			var pushValueArr:Array=new Array();
			
			pushValueArr[AVM2Ops.pushnull]=true;
			pushValueArr[AVM2Ops.pushundefined]=true;
			pushValueArr[AVM2Ops.pushtrue]=true;
			pushValueArr[AVM2Ops.pushfalse]=true;
			pushValueArr[AVM2Ops.pushnan]=true;
			
			pushValueArr[AVM2Ops.pushbyte]=true;
			pushValueArr[AVM2Ops.pushshort]=true;
			pushValueArr[AVM2Ops.pushstring]=true;
			pushValueArr[AVM2Ops.pushint]=true;
			pushValueArr[AVM2Ops.pushuint]=true;
			pushValueArr[AVM2Ops.pushdouble]=true;
			pushValueArr[AVM2Ops.pushnamespace]=true;
			
			return pushValueArr;
		}();
		
		private static function normalizePushPushSwap(codeArr:Array):Array{
			
			//push value1
			//push value2
			//swap
			//==>
			//push value2
			//push value1
			
			var totalCode:int=codeArr.length;
			
			var codeId:int=-1;
			var newCodeArr:Array=new Array();
			while(++codeId<totalCode){
				var code:*=codeArr[codeId];
				if(
					pushValueArr[code]
					||
					(
						code.constructor==Code
						&&
						pushValueArr[code.op]
					)
				){
					var code2:*=codeArr[codeId+1];
					if(
						pushValueArr[code2]
						||
						(
							code2
							&&
							code2.constructor==Code
							&&
							pushValueArr[code2.op]
						)
					){
						if(codeArr[codeId+2]==AVM2Ops.swap){
							newCodeArr.push(
								code2,
								code
							);
							codeId+=2;
						}else{
							newCodeArr.push(code);
						}
					}else{
						newCodeArr.push(code);
					}
				}else{
					newCodeArr.push(code);
				}
			}
			return newCodeArr;
		}
		
		private static function normalizePushBooleanPushBooleanSetLocalXSetLocalY(codeArr:Array,paramLocalNum:int):Array{
			//尝试处理：
			//pushBoolean
			//pushBoolean
			//setlocalx
			//setlocaly
			
			if(codeArr.length){
			}else{
				return [];
			}
			
			var any:Object=new Object();
			
			var codeId:int=-1;
			var stack:Array=new Array();
			var localArr:Array=[any];
			while(--paramLocalNum>0){
				localArr[paramLocalNum]=any;
			}
			//寻找在分枝之前初始化的 local 们：
			loop:for each(var code:* in codeArr){
				codeId++;
				switch(code.constructor){
					case LabelMark:
						break loop;
					break;
					case Array:
					case ByteArray:
						//throw new Error("暂不支持");
						break loop;
					break;
					case Code:
						switch(code.op){
							case AVM2Ops.setlocal:
								localArr[code.value]=stack.pop();
							break;
							default:
								break loop;
							break;
						}
					break;
					default://int
						switch(code){
							case AVM2Ops.pushnull:
								stack.push(null);
							break;
							case AVM2Ops.pushundefined:
								stack.push(undefined);
							break;
							case AVM2Ops.pushtrue:
								stack.push(true);
							break;
							case AVM2Ops.pushfalse:
								stack.push(false);
							break;
							case AVM2Ops.swap:
								var value1:*=stack.pop();
								var value2:*=stack.pop();
								stack.push(value1,value2);
							break;
							case AVM2Ops.setlocal0:
								localArr[0]=stack.pop();
							break;
							case AVM2Ops.setlocal1:
								localArr[1]=stack.pop();
							break;
							case AVM2Ops.setlocal2:
								localArr[2]=stack.pop();
							break;
							case AVM2Ops.setlocal3:
								localArr[3]=stack.pop();
							break;
							default:
								break loop;
							break;
						}
					break;
				}
			}
			
			//标记后面可能被修改的 local 们为 any：
			var totalCode:int=codeArr.length;
			//codeId 从上面的操作开始
			while(codeId<totalCode){
				code=codeArr[codeId];
				switch(code.constructor){
					case LabelMark:
					break;
					case Array:
					case ByteArray:
						//throw new Error("暂不支持");
					break;
					case Code:
						switch(code.op){
							case AVM2Ops.setlocal:
							case AVM2Ops.inclocal:
							case AVM2Ops.declocal:
							case AVM2Ops.inclocal_i:
							case AVM2Ops.declocal_i:
							case AVM2Ops.kill:
								localArr[code.value]=any;
							break;
							case AVM2Ops.hasnext2:
								localArr[code.value.register1]=any;
								localArr[code.value.register2]=any;
							break;
							case AVM2Ops.debug:
								localArr[code.value.reg]=any;
							break;
							default:
								//
							break;
						}
						break;
					default://int
						switch(code){
							case AVM2Ops.setlocal0:
								localArr[0]=any;
							break;
							case AVM2Ops.setlocal1:
								localArr[1]=any;
							break;
							case AVM2Ops.setlocal2:
								localArr[2]=any;
							break;
							case AVM2Ops.setlocal3:
								localArr[3]=any;
							break;
							default:
								//
							break;
						}
					break;
				}
				codeId++;
			}
			
			var newCodeArr:Array=new Array();
			for each(code in codeArr){
				switch(code.constructor){
					case LabelMark:
						var getLocalId:int=-1;
						var setLocalId:int=-1;
					break;
					case Array:
					case ByteArray:
						getLocalId=-1;
						setLocalId=-1;
						//throw new Error("暂不支持");
					break;
					case Code:
						switch(code.op){
							case AVM2Ops.getlocal:
								getLocalId=code.value;
								setLocalId=-1;
							break;
							case AVM2Ops.setlocal:
								getLocalId=-1;
								setLocalId=code.value;
							break;
							default:
								getLocalId=-1;
								setLocalId=-1;
							break;
						}
					break;
					default://int
						switch(code){
							case AVM2Ops.getlocal0:
								getLocalId=0;
								setLocalId=-1;
							break;
							case AVM2Ops.getlocal1:
								getLocalId=1;
								setLocalId=-1;
							break;
							case AVM2Ops.getlocal2:
								getLocalId=2;
								setLocalId=-1;
							break;
							case AVM2Ops.getlocal3:
								getLocalId=3;
								setLocalId=-1;
							break;
							case AVM2Ops.setlocal0:
								getLocalId=-1;
								setLocalId=0;
							break;
							case AVM2Ops.setlocal1:
								getLocalId=-1;
								setLocalId=1;
							break;
							case AVM2Ops.setlocal2:
								getLocalId=-1;
								setLocalId=2;
							break;
							case AVM2Ops.setlocal3:
								getLocalId=-1;
								setLocalId=3;
							break;
							default:
								getLocalId=-1;
								setLocalId=-1;
							break;
						}
					break;
				}
				if(getLocalId>-1){
					switch(localArr[getLocalId]){
						case null:
							newCodeArr.push(AVM2Ops.pushnull);
						break;
						case undefined:
							newCodeArr.push(AVM2Ops.pushundefined);
						break;
						case true:
							newCodeArr.push(AVM2Ops.pushtrue);
						break;
						case false:
							newCodeArr.push(AVM2Ops.pushfalse);
						break;
						case any:
							newCodeArr.push(code);
						break;
						default:
							throw new Error("未知 localArr["+getLocalId+"]："+localArr[getLocalId]);
						break;
					}
				}else if(setLocalId>-1){
					switch(localArr[setLocalId]){
						case null:
						case undefined:
						case true:
						case false:
							newCodeArr.push(AVM2Ops.pop);
						break;
						case any:
							newCodeArr.push(code);
						break;
						default:
							throw new Error("未知 localArr["+setLocalId+"]："+localArr[setLocalId]);
						break;
					}
				}else{
					newCodeArr.push(code);
				}
			}
			codeArr=newCodeArr;
			totalCode=codeArr.length;
			
			for(codeId=0;codeId<totalCode;codeId++){
				code=codeArr[codeId];
				switch(code){
					case AVM2Ops.pushnull:
					case AVM2Ops.pushundefined:
					case AVM2Ops.pushtrue:
					case AVM2Ops.pushfalse:
						if(codeArr[codeId+1]==AVM2Ops.dup){
							codeArr[codeId+1]=code;
						}
					break;
				}
			}
			
			newCodeArr=new Array();
			for(codeId=0;codeId<totalCode;codeId++){
				code=codeArr[codeId];
				switch(code){
					case AVM2Ops.pushnull:
					case AVM2Ops.pushundefined:
					case AVM2Ops.pushtrue:
					case AVM2Ops.pushfalse:
						switch(codeArr[codeId+1]){
							case AVM2Ops.pushnull:
							case AVM2Ops.pushundefined:
							case AVM2Ops.pushtrue:
							case AVM2Ops.pushfalse:
								if(
									codeArr[codeId+2]==AVM2Ops.pop
									&&
									codeArr[codeId+3]==AVM2Ops.pop
								){
									//pushtrue / pushfalse
									//pushtrue / pushfalse
									//pop
									//pop
									//==>
									//
									
									codeId+=3;
								}else{
									newCodeArr.push(code);
								}
							break;
							case AVM2Ops.pop:
								//pushtrue / pushfalse
								//pop
								//==>
								//
								
								codeId++;
							break;
							default:
								newCodeArr.push(code);
							break;
						}
					break;
					default:
						newCodeArr.push(code);
					break;
				}
			}
			
			codeArr=newCodeArr;
			totalCode=codeArr.length;
			
			newCodeArr=new Array();
			for(codeId=0;codeId<totalCode;codeId++){
				code=codeArr[codeId];
				var code2:*=codeArr[codeId+1];
				if(
					code2
					&&
					code2.constructor==Code
				){
					switch(code2.op){
						case AVM2Ops.iftrue:
							switch(code){
								case AVM2Ops.pushtrue:
									//pushtrue
									//iftrue labelx
									//==>
									//jump labelx
									
									newCodeArr.push(
										new Code(AVM2Ops.jump,code2.value)
									);
									
									codeId++;
								break;
								case AVM2Ops.pushnull:
								case AVM2Ops.pushundefined:
								case AVM2Ops.pushfalse:
									//pushfalse
									//iftrue labelx
									//==>
									//
									
									codeId++;
								break;
								default:
									newCodeArr.push(code);
								break;
							}
						break;
						case AVM2Ops.iffalse:
							switch(code){
								case AVM2Ops.pushtrue:
									//pushtrue
									//iffalse labelx
									//==>
									//
									
									codeId++;
								break;
								case AVM2Ops.pushnull:
								case AVM2Ops.pushundefined:
								case AVM2Ops.pushfalse:
									//pushfalse
									//iffalse labelx
									//==>
									//jump labelx
									
									newCodeArr.push(
										new Code(AVM2Ops.jump,code2.value)
									);
									
									codeId++;
								break;
								default:
									newCodeArr.push(code);
								break;
							}
						break;
						default:
							newCodeArr.push(code);
						break;
					}
				}else{
					newCodeArr.push(code);
				}
			}
			
			
			//public static const getlocal:int=98;//0x62
			//public static const setlocal:int=99;//0x63
			//public static const inclocal:int=146;//0x92
			//public static const declocal:int=148;//0x94
			//public static const inclocal_i:int=194;//0xc2
			//public static const declocal_i:int=195;//0xc3
			////public static const getlocal0:int=208;//0xd0
			//public static const getlocal1:int=209;//0xd1
			//public static const getlocal2:int=210;//0xd2
			//public static const getlocal3:int=211;//0xd3
			////public static const setlocal0:int=212;//0xd4
			//public static const setlocal1:int=213;//0xd5
			//public static const setlocal2:int=214;//0xd6
			//public static const setlocal3:int=215;//0xd7
			//kill
			//debug
			//hasnext2
			
			return newCodeArr;
		}
		
		private static function removeOthers(codeArr:Array):Array{
			//其它
			
			var totalCode:int=codeArr.length;
			
			var code:*,code2:*,code3:*
			
			var codeId:int=-1;
			var newCodeArr:Array=new Array();
			while(++codeId<totalCode){
				code=codeArr[codeId];
				if(code==AVM2Ops.nop){
					//
				}else if(
					code==AVM2Ops.pushtrue
					&&
					codeArr[codeId+1]==AVM2Ops.not
				){
					codeId++;
					newCodeArr.push(
						AVM2Ops.pushfalse
					);
				}else if(
					code==AVM2Ops.pushfalse
					&&
					codeArr[codeId+1]==AVM2Ops.not
				){
					codeId++;
					newCodeArr.push(
						AVM2Ops.pushtrue
					);
				}else if(
					code==AVM2Ops.getlocal0
					&&
					codeArr[codeId+1]==AVM2Ops.convert_b
				){
					
					//getlocal0
					//convert_b
					//==>
					//pushtrue
					
					codeId++;
					newCodeArr.push(
						AVM2Ops.pushtrue
					);
				}else if(
					code.constructor==Code
					&&
					code.op==AVM2Ops.pushbyte
				){
					code2=codeArr[codeId+1];
					if(
						code2.constructor==Code
					){
						switch(code2.op){
							case AVM2Ops.pushbyte:
								code3=codeArr[codeId+2];
								if(
									code3.constructor==Code
								){
									if(code3.op==AVM2Ops.ifne){
										if(code.value==code2.value){
											//
										}else{
											newCodeArr.push(new Code(AVM2Ops.jump,code3.value));
										}
										codeId+=2;
									}else{
										newCodeArr.push(code);
									}
								}else{
									newCodeArr.push(code);
								}
							break;
							case AVM2Ops.lookupswitch:
								codeId++;
								if(code.value<0||code.value>=code2.value.case_offsetV.length){
									newCodeArr.push(
										new Code(AVM2Ops.jump,code2.value.default_offset)
									);
								}else{
									newCodeArr.push(
										new Code(AVM2Ops.jump,code2.value.case_offsetV[code.value])
									);
								}
							break;
							default:
								newCodeArr.push(code);
							break;
						}
					}else{
						newCodeArr.push(code);
					}
				}else{
					newCodeArr.push(code);
				}
			}
			return newCodeArr;
		}
		
		private static function normalizeJumps(codeArr:Array):Array{
			//尝试处理打乱的 jump
			
			for each(code in codeArr){
				if(code.constructor==Code&&code.op==AVM2Ops.newcatch){
					return codeArr;//- -
				}
			}
			
			var codeId:int=-1;
			for each(var code:* in codeArr){
				codeId++;
				if(code.constructor==LabelMark){
					code.pos=codeId;
				}
			}
			
			codeId=0;
			var totalCode:int=codeArr.length;
			var newCodeArr:Array=new Array();
			var isSimpleJumps:Boolean=true;
			var mark:Array=new Array();
			loop:while(codeId<totalCode){
				if(mark[codeId]){
					isSimpleJumps=false;
					break;
				}
				mark[codeId]=true;
				code=codeArr[codeId];
				switch(code.constructor){
					case LabelMark:
						newCodeArr.push(code);
						codeId++;
					break;
					case Array:
					case ByteArray:
						codeId++;
						//throw new Error("暂不支持");
					break;
					case Code:
						switch(AVM2Ops.opTypeV[code.op]){
							case "branch":
								if(code.op==AVM2Ops.jump){
									codeId=code.value.pos;
								}else{
									isSimpleJumps=false;
									break loop;
								}
							break;
							case "lookupswitch":
								isSimpleJumps=false;
								break loop;
							break;
							case "newcatch":
								isSimpleJumps=false;
								break loop;
							break;
							default:
								newCodeArr.push(code);
								codeId++;
							break;
						}
					break;
					default://int
						newCodeArr.push(code);
						switch(code){
							case AVM2Ops.returnvoid:
							case AVM2Ops.returnvalue:
							case AVM2Ops.throw_:
								break loop;
							break;
							default:
								codeId++;
							break;
						}
					break;
				}
			}
			if(isSimpleJumps){
				return newCodeArr;
			}
			return codeArr;
		}
	}
}