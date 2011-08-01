/***
BytesData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月24日 20:24:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	
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
		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			if(dataLength>0){
				if(_toXMLOptions&&_toXMLOptions.BytesDataToXMLOption=="数据块（仅位置）"){
					return <{xmlName} class="zero.swf.BytesData"
						src={_toXMLOptions.src||_toXMLOptions.getSrcFun(ownData)}
						offset={dataOffset}
						length={dataLength}
					/>;
				}
				return <{xmlName} class="zero.swf.BytesData"
					length={dataLength}
					value={BytesAndStr16.bytes2str16(ownData,dataOffset,dataLength)}
				/>;
			}
			return <{xmlName} class="zero.swf.BytesData"/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var value:String=xml.@value.toString();
			if(value){
				var data:ByteArray=BytesAndStr16.str162bytes(value);
				initByData(data,0,data.length,null);
			}else{
				var src:String=xml.@src.toString();
				if(src){
					if(_initByXMLOptions){
					}else{
						throw new Error("需要提供 _initByXMLOptions");
					}
					var offset:int=int(xml.@offset.toString());
					initByData(_initByXMLOptions.resData||_initByXMLOptions.getResDataFun(src),offset,offset+int(xml.@length.toString()),null);
				}else{
					initByData(new ByteArray(),0,0,null);
				}
			}
		}
		}//end of CONFIG::USE_XML
	}
}

