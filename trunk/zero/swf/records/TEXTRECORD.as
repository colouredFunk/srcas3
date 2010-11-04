/***
TEXTRECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月4日 21:43:47 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Text records
//A TEXTRECORD sets text styles for subsequent characters. It can be used to select a font,
//change the text color, change the point size, insert a line break, or set the x and y position of
//the next character in the text. The new text styles apply until another TEXTRECORD
//changes the styles.
//The TEXTRECORD also defines the actual characters in a text object. Characters are
//referred to by an index into the current font's glyph table, not by a character code. Each
//TEXTRECORD contains a group of characters that all share the same text style, and are on
//the same line of text.

//TEXTRECORD
//Field 				Type 												Comment
//TextRecordType 		UB[1] 												Always 1.
//StyleFlagsReserved 	UB[3] 												Always 0.
//StyleFlagsHasFont 	UB[1] 												1 if text font specified.
//StyleFlagsHasColor 	UB[1] 												1 if text color specified.
//StyleFlagsHasYOffset 	UB[1] 												1 if y offset specified.
//StyleFlagsHasXOffset 	UB[1] 												1 if x offset specified.
//FontID 				If StyleFlagsHasFont, UI16 							Font ID for following text.
//TextColor 			If StyleFlagsHasColor, RGB							Font color for following text.
//						If this record is part of a DefineText2 tag, RGBA
//XOffset 				If StyleFlagsHasXOffset, SI16 						x offset for following text.
//YOffset 				If StyleFlagsHasYOffset, SI16 						y offset for following text.
//TextHeight 			If hasFont, UI16 									Font height for following text.
//GlyphCount 			UI8 												Number of glyphs in record.
//GlyphEntries 			GLYPHENTRY[GlyphCount] 								Glyph entry (see following).

//The FontID field is used to select a previously defined font. This ID uniquely identifies a
//DefineFont or DefineFont2 tag from earlier in the SWF file.
//The TextHeight field defines the height of the font in twips. For example, a pixel height of 50
//is equivalent to a TextHeight of 1000. (50 * 20 = 1000).
//The XOffset field defines the offset from the left of the TextBounds rectangle to the reference
//point of the glyph (the point within the EM square from which the first curve segment
//departs). Typically, the reference point is on the baseline, near the left side of the glyph (see
//the example for Glyph text). The XOffset is generally used to create indented text or non-leftjustified
//text. If there is no XOffset specified, the offset is assumed to be zero.
//The YOffset field defines the offset from the top of the TextBounds rectangle to the reference
//point of the glyph. The TextYOffset is generally used to insert line breaks, moving the text
//position to the start of a new line.
//The GlyphCount field defines the number of characters in this string, and the size of the
//GLYPHENTRY table.

//Glyph entry
//The GLYPHENTRY structure describes a single character in a line of text. It is composed of
//an index into the current font's glyph table, and an advance value. The advance value is the
//horizontal distance between the reference point of this character and the reference point of the
//following character.
//GLYPHENTRY
//Field 				Type 				Comment
//GlyphIndex 			UB[GlyphBits] 		Glyph index into current font.
//GlyphAdvance 			SB[AdvanceBits] 	x advance value for glyph.
package zero.swf.records{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class TEXTRECORD{
		public static var GlyphBits:int;
		public static var AdvanceBits:int;
		public var TextRecordType:int;
		public var StyleFlagsHasFont:int;
		public var StyleFlagsHasColor:int;
		public var StyleFlagsHasYOffset:int;
		public var StyleFlagsHasXOffset:int;
		public var FontID:int;							//UI16
		public var TextColor:int;						//RGB
		public var XOffset:int;							//SI16
		public var YOffset:int;							//SI16
		public var TextHeight:int;						//UI16
		public var GlyphIndexV:Vector.<int>;
		public var GlyphAdvanceV:Vector.<int>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var flags:int=data[offset];
			TextRecordType=(flags<<24)>>>31;			//10000000
			//Reserved=(flags<<25)>>>29;				//01110000
			StyleFlagsHasFont=(flags<<28)>>>31;			//00001000
			StyleFlagsHasColor=(flags<<29)>>>31;		//00000100
			StyleFlagsHasYOffset=(flags<<30)>>>31;		//00000010
			StyleFlagsHasXOffset=flags&0x01;			//00000001
			++offset;
			if(StyleFlagsHasFont){
				FontID=data[offset++]|(data[offset++]<<8);
			}
			
			if(StyleFlagsHasColor){
				TextColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			}
			
			if(StyleFlagsHasXOffset){
				XOffset=data[offset++]|(data[offset++]<<8);
				if(XOffset&0x00008000){XOffset|=0xffff0000}//最高位为1,表示负数
			}
			
			if(StyleFlagsHasYOffset){
				YOffset=data[offset++]|(data[offset++]<<8);
				if(YOffset&0x00008000){YOffset|=0xffff0000}//最高位为1,表示负数
			}
			
			if(StyleFlagsHasFont){
				TextHeight=data[offset++]|(data[offset++]<<8);
			}
			var GlyphCount:int=data[offset++];
			GlyphIndexV=new Vector.<int>(GlyphCount);
			GlyphAdvanceV=new Vector.<int>(GlyphCount);
			
			var bGroupValue:int=(data[offset++]<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			var bGroupBitsOffset:int=0;
			var GlyphBGroupRshiftBitsOffset:int=32-GlyphBits;
			var AdvanceBGroupRshiftBitsOffset:int=32-AdvanceBits;
			
			for(var i:int=0;i<GlyphCount;i++){
				if(GlyphBits){
					GlyphIndexV[i]=(bGroupValue<<bGroupBitsOffset)>>>GlyphBGroupRshiftBitsOffset;
					bGroupBitsOffset+=GlyphBits;
			
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				}
			
				if(AdvanceBits){
					GlyphAdvanceV[i]=(bGroupValue<<bGroupBitsOffset)>>>AdvanceBGroupRshiftBitsOffset;
					bGroupBitsOffset+=AdvanceBits;
			
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				}
			}
			return offset-int(4-bGroupBitsOffset/8);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			flags|=TextRecordType<<7;					//10000000
			//flags|=Reserved<<4;						//01110000
			flags|=StyleFlagsHasFont<<3;				//00001000
			flags|=StyleFlagsHasColor<<2;				//00000100
			flags|=StyleFlagsHasYOffset<<1;				//00000010
			flags|=StyleFlagsHasXOffset;				//00000001
			data[0]=flags;
			
			var offset:int=1;
			if(StyleFlagsHasFont){
				data[offset++]=FontID;
				data[offset++]=FontID>>8;
			}
			
			if(StyleFlagsHasColor){
				data[offset++]=TextColor>>16;
				data[offset++]=TextColor>>8;
				data[offset++]=TextColor;
			}
			
			if(StyleFlagsHasXOffset){
				data[offset++]=XOffset;
				data[offset++]=XOffset>>8;
			}
			
			if(StyleFlagsHasYOffset){
				data[offset++]=YOffset;
				data[offset++]=YOffset>>8;
			}
			
			if(StyleFlagsHasFont){
				data[offset++]=TextHeight;
				data[offset++]=TextHeight>>8;
			}
			var GlyphCount:int=GlyphIndexV.length;
			data[offset++]=GlyphCount;
			
			var bGroupValue:int=0;
			var bGroupBitsOffset:int=0;
			var GlyphBGroupRshiftBitsOffset:int=32-GlyphBits;
			var AdvanceBGroupRshiftBitsOffset:int=32-AdvanceBits;
			
			var i:int=-1;
			for each(var GlyphIndex:int in GlyphIndexV){
				i++;
				if(GlyphBits){
					bGroupValue|=(GlyphIndex<<GlyphBGroupRshiftBitsOffset)>>>bGroupBitsOffset;
					bGroupBitsOffset+=GlyphBits;
			
					//向 data 写入满8位(1字节)的数据:
					if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				}
			
				if(AdvanceBits){
					bGroupValue|=(GlyphAdvanceV[i]<<AdvanceBGroupRshiftBitsOffset)>>>bGroupBitsOffset;
					bGroupBitsOffset+=AdvanceBits;
			
					//向 data 写入满8位(1字节)的数据:
					if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				}
			
			}
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="TEXTRECORD"
				TextRecordType={TextRecordType}
				StyleFlagsHasFont={StyleFlagsHasFont}
				StyleFlagsHasColor={StyleFlagsHasColor}
				StyleFlagsHasYOffset={StyleFlagsHasYOffset}
				StyleFlagsHasXOffset={StyleFlagsHasXOffset}
				FontID={FontID}
				TextColor={"0x"+BytesAndStr16._16V[(TextColor>>16)&0xff]+BytesAndStr16._16V[(TextColor>>8)&0xff]+BytesAndStr16._16V[TextColor&0xff]}
				XOffset={XOffset}
				YOffset={YOffset}
				TextHeight={TextHeight}
			/>;
			if(StyleFlagsHasFont){
				
			}else{
				delete xml.@FontID;
			}
			if(StyleFlagsHasColor){
				
			}else{
				delete xml.@TextColor;
			}
			if(StyleFlagsHasXOffset){
				
			}else{
				delete xml.@XOffset;
			}
			if(StyleFlagsHasYOffset){
				
			}else{
				delete xml.@YOffset;
			}
			if(StyleFlagsHasFont){
				
			}else{
				delete xml.@TextHeight;
			}
			if(GlyphIndexV.length){
				var listXML:XML=<GlyphIndexAndGlyphAdvanceList count={GlyphIndexV.length}/>
				var i:int=-1;
				for each(var GlyphIndex:int in GlyphIndexV){
					i++;
					listXML.appendChild(<GlyphIndex value={GlyphIndex}/>);
					listXML.appendChild(<GlyphAdvance value={GlyphAdvanceV[i]}/>);
				}
				xml.appendChild(listXML);
			}
			
			return xml;
		}
		public function initByXML(xml:XML):void{
			TextRecordType=int(xml.@TextRecordType.toString());
			StyleFlagsHasFont=int(xml.@StyleFlagsHasFont.toString());
			StyleFlagsHasColor=int(xml.@StyleFlagsHasColor.toString());
			StyleFlagsHasYOffset=int(xml.@StyleFlagsHasYOffset.toString());
			StyleFlagsHasXOffset=int(xml.@StyleFlagsHasXOffset.toString());
			if(StyleFlagsHasFont){
				FontID=int(xml.@FontID.toString());
			}
			if(StyleFlagsHasColor){
				TextColor=int(xml.@TextColor.toString());
			}
			if(StyleFlagsHasXOffset){
				XOffset=int(xml.@XOffset.toString());
			}
			if(StyleFlagsHasYOffset){
				YOffset=int(xml.@YOffset.toString());
			}
			if(StyleFlagsHasFont){
				TextHeight=int(xml.@TextHeight.toString());
			}
			if(xml.GlyphIndexAndGlyphAdvanceList.length()){
				var listXML:XML=xml.GlyphIndexAndGlyphAdvanceList[0];
				var GlyphIndexXMLList:XMLList=listXML.GlyphIndex;
				var GlyphAdvanceXMLList:XMLList=listXML.GlyphAdvance;
				var i:int=-1;
				GlyphIndexV=new Vector.<int>(GlyphIndexXMLList.length());
				GlyphAdvanceV=new Vector.<int>(GlyphAdvanceXMLList.length());
				for each(var GlyphIndexXML:XML in GlyphIndexXMLList){
					i++;
					GlyphIndexV[i]=int(GlyphIndexXML.@value.toString());
					GlyphAdvanceV[i]=int(GlyphAdvanceXMLList[i].@value.toString());
				}
			}else{
				GlyphIndexV=new Vector.<int>();
				GlyphAdvanceV=new Vector.<int>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
