/***
ACTIONRECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 14:22:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm1{
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	import zero.Outputer;
	import zero.ZeroCommon;
	import zero.swf.BytesData;
	
	public class ACTIONRECORD extends BytesData{
		private static var numData:ByteArray=new ByteArray();
		
		public static var outputHex:Boolean=false;//只用于 toXML 20110528
		private var hexArr:Array;//只用于 toXML 20110528
		
		public static var decodeLevel:int=1;//只用于 initByData
		
		public var codeArr:Array;
		public function ACTIONRECORD(){
		}
		
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(decodeLevel==0){
				return super.initByData(data,offset,endOffset);
			}
			
			//import flash.utils.getTimer;
			//var t:int=getTimer();
			
			var labelId:int=0;
			var labelMarkArr:Array=new Array();
			var codeByOffsetArr:Array=new Array();
			if(outputHex){
				var hexByOffsetArr:Array=new Array();
			}
			var code:*;
			
			var labelMark:AVM1LabelMark;
			var jumpOffset:int,jumpPos:int,i:int;
			
			var get_str_size:int;
			
			var constCode:AVM1Code;
			
			var flags:int;
			var NumParams:int;
			
			var startOffset:int=offset;
			
			while(offset<endOffset){
				//trace("offset="+offset);
				var pos:int=offset;
				var op:int=data[offset++];
				
				if(op<0x80){
					if(AVM1Op.opNameV[op]){
						codeByOffsetArr[pos]=op;
					}else{
						code=new ByteArray();
						code[0]=op;
						codeByOffsetArr[pos]=code;
						Outputer.output("对未知代码使用 ByteArray 进行记录："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
						Outputer.outputError("未知 op: "+op);
					}
				}else{
					var Length:int=data[offset++]|(data[offset++]<<8);
					
					switch(op){
						case AVM1Op.gotoFrame:
							code=new AVM1Code(op,data[offset++]|(data[offset++]<<8));
						break;
						case AVM1Op.getURL:
							
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code=new AVM1Code(op,{UrlString:data.readUTFBytes(get_str_size)});
							offset+=get_str_size;
							
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code.value.TargetString=data.readUTFBytes(get_str_size);
							offset+=get_str_size;
							
						break;
						case AVM1Op.setRegister:
							code=new AVM1Code(op,data[offset++]);
						break;
						case AVM1Op.constants:
							constCode=code=new AVM1Code(op,[]);
							var Count:int=data[offset++]|(data[offset++]<<8);
							var realCount:int=0;
							i=0;
							while(offset<endOffset){
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code.value.push(data.readUTFBytes(get_str_size));
								offset+=get_str_size;
								realCount++;
								if(++i>=Count){
									break;
								}
							}
							if(Count==realCount){
							}else{
								Outputer.output("Count!=realCount Count="+Count+", realCount="+realCount,"brown");
							}
						break;
						case AVM1Op.ifFrameLoaded:
							//Frame 				UI16 				Frame to wait for
							//SkipCount 			UI8 				Number of actions to skip if frame is not loaded
							code=new AVM1Code(op,{
								Frame:data[offset++]|(data[offset++]<<8),
								SkipCount:data[offset++]
							});
							Outputer.output("ifFrameLoaded 应该用 labelMark","brown");
						break;
						case AVM1Op.setTarget:
							//TargetName 		STRING 					Target of action target
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code=new AVM1Code(op,data.readUTFBytes(get_str_size));
							offset+=get_str_size;
						break;
						case AVM1Op.gotoLabel:
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code=new AVM1Code(op,data.readUTFBytes(get_str_size));
							offset+=get_str_size;
						break;
						case AVM1Op.ifFrameLoadedExpr:
							//SkipCount 			UI8 				The number of actions to skip
							code=new AVM1Code(op,data[offset++]);
							Outputer.output("ifFrameLoadedExpr 应该用 labelMark","brown");
						break;
						case AVM1Op.function2:
							//FunctionName 				STRING 						Name of function, empty if anonymous(匿名)
							//NumParams 				UI16 						# of parameters
							//RegisterCount 			UI8 						Number of registers to allocate, up to 255 registers(from 0 to 254)
							//PreloadParentFlag 		UB[1] 						0 = Don’t preload _parent into register
							//														1 = Preload _parent into register
							//PreloadRootFlag 			UB[1] 						0 = Don’t preload _root into register
							//														1 = Preload _root into register
							//SuppressSuperFlag 		UB[1] 						0 = Create super variable
							//														1 = Don’t create super variable
							//PreloadSuperFlag 			UB[1] 						0 = Don’t preload super into register
							//														1 = Preload super into register
							//SuppressArgumentsFlag 	UB[1] 						0 = Create arguments variable
							//														1 = Don’t create arguments variable
							//PreloadArgumentsFlag 		UB[1] 						0 = Don’t preload arguments into register
							//														1 = Preload arguments into register
							//SuppressThisFlag 			UB[1] 						0 = Create this variable
							//														1 = Don’t create this variable
							//PreloadThisFlag 			UB[1] 						0 = Don’t preload this into register
							//														1 = Preload this into register
							//Reserved 					UB[7] 						Always 0
							//PreloadGlobalFlag 		UB[1] 						0 = Don’t preload _global into register
							//														1 = Preload _global into register
							//Parameters 				REGISTERPARAM[NumParams] 	See REGISTERPARAM, following
							//codeSize 					UI16 						# of bytes of code that follow
							
							//REGISTERPARAM is defined as follows:
							//Field 		Type 	Comment
							//Register 		UI8 	For each parameter to the function,
							//						a register can be specified.
							//						If the register specified is zero, the
							//						parameter is created as a variable
							//						named ParamName in the activation
							//						object, which can be referenced with
							//						_getVariable and
							//						_setVariable.
							//						If the register specified is nonzero,
							//						the parameter is copied into the
							//						register, and it can be referenced
							//						with _push and
							//						_setRegister, and no
							//						variable is created in the activation
							//						object.
							//ParamName 	STRING 	Parameter name
							
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code=new AVM1Code(op,{
								FunctionName:data.readUTFBytes(get_str_size),
								Parameters:[]
							});
							offset+=get_str_size;
							
							NumParams=data[offset++]|(data[offset++]<<8);
							
							code.value.RegisterCount=data[offset++];
							
							flags=data[offset++];
							code.value.PreloadParentFlag=(flags<<24)>>>31;					//10000000
							code.value.PreloadRootFlag=(flags<<25)>>>31;					//01000000
							code.value.SuppressSuperFlag=(flags<<26)>>>31;					//00100000
							code.value.PreloadSuperFlag=(flags<<27)>>>31;					//00010000
							code.value.SuppressArgumentsFlag=(flags<<28)>>>31;				//00001000
							code.value.PreloadArgumentsFlag=(flags<<29)>>>31;				//00000100
							code.value.SuppressThisFlag=(flags<<30)>>>31;					//00000010
							code.value.PreloadThisFlag=flags&0x01;							//00000001
							
							code.value.PreloadGlobalFlag=data[offset++]&0x01;				//00000001
							
							for(i=0;i<NumParams;i++){
								code.value.Parameters[i]={Register:data[offset++]};
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code.value.Parameters[i].ParamName=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							}
							
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+codeSize
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							labelMark=labelMarkArr[jumpPos];
							if(labelMark){
							}else{
								labelMarkArr[jumpPos]=labelMark=new AVM1LabelMark();
								labelMark.labelId=labelId++;
							}
							code.value.endMark=labelMark;
						break;
						case AVM1Op.try_:
							//Reserved 				UB[5] 								Always zero
							//CatchInRegisterFlag 	UB[1] 								0 - Do not put caught object into register (instead, store in named variable)
							//															1 - Put caught object into register (do not store in named variable)
							//FinallyBlockFlag 		UB[1] 								0 - No finally block
							//															1 - Has finally block
							//CatchBlockFlag 		UB[1] 								0 - No catch block
							//															1 - Has catch block
							//TrySize 				UI16 								Length of the try block
							//CatchSize 			UI16 								Length of the catch block
							//FinallySize 			UI16 								Length of the finally block
							//CatchName 			If CatchInRegisterFlag = 0, STRING 	Name of the catch variable
							//CatchRegister 		If CatchInRegisterFlag = 1, UI8 	Register to catch into
							//TryBody 				UI8[TrySize] 						Body of the try block
							//CatchBody 			UI8[CatchSize] 						Body of the catch block, if any
							//FinallyBody 			UI8[FinallySize] 					Body of the finally block, if any
							
							//NOTE
							//The CatchSize and FinallySize fields always exist, whether or not the CatchBlockFlag or
							//FinallyBlockFlag settings are 1.
							
							//NOTE
							//The try, catch, and finally blocks do not use end tags to mark the end of their respective
							//blocks. Instead, the length of a block is set by the TrySize, CatchSize, and FinallySize
							//values.
							
							code=new AVM1Code(op,{});
							flags=data[offset++];
							//code.value.Reserved=(flags<<24)>>>27;					//11111000
							
							var TrySize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							var CatchSize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							var FinallySize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							
							if(flags&0x04){//CatchInRegisterFlag					//00000100
								code.value.CatchRegister=data[offset++];
							}else{
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code.value.CatchName=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
								
								//trace("code.value.CatchName="+code.value.CatchName);
							}
							
							jumpPos=offset+TrySize;
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							labelMark=labelMarkArr[jumpPos];
							if(labelMark){
							}else{
								labelMarkArr[jumpPos]=labelMark=new AVM1LabelMark();
								labelMark.labelId=labelId++;
							}
							code.value.TryBody=labelMark;
							
							if(flags&0x01){//CatchBlockFlag							//00000001
								jumpPos=offset+TrySize+CatchSize;
								if(jumpPos<0||jumpPos>endOffset){
									jumpPos=endOffset;
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
								}
								labelMark=labelMarkArr[jumpPos];
								if(labelMark){
								}else{
									labelMarkArr[jumpPos]=labelMark=new AVM1LabelMark();
									labelMark.labelId=labelId++;
								}
								code.value.CatchBody=labelMark;
							}
							
							if(flags&0x02){//FinallyBlockFlag						//00000010
								jumpPos=offset+TrySize+CatchSize+FinallySize;
								if(jumpPos<0||jumpPos>endOffset){
									jumpPos=endOffset;
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
								}
								labelMark=labelMarkArr[jumpPos];
								if(labelMark){
								}else{
									labelMarkArr[jumpPos]=labelMark=new AVM1LabelMark();
									labelMark.labelId=labelId++;
								}
								code.value.FinallyBody=labelMark;
							}
							
						break;
						case AVM1Op.with_:
							//Size 			UI16 				# of bytes of code that follow
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+Size
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							labelMark=labelMarkArr[jumpPos];
							if(labelMark){
							}else{
								labelMarkArr[jumpPos]=labelMark=new AVM1LabelMark();
								labelMark.labelId=labelId++;
							}
							code=new AVM1Code(op,labelMark);
						break;
						case AVM1Op.push:
							//Type 				UI8 					0 = string literal
							//											1 = floating-point literal
							//											5 and later:
							//											2 = null
							//											3 = undefined
							//											4 = register
							//											5 = Boolean
							//											6 = double
							//											7 = integer
							//											8 = constant 8
							//											9 = constant 16
							//String 			If Type = 0, STRING 	Null-terminated character string
							//Float 			If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
							//RegisterNumber 	If Type = 4, UI8 		Register number
							//Boolean 			If Type = 5, UI8 		Boolean value
							//Double 			If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
							//Integer 			If Type = 7, UI32 		32-bit little-endian integer
							//Constant8 		If Type = 8, UI8 		Constant pool index (for indexes < 256) (see _constants)
							//Constant16 		If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see _constants)
							code=new AVM1Code(op,[]);
							while(offset<pos+3+Length){
								switch(data[offset++]){
									case 0:
										get_str_size=0;
										while(data[offset+(get_str_size++)]){}
										data.position=offset;
										code.value.push(data.readUTFBytes(get_str_size));
										offset+=get_str_size;
									break;
									case 1:
										//好像没见过。。。
										numData[3]=data[offset++];
										numData[2]=data[offset++];
										numData[1]=data[offset++];
										numData[0]=data[offset++];
										numData.position=0;
										code.value.push(numData.readFloat());
										
										//data.endian=Endian.LITTLE_ENDIAN;
										//data.position=offset;
										//code.value.push(data.readFloat());
										//offset+=4;
									break;
									case 2:
										code.value.push(null);
									break;
									case 3:
										code.value.push(undefined);
									break;
									case 4:
										code.value.push(new AVM1Register(data[offset++]));
									break;
									case 5:
										code.value.push(data[offset++]?true:false);
									break;
									case 6:
										numData[3]=data[offset++];
										numData[2]=data[offset++];
										numData[1]=data[offset++];
										numData[0]=data[offset++];
										numData[7]=data[offset++];
										numData[6]=data[offset++];
										numData[5]=data[offset++];
										numData[4]=data[offset++];
										numData.position=0;
										code.value.push(numData.readDouble());
										
										//data.endian=Endian.LITTLE_ENDIAN;
										//data.position=offset;
										//code.value.push(data.readDouble());
										//offset+=8;
									break;
									case 7:
										code.value.push(data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24));
									break;
									case 8:
										code.value.push(constCode.value[data[offset++]]);
									break;
									case 9:
										code.value.push(constCode.value[data[offset++]|(data[offset++]<<8)]);
									break;
									default:
										throw new Error("未知 pushType");
									break;
								}
							}
						break;
						case AVM1Op.getURL2:
							//文档有错：
							//SendVarsMethod 		UB[2] 					0 = None
							//												1 = GET
							//												2 = POST
							//Reserved 				UB[4] 					Always 0
							//LoadTargetFlag 		UB[1] 					0 = Target is a browser window
							//												1 = Target is a path to a sprite
							//LoadVariablesFlag 	UB[1] 					0 = No variables to load
							//												1 = Load variables
							//正确的应该是：
							//LoadVariablesFlag 	UB[1] 					0 = No variables to load
							//												1 = Load variables
							//LoadTargetFlag 		UB[1] 					0 = Target is a browser window
							//												1 = Target is a path to a sprite
							//Reserved 				UB[4] 					Always 0
							//SendVarsMethod 		UB[2] 					0 = None
							//												1 = GET
							//												2 = POST
							
							//9a 01 00 00	getURL(url,target);
							//9a 01 00 01	getURL(url,target,"get");
							//9a 01 00 02	getURL(url,target,"post");
							//9a 01 00 03	getURL(url,target);
							
							//9a 01 00 40	loadMovie(url,mc);
							//9a 01 00 41	loadMovie(url,mc,"get");
							//9a 01 00 42	loadMovie(url,mc,"post");
							//9a 01 00 43	loadMovie(url,mc);
							
							//9a 01 00 80	loadVariablesNum(url,num);
							//9a 01 00 81	loadVariablesNum(url,num,"get");
							//9a 01 00 82	loadVariablesNum(url,num,"post");
							//9a 01 00 83	loadVariablesNum(url,num);
							
							//9a 01 00 c0	loadVariables(url,mc);
							//9a 01 00 c1	loadVariables(url,mc,"get");
							//9a 01 00 c2	loadVariables(url,mc,"post");
							//9a 01 00 c3	loadVariables(url,mc);
							
							
							code=new AVM1Code(op,{});
							flags=data[offset++];
							code.value.LoadVariablesFlag=(flags<<24)>>>31;			//10000000
							code.value.LoadTargetFlag=(flags<<25)>>>31;				//01000000
							//code.value.Reserved=(flags<<26)>>>28;					//00111100
							code.value.SendVarsMethod=(flags<<30)>>>30;				//00000011
						break;
						case AVM1Op.function_:
							//FunctionName 			STRING 				Function name, empty if anonymous
							//NumParams 			UI16 				# of parameters
							//param 1 				STRING 				Parameter name 1
							//param 2 				STRING 				Parameter name 2
							//...
							//param N 				STRING 				Parameter name N
							//codeSize 				UI16 				# of bytes of code that follow
							
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code=new AVM1Code(op,{
								FunctionName:data.readUTFBytes(get_str_size),
								paramArr:[]
							});
							offset+=get_str_size;
							
							NumParams=data[offset++]|(data[offset++]<<8);
							for(i=0;i<NumParams;i++){
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code.value.paramArr[i]=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							}
							
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+codeSize
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							labelMark=labelMarkArr[jumpPos];
							if(labelMark){
							}else{
								labelMarkArr[jumpPos]=labelMark=new AVM1LabelMark();
								labelMark.labelId=labelId++;
							}
							code.value.endMark=labelMark;
						break;
						case AVM1Op.branch:
						case AVM1Op.branchIfTrue:
							
							jumpOffset=data[offset++]|(data[offset++]<<8);
							if(jumpOffset&0x00008000){jumpOffset|=0xffff0000}//最高位为1,表示负数
							
							jumpPos=offset+jumpOffset;
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							labelMark=labelMarkArr[jumpPos];
							if(labelMark){
							}else{
								labelMarkArr[jumpPos]=labelMark=new AVM1LabelMark();
								labelMark.labelId=labelId++;
							}
							code=new AVM1Code(op,labelMark);
						break;
						case AVM1Op.callFrame:
							code=new AVM1Code(op);
						break;
						case AVM1Op.gotoFrame2:
							//Reserved 			UB[6] 						Always 0
							//SceneBiasFlag 	UB[1] 						Scene bias flag
							//Play flag 		UB[1] 						0 = Go to frame and stop
							//												1 = Go to frame and play
							//SceneBias 		If SceneBiasFlag = 1, UI16 	Number to be added to frame determined by stack argument
							
							code=new AVM1Code(op,{});
							flags=data[offset++];
							//code.value.Reserved=(flags<<24)>>>26;				//11111100
							if(flags&0x02){//SceneBiasFlag						//00000010
								code.value.SceneBias=data[offset++]|(data[offset++]<<8);
							}
							code.value.Play=flags&0x01;							//00000001
						break;
						default:
							code=new ByteArray();
							code.writeBytes(data,pos,3+Length);
							codeByOffsetArr[pos]=code;
							Outputer.output("对未知代码使用 ByteArray 进行记录："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
							Outputer.outputError("未知 op: "+op);
						break;
					}
					
					codeByOffsetArr[pos]=code;
					
					if(offset==pos+3+Length){
					}else{
						trace("offset 不正确, offset="+offset);
						offset=pos+3+Length;
						trace("已修正为: "+offset);
					}
				}
				if(outputHex){
					hexByOffsetArr[pos]=BytesAndStr16.bytes2str16(data,pos,offset-pos);
				}
			}
			
			//trace("offset="+offset+",endOffset="+endOffset);
			if(offset===endOffset){
			}else{
				trace("offset="+offset+",endOffset="+endOffset);
			}
			
			if(outputHex){
				hexArr=new Array();
			}
			codeArr=new Array();
			var codeId:int=-1;
			//endOffset++;
			
			for(offset=startOffset;offset<=endOffset;offset++){
				if(labelMarkArr[offset]){
					codeId++;
					codeArr[codeId]=labelMarkArr[offset];
				}
				if(codeByOffsetArr[offset]==undefined){//主要是因为 avm1 code 还带 op==AVM1OP.end 的...
				}else{
					codeId++;
					if(outputHex){
						hexArr[codeId]=hexByOffsetArr[offset];
					}
					codeArr[codeId]=codeByOffsetArr[offset];
				}
			}
			
			//trace("ACTIONRECORD.initByData 耗时 "+(getTimer()-t)+" 毫秒");
			
			return endOffset;
		}
		override public function toData():ByteArray{
			if(codeArr){
			}else{
				return super.toData();
			}
			var data:ByteArray=new ByteArray();
			//data.endian=Endian.LITTLE_ENDIAN;
			
			var posMarkArr:Array=new Array();//记录 branch, branchIfTrue, function_, function2 的位置及相关的 label 位置
			
			var offset:int=0,pos:int,Length:int;
			
			var jumpOffset:int,i:int;
			
			var labelMark:AVM1LabelMark;
			
			var subValue:*;
			
			var code:*;
			
			//统计需要放 const 里的字符串
			var constStrMark:Object=new Object();
			var constStrV:Vector.<String>=new Vector.<String>();
			var constCode:AVM1Code=null;
			loop:for each(code in codeArr){
				if(code is AVM1Code){
					switch(code.op){
						case AVM1Op.constants:
							constCode=code;
							break loop;
						break;
						case AVM1Op.push:
							for each(subValue in code.value){
								if(subValue){//subValue==""的不需要
									if(subValue is String){
										if(constStrMark["~"+subValue]>0){
											constStrMark["~"+subValue]++;
										}else{
											constStrMark["~"+subValue]=1;
											constStrV.push(subValue);
										}
									}
								}
							}
						break;
					}
				}
			}
			if(constCode){
				//如果本来就已经有 constCode 了
			}else{
				constCode=new AVM1Code(AVM1Op.constants,[]);
				for each(subValue in constStrV){
					if(constStrMark["~"+subValue]>1){
						constCode.value.push(subValue);
					}
				}
				constStrV=null;
			}
			if(constCode.value.length){
				constStrMark=new Array();
				i=constCode.value.length;
				while(--i>=0){
					constStrMark["~"+constCode.value[i]]=i;
				}
				
				pos=offset;
				
				data[offset++]=AVM1Op.constants;
				
				//Length
				data[offset++]=0x00;
				data[offset++]=0x00;
				
				var Count:int=constCode.value.length;
				data[offset++]=Count;
				data[offset++]=Count>>8;
				data.position=offset;
				for each(subValue in constCode.value){
					data.writeUTFBytes(subValue+"\x00");
				}
				offset=data.length;
				
				Length=offset-pos-3;
				data[pos+1]=Length;
				data[pos+2]=Length>>8;
			}else{
				constCode=null;
				constStrMark=null;
			}
			//
			
			for each(code in codeArr){
				//trace("code="+code);
				if(code is AVM1LabelMark){
					(code as AVM1LabelMark).pos=offset;
				}else if(code is ByteArray){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
					data.position=offset;
					data.writeBytes(code,0,code.length);
					offset=data.length;
				}else{
					if(code is int){
						data[offset++]=code;
					}else if(code is AVM1Code){
						if(code.op<0x80){
							throw new Error("请直接用 int");
						}else if(code.op==AVM1Op.constants){
							if(constCode){
								if(constCode==code){
								}else{
									throw new Error("constCode!=code");
								}
							}else{
								throw new Error("constCode="+constCode);
							}
						}else{
							pos=offset;
							
							data[offset++]=code.op;
							
							//Length
							data[offset++]=0x00;
							data[offset++]=0x00;
							
							switch(code.op){
								case AVM1Op.gotoFrame:
									data[offset++]=code.value;
									data[offset++]=code.value>>8;
								break;
								case AVM1Op.getURL:
									data.position=offset;
									data.writeUTFBytes(code.value.UrlString+"\x00");
									data.writeUTFBytes(code.value.TargetString+"\x00");
									offset=data.length;
								break;
								case AVM1Op.setRegister:
									data[offset++]=code.value;
								break;
								//case AVM1Op.constants:
								//
								//break;
								case AVM1Op.ifFrameLoaded:
									//Frame 				UI16 				Frame to wait for
									//SkipCount 			UI8 				Number of actions to skip if frame is not loaded
									data[offset++]=code.value.Frame;
									data[offset++]=code.value.Frame>>8;
									data[offset++]=code.value.SkipCount;
									Outputer.output("ifFrameLoaded 应该用 labelMark","brown");
								break;
								case AVM1Op.setTarget:
									data.position=offset;
									data.writeUTFBytes(code.value+"\x00");
									offset=data.length;
								break;
								case AVM1Op.gotoLabel:
									data.position=offset;
									data.writeUTFBytes(code.value+"\x00");
									offset=data.length;
								break;
								case AVM1Op.ifFrameLoadedExpr:
									//SkipCount 			UI8 				The number of actions to skip
									data[offset++]=code.value;
									Outputer.output("ifFrameLoadedExpr 应该用 labelMark","brown");
								break;
								case AVM1Op.function2:
									//FunctionName 				STRING 						Name of function, empty if anonymous(匿名)
									//NumParams 				UI16 						# of parameters
									//RegisterCount 			UI8 						Number of registers to allocate, up to 255 registers(from 0 to 254)
									//PreloadParentFlag 		UB[1] 						0 = Don’t preload _parent into register
									//														1 = Preload _parent into register
									//PreloadRootFlag 			UB[1] 						0 = Don’t preload _root into register
									//														1 = Preload _root into register
									//SuppressSuperFlag 		UB[1] 						0 = Create super variable
									//														1 = Don’t create super variable
									//PreloadSuperFlag 			UB[1] 						0 = Don’t preload super into register
									//														1 = Preload super into register
									//SuppressArgumentsFlag 	UB[1] 						0 = Create arguments variable
									//														1 = Don’t create arguments variable
									//PreloadArgumentsFlag 		UB[1] 						0 = Don’t preload arguments into register
									//														1 = Preload arguments into register
									//SuppressThisFlag 			UB[1] 						0 = Create this variable
									//														1 = Don’t create this variable
									//PreloadThisFlag 			UB[1] 						0 = Don’t preload this into register
									//														1 = Preload this into register
									//Reserved 					UB[7] 						Always 0
									//PreloadGlobalFlag 		UB[1] 						0 = Don’t preload _global into register
									//														1 = Preload _global into register
									//Parameters 				REGISTERPARAM[NumParams] 	See REGISTERPARAM, following
									//codeSize 					UI16 						# of bytes of code that follow
									
									//REGISTERPARAM is defined as follows:
									//Field 		Type 	Comment
									//Register 		UI8 	For each parameter to the function,
									//						a register can be specified.
									//						If the register specified is zero, the
									//						parameter is created as a variable
									//						named ParamName in the activation
									//						object, which can be referenced with
									//						_getVariable and
									//						_setVariable.
									//						If the register specified is nonzero,
									//						the parameter is copied into the
									//						register, and it can be referenced
									//						with _push and
									//						_setRegister, and no
									//						variable is created in the activation
									//						object.
									//ParamName 	STRING 	Parameter name
									
									data.position=offset;
									data.writeUTFBytes(code.value.FunctionName+"\x00");
									offset=data.length;
									
									data[offset++]=code.value.Parameters.length;
									data[offset++]=code.value.Parameters.length>>8;
									
									data[offset++]=code.value.RegisterCount;
									
									data[offset++]=
										(code.value.PreloadParentFlag<<7)
										|
										(code.value.PreloadRootFlag<<6)
										|
										(code.value.SuppressSuperFlag<<5)
										|
										(code.value.PreloadSuperFlag<<4)
										|
										(code.value.SuppressArgumentsFlag<<3)
										|
										(code.value.PreloadArgumentsFlag<<2)
										|
										(code.value.SuppressThisFlag<<1)
										|
										code.value.PreloadThisFlag;
										
									data[offset++]=code.value.PreloadGlobalFlag;
									
									for each(var Parameter:Object in code.value.Parameters){
										data[offset++]=Parameter.Register;
										data.position=offset;
										data.writeUTFBytes(Parameter.ParamName+"\x00");
										offset=data.length;
									}
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									posMarkArr[offset]=code.value.endMark;
								break;
								case AVM1Op.try_:
									//Reserved 				UB[5] 								Always zero
									//CatchInRegisterFlag 	UB[1] 								0 - Do not put caught object into register (instead, store in named variable)
									//															1 - Put caught object into register (do not store in named variable)
									//FinallyBlockFlag 		UB[1] 								0 - No finally block
									//															1 - Has finally block
									//CatchBlockFlag 		UB[1] 								0 - No catch block
									//															1 - Has catch block
									//TrySize 				UI16 								Length of the try block
									//CatchSize 			UI16 								Length of the catch block
									//FinallySize 			UI16 								Length of the finally block
									//CatchName 			If CatchInRegisterFlag = 0, STRING 	Name of the catch variable
									//CatchRegister 		If CatchInRegisterFlag = 1, UI8 	Register to catch into
									//TryBody 				UI8[TrySize] 						Body of the try block
									//CatchBody 			UI8[CatchSize] 						Body of the catch block, if any
									//FinallyBody 			UI8[FinallySize] 					Body of the finally block, if any
									
									//NOTE
									//The CatchSize and FinallySize fields always exist, whether or not the CatchBlockFlag or
									//FinallyBlockFlag settings are 1.
									
									//NOTE
									//The try, catch, and finally blocks do not use end tags to mark the end of their respective
									//blocks. Instead, the length of a block is set by the TrySize, CatchSize, and FinallySize
									//values.
									
									var flags:int=0;
									if(code.value.CatchRegister>-1){
										flags|=0x04;
									}
									if(code.value.CatchBody){
										flags|=0x01;
									}
									if(code.value.FinallyBody){
										flags|=0x02;
									}
									data[offset++]=flags;
									
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									
									code.value.SizePos=offset;//- -
									
									if(code.value.CatchRegister>-1){
										data[offset++]=code.value.CatchRegister;
									}else{
										data.position=offset;
										data.writeUTFBytes(code.value.CatchName+"\x00");
										offset=data.length;
									}
									
									posMarkArr[offset]=code;
								break;
								case AVM1Op.with_:
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									posMarkArr[offset]=code.value;
								break;
								case AVM1Op.push:
									//Type 				UI8 					0 = string literal
									//											1 = floating-point literal
									//											5 and later:
									//											2 = null
									//											3 = undefined
									//											4 = register
									//											5 = Boolean
									//											6 = double
									//											7 = integer
									//											8 = constant 8
									//											9 = constant 16
									//String 			If Type = 0, STRING 	Null-terminated character string
									//Float 			If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
									//RegisterNumber 	If Type = 4, UI8 		Register number
									//Boolean 			If Type = 5, UI8 		Boolean value
									//Double 			If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
									//Integer 			If Type = 7, UI32 		32-bit little-endian integer
									//Constant8 		If Type = 8, UI8 		Constant pool index (for indexes < 256) (see _constants)
									//Constant16 		If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see _constants)
									for each(subValue in code.value){
										switch(subValue){
											case null:
												data[offset++]=0x02;
											break;
											case undefined:
												data[offset++]=0x03;
											break;
											case true:
												data[offset++]=0x05;
												data[offset++]=0x01;
											break;
											case false:
												data[offset++]=0x05;
												data[offset++]=0x00;
											break;
											default:
												if(subValue is String){
													if(constCode&&constStrMark["~"+subValue]>-1){
														if(constStrMark["~"+subValue]>0xff){
															data[offset++]=0x09;
															data[offset++]=constStrMark["~"+subValue];
															data[offset++]=constStrMark["~"+subValue]>>8;
														}else{
															data[offset++]=0x08;
															data[offset++]=constStrMark["~"+subValue];
														}
													}else{
														data[offset++]=0x00;
														data.position=offset;
														data.writeUTFBytes(subValue+"\x00");
														offset=data.length;
													}
												}else if(subValue is int){
													data[offset++]=0x07;
													data[offset++]=subValue;
													data[offset++]=subValue>>8;
													data[offset++]=subValue>>16;
													data[offset++]=subValue>>24;
												}else if(subValue is AVM1Register){
													data[offset++]=0x04;
													data[offset++]=subValue.registerId;
												}else if(isNaN(subValue)){
													throw new Error("未知 subValue: "+subValue);
												}else{
													data[offset++]=0x06;
													numData.position=0;
													numData.writeDouble(subValue);
													data[offset++]=numData[3];
													data[offset++]=numData[2];
													data[offset++]=numData[1];
													data[offset++]=numData[0];
													data[offset++]=numData[7];
													data[offset++]=numData[6];
													data[offset++]=numData[5];
													data[offset++]=numData[4];
												}
											break;
										}
									}
								break;
								case AVM1Op.getURL2:
									//文档有错：
									//SendVarsMethod 		UB[2] 					0 = None
									//												1 = GET
									//												2 = POST
									//Reserved 				UB[4] 					Always 0
									//LoadTargetFlag 		UB[1] 					0 = Target is a browser window
									//												1 = Target is a path to a sprite
									//LoadVariablesFlag 	UB[1] 					0 = No variables to load
									//												1 = Load variables
									//正确的应该是：
									//LoadVariablesFlag 	UB[1] 					0 = No variables to load
									//												1 = Load variables
									//LoadTargetFlag 		UB[1] 					0 = Target is a browser window
									//												1 = Target is a path to a sprite
									//Reserved 				UB[4] 					Always 0
									//SendVarsMethod 		UB[2] 					0 = None
									//												1 = GET
									//
									
									
									data[offset++]=
										(code.value.LoadVariablesFlag<<7)					//10000000
										|
										(code.value.LoadTargetFlag<<6)						//01000000
										|
										code.value.SendVarsMethod;							//00000011
								break;
								case AVM1Op.function_:
									//FunctionName 			STRING 				Function name, empty if anonymous
									//NumParams 			UI16 				# of parameters
									//param 1 				STRING 				Parameter name 1
									//param 2 				STRING 				Parameter name 2
									//...
									//param N 				STRING 				Parameter name N
									//codeSize 				UI16 				# of bytes of code that follow
									
									data.position=offset;
									data.writeUTFBytes(code.value.FunctionName+"\x00");
									offset=data.length;
									data[offset++]=code.value.paramArr.length;
									data[offset++]=code.value.paramArr.length>>8;
									data.position=offset;
									for each(var param:String in code.value.paramArr){
										data.writeUTFBytes(param+"\x00");
									}
									offset=data.length;
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									posMarkArr[offset]=code.value.endMark;
								break;
								case AVM1Op.branch:
								case AVM1Op.branchIfTrue:
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
									posMarkArr[offset]=code.value;
								break;
								case AVM1Op.callFrame:
									//
								break;
								case AVM1Op.gotoFrame2:
									//Reserved 			UB[6] 						Always 0
									//SceneBiasFlag 	UB[1] 						Scene bias flag
									//Play flag 		UB[1] 						0 = Go to frame and stop
									//												1 = Go to frame and play
									//SceneBias 		If SceneBiasFlag = 1, UI16 	Number to be added to frame determined by stack argument
									
									if(code.value.SceneBias>-1){
										data[offset++]=0x02|code.value.Play;	//00000011
										data[offset++]=code.value.SceneBias;
										data[offset++]=code.value.SceneBias>>8;
									}else{
										data[offset++]=code.value.Play;			//00000001
									}
								break;
								default:
									throw new Error("未知 op: "+code.op);
								break;
							}
							
							Length=offset-pos-3;
							data[pos+1]=Length;
							data[pos+2]=Length>>8;
						}
					}
				}
			}
			
			var endOffset:int=data.length;
			for(offset=0;offset<=endOffset;offset++){
				if(posMarkArr[offset]){
					if(posMarkArr[offset] is AVM1LabelMark){
						labelMark=posMarkArr[offset];
						jumpOffset=labelMark.pos-offset;
						data[offset-2]=jumpOffset;
						data[offset-1]=jumpOffset>>8;
					}else{
						code=posMarkArr[offset];
						if(code.op==AVM1Op.try_){
							var TrySize:int=code.value.TryBody.pos-offset;
							data[code.value.SizePos-6]=TrySize;
							data[code.value.SizePos-5]=TrySize>>8;
							if(code.value.CatchBody){
								var CatchSize:int=code.value.CatchBody.pos-offset-TrySize;
								data[code.value.SizePos-4]=CatchSize;
								data[code.value.SizePos-3]=CatchSize>>8;
							}
							if(code.value.FinallyBody){
								var FinallySize:int=code.value.FinallyBody.pos-offset-TrySize-CatchSize;
								data[code.value.SizePos-2]=FinallySize;
								data[code.value.SizePos-1]=FinallySize>>8;
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
		override public function toXML(xmlName:String):XML{
			if(codeArr){
			}else{
				return super.toXML(xmlName);
			}
			var labelMark:AVM1LabelMark;
			var subValue:*,subStr:String;
			if(codeArr.length){
				var codesStr:String="";
				if(outputHex){
					var codeId:int=-1;
				}
				for each(var code:* in codeArr){
					if(outputHex){
						codeId++;
						if(hexArr[codeId]){
							codesStr+="\t\t\t\t\t//"+hexArr[codeId]+"\n";
						}
					}
					if(code is AVM1LabelMark){
						codesStr+="\t\t\t\tlabel"+(code as AVM1LabelMark).labelId+":\n";
					}else if(code is ByteArray){
						Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
						codesStr+="\t\t\t\t\t"+BytesAndStr16.bytes2str16(code,0,code.length)+"\n";
					}else{
						if(code is int){
							codesStr+="\t\t\t\t\t"+AVM1Op.opNameV[code];
						}else if(code is AVM1Code){
							if(code.op==AVM1Op.constants){
								codesStr+="\t\t\t\t\t//"+AVM1Op.opNameV[code.op];//- -
								//codesStr+="\t\t\t\t\t"+AVM1Op.opNameV[code.op];trace("暂时不使用自动注解");
							}else{
								codesStr+="\t\t\t\t\t"+AVM1Op.opNameV[code.op];
							}
							if(code.op<0x80){
								throw new Error("请直接用 int");
							}else{
								switch(code.op){
									case AVM1Op.gotoFrame:
										codesStr+=" "+code.value;
									break;
									case AVM1Op.getURL:
										codesStr+=" \""+ZeroCommon.esc_xattr(code.value.UrlString)+"\",\""+ZeroCommon.esc_xattr(code.value.TargetString)+"\"";
									break;
									case AVM1Op.setRegister:
										codesStr+=" "+code.value;
									break;
									case AVM1Op.constants:
										subStr="";
										for each(subValue in code.value){
											subStr+=",\""+ZeroCommon.esc_xattr(subValue)+"\"";
										}
										codesStr+=" "+subStr.substr(1);
									break;
									case AVM1Op.ifFrameLoaded:
										codesStr+=" "+code.value.Frame+","+code.value.SkipCount;
										Outputer.output("ifFrameLoaded 应该用 labelMark","brown");
									break;
									case AVM1Op.setTarget:
										codesStr+=" \""+ZeroCommon.esc_xattr(code.value)+"\"";
									break;
									case AVM1Op.gotoLabel:
										codesStr+=" \""+ZeroCommon.esc_xattr(code.value)+"\"";
									break;
									case AVM1Op.ifFrameLoadedExpr:
										codesStr+=" "+code.value;
										Outputer.output("ifFrameLoadedExpr 应该用 labelMark","brown");
									break;
									case AVM1Op.function2:
										subStr="";
										for each(var Parameter:Object in code.value.Parameters){
											subStr+=",r:"+Parameter.Register+"=\""+ZeroCommon.esc_xattr(Parameter.ParamName)+"\"";
										}
										codesStr+=" "+code.value.FunctionName+"[RegisterCount "+code.value.RegisterCount+"]["+(
											(code.value.PreloadParentFlag?",PreloadParent":"")+
											(code.value.PreloadRootFlag?",PreloadRoot":"")+
											(code.value.SuppressSuperFlag?",SuppressSuper":"")+
											(code.value.PreloadSuperFlag?",PreloadSuper":"")+
											(code.value.SuppressArgumentsFlag?",SuppressArguments":"")+
											(code.value.PreloadArgumentsFlag?",PreloadArguments":"")+
											(code.value.SuppressThisFlag?",SuppressThis":"")+
											(code.value.PreloadThisFlag?",PreloadThis":"")+
											(code.value.PreloadGlobalFlag?",PreloadGlobal":"")
											).substr(1)+"]("+subStr.substr(1)+")[end with label"+code.value.endMark.labelId+"]";
										
									break;
									case AVM1Op.try_:
										if(code.value.CatchRegister>-1){
											codesStr+=" r:"+code.value.CatchRegister;
										}else{
											codesStr+=" "+code.value.CatchName;
										}
										codesStr+="[end try with label"+code.value.TryBody.labelId+"]";
										if(code.value.CatchBody){
											codesStr+="[end catch with label"+code.value.CatchBody.labelId+"]";
										}
										if(code.value.FinallyBody){
											codesStr+="[end finally with label"+code.value.FinallyBody.labelId+"]";
										}
									break;
									case AVM1Op.with_:
										codesStr+=" [end with label"+code.value.labelId+"]";
									break;
									case AVM1Op.push:
										subStr="";
										for each(subValue in code.value){
											if(subValue is String){
												subStr+=",\""+ZeroCommon.esc_xattr(subValue)+"\"";
											}else if(subValue is AVM1Register){
												subStr+=",r:"+subValue.registerId;
											}else{
												subStr+=","+subValue;
											}
										}
										codesStr+=" "+subStr.substr(1);
									break;
									case AVM1Op.getURL2:
										switch(code.value.LoadVariablesFlag){
											case 0:
												switch(code.value.LoadTargetFlag){
													case 0:
														codesStr+=" getURL"
													break;
													case 1:
														codesStr+=" loadMovie"
													break;
												}
											break;
											case 1:
												switch(code.value.LoadTargetFlag){
													case 0:
														codesStr+=" loadVariablesNum"
													break;
													case 1:
														codesStr+=" loadVariables"
													break;
												}
											break;
										}
										switch(code.value.SendVarsMethod){
											case 1:
												codesStr+=",\"get\"";
											break;
											case 2:
												codesStr+=",\"post\"";
											break;
											default://0 或 3
												//codesStr+=",\"\"";
											break;
										}
									break;
									case AVM1Op.function_:
										subStr="";
										for each(var param:String in code.value.paramArr){
											subStr+=","+ZeroCommon.esc_xattr(param);
										}
										codesStr+=" "+code.value.FunctionName+"("+subStr.substr(1)+")[end with label"+code.value.endMark.labelId+"]";
									break;
									case AVM1Op.branch:
									case AVM1Op.branchIfTrue:
										codesStr+=" label"+code.value.labelId;
									break;
									case AVM1Op.callFrame:
										//
									break;
									case AVM1Op.gotoFrame2:
										if(code.value.SceneBias>-1){
											codesStr+=" "+code.value.Play+","+code.value.SceneBias;
										}else{
											codesStr+=" "+code.value.Play;
										}
									break;
									default:
										throw new Error("未知 op: "+code.op);
									break;
								}
							}
						}else{
							throw new Error("未知 code: "+code);
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
		override public function initByXML(xml:XML):void{
			codeStr=xml.toString().replace(/^\s*|\s*$/g,"");
			if(codeStr){
			}else{
				super.initByXML(xml);
				return;
			}
			var codeStrArr:Array=codeStr.split("\n");
			var codeId:int=-1;
			codeArr=new Array();
			var code:AVM1Code;
			
			var codeStr:String;
			var i:int=codeStrArr.length;
			var labelMarkMark:Object=new Object();
			var labelMark:AVM1LabelMark;
			
			var subStr:*;
			
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
					labelMarkMark[codeStr]=labelMark=new AVM1LabelMark();
					labelMark.labelId=int(codeStr.replace(/label(\d+):/,"$1"));
				}
			}
			for each(codeStr in codeStrArr){
				
				//trace("codeStr="+codeStr);
				
				if(/^label(\d+):$/.test(codeStr)){
					codeArr[++codeId]=labelMarkMark[codeStr];
				}else if((codeStr+" ").search(/[0-9a-fA-F]{2}\s+/)==0){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+codeStr,"brown");
					codeArr[++codeId]=BytesAndStr16.str162bytes(codeStr);
				}else{
					var pos:int=codeStr.search(/\s+/);
					var opStr:String;
					if(pos==-1){
						opStr=codeStr;
					}else{
						opStr=codeStr.substr(0,pos);
					}
					if(AVM1Op.ops[opStr]>=0){
						var op:int=AVM1Op.ops[opStr];
						
						codeStr=codeStr.substr(pos).replace(/^\s*|\s*$/g,"");
						if(op<0x80){
							codeArr[++codeId]=op;
						}else{
							switch(op){
								case AVM1Op.gotoFrame:
									code=new AVM1Code(op,int(codeStr));
								break;
								case AVM1Op.getURL:
									execResult=/"(.*?)"\s*,\s*"(.*?)"/.exec(codeStr);
									code=new AVM1Code(op,{
										UrlString:ZeroCommon.unesc_xattr(execResult[1]),
										TargetString:ZeroCommon.unesc_xattr(execResult[2])
									});
								break;
								case AVM1Op.setRegister:
									code=new AVM1Code(op,int(codeStr));
								break;
								case AVM1Op.constants:
									code=new AVM1Code(op,[]);
									for each(subStr in codeStr.match(/".*?"/g)){
										code.value.push(ZeroCommon.unesc_xattr(subStr.substr(1,subStr.length-2)));
									}
								break;
								case AVM1Op.ifFrameLoaded:
									execResult=codeStr.split(/\s*,\s*/);
									code=new AVM1Code(op,{
										Frame:int(execResult[0]),
										SkipCount:int(execResult[1])
									});
									Outputer.output("ifFrameLoaded 应该用 labelMark","brown");
								break;
								case AVM1Op.setTarget:
									code=new AVM1Code(op,ZeroCommon.unesc_xattr(codeStr.substr(1,codeStr.length-2)));
								break;
								case AVM1Op.gotoLabel:
									code=new AVM1Code(op,ZeroCommon.unesc_xattr(codeStr.substr(1,codeStr.length-2)));
								break;
								case AVM1Op.ifFrameLoadedExpr:
									code=new AVM1Code(op,int(codeStr));
									Outputer.output("ifFrameLoadedExpr 应该用 labelMark","brown");
								break;
								case AVM1Op.function2:
									execResult=/(.*?)\s*\[\s*RegisterCount\s+(\d+)\s*\]\[\s*(.*?)\s*\]\(\s*(.*?)\s*\)\s*\[\s*end\s+with\s+(label\d+)\s*\]/.exec(codeStr);
									
									code=new AVM1Code(op,{
										FunctionName:ZeroCommon.unesc_xattr(execResult[1]),
										Parameters:[]
									});
									
									code.value.RegisterCount=int(execResult[2]);
									
									code.value.PreloadParentFlag=0;
									code.value.PreloadRootFlag=0;
									code.value.SuppressSuperFlag=0;
									code.value.PreloadSuperFlag=0;
									code.value.SuppressArgumentsFlag=0;
									code.value.PreloadArgumentsFlag=0;
									code.value.SuppressThisFlag=0;
									code.value.PreloadThisFlag=0;
									
									code.value.PreloadGlobalFlag=0;
									
									for each(var Flag:String in execResult[3].split(/\s*,\s*/)){
										code.value[Flag+"Flag"]=1;
									}
									
									code.value.endMark=labelMarkMark[execResult[5]+":"];
									if(code.value.endMark){
									}else{
										throw new Error("找不到对应的 endMark: "+codeStr);
									}
									
									if(execResult[4]){
										for each(var ParameterStr:String in execResult[4].match(/r\:\d+\s*=\s*".*?"/g)){
											execResult=/r\:(\d+)\s*=\s*"(.*?)"/.exec(ParameterStr);
											code.value.Parameters.push({
												Register:int(execResult[1]),
												ParamName:ZeroCommon.unesc_xattr(execResult[2])
											});
										}
									}
								break;
								case AVM1Op.try_:
									code=new AVM1Code(op,{});
									execResult=/(.*?)\s*\[/.exec(codeStr);
									//trace("execResult[1]="+execResult[1]);
									if(execResult[1].indexOf("r:")==0){
										code.value.CatchRegister=int(execResult[1].substr(2));
									}else{
										code.value.CatchName=execResult[1];
									}
									for each(subStr in codeStr.match(/\[.*?\]/g)){
										execResult=/\[\s*end\s+(.*?)\s+with\s+(label\d+)\s*\]/.exec(subStr);
										labelMark=labelMarkMark[execResult[2]+":"];
										if(labelMark){
										}else{
											throw new Error("找不到对应的 labelMark: "+subStr);
										}
										switch(execResult[1]){
											case "try":
												code.value.TryBody=labelMark;
											break;
											case "catch":
												code.value.CatchBody=labelMark;
											break;
											case "finally":
												code.value.FinallyBody=labelMark;
											break;
										}
									}
								break;
								case AVM1Op.with_:
									execResult=/\[\s*end\s+with\s+(label\d+)\s*\]/.exec(codeStr);
									labelMark=labelMarkMark[execResult[1]+":"];
									if(labelMark){
										code=new AVM1Code(op,labelMark);
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
								break;
								case AVM1Op.push:
									code=new AVM1Code(op,[]);
									while(codeStr){
										if(codeStr.charAt(0)=="\""){
											var nextQuotPos:int=codeStr.indexOf("\"",1);
											if(nextQuotPos>-1){
												code.value.push(ZeroCommon.unesc_xattr(codeStr.substr(1,nextQuotPos-1)));
											}else{
												throw new Error("找不到配对的双引号");
											}
											codeStr=codeStr.substr(nextQuotPos+1).replace(/^\s*,\s*/,"");
										}else{
											var nextCommaPos:int=codeStr.search(/\s*,\s*/);
											if(nextCommaPos>-1){
											}else{
												nextCommaPos=codeStr.length;
											}
											subStr=codeStr.substr(0,nextCommaPos);
											switch(subStr){
												case "null":
													code.value.push(null);
												break;
												case "undefined":
													code.value.push(undefined);
												break;
												case "true":
													code.value.push(true);
												break;
												case "false":
													code.value.push(false);
												break;
												default:
													if(isNaN(subStr)){
														if(subStr.indexOf("r:")==0){
															code.value.push(new AVM1Register(int(subStr.substr(2))));
														}else{
															throw new Error("未知 subStr: "+subStr);
														}
													}else{
														code.value.push(Number(subStr));
													}
												break;
											}
											codeStr=codeStr.substr(nextCommaPos+1).replace(/^\s*,\s*/,"");
										}
									}
									//trace("code.value="+code.value.join("\n--------\n"));
								break;
								case AVM1Op.getURL2:
									code=new AVM1Code(op,{});
									execResult=codeStr.split(/\s*,\s*/);
									switch(execResult[0]){
										case "getURL":
											code.value.LoadVariablesFlag=0;
											code.value.LoadTargetFlag=0;
										break;
										case "loadMovie":
											code.value.LoadVariablesFlag=0;
											code.value.LoadTargetFlag=1;
										break;
										case "loadVariablesNum":
											code.value.LoadVariablesFlag=1;
											code.value.LoadTargetFlag=0;
										break;
										case "loadVariables":
											code.value.LoadVariablesFlag=1;
											code.value.LoadTargetFlag=1;
										break;
										default:
											throw new Error("未处理");
										break;
									}
									switch(execResult[1]){
										case "\"get\"":
											code.value.SendVarsMethod=1;
										break;
										case "\"post\"":
											code.value.SendVarsMethod=2;
										break;
										default://0 或 3
											code.value.SendVarsMethod=0;
										break;
									}
								break;
								case AVM1Op.function_:
									execResult=/(.*?)\s*\(\s*(.*?)\s*\)\s*\[\s*end\s+with\s+(label\d+)\s*\]/.exec(codeStr);
									code=new AVM1Code(op,{
										FunctionName:ZeroCommon.unesc_xattr(execResult[1]),
										paramArr:[]
									});
									if(execResult[2]){
										for each(var param:String in execResult[2].split(/\s*,\s*/)){
											//trace("param="+param);
											code.value.paramArr.push(param);
										}
									}
									code.value.endMark=labelMarkMark[execResult[3]+":"];
									if(code.value.endMark){
									}else{
										throw new Error("找不到对应的 endMark: "+codeStr);
									}
								break;
								case AVM1Op.branch:
								case AVM1Op.branchIfTrue:
									labelMark=labelMarkMark[codeStr+":"];
									if(labelMark){
										code=new AVM1Code(op,labelMark);
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
								break;
								case AVM1Op.callFrame:
									code=new AVM1Code(op);
								break;
								case AVM1Op.gotoFrame2:
									execResult=codeStr.split(/\s*,\s*/);
									if(execResult.length>1){
										code=new AVM1Code(op,{
											Play:int(execResult[0]),
											SceneBias:int(execResult[1])
										});
									}else{
										code=new AVM1Code(op,{
											Play:int(execResult[0])
										});
									}
								break;
								default:
									throw new Error("未知 op: "+op);
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