/***
CodesRunner
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月10日 08:44:53
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm1.runners{
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.fscommand;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import zero.swf.avm1.*;
	
	public class CodesRunner{
		//用于 getProperty 和 setProperty
		private static const propertyV:Vector.<String>=Vector.<String>([
			"_x",
			"_y",
			"_xscale",
			"_yscale",
			"_currentframe",
			"_totalframes",
			"_alpha",
			"_visible",
			"_width",
			"_height",
			"_rotation",
			"_target",
			"_framesloaded",
			"_name",
			"_droptarget",
			"_url",
			"_highquality",
			"_focusrect",
			"_soundbuftime",
			"_quality",
			"_xmouse",
			"_ymouse"
		]);
		
		public function run(data:*,thisObj:*=null):*{
			if(data is ByteArray){
			}else{
				data=str162bytes(data);
			}
			
			var actionRecord:ACTIONRECORD=new ACTIONRECORD();
			actionRecord.initByData(data,0,data.length,null);
			
			//trace(actionRecord.toXML("actionRecord",null));
			
			return runCodeArr(actionRecord.codeArr,thisObj);
		}
		public function runCodeArr(
			codeArr:Array,
			thisObj:*,
			_registerArr:Array=null,
			_argumentArr:Array=null,
			globalVars:Object=null,
			vars:Object=null
		):*{
			var i:int,L:int;
			var varName:String;
			
			if(globalVars){
			}else{
				globalVars=new Object();
				if(thisObj){
					globalVars["this"]=thisObj;
					if(thisObj.hasOwnProperty("root")){
						globalVars["_root"]=thisObj.root;
					}
					if(thisObj.hasOwnProperty("parent")){
						globalVars["_parent"]=thisObj.parent;
					}
				}
			}
			if(globalVars.hasOwnProperty("_global")){
			}else{
				globalVars["_global"]=new Object();
			}
			
			if(vars){
			}else{
				vars=new Object();
			}
			if(thisObj){
				vars["this"]=thisObj;
				if(thisObj.hasOwnProperty("root")){
					vars["_root"]=thisObj.root;
				}
				if(thisObj.hasOwnProperty("parent")){
					vars["_parent"]=thisObj.parent;
				}
			}
			vars["arguments"]=_argumentArr;
			
			//var constCode:AVM1Code;
			var registerArr:Array=new Array();
			if(_registerArr){
				L=_registerArr.length;
				for(i=0;i<L;i++){
					switch(_registerArr[i]){
						case "this":
						case "_root":
						case "_parent":
						case "arguments":
							registerArr[i]=vars[_registerArr[i]];
						break;
						default:
							if(_registerArr[i] is String &&_registerArr[i].indexOf("arg:")==0){
								registerArr[i]=_argumentArr[int(_registerArr[i].substr(4))];
							}else{
								registerArr[i]=_registerArr[i];
							}
						break;
					}
				}
			}
			
			var stack:Array=new Array();
			var value:*,value1:*,value2:*;
			var obj:*;
			
			var fName:*;//不能用 String 否则 undefined 就自动转成 null 了...
			var count:int,argsArr:Array;
			
			L=codeArr.length;
			
			var code:*;
			
			var labelIdDict:Dictionary=new Dictionary();
			for(i=0;i<L;i++){
				if(codeArr[i] is AVM1LabelMark){
					labelIdDict[codeArr[i]]=i;
				}
			}
			
			i=0;
			
			loop:while(i<L){
				code=codeArr[i];
				
				/*
				if(code is AVM1Code){
					trace(AVM1Ops.opNameV[code.op],code.value);
				}else if(code is AVM1LabelMark){
					trace(code);
				}else{
					trace(AVM1Ops.opNameV[code]);
				}
				//*/
				
				if(code is AVM1LabelMark){
				}else{
					switch(code){
						case AVM1Ops.end://0x00
							break loop;
						break;
						//0x01//nop
						//0x02
						//0x03
						case AVM1Ops.nextFrame://0x04
							if(thisObj.hasOwnProperty("nextFrame")){
								thisObj.nextFrame();
							}else{
								trace(thisObj+" 不支持 nextFrame()");
							}
						break;	
						case AVM1Ops.prevFrame://0x05
							if(thisObj.hasOwnProperty("prevFrame")){
								thisObj.prevFrame();
							}else{
								trace(thisObj+" 不支持 prevFrame()");
							}
						break;
						case AVM1Ops.play://0x06
							if(thisObj.hasOwnProperty("play")){
								thisObj.play();
							}else{
								trace(thisObj+" 不支持 play()");
							}
						break;
						case AVM1Ops.stop://0x07
							if(thisObj.hasOwnProperty("stop")){
								thisObj.stop();
							}else{
								trace(thisObj+" 不支持 stop()");
							}
						break;
						case AVM1Ops.toggleQuality://0x08
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.stopSounds://0x09
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.oldAdd://0x0a
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.subtract://0x0b
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1-value2);
						break;
						case AVM1Ops.multiply://0x0c
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1*value2);
						break;
						case AVM1Ops.divide://0x0d
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1/value2);
						break;
						case AVM1Ops.oldEquals://0x0e
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.oldLessThan://0x0f
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.and://0x10
							//貌似都是用 dup not branchIfTrue label
							//因为 a&&b 如果 a为假则不继续执行b
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1&&value2);
						break;
						case AVM1Ops.or://0x11
							//貌似都是用 dup branchIfTrue label
							//因为 a||b 如果 a为真则不继续执行b
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1||value2);
						break;
						case AVM1Ops.not://0x12
							stack.push(!stack.pop());
						break;
						case AVM1Ops.stringEq://0x13
							//貌似都是用 equals
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1==value2);
						break;
						case AVM1Ops.stringLength://0x14
							//length(expression: String, variable: Object) Number
							//自 Flash Player 5 后"不推荐使用"。此函数及所有字符串函数已不推荐使用。Adobe 建议您使用 String 类的方法和 String.length 属性来执行相同的操作。
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.substring://0x15
							//substring(string: String, index: Number, count: Number) String
							//自 Flash Player 5 后"不推荐使用"。不推荐使用此函数，而推荐使用 String.substr()。
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						//0x16
						case AVM1Ops.pop://0x17
							stack.pop();
						break;
						case AVM1Ops.int_://0x18
							//int(value: Number) Number
							//自 Flash Player 5 后"不推荐使用"。不推荐使用此函数，对于正值，推荐使用 Math.floor()；对于负值，推荐使用 Math.ceil。
							stack.push(int(stack.pop()));
						break;
						//0x19
						//0x1a
						//0x1b
						case AVM1Ops.getVariable://0x1c
							stack.push(getVar(stack.pop(),globalVars,vars));
						break;
						case AVM1Ops.setVariable://0x1d
							value=stack.pop();
							vars[stack.pop()]=value;
						break;
						//0x1e
						//0x1f
						case AVM1Ops.setTargetExpr://0x20
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.concat://0x21
							value2=stack.pop();
							value1=stack.pop();
							stack.push(String(value1)+String(value2));
						break;
						case AVM1Ops.getProperty://0x22
							varName=propertyV[stack.pop()];
							obj=stack.pop();
							switch(obj){//target
								case "":
									obj=thisObj;
								break;
								default:
									throw new Error("暂不支持的 target："+obj);
								break;
							}
							stack.push(obj[varName]);
						break;
						case AVM1Ops.setProperty://0x23
							value=stack.pop();
							varName=propertyV[stack.pop()];
							obj=stack.pop();
							switch(obj){//target
								case "":
									obj=thisObj;
								break;
								default:
									throw new Error("暂不支持的 target："+obj);
								break;
							}
							obj[varName]=value;
						break;
						case AVM1Ops.duplicateClip://0x24
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.removeClip://0x25
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.trace_://0x26
							trace(stack.pop());
						break;
						case AVM1Ops.startDrag://0x27
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.stopDrag://0x28
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.stringLess://0x29
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.throw_://0x2a
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.cast://0x2b
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.implements_://0x2c
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.FSCommand2://0x2d
							//暂时没见到...
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						//0x2e
						//0x2f
						case AVM1Ops.random://0x30
							//random(value: Number) Number
							//自 Flash Player 5 后"不推荐使用"。不推荐使用此函数，而推荐使用 Math.random()。
							value=int(stack.pop());
							if(value>0){
								stack.push(int(Math.random()*value));
							}else{
								stack.push(0);
							}
						break;
						case AVM1Ops.mBStringLength://0x31
							//mblength(string: String) Number
							//自 Flash Player 5 后"不推荐使用"。不推荐使用此函数，而推荐使用 String 类的方法和属性。
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.ord://0x32
							//ord(character: String) Number
							//自 Flash Player 5 后"不推荐使用"。不推荐使用此函数，而推荐使用 String 类的方法和属性。
							stack.push(stack.pop().charCodeAt(0));
						break;
						case AVM1Ops.chr://0x33
							//chr(number: Number) String
							//自 Flash Player 5 后"不推荐使用"。不推荐使用此函数，而推荐使用 String.fromCharCode()。
							stack.push(String.fromCharCode(stack.pop()));
						break;
						case AVM1Ops.getTimer://0x34
							stack.push(getTimer());
						break;
						case AVM1Ops.mbSubstring://0x35
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.mbOrd://0x36
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.mbChr://0x37
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						//0x38
						//0x39
						case AVM1Ops.delete_://0x3a
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.delete2://0x3b
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.varEquals://0x3c
							//trace("stack="+stack);
							value=stack.pop();
							vars[stack.pop()]=value;
						break;
						case AVM1Ops.callFunction://0x3d
							fName=stack.pop();
							argsArr=new Array();
							count=stack.pop();
							while(--count>=0){
								argsArr.push(stack.pop());
							}
							
							obj=getVar(fName,globalVars,vars);
							
							///
							stack.push(obj.apply(obj,argsArr));
							/*$#$#$#$#$#$#$#$#$
							if(obj is Fun){
								stack.push((obj as Fun).run(this,thisObj,argsArr,globalVars,vars));
							}else{
								stack.push(obj.apply(obj,argsArr));
							}
							//$#$#$#$#$#$#$#$#$*/
							///
							
						break;
						case AVM1Ops.return_://0x3e
							value=stack.pop();
							if(stack.length>0){
								trace("end，stack有残留值: "+stack);
							}
							return value;
						break;
						case AVM1Ops.modulo://0x3f
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1%value2);
						break;
						case AVM1Ops.new_://0x40
							fName=stack.pop();
							argsArr=new Array();
							count=stack.pop();
							while(--count>=0){
								argsArr.push(stack.pop());
							}
							
							obj=getVar(fName,globalVars,vars);
							
							///
							stack.push(newClass(obj,argsArr));
							/*$#$#$#$#$#$#$#$#$
							if(obj is Fun){
								stack.push(new Clazz(this,obj,argsArr,globalVars,vars));
							}else{
								stack.push(newClass(obj,argsArr));
							}
							//$#$#$#$#$#$#$#$#$*/
							///
							
						break;
						case AVM1Ops.var_://0x41
							varName=stack.pop();
							if(vars.hasOwnProperty(varName)){
							}else{
								vars[varName]=undefined;
							}
						break;
						case AVM1Ops.initArray://0x42
							count=stack.pop();
							value=new Array();
							while(--count>=0){
								value.push(stack.pop());
							}
							stack.push(value);
						break;
						case AVM1Ops.initObject://0x43
							count=stack.pop();
							obj=new Object();
							while(--count>=0){
								value=stack.pop();
								varName=stack.pop();
								obj[varName]=value;
							}
							stack.push(obj);
						break;
						case AVM1Ops.typeof_://0x44
							stack.push(typeof(stack.pop()));
						break;
						case AVM1Ops.targetPath://0x45
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.enumerate://0x46
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.add://0x47
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1+value2);
						break;
						case AVM1Ops.lessThan://0x48
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1<value2);
						break;
						case AVM1Ops.equals://0x49
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1==value2);
						break;
						case AVM1Ops.toNumber://0x4a
							stack.push(Number(stack.pop()));
						break;
						case AVM1Ops.toString_://0x4b
							stack.push(String(stack.pop()));
						break;
						case AVM1Ops.dup://0x4c
							value=stack.pop();
							stack.push(value);
							stack.push(value);
						break;
						case AVM1Ops.swap://0x4d
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value2);
							stack.push(value1);
						break;
						case AVM1Ops.getMember://0x4e
							varName=stack.pop();
							obj=stack.pop();
							stack.push(obj[varName]);
						break;
						case AVM1Ops.setMember://0x4f
							value=stack.pop();
							varName=stack.pop();
							obj=stack.pop();
							obj[varName]=value;
						break;
						case AVM1Ops.increment://0x50
							stack.push(stack.pop()+1);
						break;
						case AVM1Ops.decrement://0x51
							stack.push(stack.pop()-1);
						break;
						case AVM1Ops.callMethod://0x52
							fName=stack.pop();
							obj=stack.pop();
							argsArr=new Array();
							count=stack.pop();
							while(--count>=0){
								argsArr.push(stack.pop());
							}
							
							///
							stack.push(obj[fName].apply(obj,argsArr));
							/*$#$#$#$#$#$#$#$#$
							if(obj==="super"){
								if(fName===undefined){
									(thisObj as Clazz).superClazz=new Clazz(this,(thisObj as Clazz).fun.baseFun,argsArr,globalVars,vars);
								}else{
									stack.push(((thisObj as Clazz).superClazz[fName] as Fun).run(this,(thisObj as Clazz).superClazz,argsArr,globalVars,vars));
								}
							}else if(obj[fName] is Fun){
								stack.push((obj[fName] as Fun).run(this,thisObj,argsArr,globalVars,vars));
							}else{
								stack.push(obj[fName].apply(obj,argsArr));
							}
							//$#$#$#$#$#$#$#$#$*/
							///
							
						break;
						case AVM1Ops.newMethod://0x53
							//和 new_ 差一个 getMember 的过程
							fName=stack.pop();
							obj=stack.pop();
							argsArr=new Array();
							count=stack.pop();
							while(--count>=0){
								argsArr.push(stack.pop());
							}
							
							///
							stack.push(newClass(obj,argsArr));
							/*$#$#$#$#$#$#$#$#$
							if(obj[fName] is Fun){
								stack.push(new Clazz(this,obj[fName],argsArr,globalVars,vars));
							}else{
								stack.push(newClass(obj,argsArr));
							}
							//$#$#$#$#$#$#$#$#$*/
							///
							
						break;
						case AVM1Ops.instanceOf://0x54
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1 is value2);
						break;
						case AVM1Ops.enumerateValue://0x55
							obj=stack.pop();
							stack.push(null);
							for(varName in obj){
								stack.push(varName);
							}
						break;
						//0x56
						//0x57
						//0x58
						//0x59
						//0x5a
						//0x5b
						//0x5c
						//0x5d
						//0x5e
						//0x5f
						case AVM1Ops.bitwiseAnd://0x60
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1&value2);
						break;
						case AVM1Ops.bitwiseOr://0x61
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1|value2);
						break;
						case AVM1Ops.bitwiseXor://0x62
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1^value2);
						break;
						case AVM1Ops.shiftLeft://0x63
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1<<value2);
						break;
						case AVM1Ops.shiftRight://0x64
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1>>value2);
						break;
						case AVM1Ops.shiftRight2://0x65
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1>>>value2);
						break;
						case AVM1Ops.strictEquals://0x66
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1===value2);
						break;
						case AVM1Ops.greaterThan://0x67
							value2=stack.pop();
							value1=stack.pop();
							stack.push(value1>value2);
						break;
						case AVM1Ops.stringGreater://0x68
							throw new Error("暂不支持：op="+code+","+AVM1Ops.opNameV[code]);
						break;
						case AVM1Ops.extends_://0x69
							
							///
							throw new Error("暂不支持 extends_");
							/*$#$#$#$#$#$#$#$#$
							value2=stack.pop();//Fun
							value1=stack.pop();//Fun
							(value1 as Fun).baseFun=value2;
							//$#$#$#$#$#$#$#$#$*/
							///
							
						break;
						//0x6a
						//0x6b
						//0x6c
						//0x6d
						//0x6e
						//0x6f
						//0x70
						//0x71
						//0x72
						//0x73
						//0x74
						//0x75
						//0x76
						//0x77
						//0x78
						//0x79
						//0x7a
						//0x7b
						//0x7c
						//0x7d
						//0x7e
						//0x7f
						default:
							if(code is AVM1Code){
								switch(code.op){
									//0x80
									case AVM1Ops.gotoFrame://0x81
										if(thisObj.hasOwnProperty("gotoAndStop")){
											thisObj.gotoAndStop(code.value+1);
										}else{
											trace(thisObj+" 不支持 gotoFrame（也就是 gotoAndStop）");
										}
									break;
									//0x82
									case AVM1Ops.getURL://0x83
										if(code.value.UrlString.indexOf("FSCommand:")==0){
											trace("fscommand(\""+code.value.UrlString.substr(10)+"\",\""+code.value.TargetString+"\")");
											fscommand(code.value.UrlString.substr(10),code.value.TargetString);
										}else if(code.value.TargetString.indexOf("_level")==0){
											trace("暂不支持 loadMovieNum 和 unloadMovieNum");
										}else{
											trace("跳到网页");
											navigateToURL(new URLRequest(code.value.UrlString),code.value.TargetString);
										}
									break;
									//0x84
									//0x85
									//0x86
									case AVM1Ops.setRegister://0x87
										registerArr[code.value]=stack[stack.length-1];//不 pop
									break;
									case AVM1Ops.constants://0x88
										//constCode=code;
									break;
									//0x89
									case AVM1Ops.ifFrameLoaded://0x8a
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									case AVM1Ops.setTarget://0x8b
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									case AVM1Ops.gotoLabel://0x8c
										if(thisObj.hasOwnProperty("gotoAndStop")){
											thisObj.gotoAndStop(code.value);
										}else{
											trace(thisObj+" 不支持 gotoLabel（也就是 gotoAndStop）");
										}
									break;
									case AVM1Ops.ifFrameLoadedExpr://0x8d
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									case AVM1Ops.function2://0x8e
										
										///
										throw new Error("暂不支持 function2");
										/*$#$#$#$#$#$#$#$#$
										if(code.value.FunctionName){
											vars[code.value.FunctionName]=new Fun(codeArr.slice(i,labelIdDict[code.value.endMark]+1));
										}else{
											stack.push(new Fun(codeArr.slice(i,labelIdDict[code.value.endMark]+1)));
										}
										i=labelIdDict[code.value.endMark];
										//$#$#$#$#$#$#$#$#$*/
										///
										
									break;
									case AVM1Ops.try_://0x8f
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									//0x90
									//0x91
									//0x92
									//0x93
									case AVM1Ops.with_://0x94
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									//0x95
									case AVM1Ops.push://0x96
										for each(value in code.value){
											if(value is AVM1Register){
												stack.push(registerArr[value.registerId]);
											}else{
												stack.push(value);
											}
										}
									break;
									//0x97
									//0x98
									case AVM1Ops.branch://0x99
										i=labelIdDict[code.value];
									break;
									case AVM1Ops.getURL2://0x9a
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									case AVM1Ops.function_://0x9b
										
										///
										throw new Error("暂不支持 function_");
										/*$#$#$#$#$#$#$#$#$
										if(code.value.FunctionName){
											vars[code.value.FunctionName]=new Fun(codeArr.slice(i,labelIdDict[code.value.endMark]+1));
										}else{
											stack.push(new Fun(codeArr.slice(i,labelIdDict[code.value.endMark]+1)));
										}
										i=labelIdDict[code.value.endMark];
										//$#$#$#$#$#$#$#$#$*/
										///
										
									break;
									//0x9c
									case AVM1Ops.branchIfTrue://0x9d
										if(stack.pop()){
											i=labelIdDict[code.value];
										}
									break;
									case AVM1Ops.callFrame://0x9e
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									case AVM1Ops.gotoFrame2://0x9f
										throw new Error("暂不支持：op="+code.op+","+AVM1Ops.opNameV[code.op]);
									break;
									//0xa0
									//0xa1
									//0xa2
									//0xa3
									//0xa4
									//0xa5
									//0xa6
									//0xa7
									//0xa8
									//0xa9
									//0xaa
									//0xab
									//0xac
									//0xad
									//0xae
									//0xaf
									//0xb0
									//0xb1
									//0xb2
									//0xb3
									//0xb4
									//0xb5
									//0xb6
									//0xb7
									//0xb8
									//0xb9
									//0xba
									//0xbb
									//0xbc
									//0xbd
									//0xbe
									//0xbf
									//0xc0
									//0xc1
									//0xc2
									//0xc3
									//0xc4
									//0xc5
									//0xc6
									//0xc7
									//0xc8
									//0xc9
									//0xca
									//0xcb
									//0xcc
									//0xcd
									//0xce
									//0xcf
									//0xd0
									//0xd1
									//0xd2
									//0xd3
									//0xd4
									//0xd5
									//0xd6
									//0xd7
									//0xd8
									//0xd9
									//0xda
									//0xdb
									//0xdc
									//0xdd
									//0xde
									//0xdf
									//0xe0
									//0xe1
									//0xe2
									//0xe3
									//0xe4
									//0xe5
									//0xe6
									//0xe7
									//0xe8
									//0xe9
									//0xea
									//0xeb
									//0xec
									//0xed
									//0xee
									//0xef
									//0xf0
									//0xf1
									//0xf2
									//0xf3
									//0xf4
									//0xf5
									//0xf6
									//0xf7
									//0xf8
									//0xf9
									//0xfa
									//0xfb
									//0xfc
									//0xfd
									//0xfe
									//0xff
								}
							}else{
								throw new Error("未知 code："+code);
							}
						break;
					}
				}
				i++;
			}
			
			if(stack.length>0){
				trace("end，stack有残留值: "+stack);
			}
		}
		private static function str162bytes(str16:String):ByteArray{
			var bytes:ByteArray=new ByteArray();
			if(str16){
				var i:int=0;
				for each(var str:String in str16.split(/[^0-9a-fA-F]+/)){
					bytes[i++]=int("0x"+str);
				}
			}
			return bytes;
		}
		private static function newClass(clazz:Class,argsArr:Array):*{
			//貌似 Class 不支持像 Function.apply 的东西,参考 Flash CS3 帮助里的例子: ActionScript 3.0 编程 > 处理数组 > 高级主题  
			switch(argsArr.length){
				case 0:
					return new clazz();
				case 1:
					return new clazz(argsArr[0]);
				case 2:
					return new clazz(argsArr[0],argsArr[1]);
				case 3:
					return new clazz(argsArr[0],argsArr[1],argsArr[2]);
				case 4:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3]);
				case 5:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4]);
				case 6:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5]);
				case 7:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6]);
				case 8:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6],argsArr[7]);
				case 9:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6],argsArr[7],argsArr[8]);
				case 10:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6],argsArr[7],argsArr[8],argsArr[9]);
			}
			throw new Error("暂不支持的参数个数: "+argsArr.length);
		}
		private static function getVar(varName:String,_globalVars:Object,_vars:Object):*{
			//
			if(_vars.hasOwnProperty(varName)){
				return _vars[varName];
			}
			
			//
			if(_globalVars.hasOwnProperty(varName)){
				return _globalVars[varName];
			}
			
			//
			if(_globalVars["_global"].hasOwnProperty(varName)){
				return _globalVars["_global"][varName];
			}
			
			//
			try{
				return getDefinitionByName(varName);
			}catch(e:Error){
			}
			
			if(varName.indexOf("flash.filesystem")==0){
				throw new Error("getVar 失败："+varName+"，可能需要发布成 air");
			}else{
				throw new Error("getVar 失败："+varName);
			}
		}
	}
}