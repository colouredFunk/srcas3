/***
MoveFirstInit 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月17日 16:41:51
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.Dictionary;
	
	import zero.Outputer;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class MoveFirstInit{
		public static function getFirstInitsAndRemove(swf:SWF2):Vector.<Array>{
			var firstInitV:Vector.<Array>=new Vector.<Array>();
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
														firstInitV.push([
															clazz.name,
															methodTraits_info.name
														]);
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
		
		public static function insertFirstInitVInSWF(
			swf:SWF2,
			firstInitV:Vector.<Array>,
			markName:String="###runFirstInit()###"
		):void{
			var tag:Tag,advanceABC:AdvanceABC,clazz:AdvanceClass,script_info:AdvanceScript_info;
			loop:while(firstInitV.length){
				for each(tag in swf.tagV){
					switch(tag.type){
						case TagType.DoABC:
						case TagType.DoABCWithoutFlagsAndName:
							advanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
							for each(clazz in advanceABC.clazzV){
								if(firstInitV.length){
									insertFirstInitInTraits(clazz.itraits_infoV,firstInitV,markName);
								}else{
									break loop;
								}
								if(firstInitV.length){
									insertFirstInitInTraits(clazz.ctraits_infoV,firstInitV,markName);
								}else{
									break loop;
								}
							}
							for each(script_info in advanceABC.script_infoV){
								if(firstInitV.length){
									insertFirstInitInTraits(script_info.traits_infoV,firstInitV,markName);
								}else{
									break loop;
								}
							}
						break;
					}
				}
			}
		}
		
		private static function insertFirstInitInTraits(
			traits_infoV:Vector.<AdvanceTraits_info>,
			firstInitV:Vector.<Array>,
			markName:String
		):void{
			var firstInitResultMultinameName:AdvanceMultiname_info;
			for each(var traits_info:AdvanceTraits_info in traits_infoV){
				switch(traits_info.kind_trait_type){
					case TraitTypes.Method:
					//case TraitTypes.Getter:
					//case TraitTypes.Setter:
						var codeArr:Array=traits_info.methodi.codes.codeArr;
						var i:int=codeArr.length;
						while(--i>=0){
							if(TraceMarkName.checkIsTraceMarkName(codeArr,i,markName)){
								if(firstInitV.length){
									var firstInitArr:Array=firstInitV.pop();
									var multiname_info:AdvanceMultiname_info=firstInitArr[0];
									codeArr.splice(i,0,new Code(Op.getlex,multiname_info),new Code(Op.callpropvoid,{
										multiname_info:firstInitArr[1],
										args:0
									}));
									Outputer.output("　分离"+(multiname_info.ns.name?multiname_info.ns.name+"."+multiname_info.name:multiname_info.name)+".firstInitResult","green");
								}else{
									break;
								}
							}
						}
					break;
					//case TraitTypes.Function:
					//	traits_info.functioni.codes.codeArr
					//break;
				}
			}
		}
		public static function clearTraceMarkNames(swf:SWF2,markName:String="###runFirstInit()###"):void{
			var tag:Tag,advanceABC:AdvanceABC,clazz:AdvanceClass,script_info:AdvanceScript_info;
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						advanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
						for each(clazz in advanceABC.clazzV){
							clearTraceMarkName(clazz.itraits_infoV,markName);
							clearTraceMarkName(clazz.ctraits_infoV,markName);
						}
						for each(script_info in advanceABC.script_infoV){
							clearTraceMarkName(script_info.traits_infoV,markName);
						}
					break;
				}
			}
		}
		private static function clearTraceMarkName(
			traits_infoV:Vector.<AdvanceTraits_info>,
			markName:String
		):void{
			var firstInitResultMultinameName:AdvanceMultiname_info;
			for each(var traits_info:AdvanceTraits_info in traits_infoV){
				switch(traits_info.kind_trait_type){
					case TraitTypes.Method:
					//case TraitTypes.Getter:
					//case TraitTypes.Setter:
						TraceMarkName.clearTraceMarkName(traits_info.methodi.codes.codeArr,markName)
					break;
					//case TraitTypes.Function:
					//	traits_info.functioni.codes.codeArr
					//break;
				}
			}
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