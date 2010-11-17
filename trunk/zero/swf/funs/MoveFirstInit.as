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
						for each(var clazz:AdvanceClass in advanceABC.classV){
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
								var codeV:Vector.<BaseCode>=clazz.cinit.codes.codeV;
								var i:int=codeV.length;
								while(--i>=0){
									var advanceCode:AdvanceCode=codeV[i] as AdvanceCode;
									if(
										advanceCode
										&&
										advanceCode.op==Op.findproperty
										&&
										advanceCode.value==firstInitResultMultinameName
									){
										var newfunctionCode:AdvanceCode=codeV[i+1] as AdvanceCode;
										if(
											newfunctionCode
											&&
											newfunctionCode.op==Op.newfunction
										){
											var getglobalscopeCode:AdvanceCode=codeV[i+2] as AdvanceCode;
											if(
												getglobalscopeCode
												&&
												getglobalscopeCode.op==Op.getglobalscope
											){
												var callCode:AdvanceCode=codeV[i+3] as AdvanceCode;
												if(
													callCode
													&&
													callCode.op==Op.call
													&&
													callCode.value==0
												){
													var initpropertyCode:AdvanceCode=codeV[i+4] as AdvanceCode;
													if(
														initpropertyCode
														&&
														initpropertyCode.op==Op.initproperty
														&&
														initpropertyCode.value===firstInitResultMultinameName
													){
														codeV.splice(i,5);
														methodTraits_info.methodi=newfunctionCode.value;
														methodTraits_info.methodi.max_scope_depth++;
														methodTraits_info.methodi.codes.codeV.splice(0,0,new AdvanceCode(Op.getlocal0),new AdvanceCode(Op.pushscope));
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
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
						for each(var clazz:AdvanceClass in advanceABC.classV){
							insertFirstInitInTraits(clazz.itraits_infoV,firstInitV,markName);
							if(firstInitV.length){
							}else{
								return;
							}
							insertFirstInitInTraits(clazz.ctraits_infoV,firstInitV,markName);
							if(firstInitV.length){
							}else{
								return;
							}
						}
						for each(var script_info:AdvanceScript_info in advanceABC.script_infoV){
							insertFirstInitInTraits(script_info.traits_infoV,firstInitV,markName);
							if(firstInitV.length){
							}else{
								return;
							}
						}
					break;
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
						var codeV:Vector.<BaseCode>=traits_info.methodi.codes.codeV;
						var i:int=codeV.length;
						while(--i>=0){
							var advanceCode:AdvanceCode=codeV[i] as AdvanceCode;
							if(
								advanceCode
								&&
								advanceCode.op==Op.findpropstrict
								&&
								advanceCode.value.name=="trace"
							){
								advanceCode=codeV[i+1] as AdvanceCode;
								if(
									advanceCode
									&&
									advanceCode.op==Op.pushstring
									&&
									advanceCode.value==markName
								){
									advanceCode=codeV[i+2] as AdvanceCode;
									if(
										advanceCode
										&&
										advanceCode.op==Op.callpropvoid
										&&
										advanceCode.value.multiname_info.name=="trace"
									){
										codeV.splice(i,3);
										
										var firstInitArr:Array=firstInitV.pop();
										
										codeV.splice(i,0,new AdvanceCode(Op.getlex,firstInitArr[0]),new AdvanceCode(Op.callpropvoid,{
											multiname_info:firstInitArr[1],
											args:0
										}));
									}
								}
							}
						}
					break;
					//case TraitTypes.Function:
					//	traits_info.functioni.codes.codeV
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