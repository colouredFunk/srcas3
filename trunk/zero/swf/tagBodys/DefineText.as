/***
DefineText 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 15:01:30 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
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
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.swf.records.MATRIX;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineText extends TagBody{
		public var id:int;								//UI16
		public var TextBounds:RECT;
		public var TextMatrix:MATRIX;
		public var restDatas:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			TextBounds=new RECT();
			offset=TextBounds.initByData(data,offset,endOffset);
			
			TextMatrix=new MATRIX();
			offset=TextMatrix.initByData(data,offset,endOffset);
			
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(TextBounds.toData());
			data.writeBytes(TextMatrix.toData());
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineText
				id={id}
			>
				<TextBounds/>
				<TextMatrix/>
				<restDatas/>
			</DefineText>;
			xml.TextBounds.appendChild(TextBounds.toXML());
			xml.TextMatrix.appendChild(TextMatrix.toXML());
			xml.restDatas.appendChild(restDatas.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			TextBounds=new RECT();
			TextBounds.initByXML(xml.TextBounds.children()[0]);
			TextMatrix=new MATRIX();
			TextMatrix.initByXML(xml.TextMatrix.children()[0]);
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
