/***
DefineMorphShape2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 22:59:23 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
	import zero.swf.records.fillStyles.MORPHFILLSTYLE;
	import zero.swf.records.lineStyles.MORPHLINESTYLE2;
	import zero.swf.records.SHAPE;
	import flash.utils.ByteArray;
	public class DefineMorphShape2{
		public var id:int;								//UI16
		public var StartBounds:RECT;
		public var EndBounds:RECT;
		public var StartEdgeBounds:RECT;
		public var EndEdgeBounds:RECT;
		public var UsesNonScalingStrokes:int;
		public var UsesScalingStrokes:int;
		public var Offset:uint;							//UI32
		public var MorphFillStyleV:Vector.<MORPHFILLSTYLE>;
		public var MorphLineStyleV:Vector.<MORPHLINESTYLE2>;
		public var StartEdges:SHAPE;
		public var EndEdges:SHAPE;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			StartBounds=new RECT();
			offset=StartBounds.initByData(data,offset,endOffset);
			
			EndBounds=new RECT();
			offset=EndBounds.initByData(data,offset,endOffset);
			
			StartEdgeBounds=new RECT();
			offset=StartEdgeBounds.initByData(data,offset,endOffset);
			
			EndEdgeBounds=new RECT();
			offset=EndEdgeBounds.initByData(data,offset,endOffset);
			var flags:int=data[offset++];
			//Reserved=(flags<<24)>>>26;				//11111100
			UsesNonScalingStrokes=(flags<<30)>>>31;		//00000010
			UsesScalingStrokes=flags&0x01;				//00000001
			Offset=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			
			var MorphFillStyleCount:int=data[offset++];
			if(MorphFillStyleCount==0xff){
				MorphFillStyleCount=data[offset++]|(data[offset++]<<8);
			}
			MorphFillStyleV=new Vector.<MORPHFILLSTYLE>(MorphFillStyleCount);
			for(var i:int=0;i<MorphFillStyleCount;i++){
			
				MorphFillStyleV[i]=new MORPHFILLSTYLE();
				offset=MorphFillStyleV[i].initByData(data,offset,endOffset);
			}
			
			
			var MorphLineStyleCount:int=data[offset++];
			if(MorphLineStyleCount==0xff){
				MorphLineStyleCount=data[offset++]|(data[offset++]<<8);
			}
			MorphLineStyleV=new Vector.<MORPHLINESTYLE2>(MorphLineStyleCount);
			for(i=0;i<MorphLineStyleCount;i++){
			
				MorphLineStyleV[i]=new MORPHLINESTYLE2();
				offset=MorphLineStyleV[i].initByData(data,offset,endOffset);
			}
			
			StartEdges=new SHAPE();
			offset=StartEdges.initByData(data,offset,endOffset);
			
			EndEdges=new SHAPE();
			return EndEdges.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(StartBounds.toData());
			data.writeBytes(EndBounds.toData());
			data.writeBytes(StartEdgeBounds.toData());
			data.writeBytes(EndEdgeBounds.toData());
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
			var MorphFillStyleCount:int=MorphFillStyleV.length;
			offset+=5;
			if(MorphFillStyleCount<0xff){
				data[offset++]=MorphFillStyleCount;
			}else{
				data[offset++]=0xff;
				data[offset++]=MorphFillStyleCount;
				data[offset++]=MorphFillStyleCount>>8;
			}
			
			data.position=offset;
			for each(var MorphFillStyle:MORPHFILLSTYLE in MorphFillStyleV){
				data.writeBytes(MorphFillStyle.toData());
			}
			offset=data.length;
			var MorphLineStyleCount:int=MorphLineStyleV.length;
			
			if(MorphLineStyleCount<0xff){
				data[offset++]=MorphLineStyleCount;
			}else{
				data[offset++]=0xff;
				data[offset++]=MorphLineStyleCount;
				data[offset++]=MorphLineStyleCount>>8;
			}
			
			data.position=offset;
			for each(var MorphLineStyle:MORPHLINESTYLE2 in MorphLineStyleV){
				data.writeBytes(MorphLineStyle.toData());
			}
			data.writeBytes(StartEdges.toData());
			data.writeBytes(EndEdges.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineMorphShape2"
				id={id}
				UsesNonScalingStrokes={UsesNonScalingStrokes}
				UsesScalingStrokes={UsesScalingStrokes}
				Offset={Offset}
			/>;
			xml.appendChild(StartBounds.toXML("StartBounds"));
			xml.appendChild(EndBounds.toXML("EndBounds"));
			xml.appendChild(StartEdgeBounds.toXML("StartEdgeBounds"));
			xml.appendChild(EndEdgeBounds.toXML("EndEdgeBounds"));
			if(MorphFillStyleV.length){
				var listXML:XML=<MorphFillStyleList count={MorphFillStyleV.length}/>
				for each(var MorphFillStyle:MORPHFILLSTYLE in MorphFillStyleV){
					listXML.appendChild(MorphFillStyle.toXML("MorphFillStyle"));
				}
				xml.appendChild(listXML);
			}
			if(MorphLineStyleV.length){
				listXML=<MorphLineStyleList count={MorphLineStyleV.length}/>
				for each(var MorphLineStyle:MORPHLINESTYLE2 in MorphLineStyleV){
					listXML.appendChild(MorphLineStyle.toXML("MorphLineStyle"));
				}
				xml.appendChild(listXML);
			}
			xml.appendChild(StartEdges.toXML("StartEdges"));
			xml.appendChild(EndEdges.toXML("EndEdges"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			StartBounds=new RECT();
			StartBounds.initByXML(xml.StartBounds[0]);
			EndBounds=new RECT();
			EndBounds.initByXML(xml.EndBounds[0]);
			StartEdgeBounds=new RECT();
			StartEdgeBounds.initByXML(xml.StartEdgeBounds[0]);
			EndEdgeBounds=new RECT();
			EndEdgeBounds.initByXML(xml.EndEdgeBounds[0]);
			UsesNonScalingStrokes=int(xml.@UsesNonScalingStrokes.toString());
			UsesScalingStrokes=int(xml.@UsesScalingStrokes.toString());
			Offset=uint(xml.@Offset.toString());
			if(xml.MorphFillStyleList.length()){
				var listXML:XML=xml.MorphFillStyleList[0];
				var MorphFillStyleXMLList:XMLList=listXML.MorphFillStyle;
				var i:int=-1;
				MorphFillStyleV=new Vector.<MORPHFILLSTYLE>(MorphFillStyleXMLList.length());
				for each(var MorphFillStyleXML:XML in MorphFillStyleXMLList){
					i++;
					MorphFillStyleV[i]=new MORPHFILLSTYLE();
					MorphFillStyleV[i].initByXML(MorphFillStyleXML);
				}
			}else{
				MorphFillStyleV=new Vector.<MORPHFILLSTYLE>();
			}
			if(xml.MorphLineStyleList.length()){
				listXML=xml.MorphLineStyleList[0];
				var MorphLineStyleXMLList:XMLList=listXML.MorphLineStyle;
				i=-1;
				MorphLineStyleV=new Vector.<MORPHLINESTYLE2>(MorphLineStyleXMLList.length());
				for each(var MorphLineStyleXML:XML in MorphLineStyleXMLList){
					i++;
					MorphLineStyleV[i]=new MORPHLINESTYLE2();
					MorphLineStyleV[i].initByXML(MorphLineStyleXML);
				}
			}else{
				MorphLineStyleV=new Vector.<MORPHLINESTYLE2>();
			}
			StartEdges=new SHAPE();
			StartEdges.initByXML(xml.StartEdges[0]);
			EndEdges=new SHAPE();
			EndEdges.initByXML(xml.EndEdges[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
