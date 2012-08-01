/***
GenNamespace
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月21日 09:32:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	
	public class GenNamespace{
		
		public var mark:Object;
		
		public function GenNamespace(){
			mark=new Object();
		}
		public function gen(markStr:String):ABCNamespace{
			markStr=GroupString.ext.escape(markStr);
			var ns:ABCNamespace=mark["~"+markStr];
			if(ns){
			}else{
				ns=new ABCNamespace();
				
				var execResult:Array=/^(?:\[([\s\S]*?)\])?([\s\S]*?)(?:\((name=undefined)\))?(?:\((\d+)\))?$/.exec(markStr);
				
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
				
				/*
				if(ns.kind==NamespaceKinds.PackageNamespace){
				}else{
					trace("markStr="+markStr);
					trace("ns.kind="+NamespaceKinds.kindV[ns.kind]);
					if(ns.name is String){
						trace('ns.name="'+ns.name+'"');
					}else{
						trace('ns.name='+ns.name);
					}
				}
				*/
				
				mark["~"+markStr]=ns;
			}
			return ns;
		}
	}
}
		