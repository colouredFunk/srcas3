/***
SimpleMultinames
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月27日 20:02:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.swf.avm2.*;
	public class SimpleMultinames{
		private var namespaceMark:Object;
		private var multinameMark:Object;
		public function SimpleMultinames(){
			namespaceMark=new Object();
			multinameMark=new Object();
			
			var emptyNs:ABCNamespace=new ABCNamespace();
			emptyNs.kind=NamespaceKinds.PackageNamespace;
			emptyNs.name="";
			namespaceMark["~"]=emptyNs;
			
			var emptyMultinameL:ABCMultiname=new ABCMultiname();
			emptyMultinameL.kind=MultinameKinds.MultinameL;
			emptyMultinameL.ns_set=new ABCNs_set();
			emptyMultinameL.ns_set.nsV=new Vector.<ABCNamespace>();
			emptyMultinameL.ns_set.nsV[0]=emptyNs;
			multinameMark["~"+"[MultinameL][]."]=emptyMultinameL;
			
			var utilsNs:ABCNamespace=new ABCNamespace();
			utilsNs.kind=NamespaceKinds.PackageNamespace;
			utilsNs.name="flash.utils";
			namespaceMark["~"+"flash.utils"]=utilsNs;
			
			var utilsMultinameL:ABCMultiname=new ABCMultiname();
			utilsMultinameL.kind=MultinameKinds.MultinameL;
			utilsMultinameL.ns_set=new ABCNs_set();
			utilsMultinameL.ns_set.nsV=new Vector.<ABCNamespace>();
			utilsMultinameL.ns_set.nsV[0]=utilsNs;
			multinameMark["~"+"[MultinameL][flash.utils]."]=utilsMultinameL;
		}
		public function gen(name:String):ABCMultiname{
			var multiname:ABCMultiname=multinameMark["~"+name];
			if(multiname){
				return multiname;
			}
			
			var dotId:int=name.lastIndexOf(".");
			var multiname_nsName:String,multiname_name:String;
			if(dotId>-1){
				multiname_nsName=name.substr(0,dotId);
				multiname_name=name.substr(dotId+1);
			}else{
				multiname_nsName="";
				multiname_name=name;
			}
			
			multinameMark["~"+name]=multiname=new ABCMultiname();
			multiname.kind=MultinameKinds.QName;
			multiname.ns=namespaceMark["~"+multiname_nsName];
			if(multiname.ns){
			}else{
				namespaceMark["~"+multiname_nsName]=multiname.ns=new ABCNamespace();
				multiname.ns.kind=NamespaceKinds.PackageNamespace;
				multiname.ns.name=multiname_nsName;
			}
			multiname.name=multiname_name;
			
			return multiname;
		}
	}
}
		