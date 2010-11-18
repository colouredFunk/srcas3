/***
Advance 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月23日 19:10:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import flash.utils.getQualifiedClassName;
	
	import zero.swf.avm2.AVM2Obj;
	import zero.swf.vmarks.ConstantKind;
	
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
						this[member.name]=advanceABC.getConstValueByIdAndKind(member.name,mainAVM2Obj[member.name],this[member.constKindName])
					}else{
						if(member.classV){
							this[member.name]=new (member.classV[this[member.classVIdName]])();
							this[member.name].initByInfo(advanceABC,mainAVM2Obj[member.name]);
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
						mainAVM2Obj[member.name]=advanceABC.getIdByKindAndConstValue(this[member.constKindName],this[member.name]);
					}else{
						if(member.classV){
							mainAVM2Obj[member.name]=this[member.name].toInfo(advanceABC);
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
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML_fun(
			memberV:Vector.<Member>,
			xmlOrXMLName:*
		):XML{
			var className:String=getQualifiedClassName(this);
			var xml:XML;
			if(xmlOrXMLName is String){
				xml=<{xmlOrXMLName} class={className.substr(className.lastIndexOf("::")+2)}/>;
			}else{
				xml=xmlOrXMLName;
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
				
				if(member.xmlUseMarkKey){
					xml.appendChild(<{member.name} markKey={this[member.name].getMarkKey()}/>);
					continue;
				}
				
				if(member.isList){
					var infoV:*=this[member.name+"V"];
					var info:*;
					var infoListXML:XML=<{member.name+"List"} count={infoV.length}/>;
					if(Member.directMark[member.type]){
						for each(info in infoV){
							infoListXML.appendChild(<{member.name} value={info}/>);
						}
					}else{
						for each(info in infoV){
							infoListXML.appendChild(info.toXML(member.name));
						}
					}
					xml.appendChild(infoListXML);
				}else{
					if(Member.fromABCFileMark[member.type]){
						if(Member.directMark[member.type]){
							xml["@"+member.name]=this[member.name];
						}else{
							xml.appendChild(this[member.name].toXML(member.name));
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
										xml.appendChild(this[member.name].toXML(member.name));
									}
								break;
								default:
									throw new Error("未知 kind: "+this[member.constKindName]);
								break;
							}
						}else{
							if(member.classV){
								xml.appendChild(this[member.name].toXML(member.name));
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
											xml.appendChild(this[member.name].toXML(member.name));
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
		public function initByXML_fun(marks:Object,xml:XML,memberV:Vector.<Member>):void{
			var infoXMLList:XMLList,i:int,infoV:*,infoXML:XML;
			for each(var member:Member in memberV){
				if(member.curr==Member.CURR_CASE){
					if(member.isList){
						if(xml[member.name+"List"].length()){
						}else{
							continue;
						}
					}else{
						if(xml[member.name].length()){
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
				
				if(member.xmlUseMarkKey){
					//trace("markKey="+xml[member.name][0].@markKey.toString());
					this[member.name]=marks[member.type][xml[member.name][0].@markKey.toString()];
					//trace("markKey this[member.name]="+this[member.name]);
					continue;
				}
				
				if(Member.fromABCFileMark[member.type]){
					if(member.isList){
						infoXMLList=xml[member.name+"List"][0][member.name];
						i=-1;
						infoV=this[member.name+"V"]=new MemberClasses[member.type+"VClass"](infoXMLList.length());
						if(Member.directMark[member.type]){
							for each(infoXML in infoXMLList){
								i++;
								infoV[i]=getValueByStringAndType(infoXML.@value.toString(),member.type);
							}
						}else{
							for each(infoXML in infoXMLList){
								i++;
								infoV[i]=getInfoByXMLAndMemberType(marks,infoXML,member.type);
							}
						}
					}else{
						if(Member.directMark[member.type]){
							this[member.name]=getValueByStringAndType(xml["@"+member.name].toString(),member.type);
						}else{
							this[member.name]=getInfoByXMLAndMemberType(marks,xml[member.name][0],member.type);
						}
					}
				}else{
					if(member.isList){
						infoXMLList=xml[member.name+"List"][0][member.name];
						i=-1;
						infoV=this[member.name+"V"]=new MemberClasses[member.type+"VClass"](infoXMLList.length());
						for each(infoXML in infoXMLList){
							i++;
							infoV[i]=new MemberClasses[member.type]();
							infoV[i].initByXML(marks,infoXML);
						}
					}else if(member.constKindName){
						switch(this[member.constKindName]){
							case ConstantKind.Int:
								this[member.name]=getValueByStringAndType(xml["@"+member.name].toString(),Member.INTEGER);
							break;
							case ConstantKind.UInt:
								this[member.name]=getValueByStringAndType(xml["@"+member.name].toString(),Member.UINTEGER);
							break;
							case ConstantKind.Double:
								this[member.name]=getValueByStringAndType(xml["@"+member.name].toString(),Member.DOUBLE);
							break;
							case ConstantKind.Utf8:
								this[member.name]=getValueByStringAndType(xml["@"+member.name].toString(),Member.STRING);
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
								this[member.name]=getInfoByXMLAndMemberType(marks,xml[member.name][0],Member.NAMESPACE_INFO);
							break;
							default:
								throw new Error("未知 kind: "+this[member.constKindName]);
							break;
						}
					}else{
						if(member.classV){
							this[member.name]=new (member.classV[this[member.classVIdName]])();
							this[member.name].initByXML(xml[member.name][0]);
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
										this[member.name]=getValueByStringAndType(xml["@"+member.name].toString(),member.type);
									}else{
										//this[member.name]=new (member.classV[this[member.classVIdName]])();
										//this[member.name].initByXML(xml[member.name][0]);
										throw new Error("未处理");
									}
								}
							}
						}
					}
				}
			}
		}
		
		private static function getValueByStringAndType(str:String,type:String):*{
			switch(type){
				case Member.INTEGER:
					return int(str);
				break;
				case Member.UINTEGER:
					return uint(str);
				break;
				case Member.DOUBLE:
					return Number(str);
				break;
				case Member.STRING:
					return str;
				break;
			}
			throw new Error("getValueByStringAndType 不支持的 type: "+type);
			return undefined;
		}
		public function getInfoByXMLAndMemberType(marks:Object,xml:XML,memberType:String):*{
			if(memberType==Member.MULTINAME_INFO){
				if(xml.@kind.toString()=="*"){
					return AdvanceDefaultMultiname_info.instance;
				}
			}
			
			var oldXMLName:String=xml.name().toString();
			xml.setName(memberType);
			var markKey:String=xml.toXMLString();
			xml.setName(oldXMLName);
			
			var info:*=marks[memberType][markKey];
			
			if(info){
			}else{
				marks[memberType][markKey]=info=new MemberClasses[memberType]();
				info.initByXML(marks,xml);
				//advanceABC[memberType+"V"][advanceABC[memberType+"V"].length]=info;
			}
			
			//if(info is AdvanceNamespace_info){
			//	trace(xml.toXMLString());
			//	trace("info="+info);
			//}
			return info;
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