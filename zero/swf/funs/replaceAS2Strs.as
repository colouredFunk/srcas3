/***
replaceAS2Strs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月30日 13:13:03
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import flash.utils.ByteArray;
	
	import zero.swf.*;
	import zero.swf.avm1.*;
	import zero.swf.codes.Code;
	import zero.swf.tagBodys.*;
	
	public function replaceAS2Strs(
		swfData:ByteArray,
		str0Arr:Array,
		strtArr:Array
	):ByteArray{
		
		//把 Actions 里的特定的字符串替换成特定的字符串
		
		var swf:SWFExtend=new SWFExtend();
		swf.initBySWFData(swfData,null);
		
		if(swf.isAS3){
			throw new Error("swf 不能是 AS3 的");
		}
		
		var i:int;
		
		var mark:Object=new Object();
		i=-1;
		for each(var str0:String in str0Arr){
			i++;
			mark["~"+str0]=strtArr[i];
		}
		
		var strt:String;
		
		for each(var Actions:ACTIONRECORDs in getActions(swf)){
			for each(var code:* in Actions.codeArr){
				if(code is Code){
					switch(code.op){
						case AVM1Ops.getURL:
							strt=mark["~"+code.value.UrlString];
							if(strt is String){
								code.value.UrlString=strt;
							}
						break;
						case AVM1Ops.push:
							i=code.value.length;
							while(--i>=0){
								strt=mark["~"+code.value[i]];
								if(strt is String){
									code.value[i]=strt;
								}
							}
						break;
					}
				}
			}
		}
		
		return swf.toSWFData(null);
	}
}