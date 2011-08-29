/***
DefineFontInfo2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 10:34:42（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
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
	
	import flash.utils.ByteArray;
	
	public class DefineFontInfo2{
		
		public var FontID:int;//UI16
		public var FontName:String;//STRING
		//public var Reserved:int;//11000000
		public var FontFlagsSmallText:Boolean;//00100000
		public var FontFlagsShiftJIS:Boolean;//00010000
		public var FontFlagsANSI:Boolean;//00001000
		public var FontFlagsItalic:Boolean;//00000100
		public var FontFlagsBold:Boolean;//00000010
		//public var Reserved:int;//00000001
		public var LanguageCode:int;//LANGCODE
		public var CodeV:Vector.<int>;//UI16
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var get_str_size:int;
			var flags:int;
			var i:int;
			
			FontID=data[offset++]|(data[offset++]<<8);
			
			var FontNameLen:int=data[offset++];
			data.position=offset;
			FontName=data.readUTFBytes(FontNameLen);
			offset+=FontNameLen;
			
			flags=data[offset++];
			//Reserved=flags&0xc0;//11000000
			FontFlagsSmallText=((flags&0x20)?true:false);//00100000
			FontFlagsShiftJIS=((flags&0x10)?true:false);//00010000
			FontFlagsANSI=((flags&0x08)?true:false);//00001000
			FontFlagsItalic=((flags&0x04)?true:false);//00000100
			FontFlagsBold=((flags&0x02)?true:false);//00000010
			//Reserved=flags&0x01;//00000001
			
			LanguageCode=data[offset++];
			
			i=-1;
			CodeV=new Vector.<int>();
			while(offset<endOffset){
				i++;
				
				CodeV[i]=data[offset++]|(data[offset++]<<8);
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var flags:int;
			
			var data:ByteArray=new ByteArray();
			
			data[0]=FontID;
			data[1]=FontID>>8;
			
			var set_str_data:ByteArray=new ByteArray();
			set_str_data.writeUTFBytes(FontName+"\x00");
			if(set_str_data.length>0xff){
				throw new Error("set_str_data.length="+set_str_data.length);
			}
			data[2]=set_str_data.length;
			data.position=3;
			data.writeBytes(set_str_data);
			
			flags=0;
			//flags|=Reserved;//11000000
			if(FontFlagsSmallText){
				flags|=0x20;//00100000
			}
			if(FontFlagsShiftJIS){
				flags|=0x10;//00010000
			}
			if(FontFlagsANSI){
				flags|=0x08;//00001000
			}
			if(FontFlagsItalic){
				flags|=0x04;//00000100
			}
			if(FontFlagsBold){
				flags|=0x02;//00000010
			}
			flags|=0x01;//00000001
			data[data.length]=flags;
			
			data[data.length]=LanguageCode;
			
			for each(var Code:int in CodeV){
				
				data[data.length]=Code;
				data[data.length]=Code>>8;
				
			}
			
			return data;
			
		}
		
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineFontInfo2"
					FontID={FontID}
					FontName={FontName}
					FontFlagsSmallText={FontFlagsSmallText}
					FontFlagsShiftJIS={FontFlagsShiftJIS}
					FontFlagsANSI={FontFlagsANSI}
					FontFlagsItalic={FontFlagsItalic}
					FontFlagsBold={FontFlagsBold}
					LanguageCode={LANGCODEs.codeV[LanguageCode]}
				/>;
				
				if(CodeV.length){
					var CodeListXML:XML=<CodeList count={CodeV.length}/>;
					for each(var Code:int in CodeV){
						
						CodeListXML.appendChild(<Code value={Code} info={String.fromCharCode(Code)}/>);
						
					}
					xml.appendChild(CodeListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				var i:int;
				
				FontID=int(xml.@FontID.toString());
				
				FontName=xml.@FontName.toString();
				
				FontFlagsSmallText=(xml.@FontFlagsSmallText.toString()=="true");
				FontFlagsShiftJIS=(xml.@FontFlagsShiftJIS.toString()=="true");
				FontFlagsANSI=(xml.@FontFlagsANSI.toString()=="true");
				FontFlagsItalic=(xml.@FontFlagsItalic.toString()=="true");
				FontFlagsBold=(xml.@FontFlagsBold.toString()=="true");
				
				LanguageCode=LANGCODEs[xml.@LanguageCode.toString()];
				
				i=-1;
				CodeV=new Vector.<int>();
				for each(var CodeXML:XML in xml.CodeList.Code){
					i++;
					
					CodeV[i]=int(CodeXML.@value.toString());
					
				}
				
			}
		}
	}
}