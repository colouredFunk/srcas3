/***
Mixer 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 09:34:03
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class Mixer{
		public static var testing:Boolean;
		
		private static var classNameMark:Object;
		private static var strMark:Object;
		private static var objAndValIdDict:Dictionary;
		private static var noMixStrMark:Object;
		private static var noMixClassMark:Object;
		private static var replaceStrMark:Object;
		public static function mix(
			swfOrSWFArr:*,
			noMixStrArr:Array=null,
			noMixClassArr:Array=null,
			replaceStr0Arr:Array=null,
			replaceStrtArr:Array=null
		):void{
			//支持关联混合（对多个swf进行混合，相同的字符串混淆后仍然相同）
			var swf:SWF2,abcFile:ABCFile;
			
			trace("未处理override系统类属性的情况");
			trace("swfOrSWFArr="+swfOrSWFArr);
			
			if(swfOrSWFArr is Array){
			}else{
				swfOrSWFArr=[swfOrSWFArr];
			}
			
			noMixStrMark=new Object();
			for each(var noMixStr:String in noMixStrArr){
				noMixStrMark["~"+noMixStr]=true;
			}
			
			noMixClassMark=new Object();
			for each(var noMixClass:String in noMixClassArr){
				noMixClassMark["~"+noMixClass]=true;
			}
			
			replaceStrMark=new Object();
			var i:int=0;
			for each(var replaceStr0:String in replaceStr0Arr){
				replaceStrMark["~"+replaceStr0]=replaceStrtArr[i++];
			}
			
			strMark=new Object();
			for each(swf in swfOrSWFArr){
				classNameMark=getClassNames(swf);//遍历所有clazz获取可替换的类名，其余类名将被当作系统类
				
				objAndValIdDict=new Dictionary();
				
				getObjAndValIds(swf);
				
				var obj:*,valIdMark:Object,_valId:String;
				for(obj in objAndValIdDict){
					valIdMark=objAndValIdDict[obj];
					for(_valId in valIdMark){
						getMixStrAndMark(obj[_valId.substr(1)]);
					}
				}
				
				getRestNameObjAndValIds(swf);//根据已记录在 strMark 中的 string 对 namespace_infoV，ns_set_infoV，multiname_infoV 等进行遍历
				
				for(obj in objAndValIdDict){
					valIdMark=objAndValIdDict[obj];
					for(_valId in valIdMark){
						var valId:String=_valId.substr(1);
						obj[valId]=strMark["~"+obj[valId]];
					}
				}
			}
			
			classNameMark=null;
			strMark=null;
			objAndValIdDict=null;
			noMixStrMark=null;
			replaceStrMark=null;
		}
		private static function getMixStrAndMark(string:String):void{
			var dotMatchArr:Array=string.match(/[.:]+/g);
			var str:String;
			if(dotMatchArr){
				var str_arr:Array=string.split(/[.:]+/);
				var i:int=str_arr.length;
				while(--i>=0){
					str=str_arr[i];
					if(str){
						if(strMark["~"+str]){
						}else{
							if(replaceStrMark["~"+str] is String){
								strMark["~"+str]=replaceStrMark["~"+str];
							}else{
								if(testing){
									strMark["~"+str]="~"+str;
								}else{
									strMark["~"+str]=RandomStrs.getRan();
								}
							}
						}
						str_arr[i]=strMark["~"+str];
					}
				}
				var mixString:String=str_arr.shift();
				i=-1;
				for each(str in str_arr){
					i++;
					mixString+=dotMatchArr[i];
					mixString+=str_arr[i];
				}
				strMark["~"+string]=mixString;
			}else{
				if(strMark["~"+string]){
				}else{
					if(replaceStrMark["~"+string] is String){
						strMark["~"+string]=replaceStrMark["~"+string];
					}else{
						if(testing){
							strMark["~"+string]="~"+string;
						}else{
							strMark["~"+string]=RandomStrs.getRan();
						}
					}
				}
			}
		}
		private static function getClassNames(swf:SWF2):Object{
			var classNameMark:Object=new Object();
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
						for each(var clazz:AdvanceClass in advanceABC.clazzV){
							var className:AdvanceMultiname_info=clazz.name;
							var subMark:Object=classNameMark["~"+className.ns.name];
							if(subMark){
							}else{
								classNameMark["~"+className.ns.name]=subMark=new Object();
							}
							subMark["~"+className.name]=true;
						}
					break;
				}
			}
			return classNameMark;
		}
		private static function getRestNameObjAndValIds(swf:SWF2):void{
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
						for each(var namespace_info:AdvanceNamespace_info in advanceABC.namespace_infoV){
							if(namespace_info&&namespace_info.name){
								if(strMark["~"+namespace_info.name]){
									getObjAndValId(namespace_info,"name");
								}
							}
						}
						for each(var multiname_info:AdvanceMultiname_info in advanceABC.multiname_infoV){
							if(multiname_info&&multiname_info.name){
								if(strMark["~"+multiname_info.name]){
									getObjAndValId(multiname_info,"name");
								}
							}
						}
					break;
				}
			}
		}
		private static function getObjAndValIds(swf:SWF2):void{
			//trace("swf------------------------------");
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						getObjAndValIdByAdvanceABC((tag.getBody() as DoABCWithoutFlagsAndName).abc);
					break;
					case TagType.SymbolClass:
						getObjAndValIdBySymbolClass(tag.getBody() as SymbolClass);
					break;
					case TagType.PlaceObject2:
						getObjAndValId(tag.getBody() as PlaceObject2,"Name");//和部分 traits_info 有关
					break;
					case TagType.PlaceObject2:
						getObjAndValId(tag.getBody() as PlaceObject3,"Name");//和部分 traits_info 有关
					break;
				}
			}
		}
		private static function checkQNameIsNoMixClass(multiname_info:AdvanceMultiname_info):Boolean{
			if(multiname_info.kind==MultinameKind.QName){
				var className:String=multiname_info.getMultiname();
				//trace("className="+className);
				for each(var str:String in className.split(/[.:]+/)){
					if(noMixClassMark["~"+str]){
						return true;
					}
				}
				if(noMixClassMark["~"+className]){
					return true;
				}
			}else{
				throw new Error("multiname_info.kind="+multiname_info.kind+","+MultinameKind.kindV[multiname_info.kind]);
			}
			return false;
		}
		private static function checkNamespaceIsNoMixClass(namespace_info:AdvanceNamespace_info):Boolean{
			for each(var className:String in namespace_info.name.split(/[.:]+/)){
				//trace("className="+className);
				if(noMixClassMark["~"+className]){
					return true;
				}
			}
			return false;
		}
		private static function getObjAndValIdByAdvanceABC(advanceABC:AdvanceABC):void{
			for each(var clazz:AdvanceClass in advanceABC.clazzV){
				if(checkQNameIsNoMixClass(clazz.name)){
					continue;
				}
				if(clazz.protectedNs){
					if(checkNamespaceIsNoMixClass(clazz.protectedNs)){
						continue;
					}
				}
				getObjAndValIdByQName(clazz.name);
				getObjAndValIdByQName(clazz.super_name,classNameMark);
				getObjAndValId(clazz.protectedNs,"name");
				getObjAndValIdByMethod(clazz.iinit);
				getObjAndValIdByTraits_infoV(clazz.itraits_infoV);
				getObjAndValIdByMethod(clazz.cinit);
				getObjAndValIdByTraits_infoV(clazz.ctraits_infoV);
			}
			for each(var script_info:AdvanceScript_info in advanceABC.script_infoV){
				getObjAndValIdByMethod(script_info.init);
				getObjAndValIdByTraits_infoV(script_info.traits_infoV);
			}
		}
		private static function getObjAndValIdByTraits_infoV(traits_infoV:Vector.<AdvanceTraits_info>):void{
			for each(var traits_info:AdvanceTraits_info in traits_infoV){
				//trace(TraitTypes.typeV[traits_info.kind_trait_type]);
				switch(traits_info.kind_trait_type){
					case TraitTypes.Slot:
					case TraitTypes.Const:
					break;
					case TraitTypes.Method:
					case TraitTypes.Getter:
					case TraitTypes.Setter:
						getObjAndValIdByMethod(traits_info.methodi);
					break;
					case TraitTypes.Function:
						getObjAndValIdByMethod(traits_info.functioni);
					break;
					case TraitTypes.Clazz:
						if(checkQNameIsNoMixClass(traits_info.name)){
							continue;
						}
					break;
				}
				
				getObjAndValIdByQName(traits_info.name);
			}
		}
		private static function getObjAndValIdByMethod(method:AdvanceMethod):void{
			getObjAndValIdByQName(method.return_type,classNameMark);
			getObjAndValIdByTraits_infoV(method.traits_infoV);
		}
		private static function getObjAndValIdByQName(multiname_info:AdvanceMultiname_info,classNameMark:Object=null):void{
			if(multiname_info){
				if(multiname_info.kind==MultinameKind.QName){
					if(classNameMark){
						if(classNameMark["~"+multiname_info.ns.name]){
							if(classNameMark["~"+multiname_info.ns.name]["~"+multiname_info.name]){
							}else{
								return;
							}
						}else{
							return;
						}
					}
					getObjAndValId(multiname_info,"name");
					getObjAndValId(multiname_info.ns,"name");
				}//else{
					//throw new Error("multiname_info.kind="+multiname_info.kind+","+MultinameKind.kindV[multiname_info.kind]);
				//}
			}
		}
		private static function getObjAndValIdBySymbolClass(symbolClass:SymbolClass):void{
			var valId:int=0;
			for each(var Name:String in symbolClass.NameV){
				getObjAndValId(symbolClass.NameV,valId++);
			}
		}
		private static function getObjAndValId(obj:*,valId:*):void{
			if(obj){
				var string:String=obj[valId];
				if(string){
					//trace("string="+string);
					//if(string=="FWAd_AS3"){
					//	throw new Error("哈哈");
					//}
					if(noMixStrMark["~"+string]){
						return;
					}
					var valIdMark:Object=objAndValIdDict[obj];
					if(valIdMark){
					}else{
						objAndValIdDict[obj]=valIdMark=new Object();
					}
					
					/*
					if(valIdMark["~"+valId]){
					}else{
						var objClassName:String=getQualifiedClassName(obj);
						trace(objClassName.substr(objClassName.lastIndexOf(":")+1)+"."+valId+"="+string);
					}
					//*/
					
					//valIdMark["~"+valId]=string;
					valIdMark["~"+valId]=true;
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