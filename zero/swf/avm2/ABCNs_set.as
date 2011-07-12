/***
ABCNs_set
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月18日 17:19:59（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{
	import zero.GroupString;
	import flash.utils.Dictionary;
	public class ABCNs_set{
		public var nsV:Vector.<ABCNamespace>;
		//
		public function initByInfo(
			ns_set_info:Ns_set_info,
			allNsV:Vector.<ABCNamespace>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			
			//			ns_set_info
			//			{
			//				u30 count
			//				u30 ns[count]
			//			}
			
			//The count field defines how many ns's are identified for the entry, while each ns is an integer that indexes into
			//the namespace array of the constant pool.
			//ns是在 constant_pool.namespace_info_v 中的id
			//No entry in the ns array may be zero.
			var i:int=-1;
			nsV=new Vector.<ABCNamespace>();
			for each(var ns:int in ns_set_info.nsV){
				i++;
				if(ns>0){
					nsV[i]=allNsV[ns];
				}else{
					throw new Error("ns="+ns);
				}
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//			ns_set_info
			//			{
			//				u30 count
			//				u30 ns[count]
			//			}
			
			//The count field defines how many ns's are identified for the entry, while each ns is an integer that indexes into
			//the namespace array of the constant pool.
			//ns是在 constant_pool.namespace_info_v 中的id
			//No entry in the ns array may be zero.
			for each(var ns:ABCNamespace in nsV){
				if(ns){
					productMark.productNs(ns);
				}else{
					throw new Error("ns="+ns);
				}
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Ns_set_info{
			var ns_set_info:Ns_set_info=new Ns_set_info();
			
			//			ns_set_info
			//			{
			//				u30 count
			//				u30 ns[count]
			//			}
			
			//The count field defines how many ns's are identified for the entry, while each ns is an integer that indexes into
			//the namespace array of the constant pool.
			//ns是在 constant_pool.namespace_info_v 中的id
			//No entry in the ns array may be zero.
			var i:int=-1;
			ns_set_info.nsV=new Vector.<int>();
			for each(var ns:ABCNamespace in nsV){
				i++;
				if(ns){
					ns_set_info.nsV[i]=productMark.getNsId(ns);
				}else{
					throw new Error("ns="+ns);
				}
			}
			return ns_set_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=markStrs.xmlDict[this];
			if(xml){
				xml=xml.copy();//保证下面的 setName 不互相影响就行
				xml.setName(xmlName);
			}else{
				var markStr:String=toMarkStrAndMark(markStrs);
				if(_toXMLOptions&&_toXMLOptions.AVM2UseMarkStr){
					xml=<{xmlName} markStr={markStr}/>;
				}else{
					xml=<{xmlName}/>;
					if(nsV.length){
						var nsListXML:XML=<nsList count={nsV.length}/>
						for each(var ns:ABCNamespace in nsV){
							if(ns){
								nsListXML.appendChild(ns.toXMLAndMark(markStrs,"ns",_toXMLOptions));
							}else{
								throw new Error("ns="+ns);
							}
						}
						xml.appendChild(nsListXML);
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
			
			//获取 ns_set 的最简 markStr(自动计算 copyId)
			
			var markStr:String=markStrs.markStrDict[this];
			if(markStr is String){
				return markStr;
			}
			
			//计算 markStr
			if(nsV.length){
				markStr="";
				for each(var ns:ABCNamespace in nsV){
					if(ns){
						markStr+=","+ns.toMarkStrAndMark(markStrs);
					}else{
						throw new Error("ns="+ns);
					}
				}
				markStr="["+markStr.substr(1)+"]";
			}else{
				markStr="[](length=0)";
			}
			
			//计算 copyId
			if(markStrs.ns_setMark["~"+markStr]){
				var copyId:int=1;
				while(markStrs.ns_setMark["~"+markStr+"("+(++copyId)+")"]){};
				markStr+="("+copyId+")";
			}
			//
			
			markStrs.ns_setMark["~"+markStr]=this;
			markStrs.markStrDict[this]=markStr;
			
			return markStr;
		}
		
		public static function xml2ns_set(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):ABCNs_set{
			return markStr2ns_set(markStrs,xml2markStr(xml));
		} 
		public static function xml2markStr(xml:XML):String{
			
			//获取 ns_set 的 xml 的最简 markStr
			
			if(/^<\w+ markStr="[\s\S]*?"\/>$/.test(xml.toXMLString())){
				return normalizeMarkStr(xml.@markStr.toString());
			}
			
			var markStr:String;
			var nsXMLList:XMLList=xml.nsList.ns;
			if(nsXMLList.length()){
				markStr="";
				for each(var nsXML:XML in nsXMLList){
					markStr+=","+ABCNamespace.xml2markStr(nsXML);
				}
				markStr="["+markStr.substr(1)+"]";
			}else{
				markStr="[](length=0)";
			}
			
			var copyId:int=int(xml.@copyId.toString());
			if(copyId>1){
				markStr+="("+copyId+")";
			}
			
			return markStr;
		}
		public static function markStr2ns_set(markStrs:MarkStrs,markStr0:String):ABCNs_set{
			var ns_set:ABCNs_set=markStrs.ns_setMark["~"+markStr0];
			if(ns_set){
			}else{
				var markStr:String=normalizeMarkStr(markStr0);
				ns_set=markStrs.ns_setMark["~"+markStr];
				if(ns_set){
				}else{
					ns_set=new ABCNs_set();
					
					var execResult:Array=/^\[([\s\S]*?)\](?:\((length=0)\))?(?:\((\d+)\))?$/.exec(GroupString.ext.escape(markStr));
					
					ns_set.nsV=new Vector.<ABCNamespace>();
					if(execResult[2]){//"length=0"
					}else{
						for each(var escapeNsMarkStr:String in GroupString.ext.separate(execResult[1])){
							ns_set.nsV.push(ABCNamespace.markStr2ns(markStrs,escapeNsMarkStr));
						}
					}
					
					markStrs.markStrDict[ns_set]=markStr;
					markStrs.ns_setMark["~"+markStr]=ns_set;
				}
				markStrs.ns_setMark["~"+markStr0]=ns_set;
			}
			return ns_set;
		}
		public static function normalizeMarkStr(markStr:String):String{
			
			//获取最简 markStr
			
			var execResult:Array=/^\[([\s\S]*?)\](?:\((length=0)\))?(?:\((\d+)\))?$/.exec(GroupString.ext.escape(markStr));
			
			if(execResult[2]){//"length=0"
				markStr="[](length=0)";
			}else{
				markStr="";
				for each(var escapeNsMarkStr:String in GroupString.ext.separate(execResult[1])){
					markStr+=","+ABCNamespace.normalizeMarkStr(escapeNsMarkStr);
				}
				markStr="["+markStr.substr(1)+"]";
			}
			
			var copyId:int=int(execResult[3]);
			if(copyId>1){
				markStr+="("+copyId+")";
			}
			
			return markStr;
		}
		}//end of CONFIG::USE_XML
	}
}
