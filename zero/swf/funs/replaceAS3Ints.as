/***
replaceAS3Ints
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月24日 11:03:26
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import flash.utils.ByteArray;
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	import zero.swf.avm2.*;
	
	public function replaceAS3Ints(
		swfData:ByteArray,
		int0Arr:Array,
		inttArr:Array
	):ByteArray{
		
		//把 DoABC 或 DoABCWithoutFlagsAndName 的 ABCData 里的 integerV 里的特定的整数替换成特定的整数
		
		var swf:SWFExtend=new SWFExtend();
		swf.initBySWFData(swfData,null);
		
		if(swf.isAS3){
		}else{
			throw new Error("swf 必须是 AS3 的");
		}
		
		var mark:Object=new Object();
		var i:int=-1;
		for each(var int0:int in int0Arr){
			i++;
			mark["~"+int0]=inttArr[i];
		}
		
		for each(var ABCData:ABCFileWithSimpleConstant_pool in getABCFileWithSimpleConstant_pools(swf)){
			i=ABCData.integerV.length;
			while(--i>0){
				if(mark["~"+ABCData.integerV[i]] is int){
					ABCData.integerV[i]=mark["~"+ABCData.integerV[i]];
				}
			}
		}
		
		return swf.toSWFData(null);
	}
}