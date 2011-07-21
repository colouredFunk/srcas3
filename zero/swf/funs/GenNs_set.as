/***
GenNs_set
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月21日 10:13:00
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	
	public class GenNs_set{
		
		public var mark:Object;
		private var genNamespace:GenNamespace;
		
		public function GenNs_set(_genNamespace:GenNamespace=null){
			mark=new Object();
			genNamespace=_genNamespace||new GenNamespace();
		}
		public function gen(markStr:String):ABCNs_set{
			var ns_set:ABCNs_set=mark["~"+markStr];
			if(ns_set){
			}else{
				ns_set=new ABCNs_set();
				
				var execResult:Array=/^\[([\s\S]*?)\](?:\((length=0)\))?(?:\((\d+)\))?$/.exec(GroupString.ext.escape(markStr));
				
				ns_set.nsV=new Vector.<ABCNamespace>();
				if(execResult[2]){//"length=0"
				}else{
					for each(var escapeNsMarkStr:String in GroupString.ext.separate(execResult[1])){
						ns_set.nsV.push(genNamespace.gen(escapeNsMarkStr));
					}
				}
				
				mark["~"+markStr]=ns_set;
			}
			return ns_set
		}
	}
}
		