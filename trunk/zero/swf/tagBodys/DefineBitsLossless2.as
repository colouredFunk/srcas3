/***
DefineBitsLossless2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 20:01:27 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DefineBitsLossless2 extends DefineBitsLossless with support for opacity (alpha values). The
//colormap colors in colormapped images are defined using RGBA values, and direct images
//store 32-bit ARGB colors for each pixel. The intermediate 15-bit color depth is not available
//in DefineBitsLossless2.
//The minimum file format version for this tag is SWF 3.
//

//DefineBitsLossless2
//Field 					Type 										Comment
//Header 					RECORDHEADER (long) 						Tag type = 36
//CharacterID 				UI16 										ID for this character
//BitmapFormat 				UI8 										Format of compressed data
//																		3 = 8-bit colormapped image
//																		5 = 32-bit ARGB image
//BitmapWidth 				UI16 										Width of bitmap image
//BitmapHeight 				UI16 										Height of bitmap image
//BitmapColorTableSize 		If BitmapFormat = 3, UI8					This value is one less than the actual number of colors in the color table, allowing for up to 256 colors.
//							Otherwise absent
//
//ZlibBitmapData 			If BitmapFormat = 3, ALPHACOLORMAPDATA		ZLIB compressed bitmap data
//							If BitmapFormat = 4 or 5, ALPHABITMAPDATA
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineBitsLossless2{
		public var id:int;								//UI16
		public var BitmapFormat:int;					//UI8
		public var BitmapWidth:int;						//UI16
		public var BitmapHeight:int;					//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			BitmapFormat=data[offset+2];
			BitmapWidth=data[offset+3]|(data[offset+4]<<8);
			BitmapHeight=data[offset+5]|(data[offset+6]<<8);
			offset+=7;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data[2]=BitmapFormat;
			data[3]=BitmapWidth;
			data[4]=BitmapWidth>>8;
			data[5]=BitmapHeight;
			data[6]=BitmapHeight>>8;
			data.position=7;
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineBitsLossless2"
				id={id}
				BitmapFormat={BitmapFormat}
				BitmapWidth={BitmapWidth}
				BitmapHeight={BitmapHeight}
			/>;
			xml.appendChild(restDatas.toXML("restDatas"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			BitmapFormat=int(xml.@BitmapFormat.toString());
			BitmapWidth=int(xml.@BitmapWidth.toString());
			BitmapHeight=int(xml.@BitmapHeight.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
