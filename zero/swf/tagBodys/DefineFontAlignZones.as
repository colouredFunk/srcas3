/***
DefineFontAlignZones
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The DefineFont3 tag can be modified by a DefineFontAlignZones tag. The advanced text
//rendering engine uses alignment zones to establish the borders of a glyph for pixel snapping.
//Alignment zones are critical for high-quality display of fonts.
//The alignment zone defines a bounding box for strong vertical and horizontal components of
//a glyph. The box is described by a left coordinate, thickness, baseline coordinate, and height.
//Small thicknesses or heights are often set to 0.
//For example, consider the letter I. The letter I has a strong horizontal at its baseline and the
//top of the letter. The letter I also has strong verticals that occur at the edges of the stem—not
//the short top bar or serif. These strong verticals and horizontals of the center block of the
//letter define the alignment zones.
//
//The minimum file format version is SWF 8.
//
//DefineFontAlignZones
//Field 					Type 					Comment
//Header 					RECORDHEADER 			Tag type = 73.
//FontID 					UI16 					ID of font to use, specified by DefineFont3.
//CSMTableHint 				UB[2] 					Font thickness hint. Refers to the thickness of the typical stroke used in the font.
//													0 = thin
//													1 = medium
//													2 = thick
//													Flash Player maintains a selection of CSM tables for many fonts. However, if the font is not found in Flash Player's internal table, this hint is used to choose an appropriate table.
//Reserved 					UB[6] 					Must be 0.
//ZoneTable 				ZONERECORD[GlyphCount] 	Alignment zone information for each glyph.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineFontAlignZones/*{*/implements I_zero_swf_CheckCodesRight{
		public var FontID:int;							//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			FontID=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=FontID;
			data[1]=FontID>>8;
			data.position=2;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="DefineFontAlignZones"
				FontID={FontID}
			/>;
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			FontID=int(xml.@FontID.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
