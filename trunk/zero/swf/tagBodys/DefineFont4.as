/***
DefineFont4
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineFont4
//DefineFont4 supports only the new Flash Text Engine. The storage of font data for embedded
//fonts is in CFF format.
//The minimum file format version is SWF 10.

//Header 				RECORDHEADER 			Tag type = 91
//FontID 				UI16 					ID for this font character.
//FontFlagsReserved 	UB[5] 					Reserved bit fields.
//FontFlagsHasFontData 	UB[1] 					Font is embedded. Font tag includes SFNT font data block.
//FontFlagsItalic 		UB[1] 					Italic font
//FontFlagsBold 		UB[1] 					Bold font
//FontName 				STRING 					Name of the font.
//FontData 				FONTDATA[0 or 1] 		When present, this is an OpenType CFF font, as defined in the OpenType specification at www.microsoft.com/ typography/otspec. The following tables must be present: 'CFF ', 'cmap', 'head', 'maxp', 'OS/2', 'post', and either (a) 'hhea' and 'hmtx', or (b) 'vhea', 'vmtx', and 'VORG'. The 'cmap' table must include one of the following kinds of Unicode 'cmap' subtables: (0, 4), (0, 3), (3, 10), (3, 1), or (3, 0) [notation: (platform ID, platformspecific encoding ID)]. Tables such as 'GSUB', 'GPOS', 'GDEF', and 'BASE' may also be present. Only present for embedded fonts.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineFont4/*{*/implements I_zero_swf_CheckCodesRight{
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
			var xml:XML=<{xmlName} class="DefineFont4"
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
