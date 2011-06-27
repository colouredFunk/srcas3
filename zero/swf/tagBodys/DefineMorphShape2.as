/***
DefineMorphShape2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineMorphShape2
//The DefineMorphShape2 tag extends the capabilities of DefineMorphShape by using a new
//morph line style record in the morph shape. MORPHLINESTYLE2 allows the use of new
//types of joins and caps as well as scaling options and the ability to fill the strokes of the morph
//shape.
//DefineMorphShape2 specifies not only the shape bounds but also the edge bounds of the
//shape. While the shape bounds are calculated along the outside of the strokes, the edge
//bounds are taken from the outside of the edges. For an example of shape bounds versus edge
//bounds, see the diagram in DefineShape4. The new StartEdgeBounds and EndEdgeBounds
//fields assist Flash Player in accurately determining certain layouts.
//In addition, DefineMorphShape2 includes new hinting information, UsesNonScalingStrokes
//and UsesScalingStrokes. These flags assist Flash Player in creating the best possible area for
//invalidation.
//
//The minimum file format version is SWF 8.
//
//DefineMorphShape2
//Field 					Type 					Comment
//Header 					RECORDHEADER 			Tag type = 84
//CharacterId 				UI16 					ID for this character
//StartBounds 				RECT 					Bounds of the start shape
//EndBounds 				RECT 					Bounds of the end shape
//StartEdgeBounds 			RECT 					Bounds of the start shape, excluding strokes
//EndEdgeBounds 			RECT 					Bounds of the end shape, excluding strokes
//Reserved 					UB[6] 					Must be 0
//UsesNonScalingStrokes 	UB[1] 					If 1, the shape contains at least one non-scaling stroke.
//UsesScalingStrokes 		UB[1] 					If 1, the shape contains at least one scaling stroke.
//Offset 					UI32 					Indicates offset to EndEdges
//MorphFillStyles 			MORPHFILLSTYLEARRAY 	Fill style information is stored in the same manner as for a standard shape; however, each fill consists of interleaved information based on a single style type to accommodate morphing.
//MorphLineStyles 			MORPHLINESTYLEARRAY 	Line style information is stored in the same manner as for a standard shape; however, each line consists of interleaved information based on a single style type to accommodate morphing.
//StartEdges 				SHAPE 					Contains the set of edges and the style bits that indicate style changes (for example, MoveTo, FillStyle, and LineStyle). Number of edges must equal the number of edges in EndEdges.
//EndEdges 					SHAPE 					Contains only the set of edges, with no style information. Number of edges must equal the number of edges in StartEdges.
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineMorphShape2/*{*/implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var StartBounds:RECT;
		public var EndBounds:RECT;
		public var StartEdgeBounds:RECT;
		public var EndEdgeBounds:RECT;
		public var UsesNonScalingStrokes:int;
		public var UsesScalingStrokes:int;
		public var Offset:uint;							//UI32
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			StartBounds=new RECT();
			offset=StartBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			EndBounds=new RECT();
			offset=EndBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			StartEdgeBounds=new RECT();
			offset=StartEdgeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			EndEdgeBounds=new RECT();
			offset=EndEdgeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			var flags:int=data[offset++];
			//Reserved=(flags<<24)>>>26;				//11111100
			UsesNonScalingStrokes=(flags<<30)>>>31;		//00000010
			UsesScalingStrokes=flags&0x01;				//00000001
			Offset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(StartBounds.toData(_toDataOptions));
			data.writeBytes(EndBounds.toData(_toDataOptions));
			data.writeBytes(StartEdgeBounds.toData(_toDataOptions));
			data.writeBytes(EndEdgeBounds.toData(_toDataOptions));
			var offset:int=data.length;
			var flags:int=0;
			//flags|=Reserved<<2;						//11111100
			flags|=UsesNonScalingStrokes<<1;			//00000010
			flags|=UsesScalingStrokes;					//00000001
			data[offset]=flags;
			
			data[offset+1]=Offset;
			data[offset+2]=Offset>>8;
			data[offset+3]=Offset>>16;
			data[offset+4]=Offset>>24;
			data.position=offset+5;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="DefineMorphShape2"
				id={id}
				UsesNonScalingStrokes={UsesNonScalingStrokes}
				UsesScalingStrokes={UsesScalingStrokes}
				Offset={Offset}
			/>;
			xml.appendChild(StartBounds.toXML("StartBounds",_toXMLOptions));
			xml.appendChild(EndBounds.toXML("EndBounds",_toXMLOptions));
			xml.appendChild(StartEdgeBounds.toXML("StartEdgeBounds",_toXMLOptions));
			xml.appendChild(EndEdgeBounds.toXML("EndEdgeBounds",_toXMLOptions));
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			id=int(xml.@id.toString());
			StartBounds=new RECT();
			StartBounds.initByXML(xml.StartBounds[0],_initByXMLOptions);
			EndBounds=new RECT();
			EndBounds.initByXML(xml.EndBounds[0],_initByXMLOptions);
			StartEdgeBounds=new RECT();
			StartEdgeBounds.initByXML(xml.StartEdgeBounds[0],_initByXMLOptions);
			EndEdgeBounds=new RECT();
			EndEdgeBounds.initByXML(xml.EndEdgeBounds[0],_initByXMLOptions);
			UsesNonScalingStrokes=int(xml.@UsesNonScalingStrokes.toString());
			UsesScalingStrokes=int(xml.@UsesScalingStrokes.toString());
			Offset=uint(xml.@Offset.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
