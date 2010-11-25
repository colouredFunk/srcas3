/***
Advance 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月23日 19:10:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import zero.swf.avm2.AVM2Obj;
	import zero.swf.avm2.Multiname_info;
	import zero.swf.vmarks.*;
	
	public class Advance{
		
		//public static var test_tempArr:Array;
		//public static var test_total_new:int;
		
		public function Advance(){
			//trace(this+", test_total_new="+(++test_total_new));
		}
		
		
		public function initByInfo_fun(advanceABC:AdvanceABC,mainAVM2Obj:AVM2Obj,memberV:Vector.<Member>,...rests):void{
			var restId:int=0,infoV:*,i:int;
			for each(var member:Member in memberV){
				if(member.curr==Member.CURR_CASE){
					if(rests[restId++]){
					}else{
						continue;
					}
				}
				
				if(Member.fromABCFileMark[member.type]){
					if(member.isList){
						var idV:Vector.<int>=mainAVM2Obj[member.name+"V"];
						infoV=this[member.name+"V"]=new MemberClasses[member.type+"VClass"](idV.length);
						i=-1;
						for each(var id:int in idV){
							i++;
							infoV[i]=advanceABC.getInfoByIdAndMemberType(id,member.type);
						}
					}else{
						//if(Member.directMark[member.type]){
							//
						//}else{
							//
						//}
						this[member.name]=advanceABC.getInfoByIdAndMemberType(mainAVM2Obj[member.name],member.type);
					}
				}else{
					if(member.isList){
						var avm2ObjV:*=mainAVM2Obj[member.name+"V"];
						infoV=this[member.name+"V"]=new MemberClasses[member.type+"VClass"](avm2ObjV.length);
						i=-1;
						for each(var avm2Obj:AVM2Obj in avm2ObjV){
							i++;
							infoV[i]=new MemberClasses[member.type]();
							infoV[i].initByInfo(advanceABC,avm2Obj);
						}
					}else if(member.constKindName){
						switch(this[member.constKindName]){
							case ConstantKind.Int:
								this[member.name]=advanceABC.getInfoByIdAndMemberType(mainAVM2Obj[member.name],Member.INTEGER);
							break;
							case ConstantKind.UInt:
								this[member.name]=advanceABC.getInfoByIdAndMemberType(mainAVM2Obj[member.name],Member.UINTEGER);
							break;
							case ConstantKind.Double:
								this[member.name]=advanceABC.getInfoByIdAndMemberType(mainAVM2Obj[member.name],Member.DOUBLE);
							break;
							case ConstantKind.Utf8:
								this[member.name]=advanceABC.getInfoByIdAndMemberType(mainAVM2Obj[member.name],Member.STRING);
							break;
							case ConstantKind.True:
							case ConstantKind.False:
							case ConstantKind.Null:
							case ConstantKind.Undefined:
								this[member.name]=this[member.constKindName];//看了几个 swf, id 都是 和 kind 相等
							break;
							case ConstantKind.Namespace:
							case ConstantKind.PackageNamespace:
							case ConstantKind.PackageInternalNs:
							case ConstantKind.ProtectedNamespace:
							case ConstantKind.ExplicitNamespace:
							case ConstantKind.StaticProtectedNs:
							case ConstantKind.PrivateNs:
								this[member.name]=advanceABC.getInfoByIdAndMemberType(mainAVM2Obj[member.name],Member.NAMESPACE_INFO);
							break;
							default:
								throw new Error("未知 kind: "+this[member.constKindName]);
							break;
						}
					}else{
						//if(member.kindClass){
						//	只在 toXML 或 initByXML 时有用
						//}eles if(member.flagClass){
						//	只在 toXML 或 initByXML 时有用
						//}eles{
							if(member.type==Member.DIRECT_INT){
								this[member.name]=mainAVM2Obj[member.name];
							}else{
								if(Member.directMark[member.type]){
									throw new Error("未处理");
								}else{
									throw new Error("未处理");
								}
							}
						//}
					}
				}
			}
		}
		public function toInfo_fun(advanceABC:AdvanceABC,mainAVM2Obj:AVM2Obj,memberV:Vector.<Member>):void{
			var infoV:*,i:int,info:*;
			for each(var member:Member in memberV){
				if(member.curr==Member.CURR_CASE){
					if(member.isList){
						if(this[member.name+"V"]){
						}else{
							continue;
						}
					}else{
						if(this[member.name]){
						}else{
							continue;
						}
					}
				}
				
				if(Member.fromABCFileMark[member.type]){
					if(member.isList){
						infoV=this[member.name+"V"];
						var idV:Vector.<int>=mainAVM2Obj[member.name+"V"]=new Vector.<int>(infoV.length);
						i=-1;
						for each(info in infoV){
							i++;
							idV[i]=advanceABC.getIdByInfoAndMemberType(info,member.type);
						}
					}else{
						//if(Member.directMark[member.type]){
							//
						//}else{
							//
						//}
						mainAVM2Obj[member.name]=advanceABC.getIdByInfoAndMemberType(this[member.name],member.type);
					}
				}else{
					if(member.isList){
						infoV=this[member.name+"V"];
						var avm2ObjV:*=mainAVM2Obj[member.name+"V"]=new MemberClasses[member.type+"AVM2ObjVClass"](infoV.length);
						i=-1;
						for each(info in infoV){
							i++;
							avm2ObjV[i]=info.toInfo(advanceABC);
						}
					}else if(member.constKindName){
						switch(this[member.constKindName]){
							case ConstantKind.Int:
								mainAVM2Obj[member.name]=advanceABC.getIdByInfoAndMemberType(this[member.name],Member.INTEGER);
							break;
							case ConstantKind.UInt:
								mainAVM2Obj[member.name]=advanceABC.getIdByInfoAndMemberType(this[member.name],Member.UINTEGER);
							break;
							case ConstantKind.Double:
								mainAVM2Obj[member.name]=advanceABC.getIdByInfoAndMemberType(this[member.name],Member.DOUBLE);
							break;
							case ConstantKind.Utf8:
								mainAVM2Obj[member.name]=advanceABC.getIdByInfoAndMemberType(this[member.name],Member.STRING);
							break;
							case ConstantKind.True:
							case ConstantKind.False:
							case ConstantKind.Null:
							case ConstantKind.Undefined:
								mainAVM2Obj[member.name]=this[member.constKindName];//看了几个 swf, id 都是 和 kind 相等
							break;
							case ConstantKind.Namespace:
							case ConstantKind.PackageNamespace:
							case ConstantKind.PackageInternalNs:
							case ConstantKind.ProtectedNamespace:
							case ConstantKind.ExplicitNamespace:
							case ConstantKind.StaticProtectedNs:
							case ConstantKind.PrivateNs:
								mainAVM2Obj[member.name]=advanceABC.getIdByInfoAndMemberType(this[member.name],Member.NAMESPACE_INFO);
							break;
							default:
								throw new Error("未知 kind: "+this[member.constKindName]);
							break;
						}
					}else{
						if(member.type==Member.DIRECT_INT){
							mainAVM2Obj[member.name]=this[member.name];
						}else{
							//if(member.kindClass){
							//	只在 toXML 或 initByXML 时有用
							//}eles if(member.flagClass){
							//	只在 toXML 或 initByXML 时有用
							//}eles{
								if(Member.directMark[member.type]){
									throw new Error("未处理");
								}else{
									throw new Error("未处理");
								}
							//}
						}
					}
				}
			}
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		protected static const useMarkKey:Boolean=function():Boolean{
			
			///*
			return true;
			//*/
			
			/*
			trace("测试模式: useMarkKey==false");
			return false;
			//*/
			
		}();
		public function toXML_fun(
			infoMark:InfoMark,
			memberV:Vector.<Member>,
			xml:XML=null
		):XML{
			if(xml){
			}else{
				var className:String=getQualifiedClassName(this);
				xml=<{className.substr(className.lastIndexOf("::")+2)}/>;
			}
			
			for each(var member:Member in memberV){
				if(member.curr==Member.CURR_CASE){
					//未考虑 int, uint, string 之类 为 0 或 "" 的情况
					if(member.isList){
						if(this[member.name+"V"]&&this[member.name+"V"].length){
						}else{
							continue;
						}
					}else{
						if(this[member.name]){
							
						}else{
							continue;
						}
					}
				}else{
					if(member.isList){
						if(this[member.name+"V"].length){
						}else{
							continue;
						}
					}
				}
				
				if(member.isList){
					var infoV:*=this[member.name+"V"];
					var info:*,infoXML:XML;
					var infoListXML:XML=<{member.name+"List"} count={infoV.length}/>;
					if(Member.directMark[member.type]){
						for each(info in infoV){
							infoListXML.appendChild(<{member.name} value={info}/>);
						}
					}else{
						for each(info in infoV){
							if(Member.useMarkKeyMark[member.type]){
								if(useMarkKey){
									infoListXML.appendChild(<{member.name} value={MarkStrs[member.type+"2markStr"](infoMark,info)}/>);
								}else{
									infoXML=MarkStrs[member.type+"2xml"](infoMark,info);
									infoXML.setName(member.name);
									infoListXML.appendChild(infoXML);
								}
							}else{
								infoXML=info.toXMLAndMark(infoMark);
								infoXML.setName(member.name);
								infoListXML.appendChild(infoXML);
							}
						}
					}
					xml.appendChild(infoListXML);
				}else{
					if(Member.fromABCFileMark[member.type]){
						if(Member.directMark[member.type]){
							xml["@"+member.name]=this[member.name];
						}else{
							if(Member.useMarkKeyMark[member.type]){
								if(useMarkKey){
									xml["@"+member.name]=MarkStrs[member.type+"2markStr"](infoMark,this[member.name]);
								}else{
									infoXML=MarkStrs[member.type+"2xml"](infoMark,this[member.name]);
									infoXML.setName(member.name);
									xml.appendChild(infoXML);
								}
							}else{
								infoXML=this[member.name].toXMLAndMark(infoMark);
								infoXML.setName(member.name);
								xml.appendChild(infoXML);
							}
						}
					}else{
						if(member.constKindName){
							switch(this[member.constKindName]){
								case ConstantKind.Int:
								case ConstantKind.UInt:
								case ConstantKind.Double:
								case ConstantKind.Utf8:
									xml["@"+member.name]=this[member.name];
								break;
								case ConstantKind.True:
								case ConstantKind.False:
								case ConstantKind.Null:
								case ConstantKind.Undefined:
								break;
								case ConstantKind.Namespace:
								case ConstantKind.PackageNamespace:
								case ConstantKind.PackageInternalNs:
								case ConstantKind.ProtectedNamespace:
								case ConstantKind.ExplicitNamespace:
								case ConstantKind.StaticProtectedNs:
								case ConstantKind.PrivateNs:
									if(this[member.name]){
										if(useMarkKey){
											xml["@"+member.name]=MarkStrs.namespace_info2markStr(infoMark,this[member.name]);
										}else{
											infoXML=MarkStrs.namespace_info2xml(infoMark,this[member.name]);
											infoXML.setName(member.name);
											xml.appendChild(infoXML);
										}
									}
								break;
								default:
									throw new Error("未知 kind: "+this[member.constKindName]);
								break;
							}
						}else{
							if(member.kindClass){
								xml["@"+member.name]=member.kindClass[member.kindVName][this[member.name]];
							}else if(member.flagClass){
								var flagsStr:String="";
								for each(var flagStr:String in member.flagClass["flagV"]){
									if(this[member.name]&member.flagClass[flagStr]){
										flagsStr+="|"+flagStr;
									}
								}
								xml["@"+member.name]=flagsStr.substr(1);
							}else{
								if(member.type==Member.DIRECT_INT){
									xml["@"+member.name]=this[member.name];
								}else{
									if(Member.directMark[member.type]){
										xml["@"+member.name]=this[member.name];
									}else{
										if(Member.useMarkKeyMark[member.type]){
											if(useMarkKey){
												xml["@"+member.name]=MarkStrs[member.type+"2markStr"](infoMark,this[member.name]);
											}else{
												infoXML=MarkStrs[member.type+"2xml"](infoMark,this[member.name]);
												infoXML.setName(member.name);
												xml.appendChild(infoXML);
											}
										}else{
											infoXML=this[member.name].toXMLAndMark(infoMark);
											infoXML.setName(member.name);
											xml.appendChild(infoXML);
										}
									}
								}
							}
						}
					}
				}
			}
			return xml;
		}
		public function initByXML_fun(
			infoMark:InfoMark,
			xml:XML,
			memberV:Vector.<Member>
		):void{
			var infoXMLList:XMLList,i:int,infoV:*,infoXML:XML;
			for each(var member:Member in memberV){
				//if(member.name=="protectedNs"){
				//	trace("member.name="+member.name);
				//}
				if(member.curr==Member.CURR_CASE){
					if(member.isList){
						if(xml[member.name+"List"].length()){
						}else{
							continue;
						}
					}else{
						if(
							Member.useMarkKeyMark[member.type]&&xml["@"+member.name].length()
							||
							xml[member.name].length()){
						}else{
							continue;
						}
					}
				}else{
					if(member.isList){
						if(xml[member.name+"List"].length()){
						}else{
							this[member.name+"V"]=new MemberClasses[member.type+"VClass"]();
							continue;
						}
					}
				}
				//if(member.name=="protectedNs"){
				//	trace("member.name="+member.name+"--------------");
				//}
				
				
				if(Member.fromABCFileMark[member.type]){
					if(member.isList){
						infoXMLList=xml[member.name+"List"][0][member.name];
						i=-1;
						infoV=this[member.name+"V"]=new MemberClasses[member.type+"VClass"](infoXMLList.length());
						if(Member.directMark[member.type]){
							for each(infoXML in infoXMLList){
								i++;
								switch(member.type){
									case Member.INTEGER:
										infoV[i]=int(infoXML.@value.toString());
									break;
									case Member.UINTEGER:
										infoV[i]=int(infoXML.@value.toString());
									break;
									case Member.DOUBLE:
										infoV[i]=Number(infoXML.@value.toString());
									break;
									case Member.STRING:
										infoV[i]=infoXML.@value.toString();
									break;
								}
							}
						}else{
							for each(infoXML in infoXMLList){
								i++;
								if(Member.useMarkKeyMark[member.type]){
									if(/<\w+ value=".*?"\/>/.test(infoXML.toXMLString())){
										infoV[i]=MarkStrs["markStr2"+member.type](infoMark,infoXML.@value.toString());
									}else{
										infoV[i]=MarkStrs["xml2"+member.type](infoMark,infoXML);
									}
								}else{
									infoV[i]=new MemberClasses[member.type]();
									infoV[i].initByXMLAndMark(infoMark,infoXML);
								}
							}
						}
					}else{
						if(Member.directMark[member.type]){
							switch(member.type){
								case Member.INTEGER:
									this[member.name]=int(xml["@"+member.name].toString());
								break;
								case Member.UINTEGER:
									this[member.name]=int(xml["@"+member.name].toString());
								break;
								case Member.DOUBLE:
									this[member.name]=Number(xml["@"+member.name].toString());
								break;
								case Member.STRING:
									this[member.name]=xml["@"+member.name].toString();
								break;
							}
						}else{
							if(Member.useMarkKeyMark[member.type]){
								if(xml["@"+member.name].length()){
									this[member.name]=MarkStrs["markStr2"+member.type](infoMark,xml["@"+member.name].toString());
								}else{
									this[member.name]=MarkStrs["xml2"+member.type](infoMark,xml[member.name][0]);
								}
							}else{
								this[member.name]=new MemberClasses[member.type]();
								this[member.name].initByXMLAndMark(infoMark,xml[member.name][0]);
							}
							//if(member.name=="protectedNs"){
							//	trace("this[member.name]="+this[member.name]);
							//}
						}
					}
				}else{
					if(member.isList){
						infoXMLList=xml[member.name+"List"][0][member.name];
						i=-1;
						infoV=this[member.name+"V"]=new MemberClasses[member.type+"VClass"](infoXMLList.length());
						for each(infoXML in infoXMLList){
							i++;
							if(Member.useMarkKeyMark[member.type]){
								if(/<\w+ value=".*?"\/>/.test(infoXML.toXMLString())){
									infoV[i]=MarkStrs["markStr2"+member.type](infoMark,infoXML.@value.toString());
								}else{
									infoV[i]=MarkStrs["xml2"+member.type](infoMark,infoXML);
								}
							}else{
								infoV[i]=new MemberClasses[member.type]();
								infoV[i].initByXMLAndMark(infoMark,infoXML);
							}
						}
					}else if(member.constKindName){
						switch(this[member.constKindName]){
							case ConstantKind.Int:
								this[member.name]=int(xml["@"+member.name].toString());
							break;
							case ConstantKind.UInt:
								this[member.name]=int(xml["@"+member.name].toString());
							break;
							case ConstantKind.Double:
								this[member.name]=Number(xml["@"+member.name].toString());
							break;
							case ConstantKind.Utf8:
								this[member.name]=xml["@"+member.name].toString();
							break;
							case ConstantKind.True:
							case ConstantKind.False:
							case ConstantKind.Null:
							case ConstantKind.Undefined:
								this[member.name]=this[member.constKindName];//看了几个 swf, id 都是 和 kind 相等
							break;
							case ConstantKind.Namespace:
							case ConstantKind.PackageNamespace:
							case ConstantKind.PackageInternalNs:
							case ConstantKind.ProtectedNamespace:
							case ConstantKind.ExplicitNamespace:
							case ConstantKind.StaticProtectedNs:
							case ConstantKind.PrivateNs:
								if(xml["@"+member.name].length()){
									this[member.name]=MarkStrs.markStr2namespace_info(infoMark,xml["@"+member.name].toString());
								}else{
									this[member.name]=MarkStrs.xml2namespace_info(infoMark,xml[member.name][0]);
								}
							break;
							default:
								throw new Error("未知 kind: "+this[member.constKindName]);
							break;
						}
					}else{
						if(member.kindClass){
							this[member.name]=member.kindClass[xml["@"+member.name].toString()];
						}else if(member.flagClass){
							this[member.name]=0;
							for each(var flagStr:String in xml["@"+member.name].toString().split("|")){
								this[member.name]|=member.flagClass[flagStr];
							}
						}else{
							if(member.type==Member.DIRECT_INT){
								this[member.name]=int(xml["@"+member.name].toString());
							}else{
								if(Member.directMark[member.type]){
									switch(member.type){
										case Member.INTEGER:
											this[member.name]=int(xml["@"+member.name].toString());
										break;
										case Member.UINTEGER:
											this[member.name]=int(xml["@"+member.name].toString());
										break;
										case Member.DOUBLE:
											this[member.name]=Number(xml["@"+member.name].toString());
										break;
										case Member.STRING:
											this[member.name]=xml["@"+member.name].toString();
										break;
									}
								}else{
									throw new Error("未处理");
								}
							}
						}
					}
				}
			}
		}
		
		////
		
		public function toXMLAndMark(infoMark:InfoMark):XML{
			return toXML_fun(infoMark,this["constructor"].memberV);
		}
		public function initByXMLAndMark(infoMark:InfoMark,xml:XML):void{
			initByXML_fun(infoMark,xml,this["constructor"].memberV);
		}
		}//end of CONFIG::toXMLAndInitByXML
		
		/*
		private function getGenericNameByArr(infoMark:InfoMark,multiname_info:AdvanceMultiname_info,arr:Array):void{
			multiname_info.TypeDefinition=getInfoByXMLOrMarkStr(infoMark,arr[0]);
			multiname_info.ParamV=new Vector.<AdvanceMultiname_info>();
			arr=arr[1];
			var i:int=0;
			var L:int=arr.length;
			while(i<L){
				var Param:*=arr[i++];
				if(Param is Array){
					if(Param.length==1&&Param[0]==="GenericName"){
						multiname_info.ParamV.push(getInfoByXMLOrMarkStr(infoMark,"[GenericName]"+arr2str(arr[i++])));
					}else{
						throw new Error("不合法的 Param: "+Param);
					}
				}
			}
		}
		private static function getArrFromXMLList(xmlList:XMLList):Array{
			//从包含嵌套中括号的字符串中整理出数组来
			//getArrFromStr_getArrFromXMLList(
			//	new XMLList(str.replace(/\[/g,"<node>").replace(/\]/g,"</node>"))
			//);
			var arr:Array=new Array();
			var i:int=0;
			for each(var xml:XML in xmlList){
				if(String(xml.name())==="node"){
					arr[i++]=getArrFromXMLList(xml.children());
				}else{
					arr[i++]=xml.toString();
				}
			}
			return arr;
		}
		private static function arr2str(arr:Array):String{
			var str:String="";
			for each(var element:* in arr){
				if(element is Array){
					str+=","+arr2str(element);
				}else{
					str+=","+element;
				}
			}
			return "["+str.substr(1)+"]";
		}
		//*/
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