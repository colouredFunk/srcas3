/***
DefineFont2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineFont2
//The DefineFont2 tag extends the functionality of DefineFont. Enhancements include
//the following:
//■ 32-bit entries in the OffsetTable, for fonts with more than 64K glyphs.
//■ Mapping to device fonts, by incorporating all the functionality of DefineFontInfo.
//■ Font metrics for improved layout of dynamic glyph text.
//DefineFont2 tags are the only font definitions that can be used for dynamic text.
//The minimum file format version is SWF 3.
//
//DefineFont2
//Field 					Type 												Comment
//Header 					RECORDHEADER 										Tag type = 48.
//FontID 					UI16 												ID for this font character.
//FontFlagsHasLayout 		UB[1] 												Has font metrics/layout information.
//FontFlagsShiftJIS 		UB[1] 												ShiftJIS encoding.
//FontFlagsSmallText 		UB[1] 												SWF 7 or later: Font is small. Character glyphs are aligned on pixel boundaries for dynamic and input text.
//FontFlagsANSI 			UB[1] 												ANSI encoding.
//FontFlagsWideOffsets 		UB[1] 												If 1, uses 32 bit offsets.
//FontFlagsWideCodes 		UB[1] 												If 1, font uses 16-bit codes; otherwise font uses 8 bit codes.
//FontFlagsItalic 			UB[1] 												Italic Font.
//FontFlagsBold 			UB[1] 												Bold Font.
//LanguageCode 				LANGCODE 											SWF 5 or earlier: always 0
//																				SWF 6 or later: language code
//FontNameLen 				UI8 												Length of name.
//FontName 					UI8[FontNameLen] 									Name of font (see DefineFontInfo).
//NumGlyphs 				UI16 												Count of glyphs in font. May be zero for device fonts.
//OffsetTable 				If FontFlagsWideOffsets, UI32[NumGlyphs]			Same as in DefineFont.
//							Otherwise UI16[NumGlyphs]
//CodeTableOffset 			If FontFlagsWideOffsets, UI32						Byte count from start of OffsetTable to start of CodeTable.
//							Otherwise UI16
//
//GlyphShapeTable 			SHAPE[NumGlyphs] 									Same as in DefineFont.
//CodeTable 				If FontFlagsWideCodes, UI16[NumGlyphs]				Sorted in ascending order. Always UCS-2 in SWF 6 or later.
//							Otherwise UI8[NumGlyphs]
//FontAscent 				If FontFlagsHasLayout, SI16 						Font ascender height.
//FontDescent 				If FontFlagsHasLayout, SI16 						Font descender height.
//FontLeading 				If FontFlagsHasLayout, SI16 						Font leading height (see following).
//FontAdvanceTable 			If FontFlagsHasLayout, SI16[NumGlyphs]				Advance value to be used for each glyph in dynamic glyph text.
//FontBoundsTable 			If FontFlagsHasLayout, RECT[NumGlyphs]				Not used in Flash Player through version 7 (but must be present).
//KerningCount 				If FontFlagsHasLayout, UI16 						Not used in Flash Player through version 7 (always set to 0 to save space).
//FontKerningTable 			If FontFlagsHasLayout, KERNINGRECORD[KerningCount]	Not used in Flash Player through version 7 (omit with KerningCount of 0).
//In SWF 6 or later files, DefineFont2 has the same Unicode requirements as DefineFontInfo.
//Similarly to the DefineFontInfo tag, the CodeTable (and thus also the OffsetTable,
//GlyphShapeTable, and FontAdvanceTable) must be sorted in code point order.
//If a DefineFont2 tag will be used only for dynamic device text, and no glyph-rendering
//fallback is desired, set NumGlyphs to zero, and omit all tables having NumGlyphs entries.
//This will substantially reduce the size of the DefineFont2 tag. DefineFont2 tags without
//glyphs cannot support static text, which uses glyph indices to select characters, and also
//cannot support glyph text, which requires glyph shape definitions.
//Layout information (ascent, descent, leading, advance table, bounds table, kerning table) is
//useful only for dynamic glyph text. This information takes the place of the per-character
//placement information that is used in static glyph text. The layout information in the
//DefineFont2 tag is fairly standard font-metrics information that can typically be extracted
//directly from a standard font definition, such as a TrueType font.

//NOTE
//Leading is a vertical line-spacing metric. It is the distance (in EM-square coordinates)
//between the bottom of the descender of one line and the top of the ascender of the next
//line.
//
//As with DefineFont, in DefineFont2 the first STYLECHANGERECORD of each SHAPE in
//the GlyphShapeTable does not use the LineStyle and LineStyles fields. In addition, the first
//STYLECHANGERECORD of each shape must have both fields StateFillStyle0 and
//FillStyle0 set to 1.
//The DefineFont2 tag reserves space for a font bounds table and kerning table. This
//information is not used in Flash Player through version 7. However, this information must be
//present in order to constitute a well-formed DefineFont2 tag. Supply minimal (low-bit)
//RECTs for FontBoundsTable, and always set KerningCount to zero, which allows
//FontKerningTable to be omitted.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineFont2{//implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineFont2"
				id={id}
			/>;
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
