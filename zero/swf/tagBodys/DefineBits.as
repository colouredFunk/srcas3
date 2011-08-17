/***
DefineBits
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//This tag defines a bitmap character with JPEG compression. It contains only the JPEG
//compressed image data (from the Frame Header onward). A separate JPEGTables tag contains
//the JPEG encoding data used to encode this image (the Tables/Misc segment).
//NOTE
//Only one JPEGTables tag is allowed in a SWF file, and thus all bitmaps defined with
//DefineBits must share common encoding tables.
//The data in this tag begins with the JPEG SOI marker 0xFF, 0xD8 and ends with the EOI
//marker 0xFF, 0xD9. Before version 8 of the SWF file format, SWF files could contain an
//erroneous header of 0xFF, 0xD9, 0xFF, 0xD8 before the JPEG SOI marker.
//The minimum file format version for this tag is SWF 1.
//
//DefineBits
//Field 			Type 					Comment
//Header 			RECORDHEADER (long) 	Tag type = 6
//CharacterID 		UI16 					ID for this character
//JPEGData 			UI8[image data size] 	JPEG compressed image
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineBits{//implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var JPEGData:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			id=data[offset++]|(data[offset++]<<8);
			var JPEGDataClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					JPEGDataClass=_initByDataOptions.classes["zero.swf.BytesData"];
				}
			}
			JPEGData=new (JPEGDataClass||BytesData)();
			return JPEGData.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(JPEGData.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineBits"
				id={id}
			/>;
			xml.appendChild(JPEGData.toXML("JPEGData",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			JPEGData=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[xml.JPEGData[0]["@class"].toString()]||BytesData)();
			JPEGData.initByXML(xml.JPEGData[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
