/***
replaceInts
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
	public function replaceInts(
		swfData:ByteArray,
		int0Arr:Array,
		inttArr:Array
	):ByteArray{
		var swf:SWF=new SWF();
		swf.initBySWFData(swfData,null);
		
		var int0:int;
		var i:int;
		
		var mark:Object=new Object();
		i=-1;
		for each(int0 in int0Arr){
			i++;
			mark[int0]=inttArr[i];
		}
		
		var ABCData:ABCFileWithSimpleConstant_pool;
		for each(var tag:Tag in swf.tagV){
			switch(tag.type){
				case TagTypes.DoABC:
					ABCData=tag.getBody(DoABC,{ABCDataClass:ABCFileWithSimpleConstant_pool}).ABCData;
				break;
				case TagTypes.DoABCWithoutFlagsAndName:
					ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCFileWithSimpleConstant_pool}).ABCData;
				break;
				default:
					ABCData=null;
				break;
			}
			if(ABCData){
				i=ABCData.integerV.length;
				while(--i>0){
					if(mark.hasOwnProperty(ABCData.integerV[i])){
						ABCData.integerV[i]=mark[ABCData.integerV[i]]
					}
				}
			}
		}
		
		return swf.toSWFData(null);
	}
}