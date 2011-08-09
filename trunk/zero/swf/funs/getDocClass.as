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
	import zero.swf.funs.*;
	import zero.swf.tagBodys.*;
	public function getDocClass(swf:SWF):ABCClass{
		var docClassName:String=getDocClassName(swf);
		if(docClassName){
			var ABCData:ABCClasses;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
						ABCData=tag.getBody(DoABC,{ABCDataClass:ABCClasses}).ABCData;
					break;
					case TagTypes.DoABCWithoutFlagsAndName:
						ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCClasses}).ABCData;
					break;
					default:
						ABCData=null;
					break;
				}
				if(ABCData){
					for each(var clazz:ABCClass in ABCData.classV){
						if(clazz.getClassName()==docClassName){
							return clazz;
						}
					}
				}
			}
			throw new Error("找不到 docClassName");
		}
		return null;
	}
}
		