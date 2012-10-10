/***
getDocClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月17日 21:37:24
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.utils.*;
	import zero.swf.tagBodys.*;
	public function getDocClass(swf:SWFExtend):ABCClass{
		if(swf.isAS3){
			var docClassName:String=swf.docClassName;
			if(docClassName){
				for each(var ABCData:ABCClasses in getABCClasseses(swf)){
					for each(var clazz:ABCClass in ABCData.classV){
						if(clazz.name.getQNameString()==docClassName){
							return clazz;
						}
						//trace("docClassName="+docClassName);
						//trace(clazz.getClassName());
						//trace(clazz.getClassName()==docClassName);
					}
				}
				trace("找不到 docClass："+docClassName+"，（可能是代码和动画分离后的动画部分）");
			}
			return null;
		}
		throw new Error("swf.isAS3="+swf.isAS3);
	}
}
		