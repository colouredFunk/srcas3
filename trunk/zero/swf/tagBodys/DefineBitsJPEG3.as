/***
DefineBitsJPEG3 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 14:54:30 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//This tag defines a bitmap character with JPEG compression. This tag extends
//DefineBitsJPEG2, adding alpha channel (opacity) data. Opacity/transparency information is
//not a standard feature in JPEG images, so the alpha channel information is encoded separately
//from the JPEG data, and compressed using the ZLIB standard for compression. The data
//format used by the ZLIB library is described by Request for Comments (RFCs) documents
//1950 to 1952.
//The data in this tag begins with the JPEG SOI marker 0xFF, 0xD8 and ends with the EOI
//marker 0xFF, 0xD9. Before version 8 of the SWF file format, SWF files could contain an
//erroneous header of 0xFF, 0xD9, 0xFF, 0xD8 before the JPEG SOI marker.
//In addition to specifying JPEG data, DefineBitsJPEG2 can also contain PNG image data and
//non-animated GIF89a image data.
//■ If ImageData begins with the eight bytes 0x89 0x50 0x4E 0x47 0x0D 0x0A 0x1A 0x0A, the
//ImageData contains PNG data.
//■ If ImageData begins with the six bytes 0x47 0x49 0x46 0x38 0x39 0x61, the ImageData
//contains GIF89a data.
//If ImageData contains PNG or GIF89a data, the optional BitmapAlphaData is not
//supported.
//The minimum file format version for this tag is SWF 3. The minimum file format version for
//embedding PNG of GIF89a data is SWF 8.
//
//DefineBitsJPEG3
//Field 				Type 					Comment
//Header 				RECORDHEADER (long) 	Tag type = 35.
//CharacterID 			UI16 					ID for this character.
//AlphaDataOffset 		UI32 					Count of bytes in ImageData.
//ImageData 			UI8[data size] 			Compressed image data in either JPEG, PNG, or GIF89a format
//BitmapAlphaData 		UI8[alpha data size] 	ZLIB compressed array of alpha data. Only supported when tag contains JPEG data. One byte per pixel. Total size after decompression must equal (width * height) of JPEG image.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineBitsJPEG3 extends TagBody{
		public var id:int;								//UI16
		
		public var AlphaDataOffset:uint;				//UI32
		public var ImageData:BytesData;
		public var BitmapAlphaData:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			
			AlphaDataOffset=data[offset+2]|(data[offset+3]<<8)|(data[offset+4]<<16)|(data[offset+5]<<24);
			offset+=6;
			ImageData=new BytesData();
			offset=ImageData.initByData(data,offset,offset+AlphaDataOffset);
			
			BitmapAlphaData=new BytesData();
			return BitmapAlphaData.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			AlphaDataOffset=ImageData.dataLength;
			data[2]=AlphaDataOffset;
			data[3]=AlphaDataOffset>>8;
			data[4]=AlphaDataOffset>>16;
			data[5]=AlphaDataOffset>>24;
			data.position=6;
			data.writeBytes(ImageData.toData());
			data.writeBytes(BitmapAlphaData.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineBitsJPEG3
				id={id}
				AlphaDataOffset={AlphaDataOffset}
			>
				<ImageData/>
				<BitmapAlphaData/>
			</DefineBitsJPEG3>;
			xml.ImageData.appendChild(ImageData.toXML());
			xml.BitmapAlphaData.appendChild(BitmapAlphaData.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			AlphaDataOffset=uint(xml.@AlphaDataOffset.toString());
			ImageData=new BytesData();
			ImageData.initByXML(xml.ImageData.children()[0]);
			BitmapAlphaData=new BytesData();
			BitmapAlphaData.initByXML(xml.BitmapAlphaData.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
