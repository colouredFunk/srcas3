/***
DefineText 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 21:00:29 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
	import zero.swf.records.TEXTRECORD;
	import flash.utils.ByteArray;
	public class DefineText{
		public var id:int;								//UI16
		public var TextBounds:RECT;
		public var TextMatrix:MATRIX;
		public var GlyphBits:int;						//UI8
		public var AdvanceBits:int;						//UI8
		
		public var TextRecordV:Vector.<TEXTRECORD>;
		public var EndOfRecordsFlag:int;				//UI8
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			TextBounds=new RECT();
			offset=TextBounds.initByData(data,offset,endOffset);
			
			TextMatrix=new MATRIX();
			offset=TextMatrix.initByData(data,offset,endOffset);
			GlyphBits=data[offset++];
			AdvanceBits=data[offset++];
			TEXTRECORD.GlyphBits=GlyphBits;
			TEXTRECORD.AdvanceBits=AdvanceBits;
			TEXTRECORD.TextColor_use_RGBA=false;
			
			var i:int=-1;
			TextRecordV=new Vector.<TEXTRECORD>();
			while(data[offset]){
				i++;
			
				TextRecordV[i]=new TEXTRECORD();
				offset=TextRecordV[i].initByData(data,offset,endOffset);
			}
			EndOfRecordsFlag=data[offset++];
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(TextBounds.toData());
			data.writeBytes(TextMatrix.toData());
			var offset:int=data.length;
			data[offset]=GlyphBits;
			data[offset+1]=AdvanceBits;
			TEXTRECORD.GlyphBits=GlyphBits;
			TEXTRECORD.AdvanceBits=AdvanceBits;
			TEXTRECORD.TextColor_use_RGBA=false;
			offset+=2;
			data.position=offset;
			for each(var TextRecord:TEXTRECORD in TextRecordV){
				data.writeBytes(TextRecord.toData());
			}
			data[data.length]=EndOfRecordsFlag;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineText"
				id={id}
				GlyphBits={GlyphBits}
				AdvanceBits={AdvanceBits}
				EndOfRecordsFlag={EndOfRecordsFlag}
			/>;
			xml.appendChild(TextBounds.toXML("TextBounds"));
			xml.appendChild(TextMatrix.toXML("TextMatrix"));
			TEXTRECORD.TextColor_use_RGBA=false;
			if(TextRecordV.length){
				var listXML:XML=<TextRecordList count={TextRecordV.length}/>
				for each(var TextRecord:TEXTRECORD in TextRecordV){
					listXML.appendChild(TextRecord.toXML("TextRecord"));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			TextBounds=new RECT();
			TextBounds.initByXML(xml.TextBounds[0]);
			TextMatrix=new MATRIX();
			TextMatrix.initByXML(xml.TextMatrix[0]);
			GlyphBits=int(xml.@GlyphBits.toString());
			AdvanceBits=int(xml.@AdvanceBits.toString());
			
			if(xml.TextRecordList.length()){
				var listXML:XML=xml.TextRecordList[0];
				var TextRecordXMLList:XMLList=listXML.TextRecord;
				var i:int=-1;
				TextRecordV=new Vector.<TEXTRECORD>(TextRecordXMLList.length());
				for each(var TextRecordXML:XML in TextRecordXMLList){
					i++;
					TextRecordV[i]=new TEXTRECORD();
					TextRecordV[i].initByXML(TextRecordXML);
				}
			}else{
				TextRecordV=new Vector.<TEXTRECORD>();
			}
			EndOfRecordsFlag=int(xml.@EndOfRecordsFlag.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
