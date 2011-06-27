/***
DefineText
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineText
//The DefineText tag defines a block of static text. It describes the font, size, color, and exact
//position of every character in the text object.
//The minimum file format version is SWF 1.
//DefineText
//Field 				Type 						Comment
//Header 				RECORDHEADER 				Tag type = 11.
//CharacterID 			UI16 						ID for this text character.
//TextBounds 			RECT 						Bounds of the text.
//TextMatrix 			MATRIX 						Transformation matrix for the text.
//GlyphBits 			UI8 						Bits in each glyph index.
//AdvanceBits 			UI8 						Bits in each advance value.
//TextRecords 			TEXTRECORD[zero or more] 	Text records.
//EndOfRecordsFlag 		UI8 						Must be 0.
//The TextBounds field is the rectangle that completely encloses all the characters in this text block.
//The GlyphBits and AdvanceBits fields define the number of bits used for the GlyphIndex and
//GlyphAdvance fields, respectively, in each GLYPHENTRY record.
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.swf.records.MATRIX;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineText{//implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var TextBounds:RECT;
		public var TextMatrix:MATRIX;
		public var GlyphBits:int;						//UI8
		public var AdvanceBits:int;						//UI8
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			TextBounds=new RECT();
			offset=TextBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			TextMatrix=new MATRIX();
			offset=TextMatrix.initByData(data,offset,endOffset,_initByDataOptions);
			GlyphBits=data[offset++];
			AdvanceBits=data[offset++];
			
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(TextBounds.toData(_toDataOptions));
			data.writeBytes(TextMatrix.toData(_toDataOptions));
			var offset:int=data.length;
			data[offset]=GlyphBits;
			data[offset+1]=AdvanceBits;
			data.position=offset+2;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineText"
				id={id}
				GlyphBits={GlyphBits}
				AdvanceBits={AdvanceBits}
			/>;
			xml.appendChild(TextBounds.toXML("TextBounds",_toXMLOptions));
			xml.appendChild(TextMatrix.toXML("TextMatrix",_toXMLOptions));
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			TextBounds=new RECT();
			TextBounds.initByXML(xml.TextBounds[0],_initByXMLOptions);
			TextMatrix=new MATRIX();
			TextMatrix.initByXML(xml.TextMatrix[0],_initByXMLOptions);
			GlyphBits=int(xml.@GlyphBits.toString());
			AdvanceBits=int(xml.@AdvanceBits.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
