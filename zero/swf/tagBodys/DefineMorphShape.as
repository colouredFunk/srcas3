/***
DefineMorphShape 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 22:59:23 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
	import zero.swf.records.fillStyles.MORPHFILLSTYLE;
	import zero.swf.records.lineStyles.MORPHLINESTYLE;
	import zero.swf.records.SHAPE;
	import flash.utils.ByteArray;
	public class DefineMorphShape{
		public var id:int;								//UI16
		public var StartBounds:RECT;
		public var EndBounds:RECT;
		public var Offset:uint;							//UI32
		public var MorphFillStyleV:Vector.<MORPHFILLSTYLE>;
		public var MorphLineStyleV:Vector.<MORPHLINESTYLE>;
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
			MorphLineStyleV=new Vector.<MORPHLINESTYLE>(MorphLineStyleCount);
			for(i=0;i<MorphLineStyleCount;i++){
			
				MorphLineStyleV[i]=new MORPHLINESTYLE();
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
			var offset:int=data.length;
			data[offset]=Offset;
			data[offset+1]=Offset>>8;
			data[offset+2]=Offset>>16;
			data[offset+3]=Offset>>24;
			var MorphFillStyleCount:int=MorphFillStyleV.length;
			offset+=4;
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
			for each(var MorphLineStyle:MORPHLINESTYLE in MorphLineStyleV){
				data.writeBytes(MorphLineStyle.toData());
			}
			data.writeBytes(StartEdges.toData());
			data.writeBytes(EndEdges.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineMorphShape"
				id={id}
				Offset={Offset}
			/>;
			xml.appendChild(StartBounds.toXML("StartBounds"));
			xml.appendChild(EndBounds.toXML("EndBounds"));
			if(MorphFillStyleV.length){
				var listXML:XML=<MorphFillStyleList count={MorphFillStyleV.length}/>
				for each(var MorphFillStyle:MORPHFILLSTYLE in MorphFillStyleV){
					listXML.appendChild(MorphFillStyle.toXML("MorphFillStyle"));
				}
				xml.appendChild(listXML);
			}
			if(MorphLineStyleV.length){
				listXML=<MorphLineStyleList count={MorphLineStyleV.length}/>
				for each(var MorphLineStyle:MORPHLINESTYLE in MorphLineStyleV){
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
				MorphLineStyleV=new Vector.<MORPHLINESTYLE>(MorphLineStyleXMLList.length());
				for each(var MorphLineStyleXML:XML in MorphLineStyleXMLList){
					i++;
					MorphLineStyleV[i]=new MORPHLINESTYLE();
					MorphLineStyleV[i].initByXML(MorphLineStyleXML);
				}
			}else{
				MorphLineStyleV=new Vector.<MORPHLINESTYLE>();
			}
			StartEdges=new SHAPE();
			StartEdges.initByXML(xml.StartEdges[0]);
			EndEdges=new SHAPE();
			EndEdges.initByXML(xml.EndEdges[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
