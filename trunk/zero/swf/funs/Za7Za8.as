/***
Za7Za8 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月6日 14:35:33
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.*;
	
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class Za7Za8{
		public static function getUsefulTags(tagV:Vector.<Tag>):Vector.<Tag>{
			//把 FileAttributes，DebugId 等不想要的去掉
			var usefulTagV:Vector.<Tag>=new Vector.<Tag>();
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagType.DefineShape:
					case TagType.PlaceObject:
					case TagType.RemoveObject:
					case TagType.DefineBits:
					case TagType.DefineButton:
					case TagType.DefineFont:
					case TagType.DefineText:
					case TagType.DefineFontInfo:
					case TagType.DefineSound:
					case TagType.StartSound:
					case TagType.DefineButtonSound:
					case TagType.SoundStreamHead:
					case TagType.SoundStreamBlock:
					case TagType.DefineBitsLossless:
					case TagType.DefineBitsJPEG2:
					case TagType.DefineShape2:
					case TagType.DefineButtonCxform:
					case TagType.PlaceObject2:
					case TagType.RemoveObject2:
					case TagType.DefineShape3:
					case TagType.DefineText2:
					case TagType.DefineButton2:
					case TagType.DefineBitsJPEG3:
					case TagType.DefineBitsLossless2:
					case TagType.DefineEditText:
					case TagType.DefineSprite:
					case TagType.SoundStreamHead2:
					case TagType.DefineMorphShape:
					case TagType.DefineFont2:
					case TagType.DefineVideoStream:
					case TagType.VideoFrame:
					case TagType.DefineFontInfo2:
					case TagType.SetTabIndex:
					case TagType.PlaceObject3:
					case TagType.ImportAssets2:
					case TagType.DoABCWithoutFlagsAndName:
					case TagType.DefineFontAlignZones:
					case TagType.CSMTextSettings:
					case TagType.DefineFont3:
					case TagType.SymbolClass:
					case TagType.DefineScalingGrid:
					case TagType.DoABC:
					case TagType.DefineShape4:
					case TagType.DefineMorphShape2:
					case TagType.DefineBinaryData:
					case TagType.DefineFontName:
					case TagType.StartSound2:
					case TagType.DefineBitsJPEG4:
					case TagType.DefineFont4:
						usefulTagV.push(tag);
					break;
				}
			}
			return usefulTagV;
		}
		
		public static function forEachClasses(
			swf:SWF2,
			classNameOrClassNameMark:*,
			fun:Function
		):void{
			DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC);
			var tag:Tag,advanceABC:AdvanceABC,clazz:AdvanceClass;
			var classNameMark:Object;
			if(classNameOrClassNameMark is Array){
				for each(var className:String in classNameOrClassNameMark){
					classNameMark=new Object();
					if(className){
						classNameMark["~"+className]=true;
					}
				}
			}else{
				classNameMark=classNameOrClassNameMark;
			}
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						advanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC
						var i:int=advanceABC.clazzV.length;
						while(--i>=0){
							clazz=advanceABC.clazzV[i];
							className=getClassNameByMultinameInfo(clazz.name);
							if(classNameMark["~"+className]){
								fun(advanceABC,advanceABC.clazzV,i,className);
							}
						}
					break;
				}
			}
			DoABCWithoutFlagsAndName.setDecodeABC(null);
		}
		
		public static function forEachTraits(
			swf:SWF2,
			classNameArr:Array,
			traitsNameArr:Array,
			fun:Function
		):void{
			DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC);
			var tag:Tag,advanceABC:AdvanceABC,clazz:AdvanceClass;
			if(traitsNameArr){
				var traitsNameMark:Object=new Object();
				for each(var traitsName:String in traitsNameArr){
					traitsNameMark["~"+traitsName]=true;
				}
			}
			if(classNameArr){
				var classNameMark:Object=new Object();
				for each(var className:String in classNameArr){
					classNameMark["~"+className]=true;
				}
			}
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						advanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC
						for each(clazz in advanceABC.clazzV){
							className=getClassNameByMultinameInfo(clazz.name);
							
							if(classNameMark){
								if(classNameMark["~"+className]){
									delete classNameMark["~"+className];
								}else{
									continue;
								}
							}
							
							var i:int;
							i=clazz.itraits_infoV.length;
							while(--i>=0){
								traitsName=clazz.itraits_infoV[i].name.name;
								if(traitsNameMark){
									if(traitsNameMark["~"+traitsName]){
									}else{
										continue;
									}
								}
								fun(clazz,clazz.itraits_infoV,i,traitsName);
							}
							i=clazz.ctraits_infoV.length;
							while(--i>=0){
								traitsName=clazz.ctraits_infoV[i].name.name;
								if(traitsNameMark){
									if(traitsNameMark["~"+traitsName]){
									}else{
										continue;
									}
								}
								fun(clazz,clazz.ctraits_infoV,i,traitsName);
							}
						}
					break;
				}
			}
			DoABCWithoutFlagsAndName.setDecodeABC(null);
			
			for(className in classNameMark){
				throw new Error("找不到 class: "+className);
				break;
			}
		}
		
		public static function getCodesSWF(swf:SWF2,docClassSWF:SWF2=null,addFrame:Boolean=false):SWF2{
			//分离 swf 为 artwork 和 codes 两部分
			var codesSWF:SWF2=new SWF2();
			var i:int=swf.tagV.length;
			while(--i>=0){
				var tag:Tag=swf.tagV[i];
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						codesSWF.tagV.unshift(tag);
						swf.tagV.splice(i,1);
					break;
				}
			}
			if(addFrame){
				codesSWF.tagV.unshift(new Tag(TagType.ShowFrame));
				codesSWF.tagV.unshift(new Tag(TagType.ShowFrame));
			}
			if(docClassSWF){
				codesSWF.tagV=getUsefulTags(docClassSWF.tagV).concat(codesSWF.tagV);
			}
			codesSWF.tagV.push(new Tag(TagType.ShowFrame));
			codesSWF.tagV.push(new Tag(TagType.End));
			
			//for each(tag in codesSWF.tagV){
			//	trace(TagType.typeNameArr[tag.type]);
			//}
			
			return codesSWF;
		}
		
		public static function getFirstInitsAndRemove(swf:SWF2):Vector.<Vector.<AdvanceMultiname_info>>{
			var firstInitV:Vector.<Vector.<AdvanceMultiname_info>>=new Vector.<Vector.<AdvanceMultiname_info>>();
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
						for each(var clazz:AdvanceClass in advanceABC.clazzV){
							var firstInitResultMultinameName:AdvanceMultiname_info=null;
							var methodTraits_info:AdvanceTraits_info;
							for each(var traits_info:AdvanceTraits_info in clazz.ctraits_infoV){
								if(traits_info.kind_trait_type==TraitTypes.Const){
									if(traits_info.name.name=="firstInitResult"){
										firstInitResultMultinameName=traits_info.name;
										
										methodTraits_info=new AdvanceTraits_info();
										methodTraits_info.kind_attributes=TraitAttributes.Final;
										methodTraits_info.kind_trait_type=TraitTypes.Method;
										//methodTraits_info.disp_id=5;
										methodTraits_info.name=new AdvanceMultiname_info();
										methodTraits_info.name.kind=MultinameKind.QName;
										methodTraits_info.name.name=RandomStrs.getRan();
										methodTraits_info.name.ns=new AdvanceNamespace_info();
										methodTraits_info.name.ns.kind=NamespaceKind.PackageNamespace;
										methodTraits_info.name.ns.name="";
										clazz.ctraits_infoV[clazz.ctraits_infoV.indexOf(traits_info)]=methodTraits_info;
										break;
									}
								}
							}
							if(firstInitResultMultinameName){
								var codeArr:Array=clazz.cinit.codes.codeArr;
								var i:int=codeArr.length;
								while(--i>=0){
									var findpropertyCode:*=codeArr[i];
									if(
										findpropertyCode is Code
										&&
										findpropertyCode.op==Op.findproperty
										&&
										findpropertyCode.value==firstInitResultMultinameName
									){
										var newfunctionCode:*=codeArr[i+1];
										if(
											newfunctionCode is Code
											&&
											newfunctionCode.op==Op.newfunction
										){
											var getglobalscopeCode:*=codeArr[i+2];
											if(getglobalscopeCode===Op.getglobalscope){
												var callCode:*=codeArr[i+3];
												if(
													callCode is Code
													&&
													callCode.op==Op.call
													&&
													callCode.value==0
												){
													var initpropertyCode:*=codeArr[i+4];
													if(
														initpropertyCode is Code
														&&
														initpropertyCode.op==Op.initproperty
														&&
														initpropertyCode.value===firstInitResultMultinameName
													){
														codeArr.splice(i,5);
														methodTraits_info.methodi=newfunctionCode.value;
														methodTraits_info.methodi.max_scope_depth++;
														methodTraits_info.methodi.codes.codeArr.splice(0,0,Op.getlocal0,Op.pushscope);
														firstInitV.push(Vector.<AdvanceMultiname_info>([
															clazz.name,
															methodTraits_info.name
														]));
													}else{
														throw new Error("initpropertyCode="+initpropertyCode);
													}
												}else{
													throw new Error("callCode="+callCode);
												}
											}else{
												throw new Error("getglobalscopeCode="+getglobalscopeCode);
											}
										}else{
											throw new Error("newfunctionCode="+newfunctionCode);
										}
										
									}
								}
							}
						}
					break;
				}
			}
			return firstInitV;
		}
		
		private static function getMethods(swf:SWF2):Vector.<AdvanceMethod>{
			var methodV:Vector.<AdvanceMethod>=new Vector.<AdvanceMethod>();
			var i:int=0;
			var traits_info:AdvanceTraits_info;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
						for each(var clazz:AdvanceClass in advanceABC.clazzV){
							methodV[i++]=clazz.iinit;
							for each(traits_info in clazz.itraits_infoV){
								switch(traits_info.kind_trait_type){
									case TraitTypes.Method:
									case TraitTypes.Getter:
									case TraitTypes.Setter:
										methodV[i++]=traits_info.methodi;
									break;
									case TraitTypes.Function:
										methodV[i++]=traits_info.functioni;
									break;
								}
							}
							methodV[i++]=clazz.cinit;
							for each(traits_info in clazz.ctraits_infoV){
								switch(traits_info.kind_trait_type){
									case TraitTypes.Method:
									case TraitTypes.Getter:
									case TraitTypes.Setter:
										methodV[i++]=traits_info.methodi;
									break;
									case TraitTypes.Function:
										methodV[i++]=traits_info.functioni;
									break;
								}
							}
						}
						for each(var script_info:AdvanceScript_info in advanceABC.script_infoV){
							methodV[i++]=script_info.init;
							for each(traits_info in script_info.traits_infoV){
								switch(traits_info.kind_trait_type){
									case TraitTypes.Method:
									case TraitTypes.Getter:
									case TraitTypes.Setter:
										methodV[i++]=traits_info.methodi;
									break;
									case TraitTypes.Function:
										methodV[i++]=traits_info.functioni;
									break;
								}
							}
						}
					break;
				}
			}
			return methodV;
		}
		public static function insertFirstInitVInSWF(
			swf:SWF2,
			firstInitV:Vector.<Vector.<AdvanceMultiname_info>>,
			getPushStringCodeIdAndKeys:Function,
			infoMark:InfoMark,
			pushStringCodeTraits_infoXML:XML,
			objCallMethodTraits_infoXML0:XML,
			objCallMethod2Traits_infoXML0:XML,
			markName:String
		):Vector.<AdvanceMethod>{
			var insert_methodV:Vector.<AdvanceMethod>=new Vector.<AdvanceMethod>();
			var tag:Tag,advanceABC:AdvanceABC,clazz:AdvanceClass,script_info:AdvanceScript_info;
			var methodV:Vector.<AdvanceMethod>=getMethods(swf);
			
			var firstInitResultMultinameName:AdvanceMultiname_info;
			var pushStringCodeStr:String=pushStringCodeTraits_infoXML.methodi[0].codes[0].toString();
			
			loop:while(firstInitV.length){
				for each(var method:AdvanceMethod in methodV){
					if(firstInitV.length){
						var codeArr:Array=method.codes.codeArr;
						var i:int=codeArr.length;
						while(--i>=0){
							if(checkIsTraceMarkName(codeArr,i,markName)){
								if(firstInitV.length){
									var objAndMethodName:Vector.<AdvanceMultiname_info>=firstInitV.shift();
									var objCallMethodTraits_infoXML:XML;
									var firstInitClassName:String;
									if(objAndMethodName[0].ns.name){
										objCallMethodTraits_infoXML=objCallMethod2Traits_infoXML0.copy();
										firstInitClassName=objAndMethodName[0].ns.name+"."+objAndMethodName[0].name;
									}else{
										objCallMethodTraits_infoXML=objCallMethodTraits_infoXML0.copy();
										firstInitClassName=objAndMethodName[0].name;
									}
									var codesStr:String=objCallMethodTraits_infoXML.methodi[0].codes[0].toString();
									//trace("codesStr="+codesStr);
									//trace("------------------------------------------------------------");
									codesStr=replacePushStringCode(
										codesStr,
										pushStringCodeStr,
										getPushStringCodeIdAndKeys,
										["objName","methodName"],
										[firstInitClassName,objAndMethodName[1].name]
									);
									objCallMethodTraits_infoXML.methodi[0].codes=codesStr;
									
									var objCallMethodTraits_info:AdvanceTraits_info=new AdvanceTraits_info();
									objCallMethodTraits_info["initByXMLAndMark"](
										infoMark,
										objCallMethodTraits_infoXML
									);
									objCallMethodTraits_info.slot_id=0;//否则可能会出错
									objCallMethodTraits_info.disp_id=0;//否则可能会出错
									
									var objCallMethodCodeArr:Array=normalizeCodeArr(objCallMethodTraits_info.methodi.codes.codeArr);
									objCallMethodCodeArr.unshift(i,0);
									codeArr.splice.apply(codeArr,objCallMethodCodeArr);
									//*/
									
									var max_stack:int=int(pushStringCodeTraits_infoXML.methodi[0].@max_stack.toString());
									if(method.max_stack<max_stack){
										method.max_stack=max_stack;
									}
									insert_methodV.push(method);
									Outputer.output("　分离"+firstInitClassName+".firstInitResult","green");
								}else{
									break loop;
								}
							}
						}
					}else{
						break loop;
					}
				}
			}
			return insert_methodV;
		}
		
		public static function replacePushStringCode(
			codesStr:String,
			pushStringCodeStr:String,
			getPushStringCodeIdAndKeys:Function,
			str0Arr:Array,strtArr:Array
		):String{
			var str:String,i:int,encodeStrObj:Object;
			
			var strMark:Object=new Object();
			i=0;
			for each(str in str0Arr){
				strMark["~"+str]=strtArr[i++];
			}
			var execResult:Array=/(\s*\/\/getlocal0\s*\/\/pushscope[\s\S]*?)\{writeStrData([\s\S]*?)writeStrData\}([\s\S]*?\/\/returnvoid\s*)/.exec(pushStringCodeStr);
			var newCodesStr:String="";
			for each(var _codeStr:String in codesStr.split(/[\r\n]+/)){
				var codeStr:String=_codeStr.replace(/^\s*|\s*$/g,"");
				if(codeStr.indexOf("//")==0){
					continue;
				}
				if(codeStr.indexOf("pushstring")==0){
					str=codeStr.replace(/^pushstring\s+"(.*)"$/,"$1");
					if(strMark["~"+str] is String){
						str=strMark["~"+str];
					}
					
					var strData:ByteArray=new ByteArray();
					strData.writeUTFBytes(str);
					var len:int=strData.length;
					newCodesStr+=execResult[1]+"\n";
					for each(i in ZeroCommon.getDisorderArr(len)){
						encodeStrObj=getPushStringCodeIdAndKeys(strData[i]);
						newCodesStr+=execResult[2]
							.replace(/\${i\}/g,i.toString())
							.replace(/\${pos\}/g,encodeStrObj.pos.toString())
							.replace(/\${key\}/g,encodeStrObj.key.toString())
							+"\n";
					}
					encodeStrObj=getPushStringCodeIdAndKeys(len);
					newCodesStr+=execResult[3]
						.replace(/\${len_pos\}/g,encodeStrObj.pos.toString())
						.replace(/\${len_key\}/g,encodeStrObj.key.toString())
						+"\n";
				}else{
					newCodesStr+=codeStr+"\n";
				}
			}
			return newCodesStr;
		}
		public static function clearTraceMarkNames(swf:SWF2,markName:String):void{
			for each(var method:AdvanceMethod in getMethods(swf)){
				clearTraceMarkName(method.codes.codeArr,markName);
			}
		}
		
		public static function checkIsTraceMarkName(
			codeArr:Array,
			i:int,
			markName:String
		):Boolean{
			var code:*=codeArr[i];
			if(
				code is Code
				&&
				code.op==Op.findpropstrict
				&&
				code.value.name=="trace"
			){
				code=codeArr[i+1];
				if(
					code is Code
					&&
					code.op==Op.pushstring
					&&
					code.value==markName
				){
					code=codeArr[i+2];
					if(
						code is Code
						&&
						code.op==Op.callpropvoid
						&&
						code.value.multiname_info.name=="trace"
					){
						return true;
					}
				}
			}
			return false;
		}
		public static function clearTraceMarkName(codeArr:Array,markName:String):void{
			//trace("markName="+markName);
			var i:int=codeArr.length;
			while(--i>=0){
				if(checkIsTraceMarkName(codeArr,i,markName)){
					codeArr.splice(i,3);
				}
			}
		}
		
		public static function insertCodeArrAndClearMarkName(
			method0:AdvanceMethod,
			method:AdvanceMethod,
			markName:String
		):void{
			var codeArr:Array=normalizeCodeArr(method.codes.codeArr);
			var i:int=-1;
			for each(var code:* in method0.codes.codeArr){
				i++;
				if(checkIsTraceMarkName(method0.codes.codeArr,i,markName)){
					clearTraceMarkName(method0.codes.codeArr,markName);
					codeArr.unshift(i,0);//因为 codeArr 已经是副本所以不会影响原 codeArr
					method0.codes.codeArr.splice.apply(method0.codes.codeArr,codeArr);
					if(method0.max_stack<method.max_stack){
						method0.max_stack=method.max_stack;
					}
					if(method0.local_count<method.local_count){
						method0.local_count=method.local_count;
					}
					return;
				}
			}
			throw new Error("找不到 markName: "+markName);
		}
		public static function normalizeCodeArr(codeArr:Array):Array{
			codeArr=codeArr.slice();
			if(
				codeArr.shift()===Op.getlocal0
				&&
				codeArr.shift()===Op.pushscope
				&&
				codeArr.pop()===Op.returnvoid
			){
			}else{
				throw new Error("codeArr 不太正常");
			}
			return codeArr;
		}
		public static function insertCodesInMethod(
			method0:AdvanceMethod,
			method:AdvanceMethod
		):void{
			var code0:*,code1:*;
			if(method0.codes.codeArr.length>1){
				code0=method0.codes.codeArr[0];
				code1=method0.codes.codeArr[1];
				if(
					code0===Op.getlocal0
					&&
					code1===Op.pushscope
				){
					method0.codes.codeArr.shift();
					method0.codes.codeArr.shift();
				}else{
					code0=null;
					code1=null;
				}
			}
			
			if(method0.max_stack<method.max_stack){
				method0.max_stack=method.max_stack;
			}
			
			method0.codes.codeArr=normalizeCodeArr(method.codes.codeArr).concat(method0.codes.codeArr);
			
			if(code0&&code1){
				method0.codes.codeArr.unshift(code1);
				method0.codes.codeArr.unshift(code0);
			}
		}
		
		public static function addPlayerVersionSWF(swf:SWF2,playerVersionSWFData:ByteArray):void{
			//检测播放器版本
			var playerVersionSWF:SWF2=new SWF2();
			playerVersionSWF.initBySWFData(playerVersionSWFData);
			
			swf.tagV.pop();//End
			swf.tagV.pop();//ShowFrame
			swf.tagV.pop();//ShowFrame
			swf.tagV.pop();//ShowFrame
			swf.tagV.pop();//ShowFrame
			swf.tagV.pop();//ShowFrame
			
			swf.tagV=swf.tagV.concat(getUsefulTags(playerVersionSWF.tagV));
			
			playerVersionSWF=null;
			
			swf.tagV.push(new Tag(TagType.ShowFrame));
			swf.tagV.push(new Tag(TagType.ShowFrame));
			swf.tagV.push(new Tag(TagType.ShowFrame));
			swf.tagV.push(new Tag(TagType.ShowFrame));
			swf.tagV.push(new Tag(TagType.ShowFrame));
			swf.tagV.push(new Tag(TagType.End));
		}
		
		public static function getClassNameByMultinameInfo(multiname_info:AdvanceMultiname_info):String{
			return multiname_info.ns.name
				?
				multiname_info.ns.name+"."+multiname_info.name
				:
				multiname_info.name
		}
		
		public static function getAdvanceClassByClassName(swf:SWF2,className:String):AdvanceClass{
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var abc:AdvanceABC=tag.getBody().abc;
						for each(var clazz:AdvanceClass in abc.clazzV){
							if(className==getClassNameByMultinameInfo(clazz.name)){
								return clazz;
							}
						}
					break;
				}
			}
			return null;
		}
		
		public static function checkIsClass(swf:SWF2,name:String,className:String):Boolean{
			while(name){
				if(name==className){
					return true;
				}
				var clazz:AdvanceClass=getAdvanceClassByClassName(swf,name);
				if(clazz){
					name=getClassNameByMultinameInfo(clazz.super_name);
				}else{
					break;
				}
			}
			return false
		}
		public static function getMethodByName(clazz:AdvanceClass,name:String):AdvanceMethod{
			for each(var traits_info:AdvanceTraits_info in clazz.itraits_infoV){
				if(traits_info.kind_trait_type==TraitTypes.Method){
					if(traits_info.name.name==name){
						return traits_info.methodi;
					}
				}
			}
			return null;
		}
		
		public static function getDefineBinaryDataTagByClassName(swf:SWF2,DefineBinaryDataClassName:String):Tag{
			var defineBinaryDataTagArr:Array=new Array();
			var defineBinaryDataTag:Tag=null;
			for each(var tag:Tag in swf.tagV){
				if(tag.type==TagType.DefineBinaryData){
					defineBinaryDataTagArr[tag.getDefId()]=tag;
				}else if(tag.type==TagType.SymbolClass){
					var symbolClass:SymbolClass=tag.getBody() as SymbolClass;
					for each(var Name:String in symbolClass.NameV){
						if(Name==DefineBinaryDataClassName){
							defineBinaryDataTag=defineBinaryDataTagArr[symbolClass.TagV[symbolClass.NameV.indexOf(Name)]];
							break;
						}
					}
				}
			}
			return defineBinaryDataTag;
		}
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