/***
getYouyouwinShellClassName
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月13日 09:06:32
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	public function getYouyouwinShellClassName(swf:SWF):String{
		var docClassName:String=getDocClassName(swf);
		if(docClassName){
			if(
				docClassName=="SWFShellAdderOnline"
				||
				docClassName.indexOf("@youyouwin")==0
			){
				return docClassName;
			}
		}
		return null;
	}
}
		