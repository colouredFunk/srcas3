/***
ABCNamespace
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月17日 14:15:57（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{
	import flash.utils.Dictionary;
	
	import zero.ComplexString;
	import zero.GroupString;
	public class ABCNamespace{
		public var kind:int;							//direct_int
		public var name:String;							//string
		//
		public function initByInfo(
			namespace_info:Namespace_info,
			stringV:Vector.<String>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			if(NamespaceKinds.kindV[namespace_info.kind]){
			}else{
				throw new Error("namespace_info.kind="+namespace_info.kind);
			}
			
			//			namespace_info
			//			{
			//				u8 kind
			//				u30 name
			//			}
			
			//A single byte defines the type of entry that follows, thus identifying how the name field should be interpreted by the loader. 
			//The table below lists the legal values for kind.
			//Namespace Kind 				Value
			//CONSTANT_Namespace 			0x08
			//CONSTANT_PackageNamespace 	0x16
			//CONSTANT_PackageInternalNs 	0x17
			//CONSTANT_ProtectedNamespace 	0x18
			//CONSTANT_ExplicitNamespace 	0x19
			//CONSTANT_StaticProtectedNs 	0x1A
			//CONSTANT_PrivateNs 			0x05
			kind=namespace_info.kind;
			
			//The name field is an index into the string section of the constant pool.
			//name是在 constant_pool.string_v 中的id
			//A value of zero denotes an empty string.
			name=stringV[namespace_info.name];//stringV[0]==null
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//			namespace_info
			//			{
			//				u8 kind
			//				u30 name
			//			}
			
			//A single byte defines the type of entry that follows, thus identifying how the name field should be interpreted by the loader. 
			//The table below lists the legal values for kind.
			//Namespace Kind 				Value
			//CONSTANT_Namespace 			0x08
			//CONSTANT_PackageNamespace 	0x16
			//CONSTANT_PackageInternalNs 	0x17
			//CONSTANT_ProtectedNamespace 	0x18
			//CONSTANT_ExplicitNamespace 	0x19
			//CONSTANT_StaticProtectedNs 	0x1A
			//CONSTANT_PrivateNs 			0x05
			//
			
			//The name field is an index into the string section of the constant pool.
			//name是在 constant_pool.string_v 中的id
			//A value of zero denotes an empty string.
			productMark.productString(name);
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Namespace_info{
			if(NamespaceKinds.kindV[kind]){
			}else{
				throw new Error("kind="+kind);
			}
			
			var namespace_info:Namespace_info=new Namespace_info();
			
			//			namespace_info
			//			{
			//				u8 kind
			//				u30 name
			//			}
			
			//A single byte defines the type of entry that follows, thus identifying how the name field should be interpreted by the loader. 
			//The table below lists the legal values for kind.
			//Namespace Kind 				Value
			//CONSTANT_Namespace 			0x08
			//CONSTANT_PackageNamespace 	0x16
			//CONSTANT_PackageInternalNs 	0x17
			//CONSTANT_ProtectedNamespace 	0x18
			//CONSTANT_ExplicitNamespace 	0x19
			//CONSTANT_StaticProtectedNs 	0x1A
			//CONSTANT_PrivateNs 			0x05
			namespace_info.kind=kind;
			
			//The name field is an index into the string section of the constant pool.
			//name是在 constant_pool.string_v 中的id
			//A value of zero denotes an empty string.
			namespace_info.name=productMark.getStringId(name);
			
			return namespace_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			if(NamespaceKinds.kindV[kind]){
			}else{
				throw new Error("kind="+kind);
			}
			
			var xml:XML=markStrs.xmlDict[this];
			if(xml){
				xml=xml.copy();//保证下面的 setName 不互相影响就行
				xml.setName(xmlName);
			}else{
				var markStr:String=toMarkStrAndMark(markStrs);
				if(_toXMLOptions&&_toXMLOptions.AVM2UseMarkStr){
					xml=<{xmlName} markStr={markStr}/>;
				}else{
					xml=<{xmlName}
						kind={NamespaceKinds.kindV[kind]}
					/>;
					if(name is String){
						xml.@name=name;
					}
					
					var execResult:Array=/^[\s\S]*\((\d+)\)$/.exec(markStr);
					if(execResult){
						var copyId:int=int(execResult[1]);
						if(copyId>1){
							xml.@copyId=copyId;
						}
					}
				}
				markStrs.xmlDict[this]=xml;
			}
			return xml;
		}
		public function toMarkStrAndMark(markStrs:MarkStrs):String{
			if(NamespaceKinds.kindV[kind]){
			}else{
				throw new Error("kind="+kind);
			}
			
			//获取 ns 的最简 markStr(自动计算 copyId)
			
			var markStr:String=markStrs.markStrDict[this];
			if(markStr is String){
				return markStr;
			}
			
			//计算 markStr
			if(kind==NamespaceKinds.PackageNamespace){
				markStr="";
			}else{
				markStr="["+NamespaceKinds.kindV[kind]+"]";
			}
			if(name is String){
				markStr+=ComplexString.ext.escape(name);
			}else{
				markStr+="(name=undefined)";
			}
			
			//计算 copyId
			if(markStrs.nsMark["~"+markStr]){
				var copyId:int=1;
				while(markStrs.nsMark["~"+markStr+"("+(++copyId)+")"]){};
				markStr+="("+copyId+")";
			}
			//
			
			markStrs.nsMark["~"+markStr]=this;
			markStrs.markStrDict[this]=markStr;
			
			return markStr;
		}
		
		public static function xml2ns(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):ABCNamespace{
			return markStr2ns(markStrs,xml2markStr(xml));
		} 
		public static function xml2markStr(xml:XML):String{
			
			//获取 ns 的 xml 的最简 markStr
			
			if(/^<\w+ markStr="[\s\S]*?"\/>$/.test(xml.toXMLString())){
				return normalizeMarkStr(xml.@markStr.toString());
			}
			
			var markStr:String;
			var kind:int=NamespaceKinds[xml.@kind.toString()];
			if(kind>0){
				if(kind==NamespaceKinds.PackageNamespace){
					markStr="";
				}else{
					markStr="["+NamespaceKinds.kindV[kind]+"]";
				}
			}else{
				throw new Error("不合法的 kindStr："+xml.@kind.toString());
			}
			
			var nameXML:XML=xml.@name[0];
			if(nameXML){
				markStr+=ComplexString.ext.escape(nameXML.toString());
			}else{
				markStr+="(name=undefined)";
			}
			
			var copyId:int=int(xml.@copyId.toString());
			if(copyId>1){
				markStr+="("+copyId+")";
			}
			
			return markStr;
		}
		public static function markStr2ns(markStrs:MarkStrs,markStr0:String):ABCNamespace{
			var ns:ABCNamespace=markStrs.nsMark["~"+markStr0];
			if(ns){
			}else{
				var markStr:String=normalizeMarkStr(markStr0);
				ns=markStrs.nsMark["~"+markStr];
				if(ns){
				}else{
					ns=new ABCNamespace();
					
					var execResult:Array=/^(?:\[([\s\S]*?)\])?([\s\S]*?)(?:\((name=undefined)\))?(?:\((\d+)\))?$/.exec(GroupString.ext.escape(markStr));
					
					if(execResult[1]){
						ns.kind=NamespaceKinds[execResult[1]];
						if(ns.kind>0){
							//
						}else{
							throw new Error("不合法的 kindStr："+execResult[1]);
						}
					}else{
						ns.kind=NamespaceKinds.PackageNamespace;
					}
					
					if(execResult[3]){//"name=undefined"
						ns.name=null;
					}else{
						ns.name=ComplexString.ext.unescape(execResult[2]);
					}
					
					markStrs.markStrDict[ns]=markStr;
					markStrs.nsMark["~"+markStr]=ns;
				}
				markStrs.nsMark["~"+markStr0]=ns;
			}
			return ns;
		}
		public static function normalizeMarkStr(markStr:String):String{
			
			//获取最简 markStr
			
			var execResult:Array=/^(?:\[([\s\S]*?)\])?([\s\S]*?)(?:\((name=undefined)\))?(?:\((\d+)\))?$/.exec(GroupString.ext.escape(markStr));
			
			if(execResult[1]){
				var kind:int=NamespaceKinds[execResult[1]];
				if(kind>0){
					if(kind==NamespaceKinds.PackageNamespace){
						markStr="";
					}else{
						markStr="["+NamespaceKinds.kindV[kind]+"]";
					}
				}else{
					throw new Error("不合法的 kindStr："+execResult[1]);
				}
			}else{
				markStr="";
			}
			
			if(execResult[3]){//"name=undefined"
				markStr+="(name=undefined)";
			}else{
				markStr+=GroupString.ext.unescape(execResult[2]);
			}
			
			var copyId:int=int(execResult[4]);
			if(copyId>1){
				markStr+="("+copyId+")";
			}
			
			return markStr;
		}
		}//end of CONFIG::USE_XML
		
		public function toString():String{
			return "["+NamespaceKinds.kindV[kind]+"]"+name;
		}
	}
}