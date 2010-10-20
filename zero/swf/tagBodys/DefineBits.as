/***
DefineBits 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月12日 21:34:02 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
	public class DefineBits extends TagBody{
		public var id:int;								//UI16
		public var JPEGData:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			//#offsetpp
			offset+=2;
			JPEGData=new BytesData();
			return JPEGData.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(JPEGData.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineBits
				id={id}
			>
				<JPEGData/>
			</DefineBits>;
			xml.JPEGData.appendChild(JPEGData.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			JPEGData=new BytesData();
			JPEGData.initByXML(xml.JPEGData.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
