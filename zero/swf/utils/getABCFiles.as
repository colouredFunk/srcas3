/***
getABCFiles
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月2日 23:05:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.avm2.ABCFile;
	import zero.swf.tagBodys.DoABC;
	import zero.swf.tagBodys.DoABCWithoutFlagsAndName;
	
	public function getABCFiles(swf:SWF,_initByDataOptions:Object=null):Vector.<ABCFile>{
		
		if(_initByDataOptions){
		}else{
			_initByDataOptions={};
		}
		_initByDataOptions.ABCDataClass=ABCFile;
		
		var ABCDataV:Vector.<ABCFile>=new Vector.<ABCFile>();
		for each(var tag:Tag in swf.tagV){
			switch(tag.type){
				case TagTypes.DoABC:
					ABCDataV.push(tag.getBody(DoABC,_initByDataOptions).ABCData);
				break;
				case TagTypes.DoABCWithoutFlagsAndName:
					ABCDataV.push(tag.getBody(DoABCWithoutFlagsAndName,_initByDataOptions).ABCData);
				break;
			}
		}
		return ABCDataV;
	}
}