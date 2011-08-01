/***
RemoveObject 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 16:01:29 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//RemoveObject
//The RemoveObject tag removes the specified character (at the specified depth) from the
//display list.
//The minimum file format version is SWF 1.

//RemoveObject
//Field 		Type 			Comment
//Header 		RECORDHEADER 	Tag type = 5
//CharacterId 	UI16 			ID of character to remove
//Depth 		UI16 			Depth of character
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class RemoveObject{//implements I_zero_swf_CheckCodesRight{
		public var CharacterId:int;						//UI16
		public var Depth:int;							//UI16
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			CharacterId=data[offset++]|(data[offset++]<<8);
			Depth=data[offset++]|(data[offset++]<<8);
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=CharacterId;
			data[1]=CharacterId>>8;
			data[2]=Depth;
			data[3]=Depth>>8;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.RemoveObject"
				CharacterId={CharacterId}
				Depth={Depth}
			/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			CharacterId=int(xml.@CharacterId.toString());
			Depth=int(xml.@Depth.toString());
		}
		}//end of CONFIG::USE_XML
	}
}
