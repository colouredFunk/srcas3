/***
DefineFont3
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineFont3
//The DefineFont3 tag is introduced along with the DefineFontAlignZones tag in SWF 8. The
//DefineFontAlignZones tag is optional but recommended for SWF files using advanced antialiasing,
//and it modifies the DefineFont3 tag.
//The DefineFont3 tag extends the functionality of DefineFont2 by expressing the SHAPE
//coordinates in the GlyphShapeTable at 20 times the resolution. All the EMSquare coordinates
//are multiplied by 20 at export, allowing fractional resolution to 1/20 of a unit. This allows for
//more precisely defined glyphs and results in better visual quality.
//The minimum file format version is SWF 8.

//DefineFont3
//Field 					Type 												Comment
//Header 					RECORDHEADER 										Tag type = 75.
//FontID 					UI16 												ID for this font character.
//FontFlagsHasLayout 		UB[1] 												Has font metrics/layout information.
//FontFlagsShiftJIS 		UB[1] 												ShiftJIS encoding.
//FontFlagsSmallText 		UB[1] 												SWF 7 or later: Font is small. Character glyphs are aligned on pixel boundaries for dynamic and input text.
//FontFlagsANSI 			UB[1] 												ANSI encoding.
//FontFlagsWideOffsets 		UB[1] 												If 1, uses 32 bit offsets.
//FontFlagsWideCodes 		UB[1] 												Must be 1.
//FontFlagsItalic 			UB[1] 												Italic Font.
//FontFlagsBold 			UB[1] 												Bold Font.
//LanguageCode 				LANGCODE 											SWF 5 or earlier: always 0
//																				SWF 6 or later: language code
//FontNameLen 				UI8 												Length of name.
//FontName 					UI8[FontNameLen]									Name of font (see DefineFontInfo).
//NumGlyphs 				UI16 												Count of glyphs in font. May be zero for device fonts.
//OffsetTable 				If FontFlagsWideOffsets, UI32[NumGlyphs]			Same as in DefineFont.
//							Otherwise UI16[NumGlyphs]
//CodeTableOffset 			If FontFlagsWideOffsets, UI32						Byte count from start of OffsetTable to start of CodeTable.
//							Otherwise UI16
//GlyphShapeTable 			SHAPE[NumGlyphs] 									Same as in DefineFont.
//CodeTable 				UI16[NumGlyphs] 									Sorted in ascending order. Always UCS-2 in SWF 6 or later.
//FontAscent 				If FontFlagsHasLayout, SI16 						Font ascender height.
//FontDescent 				If FontFlagsHasLayout, SI16 						Font descender height.
//FontLeading 				If FontFlagsHasLayout, SI16 						Font leading height (see following).
//FontAdvanceTable 			If FontFlagsHasLayout, SI16[NumGlyphs]				Advance value to be used for each glyph in dynamic glyph text.
//FontBoundsTable 			If FontFlagsHasLayout, RECT[NumGlyphs]				Not used in Flash Player through version 7 (but must be present).
//KerningCount 				If FontFlagsHasLayout, UI16 						Not used in Flash Player through version 7 (always set to 0 to save space).
//FontKerningTable 			If FontFlagsHasLayout, KERNINGRECORD[KerningCount]	Not used in Flash Player through version 7 (omit with KerningCount of 0).
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineFont3/*{*/implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="DefineFont3"
				id={id}
			/>;
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			id=int(xml.@id.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
