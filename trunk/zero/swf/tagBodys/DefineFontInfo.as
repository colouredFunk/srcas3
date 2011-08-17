/***
DefineFontInfo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The DefineFontInfo tag defines a mapping from a glyph font (defined with DefineFont) to a
//device font. It provides a font name and style to pass to the playback platform's text engine,
//and a table of character codes that identifies the character represented by each glyph in the
//corresponding DefineFont tag, allowing the glyph indices of a DefineText tag to be converted
//to character strings.
//The presence of a DefineFontInfo tag does not force a glyph font to become a device font; it
//merely makes the option available. The actual choice between glyph and device usage is made
//according to the value of devicefont (see the introduction) or the value of UseOutlines in a
//DefineEditText tag. If a device font is unavailable on a playback platform, Flash Player will
//fall back to glyph text.
//
//The minimum file format version is SWF 1.
//
//DefineFontInfo
//Field 				Type 									Comment
//Header 				RECORDHEADER 							Tag type = 13.
//FontID 				UI16 									Font ID this information is for.
//FontNameLen 			UI8 									Length of font name.
//FontName 				UI8[FontNameLen] 						Name of the font (see following).
//FontFlagsReserved 	UB[2] 									Reserved bit fields.
//FontFlagsSmallText 	UB[1] 									SWF 7 file format or later: Font is small. Character glyphs are aligned on pixel boundaries for dynamic and input text.
//FontFlagsShiftJIS 	UB[1] 									ShiftJIS character codes.
//FontFlagsANSI 		UB[1] 									ANSI character codes.
//FontFlagsItalic 		UB[1] 									Font is italic.
//FontFlagsBold 		UB[1] 									Font is bold.
//FontFlagsWideCodes 	UB[1] 									If 1, CodeTable is UI16 array; otherwise, CodeTable is UI8 array.
//CodeTable 			If FontFlagsWideCodes, UI16[nGlyphs]	Glyph to code table, sorted in ascending order.
//						Otherwise, UI8[nGlyphs]
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineFontInfo{//implements I_zero_swf_CheckCodesRight{
		public var FontID:int;							//UI16
		public var restDatas:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			FontID=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.BytesData"]||BytesData)();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=FontID;
			data[1]=FontID>>8;
			data.position=2;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineFontInfo"
				FontID={FontID}
			/>;
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			FontID=int(xml.@FontID.toString());
			restDatas=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[xml.restDatas[0]["@class"].toString()]||BytesData)();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
