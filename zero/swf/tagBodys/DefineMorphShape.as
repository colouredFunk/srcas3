/***
DefineMorphShape
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The DefineMorphShape tag defines the start and end states of a morph sequence. A morph
//object should be displayed with the PlaceObject2 tag, where the ratio field specifies how far
//the morph has progressed.
//
//The minimum file format version is SWF 3.
//
//DefineMorphShape
//Field 				Type 					Comment
//Header 				RECORDHEADER 			Tag type = 46
//CharacterId 			UI16 					ID for this character
//StartBounds 			RECT 					Bounds of the start shape
//EndBounds 			RECT 					Bounds of the end shape
//Offset 				UI32 					Indicates offset to EndEdges
//MorphFillStyles 		MORPHFILLSTYLEARRAY 	Fill style information is stored in the same manner as for a standard shape; however, each fill consists of interleaved information based on a single style type to accommodate morphing.
//MorphLineStyles 		MORPHLINESTYLEARRAY 	Line style information is stored in the same manner as for a standard shape; however, each line consists of interleaved information based on a single style type to accommodate morphing.
//StartEdges 			SHAPE 					Contains the set of edges and the style bits that indicate style changes (for example, MoveTo, FillStyle, and LineStyle). Number of edges must equal the number of edges in EndEdges.
//EndEdges 				SHAPE 					Contains only the set of edges, with no style information. Number of edges must equal the number of edges in StartEdges.
//
//StartBounds This defines the bounding-box of the shape at the start of the morph.
//EndBounds This defines the bounding-box at the end of the morph.
//MorphFillStyles This contains an array of interleaved fill styles for the start and end shapes. The fill style for the start shape is followed by the corresponding fill style for the end shape.
//MorphLineStyles This contains an array of interleaved line styles.
//StartEdges This array specifies the edges for the start shape, and the style change records for both shapes. Because the StyleChangeRecords must be the same for the start and end shapes, they are defined only in the StartEdges array.
//EndEdges This array specifies the edges for the end shape, and contains no style change records. The number of edges specified in StartEdges must equal the number of edges in EndEdges.
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineMorphShape{//implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var StartBounds:RECT;
		public var EndBounds:RECT;
		public var Offset:uint;							//UI32
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			StartBounds=new RECT();
			offset=StartBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			EndBounds=new RECT();
			offset=EndBounds.initByData(data,offset,endOffset,_initByDataOptions);
			Offset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(StartBounds.toData(_toDataOptions));
			data.writeBytes(EndBounds.toData(_toDataOptions));
			var offset:int=data.length;
			data[offset]=Offset;
			data[offset+1]=Offset>>8;
			data[offset+2]=Offset>>16;
			data[offset+3]=Offset>>24;
			data.position=offset+4;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineMorphShape"
				id={id}
				Offset={Offset}
			/>;
			xml.appendChild(StartBounds.toXML("StartBounds",_toXMLOptions));
			xml.appendChild(EndBounds.toXML("EndBounds",_toXMLOptions));
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			StartBounds=new RECT();
			StartBounds.initByXML(xml.StartBounds[0],_initByXMLOptions);
			EndBounds=new RECT();
			EndBounds.initByXML(xml.EndBounds[0],_initByXMLOptions);
			Offset=uint(xml.@Offset.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
