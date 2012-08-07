/***
BytesData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月24日 20:24:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.getfonts.swf{
	
	import flash.utils.ByteArray;
	
	public class BytesData{//implements I_zero_swf_CheckCodesRight{
		public var ownData:ByteArray;
		public var dataOffset:int;
		public var dataLength:int;
		public function BytesData(){
		}
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			ownData=data;
			dataOffset=offset;
			dataLength=endOffset-offset;
			return endOffset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			if(dataLength>0){
				data.writeBytes(ownData,dataOffset,dataLength);
			}
			return data;
		}
	}
}

