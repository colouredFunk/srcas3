/***
getABCFiles
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月2日 23:05:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public function getABCFiles(swf:SWF):Vector.<ABCFile>{
		var ABCDataV:Vector.<ABCFile>=new Vector.<ABCFile>();
		for each(var tag:Tag in swf.tagV){
			switch(tag.type){
				case TagTypes.DoABC:
					ABCDataV.push(tag.getBody(DoABC,{ABCDataClass:ABCFile}).ABCData);
				break;
				case TagTypes.DoABCWithoutFlagsAndName:
					ABCDataV.push(tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCFile}).ABCData);
				break;
			}
		}
		return ABCDataV;
	}
}