/***
GenMultiname
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月21日 09:32:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	
	public class GenMultiname{
		
		public var mark:Object;
		private var genNamespace:GenNamespace;
		private var genNs_set:GenNs_set;
		
		public function GenMultiname(
			_genNamespace:GenNamespace=null,
			_genNs_set:GenNs_set=null
		){
			mark=new Object();
			genNamespace=_genNamespace||new GenNamespace();
			genNs_set=_genNs_set||new GenNs_set(genNamespace);
		}
		public function gen(markStr:String):ABCMultiname{
			var multiname:ABCMultiname=mark["~"+markStr];
			if(multiname){
			}else{
				multiname=new ABCMultiname();
				
				var id:int,escapeMarkStr:String;
				if(markStr.indexOf("[")==0){
					//可能是 multinameKind，也可能是 QName 的  ns.kind
					id=markStr.indexOf("]");
					multiname.kind=MultinameKinds[markStr.substr(1,id-1)];
					if(multiname.kind>0){
						escapeMarkStr=GroupString.ext.escape(markStr.substr(id+1));
					}else{
						multiname.kind=MultinameKinds.QName;
						escapeMarkStr=GroupString.ext.escape(markStr);
					}
				}else{
					multiname.kind=MultinameKinds.QName;
					escapeMarkStr=GroupString.ext.escape(markStr);
				}
				
				var execResult:Array;
				var dotId:int;
				
				switch(multiname.kind){
					case MultinameKinds.QName:
					case MultinameKinds.QNameA:
						if(escapeMarkStr.indexOf("(ns=undefined)")==0){
							multiname.ns=null;
							escapeMarkStr=escapeMarkStr.replace(/\(ns=undefined\)\.?/,"");
						}else{
							dotId=escapeMarkStr.lastIndexOf(".");
							if(dotId==-1){
								multiname.ns=genNamespace.gen("");
							}else{
								multiname.ns=genNamespace.gen(escapeMarkStr.substr(0,dotId));
								escapeMarkStr=escapeMarkStr.substr(dotId+1);
							}
						}
						execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
						if(execResult[1]=="(name=undefined)"){
							multiname.name=null;
						}else{
							multiname.name=ComplexString.ext.unescape(execResult[1]);
						}
						//copyId=int(execResult[2]);
					break;
					case MultinameKinds.Multiname:
					case MultinameKinds.MultinameA:
						dotId=escapeMarkStr.lastIndexOf(".");
						if(dotId==-1){
							throw new Error("dotId="+dotId);
						}else{
							multiname.ns_set=genNs_set.gen(escapeMarkStr.substr(0,dotId));
							escapeMarkStr=escapeMarkStr.substr(dotId+1);
						}
						execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
						if(execResult[1]=="(name=undefined)"){
							multiname.name=null;
						}else{
							multiname.name=ComplexString.ext.unescape(execResult[1]);
						}
						//copyId=int(execResult[2]);
					break;
					case MultinameKinds.RTQName:
					case MultinameKinds.RTQNameA:
						execResult=/^([\s\S]*?)(?:\((\d+)\))?$/.exec(escapeMarkStr);
						if(execResult[1]=="(name=undefined)"){
							multiname.name=null;
						}else{
							multiname.name=ComplexString.ext.unescape(execResult[1]);
						}
						//copyId=int(execResult[2]);
					break;
					case MultinameKinds.RTQNameL:
					case MultinameKinds.RTQNameLA:
						//什么都不用干...
					break;
					case MultinameKinds.MultinameL:
					case MultinameKinds.MultinameLA:
						dotId=escapeMarkStr.lastIndexOf(".");
						if(dotId==-1){
							throw new Error("dotId="+dotId);
						}else{
							multiname.ns_set=genNs_set.gen(escapeMarkStr.substr(0,dotId));
							escapeMarkStr=escapeMarkStr.substr(dotId+1);
						}
					break;
					case MultinameKinds.GenericName:
						execResult=/^([\s\S]*?)\.?<([\s\S]*)>(?:\((\d+)\))?$/.exec(escapeMarkStr);
						if(execResult[1]=="(TypeDefinition=undefined)"){
						}else{
							multiname.TypeDefinition=gen(execResult[1]);
						}
						multiname.ParamV=new Vector.<ABCMultiname>();
						for each(var ParamMarkStr:String in GroupString.ext.separate(execResult[2])){
							if(ParamMarkStr=="(Param=undefined)"){
								multiname.ParamV.push(null);
							}else{
								multiname.ParamV.push(gen(ParamMarkStr));
							}
						}
						if(multiname.ParamV.length){
						}else{
							throw new Error("multiname.ParamV.length="+multiname.ParamV.length);
						}
						//copyId=int(execResult[3]);
					break;
					default:
						throw new Error("未知 multiname.kind："+multiname.kind);
					break;
				}
				
				mark["~"+markStr]=multiname;
			}
			return multiname;
		}
	}
}