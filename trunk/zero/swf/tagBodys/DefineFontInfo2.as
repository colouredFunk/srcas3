/***
DefineFontInfo2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 18:23:10 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DefineFontInfo2
//When generating SWF 6 or later, it is recommended that you use the new DefineFontInfo2
//tag rather than DefineFontInfo. DefineFontInfo2 is identical to DefineFontInfo, except that
//it adds a field for a language code. If you use the older DefineFontInfo, the language code will
//be assumed to be zero, which results in behavior that is dependent on the locale in which
//Flash Player is running.
//
//The minimum file format version is SWF 6.
//
//DefineFontInfo2
//Field 				Type 				Comment
//Header				RECORDHEADER 		Tag type = 62.
//FontID 				UI16 				Font ID this information is for.
//FontNameLen 			UI8 				Length of font name.
//FontName 				UI8[FontNameLen] 	Name of the font.
//FontFlagsReserved 	UB[2] 				Reserved bit fields.
//FontFlagsSmallText 	UB[1] 				SWF 7 or later: Font is small. Character glyphs are aligned on pixel boundaries for dynamic and input text.
//FontFlagsShiftJIS 	UB[1] 				Always 0.
//FontFlagsANSI 		UB[1] 				Always 0.
//FontFlagsItalic 		UB[1] 				Font is italic.
//FontFlagsBold 		UB[1] 				Font is bold.
//FontFlagsWideCodes 	UB[1] 				Always 1.
//LanguageCode 			LANGCODE 			Language ID.
//CodeTable 			UI16[nGlyphs] 		Glyph to code table in UCS-2,sorted in ascending order.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineFontInfo2{
		public var FontID:int;							//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			FontID=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=FontID;
			data[1]=FontID>>8;
			data.position=2;
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineFontInfo2"
				FontID={FontID}
			/>;
			xml.appendChild(restDatas.toXML("restDatas"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			FontID=int(xml.@FontID.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
