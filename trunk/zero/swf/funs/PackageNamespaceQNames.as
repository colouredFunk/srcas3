/***
PackageNamespaceQNames
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月27日 20:02:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.swf.avm2.*;
	public class PackageNamespaceQNames{
		private var mark:Object;
		public function PackageNamespaceQNames(){
			mark=new Object();
		}
		public function gen(name:String):ABCMultiname{
			var multiname:ABCMultiname=mark["~"+name];
			if(multiname){
				return multiname;
			}
			
			var dotId:int=name.lastIndexOf(".");
			var nsName:String;
			if(dotId>-1){
				nsName=name.substr(0,dotId);
				name=name.substr(dotId+1);
			}else{
				nsName="";
			}
			
			mark["~"+name]=multiname=new ABCMultiname();
			multiname.kind=MultinameKinds.QName;
			multiname.ns=new ABCNamespace();
			multiname.ns.kind=NamespaceKinds.PackageNamespace;
			multiname.ns.name=nsName;
			multiname.name=name;
			
			return multiname;
		}
	}
}
		