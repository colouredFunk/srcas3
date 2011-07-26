/***
DefineBitsJPEG2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineBitsJPEG2
//This tag defines a bitmap character with JPEG compression. It differs from DefineBits in that
//it contains both the JPEG encoding table and the JPEG image data. This tag allows multiple
//JPEG images with differing encoding tables to be defined within a single SWF file.
//The data in this tag begins with the JPEG SOI marker 0xFF, 0xD8 and ends with the EOI
//marker 0xFF, 0xD9. Before version 8 of the SWF file format, SWF files could contain an
//erroneous header of 0xFF, 0xD9, 0xFF, 0xD8 before the JPEG SOI marker.
//In addition to specifying JPEG data, DefineBitsJPEG2 can also contain PNG image data and
//non-animated GIF89a image data.
//■ If ImageData begins with the eight bytes 0x89 0x50 0x4E 0x47 0x0D 0x0A 0x1A 0x0A, the
//ImageData contains PNG data.
//■ If ImageData begins with the six bytes 0x47 0x49 0x46 0x38 0x39 0x61, the ImageData
//contains GIF89a data.
//The minimum file format version for this tag is SWF 2. The minimum file format version for
//embedding PNG of GIF89a data is SWF 8.
//
//DefineBitsJPEG2
//Field 			Type 					Comment
//Header 			RECORDHEADER (long) 	Tag type = 21
//CharacterID 		UI16 					ID for this character
//ImageData 		UI8[data size] 			Compressed image data in either JPEG, PNG, or GIF89a format
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineBitsJPEG2{//implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var ImageData:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			id=data[offset++]|(data[offset++]<<8);
			var ImageDataClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ImageDataClass=_initByDataOptions.classes["zero.swf.BytesData"];
				}
			}
			ImageData=new (ImageDataClass||BytesData)();
			return ImageData.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ImageData.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineBitsJPEG2"
				id={id}
			/>;
			xml.appendChild(ImageData.toXML("ImageData",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			ImageData=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[xml.ImageData[0]["@class"].toString()]||BytesData)();
			ImageData.initByXML(xml.ImageData[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
