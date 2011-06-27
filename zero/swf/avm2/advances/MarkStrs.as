/***
MarkStrs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月23日 19:56:42
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.vmarks.*;
	
	public class MarkStrs{
		public static function method2markStr(infoMark:InfoMark,method:AdvanceMethod):String{
			if(method){
				var markStr:String=infoMark.markStrDict[method];
				if(markStr is String){
					return markStr;
				}
				
				if(method.param_typeV.length){
					markStr="";
					var paramId:int=0;
					var param_type:AdvanceMultiname_info;
					if(method.param_nameV){
						for each(param_type in method.param_typeV){
							markStr+=","+method.param_nameV[paramId++]+":"+multiname_info2markStr(infoMark,param_type);
						}
					}else{
						for each(param_type in method.param_typeV){
							markStr+=",param"+(paramId++)+":"+multiname_info2markStr(infoMark,param_type);
						}
					}
					markStr="function("+markStr.substr(1)+"):";
				}else{
					markStr="function():";
				}
				markStr+=multiname_info2markStr(infoMark,method.return_type)+"{...}";
				if(infoMark.method["~"+markStr]){
					var specialId:int=1;
					while(infoMark.method["~"+markStr+"("+(++specialId)+")"]){}
					markStr+="("+specialId+")";
				}
				
				infoMark.method["~"+markStr]=method;
				infoMark.markStrDict[method]=markStr;
				
				return markStr;
			}
			throw new Error("method="+method);
			return null;
		}
		public static function method2xml(infoMark:InfoMark,method:AdvanceMethod):XML{
			var xml:XML=infoMark.xmlDict[method];
			if(xml){
			}else{
				var markStr:String=infoMark.markStrDict[method];
				if(markStr is String){
				}else{
					markStr=method2markStr(infoMark,method);
				}
				xml=method.toXMLAndMark(infoMark);
				var infoId:int=int(markStr.replace(/^.*\((\d+)\)$/,"$1"));
				if(infoId>1){
					xml.@infoId=infoId;
				}
				infoMark.xmlDict[method]=xml;
			}
			return xml.copy();
		}
		
		public static function namespace_info2markStr(infoMark:InfoMark,namespace_info:AdvanceNamespace_info):String{
			if(namespace_info){
				//获取 namespace_info 的最简 markStr(自动计算 infoId)
				var markStr:String=infoMark.markStrDict[namespace_info];
				if(markStr is String){
					return markStr;
				}
				
				//计算 infoId
				markStr=get_namespace_info_markStr("["+NamespaceKind.kindV[namespace_info.kind]+"]"+namespace_info.name);
				if(infoMark.namespace_info["~"+markStr]){
					var infoId:int=1;
					while(infoMark.namespace_info["~"+markStr+"("+(++infoId)+")"]){};
					markStr+="("+infoId+")";
				}
				//
				
				infoMark.namespace_info["~"+markStr]=namespace_info;
				infoMark.markStrDict[namespace_info]=markStr;
				
				return markStr;
			}
			throw new Error("namespace_info="+namespace_info);
			return null;
		}
		public static function namespace_infoXML2markStr(infoMark:InfoMark,xml:XML):String{
			//获取 namespace_info 的 xml 的最简 markStr
			return get_namespace_info_markStr("["+xml.@kind.toString()+"]"+xml.@name.toString()+"("+int(xml.@infoId.toString())+")");
		}
		private static function get_namespace_info_markStr(markStr:String):String{
			//获取最简 markStr
			//[kind]name(infoId)
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec(""));					//,,,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("(1)"));					//(1),,,1
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("name"));				//name,,name,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("name(1)"));				//name(1),,name,1
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]"));				//[kind],kind,,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind](1)"));			//[kind](1),kind,,1
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]name"));			//[kind]name,kind,name,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]name(1)"));		//[kind]name(1),kind,name,1
			
			var execResult:Array=/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec(markStr);
			//trace("execResult="+execResult.slice(1));
			if(execResult[0]===markStr){
				
				var kind:int=NamespaceKind[execResult[1]];
				if(kind>0){
					if(kind==NamespaceKind.PackageNamespace){
						markStr=execResult[2];
					}else{
						markStr="["+NamespaceKind.kindV[kind]+"]"+execResult[2];
					}
				}else{
					markStr=execResult[2];
				}
				
				//计算 infoId
				var infoId:int=int(execResult[3]);
				if(infoId>1){
					markStr+="("+infoId+")";
				}
				//
				
				return markStr;
				
			}
			throw new Error("不合法的 markStr: "+markStr);
			return null;
		}
		/*
		private static function get_namespace_info_fullMarkStr(markStr:String):String{
			//[kind]name(infoId)
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec(""));					//,,,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("(1)"));					//(1),,,1
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("name"));				//name,,name,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("name(1)"));				//name(1),,name,1
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]"));				//[kind],kind,,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind](1)"));			//[kind](1),kind,,1
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]name"));			//[kind]name,kind,name,
			//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]name(1)"));		//[kind]name(1),kind,name,1
			
			var execResult:Array=/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec(markStr);
			if(execResult[0]===markStr){
				var infoId:int=int(execResult[3]);
				if(infoId>1){
				}else{
					infoId=1;
				}
				return "["+
					(execResult[1]||NamespaceKind.kindV[NamespaceKind.PackageNamespace])+
					"]"+
					execResult[2]+
					"("+
					infoId+
					")";
				
			}
			throw new Error("不合法的 markStr: "+markStr);
			return null;
		}
		//*/
		
		public static function ns_set_info2markStr(infoMark:InfoMark,ns_set_info:AdvanceNs_set_info):String{
			if(ns_set_info){
				//获取 ns_set_info 的最简 markStr(自动计算 infoId)
				var markStr:String=infoMark.markStrDict[ns_set_info];
				if(markStr is String){
					return markStr;
				}
				
				markStr="";
				for each(var ns:AdvanceNamespace_info in ns_set_info.nsV){
					markStr+=","+namespace_info2markStr(infoMark,ns);
				}
				markStr="["+markStr.substr(1)+"]";
				
				infoMark.ns_set_info["~"+markStr]=ns_set_info;
				infoMark.markStrDict[ns_set_info]=markStr;
				
				return markStr;
			}
			throw new Error("ns_set_info="+ns_set_info);
			return null;
		}
		public static function ns_set_infoXML2markStr(infoMark:InfoMark,xml:XML):String{
			//获取 ns_set_info 的 xml 的最简 markStr
			var markStr:String="";
			for each(var nsXML:XML in xml.nsList[0].ns){
				if(/<\w+ value=".*?"\/>/.test(nsXML.toXMLString())){
					markStr+=","+get_namespace_info_markStr(nsXML.@value.toString());
				}else{
					markStr+=","+namespace_infoXML2markStr(infoMark,nsXML);
				}
			}
			return "["+markStr.substr(1)+"]";
		}
		private static function get_ns_set_info_markStr(markStr:String):String{
			if(/^\[.*\]$/.test(markStr)){
				var nsMarkStrArr:Array=markStr.substr(1,markStr.length-2).split(",");
				markStr="";
				for each(var nsMarkStr:String in nsMarkStrArr){
					markStr+=","+get_namespace_info_markStr(nsMarkStr);
				}
				return "["+markStr.substr(1)+"]";
			}
			throw new Error("不合法的 markStr: "+markStr);
			return null;
		}
		
		public static function multiname_info2markStr(infoMark:InfoMark,multiname_info:AdvanceMultiname_info):String{
			if(multiname_info){
				//获取 multiname_info 的最简 markStr(自动计算 infoId)
				var markStr:String=infoMark.markStrDict[multiname_info];
				if(markStr is String){
					return markStr;
				}
				
				switch(multiname_info.kind){
					case MultinameKind.QName:
					case MultinameKind.QNameA:
						
						markStr=namespace_info2markStr(infoMark,multiname_info.ns)+"."+multiname_info.name;
						
					break;
					case MultinameKind.Multiname:
					case MultinameKind.MultinameA:
						
						markStr=ns_set_info2markStr(infoMark,multiname_info.ns_set)+"."+multiname_info.name;
						
					break;
					case MultinameKind.RTQName:
					case MultinameKind.RTQNameA:
						
						markStr=multiname_info.name;
						
					break;
					case MultinameKind.RTQNameL:
					case MultinameKind.RTQNameLA:
						
						markStr="";
						
					break;
					case MultinameKind.MultinameL:
					case MultinameKind.MultinameLA:
						
						markStr=ns_set_info2markStr(infoMark,multiname_info.ns_set)+".";
						
					break;
					case MultinameKind.GenericName:
						
						var ParamMarkStrs:String="";
						for each(var Param:AdvanceMultiname_info in multiname_info.ParamV){
							ParamMarkStrs+=","+multiname_info2markStr(infoMark,Param);
						}
						markStr=multiname_info2markStr(infoMark,multiname_info.TypeDefinition)+".<"+ParamMarkStrs.substr(1)+">";
						
					break;
					default:
						throw new Error("未知 kind: "+multiname_info.kind);
					break;
				}
				//
				
				//计算 infoId
				markStr=get_multiname_info_markStr("["+MultinameKind.kindV[multiname_info.kind]+"]"+markStr);
				if(infoMark.multiname_info["~"+markStr]){
					var infoId:int=1;
					while(infoMark.multiname_info["~"+markStr+"("+(++infoId)+")"]){};
					markStr+="("+infoId+")";
				}
				//
				
				infoMark.multiname_info["~"+markStr]=multiname_info;
				infoMark.markStrDict[multiname_info]=markStr;
				
				return markStr;
			}
			throw new Error("multiname_info="+multiname_info);
			return null;
		}
		public static function multiname_infoXML2markStr(infoMark:InfoMark,xml:XML):String{
			//得到的不是 fullMarkStr 也不是 最简 markStr
			var kindStr:String=xml.@kind.toString();
			if(kindStr=="*"){
				return "*";
			}
			var markStr:String="["+kindStr+"]";
			switch(MultinameKind[kindStr]){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					if(xml.@ns.length()){
						markStr+=xml.@ns.toString();
					}else{
						markStr+=namespace_infoXML2markStr(infoMark,xml.ns[0]);
					}
					markStr+="."+xml.@name.toString()+"("+int(xml.@infoId.toString())+")";
					return get_multiname_info_markStr(markStr);
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					if(xml.@ns_set.length()){
						markStr+=xml.@ns_set.toString();
					}else{
						markStr+=ns_set_infoXML2markStr(infoMark,xml.ns_set[0]);
					}
					markStr+="."+xml.@name.toString()+"("+int(xml.@infoId.toString())+")";
					return get_multiname_info_markStr(markStr);
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					markStr+=xml.@name.toString()+"("+int(xml.@infoId.toString())+")";
					return get_multiname_info_markStr(markStr);
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					//什么都不用干...
					return get_multiname_info_markStr(markStr);
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					if(xml.@ns_set.length()){
						markStr+=xml.@ns_set.toString();
					}else{
						markStr+=ns_set_infoXML2markStr(infoMark,xml.ns_set[0]);
					}
					markStr+=".("+int(xml.@infoId.toString())+")";
					return get_multiname_info_markStr(markStr);
				break;
				case MultinameKind.GenericName:
					if(xml.@TypeDefinition.length()){
						markStr+=xml.@TypeDefinition.toString();
					}else{
						markStr+=multiname_infoXML2markStr(infoMark,xml.TypeDefinition[0]);
					}
					var ParamStrs:String="";
					for each(var ParamXML:XML in xml.ParamList[0].Param){
						if(ParamXML.@value.length()){
							ParamStrs+=","+ParamXML.@value.toString();
						}else{
							ParamStrs+=","+multiname_infoXML2markStr(infoMark,ParamXML);
						}
						markStr+=".<"+ParamStrs.substr(1)+">";
					}
					markStr+="("+int(xml.@infoId.toString())+")";
					//trace("markStr=\n"+markStr+"\n"+get_multiname_info_markStr(markStr)+"\n-------------------");
					return get_multiname_info_markStr(markStr);
				break;
			}
			throw new Error("不合法的 kindStr: "+kindStr+"\nxml: "+xml.toXMLString());
			return null;
		}
		private static function get_multiname_info_markStr(markStr:String):String{
			//获取最简 markStr
			var id:int,kind:int,subMarkStr:String;
			if(markStr.indexOf("[")==0){
				//可能是 kind，也可能是 QName 的 namespaceKind
				id=markStr.indexOf("]");
				kind=MultinameKind[markStr.substr(1,id-1)];
				if(kind>0){
					subMarkStr=markStr.substr(id+1);
				}else{
					kind=MultinameKind.QName;
					subMarkStr=markStr;
				}
			}else{
				kind=MultinameKind.QName;
				subMarkStr=markStr;
			}
			
			var execResult:Array,name_str:String,nss_str:String,infoId:int;
			
			var dotId:int;
			
			switch(kind){
				case MultinameKind.QName:
				case MultinameKind.QNameA:
					//""
					//"(1)."
					//"name."
					//"name(1)."
					//"[kind]."
					//"[kind](1)."
					//"[kind]name."
					//"[kind]name(1)."
					//
					//"(1)"
					//"(1).(1)"
					//"name.(1)"
					//"name(1).(1)"
					//"[kind].(1)"
					//"[kind](1).(1)"
					//"[kind]name.(1)"
					//"[kind]name(1).(1)"
					//
					//"name"
					//"(1).name"
					//"name.name"
					//"name(1).name"
					//"[kind].name"
					//"[kind](1).name"
					//"[kind]name.name"
					//"[kind]name(1).name"
					//
					//"name(1)"
					//"(1).name(1)"
					//"name.name(1)"
					//"name(1).name(1)"
					//"[kind].name(1)"
					//"[kind](1).name(1)"
					//"[kind]name.name(1)"
					//"[kind]name(1).name(1)"
					
					dotId=subMarkStr.lastIndexOf(".");
					if(dotId==-1){
						name_str=subMarkStr;
						nss_str="";
					}else{
						name_str=subMarkStr.substr(dotId+1);
						nss_str=subMarkStr.substr(0,dotId);
					}
					
					//trace("ns_str="+ns_str+",name_str="+name_str);
					
					//name(infoId)
					//trace(/^(.*?)(?:\((\d+)\))?$/.exec(""));				//,,
					//trace(/^(.*?)(?:\((\d+)\))?$/.exec("name"));			//name,name,
					//trace(/^(.*?)(?:\((\d+)\))?$/.exec("(1)"));			//(1),,1
					//trace(/^(.*?)(?:\((\d+)\))?$/.exec("name(1)"));		//name(1),name,1
					execResult=/^(.*?)(?:\((\d+)\))?$/.exec(name_str);
					if(execResult[0]===name_str){
						if(kind==MultinameKind.QName){
							markStr="";
						}else{
							markStr="[QNameA]";
						}
						markStr+=get_namespace_info_markStr(nss_str);
						if(markStr){
							markStr+="."+execResult[1];
						}else{
							markStr=execResult[1];
						}
						
						//计算 infoId
						infoId=int(execResult[2]);
						if(infoId>1){
							markStr+="("+infoId+")";
						}
						//
						
						return markStr;
					}
				break;
				case MultinameKind.Multiname:
				case MultinameKind.MultinameA:
					dotId=subMarkStr.lastIndexOf(".");
					if(dotId==-1){
						//
					}else{
						name_str=subMarkStr.substr(dotId+1);
						nss_str=subMarkStr.substr(0,dotId);
						execResult=/^(.*?)(?:\((\d+)\))?$/.exec(name_str);
						if(execResult[0]===name_str){
							markStr="["+
								MultinameKind.kindV[kind]+
								"]"+
								get_ns_set_info_markStr(nss_str)+"."+
								execResult[1];
							
							//计算 infoId
							infoId=int(execResult[2]);
							if(infoId>1){
								markStr+="("+infoId+")";
							}
							//
							
							return markStr;
						}
					}
				break;
				case MultinameKind.RTQName:
				case MultinameKind.RTQNameA:
					execResult=/^(.*?)(?:\((\d+)\))?$/.exec(subMarkStr);
					if(execResult[0]===subMarkStr){
						markStr="["+
							MultinameKind.kindV[kind]+
							"]"+
							execResult[1];
						
						//计算 infoId
						infoId=int(execResult[2]);
						if(infoId>1){
							markStr+="("+infoId+")";
						}
						//
						
						return markStr;
					}
				break;
				case MultinameKind.RTQNameL:
				case MultinameKind.RTQNameLA:
					markStr="["+
						MultinameKind.kindV[kind]+
					"]";
					return markStr;
				break;
				case MultinameKind.MultinameL:
				case MultinameKind.MultinameLA:
					dotId=subMarkStr.lastIndexOf(".");
					if(dotId==-1){
						//
					}else{
						name_str=subMarkStr.substr(dotId+1);
						nss_str=subMarkStr.substr(0,dotId);
						execResult=/^(?:\((\d+)\))?$/.exec(name_str);
						if(execResult[0]===name_str){
							markStr="["+
								MultinameKind.kindV[kind]+
								"]"+
								get_ns_set_info_markStr(nss_str)+".";
							
							//计算 infoId
							infoId=int(execResult[1]);
							if(infoId>1){
								markStr+="("+infoId+")";
							}
							//
							
							return markStr;
						}
					}
				break;
				case MultinameKind.GenericName:
					execResult=/^(.*?)\.<(.*)>(?:\((\d+)\))?$/.exec(subMarkStr);
					if(execResult[0]===subMarkStr){
						var ParamMarkStrs:String="";
						for each(var ParamMarkStr:String in execResult[2].split(",")){
							ParamMarkStrs+=","+get_multiname_info_markStr(ParamMarkStr);
						}
						markStr="[GenericName]"+get_multiname_info_markStr(execResult[1])+".<"+ParamMarkStrs.substr(1)+">";
						
						//计算 infoId
						infoId=int(execResult[2]);
						if(infoId>1){
							markStr+="("+infoId+")";
						}
						//
						
						return markStr;
					}
				break;
			}
			throw new Error("不合法的 markStr: "+markStr);
			return null;
		}
		
		public static function namespace_info2xml(infoMark:InfoMark,namespace_info:AdvanceNamespace_info):XML{
			var xml:XML=infoMark.xmlDict[namespace_info];
			if(xml){
			}else{
				var markStr:String=infoMark.markStrDict[namespace_info];
				if(markStr is String){
				}else{
					markStr=namespace_info2markStr(infoMark,namespace_info);
				}
				xml=namespace_info.toXMLAndMark(infoMark);
				var infoId:int=int(markStr.replace(/^.*\((\d+)\)$/,"$1"));
				if(infoId>1){
					xml.@infoId=infoId;
				}
				infoMark.xmlDict[namespace_info]=xml;
			}
			return xml.copy();
		}
		public static function ns_set_info2xml(infoMark:InfoMark,ns_set_info:AdvanceNs_set_info):XML{
			var xml:XML=infoMark.xmlDict[ns_set_info];
			if(xml){
			}else{
				var markStr:String=infoMark.markStrDict[ns_set_info];
				if(markStr is String){
				}else{
					markStr=ns_set_info2markStr(infoMark,ns_set_info);
				}
				xml=ns_set_info.toXMLAndMark(infoMark);
				var infoId:int=int(markStr.replace(/^.*\((\d+)\)$/,"$1"));
				if(infoId>1){
					xml.@infoId=infoId;
				}
				infoMark.xmlDict[ns_set_info]=xml;
			}
			return xml.copy();
		}
		public static function multiname_info2xml(infoMark:InfoMark,multiname_info:AdvanceMultiname_info):XML{
			var xml:XML=infoMark.xmlDict[multiname_info];
			if(xml){
			}else{
				var markStr:String=infoMark.markStrDict[multiname_info];
				if(markStr is String){
				}else{
					markStr=multiname_info2markStr(infoMark,multiname_info);
				}
				xml=multiname_info.toXMLAndMark(infoMark);
				var infoId:int=int(markStr.replace(/^.*\((\d+)\)$/,"$1"));
				if(infoId>1){
					xml.@infoId=infoId;
				}
				infoMark.xmlDict[multiname_info]=xml;
			}
			return xml.copy();
		}
		
		
		public static function markStr2namespace_info(infoMark:InfoMark,markStr0:String):AdvanceNamespace_info{
			var namespace_info:AdvanceNamespace_info=infoMark.namespace_info["~"+markStr0];
			if(namespace_info){
			}else{
				var markStr:String=get_namespace_info_markStr(markStr0);
				namespace_info=infoMark.namespace_info["~"+markStr];
				if(namespace_info){
				}else{
					
					//[kind]name(infoId)
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec(""));					//,,,
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("(1)"));					//(1),,,1
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("name"));				//name,,name,
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("name(1)"));				//name(1),,name,1
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]"));				//[kind],kind,,
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind](1)"));			//[kind](1),kind,,1
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]name"));			//[kind]name,kind,name,
					//trace(/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec("[kind]name(1)"));		//[kind]name(1),kind,name,1
					
					var execResult:Array=/^(?:\[(.*?)\])?(.*?)(?:\((\d+)\))?$/.exec(markStr);
					namespace_info=new AdvanceNamespace_info();
					namespace_info.kind=NamespaceKind[execResult[1]];
					if(namespace_info.kind>0){
					}else{
						namespace_info.kind=NamespaceKind.PackageNamespace;
					}
					namespace_info.name=execResult[2];
					//infoId=int(execResult[3]);
					
					infoMark.markStrDict[namespace_info]=markStr;
					infoMark.namespace_info["~"+markStr]=namespace_info;
				}
				infoMark.namespace_info["~"+markStr0]=namespace_info;
			}
			return namespace_info;
		}
		public static function markStr2ns_set_info(infoMark:InfoMark,markStr0:String):AdvanceNs_set_info{
			var ns_set_info:AdvanceNs_set_info=infoMark.ns_set_info["~"+markStr0];
			if(ns_set_info){
			}else{
				var markStr:String=get_ns_set_info_markStr(markStr0);
				ns_set_info=infoMark.ns_set_info["~"+markStr];
				if(ns_set_info){
				}else{
					ns_set_info=new AdvanceNs_set_info();
					ns_set_info.nsV=new Vector.<AdvanceNamespace_info>();
					for each(var nsMarkStr:String in markStr.replace(/^\[(.*)\]$/,"$1").split(/,/)){
						ns_set_info.nsV.push(markStr2namespace_info(infoMark,nsMarkStr));
					}
					
					infoMark.markStrDict[ns_set_info]=markStr;
					infoMark.ns_set_info["~"+markStr]=ns_set_info;
				}
				infoMark.ns_set_info["~"+markStr0]=ns_set_info;
			}
			return ns_set_info;
		}
		public static function markStr2multiname_info(infoMark:InfoMark,markStr0:String):AdvanceMultiname_info{
			var multiname_info:AdvanceMultiname_info=infoMark.multiname_info["~"+markStr0];
			if(multiname_info){
			}else{
				var markStr:String=get_multiname_info_markStr(markStr0);
				multiname_info=infoMark.multiname_info["~"+markStr];
				if(multiname_info){
				}else{
					multiname_info=new AdvanceMultiname_info();
					var id:int,subMarkStr:String;
					if(markStr.indexOf("[")==0){
						//可能是 kind，也可能是 QName 的 namespaceKind
						id=markStr.indexOf("]");
						multiname_info.kind=MultinameKind[markStr.substr(1,id-1)];
						if(multiname_info.kind>0){
							subMarkStr=markStr.substr(id+1);
						}else{
							multiname_info.kind=MultinameKind.QName;
							subMarkStr=markStr;
						}
					}else{
						multiname_info.kind=MultinameKind.QName;
						subMarkStr=markStr;
					}
					
					var execResult:Array,name_str:String,nss_str:String;
					
					var dotId:int;
					
					switch(multiname_info.kind){
						case MultinameKind.QName:
						case MultinameKind.QNameA:
							dotId=subMarkStr.lastIndexOf(".");
							if(dotId==-1){
								name_str=subMarkStr;
								nss_str="";
							}else{
								name_str=subMarkStr.substr(dotId+1);
								nss_str=subMarkStr.substr(0,dotId);
							}
							//trace("ns_str="+ns_str+",name_str="+name_str);
							
							//name(infoId)
							//trace(/^(.*?)(?:\((\d+)\))?$/.exec(""));				//,,
							//trace(/^(.*?)(?:\((\d+)\))?$/.exec("name"));			//name,name,
							//trace(/^(.*?)(?:\((\d+)\))?$/.exec("(1)"));			//(1),,1
							//trace(/^(.*?)(?:\((\d+)\))?$/.exec("name(1)"));		//name(1),name,1
							execResult=/^(.*?)(?:\((\d+)\))?$/.exec(name_str);
							multiname_info.ns=markStr2namespace_info(infoMark,nss_str);
							multiname_info.name=execResult[1];
							//infoId=int(execResult[2]);
						break;
						case MultinameKind.Multiname:
						case MultinameKind.MultinameA:
							dotId=subMarkStr.lastIndexOf(".");
							name_str=subMarkStr.substr(dotId+1);
							nss_str=subMarkStr.substr(0,dotId);
							execResult=/^(.*?)(?:\((\d+)\))?$/.exec(name_str);
							multiname_info.ns_set=markStr2ns_set_info(infoMark,nss_str);
							multiname_info.name=execResult[1];
							//infoId=int(execResult[2]);
						break;
						case MultinameKind.RTQName:
						case MultinameKind.RTQNameA:
							execResult=/^(.*?)(?:\((\d+)\))?$/.exec(subMarkStr);
							multiname_info.name=execResult[1];
							//infoId=int(execResult[2]);
						break;
						case MultinameKind.RTQNameL:
						case MultinameKind.RTQNameLA:
							//什么都不用干...
						break;
						case MultinameKind.MultinameL:
						case MultinameKind.MultinameLA:
							dotId=subMarkStr.lastIndexOf(".");
							//name_str=subMarkStr.substr(dotId+1);
							nss_str=subMarkStr.substr(0,dotId);
							//execResult=/^(?:\((\d+)\))?$/.exec(name_str);
							multiname_info.ns_set=markStr2ns_set_info(infoMark,nss_str);
							//infoId=int(execResult[1]);
						break;
						case MultinameKind.GenericName:
							execResult=/^(.*?)\.<(.*)>(?:\((\d+)\))?$/.exec(subMarkStr);
							multiname_info.ParamV=new Vector.<AdvanceMultiname_info>();
							for each(var ParamMarkStr:String in execResult[2].split(",")){
								multiname_info.ParamV.push(
									markStr2multiname_info(infoMark,ParamMarkStr)
								);
							}
							multiname_info.TypeDefinition=markStr2multiname_info(infoMark,execResult[1]);
							//infoId=int(execResult[3]);
						break;
					}
					
					infoMark.markStrDict[multiname_info]=markStr;
					infoMark.multiname_info["~"+markStr]=multiname_info;
				}
				infoMark.multiname_info["~"+markStr0]=multiname_info;
			}
			return multiname_info;
		}
		
		public static function xml2namespace_info(infoMark:InfoMark,xml:XML):AdvanceNamespace_info{
			return markStr2namespace_info(
				infoMark,
				namespace_infoXML2markStr(infoMark,xml)
			);
		}
		public static function xml2ns_set_info(infoMark:InfoMark,xml:XML):AdvanceNs_set_info{
			return markStr2ns_set_info(
				infoMark,
				ns_set_infoXML2markStr(infoMark,xml)
			);
		}
		public static function xml2multiname_info(infoMark:InfoMark,xml:XML):AdvanceMultiname_info{
			return markStr2multiname_info(
				infoMark,
				multiname_infoXML2markStr(infoMark,xml)
			);
		}
		public static function markStr2method(infoMark:InfoMark,markStr:String):AdvanceMethod{
			var method:AdvanceMethod=infoMark.method["~"+markStr];
			if(method){
			}else{
				method=new AdvanceMethod();
				if(/^<[\s\S]*>$/.test(markStr)){
					method.initByXMLAndMark(infoMark,new XML(markStr));
				}else{
					method.initByXMLAndMark(infoMark,infoMark.specialXMLs["~"+markStr]);
				}
				
				infoMark.method["~"+markStr]=method;
				infoMark.markStrDict[method]=markStr;
			}
			return method;
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