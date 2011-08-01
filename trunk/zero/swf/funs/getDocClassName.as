/***
getDocClassName
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月17日 21:39:57
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.*;
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	public function getDocClassName(swf:SWF):String{
		for each(var tag:Tag in swf.tagV){
			if(tag.type==TagTypes.SymbolClass){
				var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
				var i:int=-1;
				for each(var className:String in symbolClass.NameV){
					i++;
					if(symbolClass.TagV[i]==0){
						return className.replace(/\:\:/g,".");
					}
				}
			}
		}
		return null;
	}
}
		