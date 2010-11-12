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
	
	public class Advance{
		public static var test_tempArr:Array;
		//public static var test_total_new:int;
		public function Advance(){
			//trace(this+", test_total_new="+(++test_total_new));
		}
		
		
		public function initByInfo_fun(avm2Obj:AVM2Obj,memberV:Vector.<Member>,...rests):void{
			var restId:int=0;
			for each(var member:Member in memberV){
				if(member.curr==Member.CURR_CASE){
					if(rests[restId++]){
					}else{
						continue;
					}
				}
				
				if(Member.fromABCFileMark[member.type]){
					if(member.isList){
						AdvanceABC.currInstance.getInfoVByIdsAndMemberType(this,avm2Obj,member.name+"V",member.type);
					}else{
						//if(Member.directMark[member.type]){
							//
						//}else{
							//
						//}
						this[member.name]=AdvanceABC.currInstance.getInfoByIdAndMemberType(avm2Obj[member.name],member.type);
					}
				}else{
					if(member.isList){
						getInfoVByAVM2Objs(avm2Obj,member.name+"V",MemberClasses[member.type],MemberClasses[member.type+"VClass"]);
					}else if(member.constKindName){
						this[member.name]=AdvanceABC.currInstance.getConstValueByIdAndKind(member.name,avm2Obj[member.name],this[member.constKindName])
					}else{
						if(member.classV){
							this[member.name]=new (member.classV[this[member.classVIdName]])();
							this[member.name].initByInfo(avm2Obj[member.name]);
						}else{
							//if(member.kindClass){
							//	只在 toXML 或 initByXML 时有用
							//}eles if(member.flagClass){
							//	只在 toXML 或 initByXML 时有用
							//}eles{
								if(member.type==Member.DIRECT_INT){
									this[member.name]=avm2Obj[member.name];
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
		
		public function toInfo_fun(avm2Obj:AVM2Obj,memberV:Vector.<Member>):void{
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
						AdvanceABC.currInstance.getIdsByInfoVAndMemberType(this,avm2Obj,member.name+"V",member.type);
					}else{
						//if(Member.directMark[member.type]){
							//
						//}else{
							//
						//}
						avm2Obj[member.name]=AdvanceABC.currInstance.getIdByInfoAndMemberType(this[member.name],member.type);
					}
				}else{
					if(member.isList){
						getAVM2ObjsByInfoV(avm2Obj,member.name+"V",MemberClasses[member.type+"AVM2ObjClass"],MemberClasses[member.type+"AVM2ObjVClass"]);
					}else if(member.constKindName){
						avm2Obj[member.name]=AdvanceABC.currInstance.getIdByKindAndConstValue(this[member.constKindName],this[member.name]);
					}else{
						if(member.classV){
							avm2Obj[member.name]=this[member.name].toInfo();
						}else{
							if(member.type==Member.DIRECT_INT){
								avm2Obj[member.name]=this[member.name];
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
		
		public function toXML_fun(memberV:Vector.<Member>,xmlOrXMLName:*):XML{
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
				
				if(Member.fromABCFileMark[member.type]){
					if(member.isList){
						xml.appendChild(AdvanceABC.currInstance.getInfoListXMLByInfoVAndMemberType(this,member.name,member.type));
					}else{
						if(Member.directMark[member.type]){
							xml["@"+member.name]=this[member.name];
						}else{
							xml.appendChild(this[member.name].toXML(member.name));
						}
					}
				}else{
					if(member.isList){
						xml.appendChild(getInfoListXMLByInfoV(member.name,true));
					}else if(member.constKindName){
						AdvanceABC.currInstance.getXMLByKindAndConstValue(member.name,xml,this[member.constKindName],this[member.name]);
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
			return xml;
		}
		
		public function initByXML_fun(xml:XML,memberV:Vector.<Member>):void{
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
					this[member.name]=AdvanceABC.currInstance.marks[member.type][xml[member.name][0].@markKey.toString()];
					//trace("markKey this[member.name]="+this[member.name]);
					continue;
				}
				
				if(Member.fromABCFileMark[member.type]){
					if(member.isList){
						AdvanceABC.currInstance.getInfoVByInfoListXMLAndMemberType(this,member.name,xml,member.type);
					}else{
						if(Member.directMark[member.type]){
							this[member.name]=getValueByStringAndType(xml["@"+member.name].toString(),member.type);
						}else{
							this[member.name]=AdvanceABC.currInstance.getInfoByXMLAndMemberType(xml[member.name][0],member.type);
						}
					}
				}else{
					if(member.isList){
						getInfoVByInfoListXML(member.name,xml,MemberClasses[member.type],MemberClasses[member.type+"VClass"]);
					}else if(member.constKindName){
						AdvanceABC.currInstance.getConstValueByXMLAndKind(this,member.name,xml,this[member.constKindName]);
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
		
		public static function getValueByStringAndType(str:String,type:String):*{
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
		
		public function getInfoVByAVM2Objs(avm2Obj:AVM2Obj,infoVName:String,infoClass:Class,infoVClass:*):void{
			var avm2ObjV:*=avm2Obj[infoVName];
			var infoV:*=this[infoVName]=new infoVClass(avm2ObjV.length);
			var i:int=-1;
			for each(avm2Obj in avm2ObjV){
				i++;
				infoV[i]=new infoClass();
				infoV[i].initByInfo(avm2Obj);
			}
		}
		
		public function getAVM2ObjsByInfoV(avm2Obj:AVM2Obj,infoVName:String,avm2ObjClass:Class,avm2ObjVClass:*):void{
			var infoV:*=this[infoVName];
			var avm2ObjV:*=avm2Obj[infoVName]=new avm2ObjVClass(infoV.length);
			var i:int=-1;
			for each(var info:* in infoV){
				i++;
				avm2ObjV[i]=info.toInfo();
			}
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function getInfoListXMLByInfoV(name:String,isAdvance:Boolean):XML{
			var infoV:*=this[name+"V"];
			var infoListXML:XML=<{name+"List"} count={infoV.length}/>;
			for each(var info:* in infoV){
				if(isAdvance){
					infoListXML.appendChild(info.toXML(name));
				}else{
					infoListXML.appendChild(<{name} value={info}/>);
				}
			}
			return infoListXML;
		}
		
		public function getInfoVByInfoListXML(name:String,xml:XML,infoClass:Class,infoVClass:*):void{
			var infoXMLList:XMLList=xml[name+"List"][0][name];
			var i:int=-1;
			var infoV:*=this[name+"V"]=new infoVClass(infoXMLList.length());
			for each(var infoXML:XML in infoXMLList){
				i++;
				infoV[i]=new infoClass();
				infoV[i].initByXML(infoXML);
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