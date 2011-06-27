/***
DefineShape4
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineShape4
//DefineShape4 extends the capabilities of DefineShape3 by using a new line style record in the
//shape. LINESTYLE2 allows new types of joins and caps as well as scaling options and the
//ability to fill a stroke.
//
//DefineShape4 specifies not only the shape bounds but also the edge bounds of the shape.
//While the shape bounds are calculated along the outside of the strokes, the edge bounds are
//taken from the outside of the edges, as shown in the following diagram. The EdgeBounds
//field assists Flash Player in accurately determining certain layouts.
//
//In addition, DefineShape4 includes new hinting flags UsesNonScalingStrokes and
//UsesScalingStrokes. These flags assist Flash Player in creating the best possible area for
//invalidation.
//The minimum file format version is SWF 8.
//
//DefineShape4
//Field 					Type 			Comment
//Header 					RECORDHEADER 	Tag type = 83.
//ShapeId 					UI16 			ID for this character.
//ShapeBounds 				RECT 			Bounds of the shape.
//EdgeBounds 				RECT 			Bounds of the shape, excluding strokes.
//Reserved 					UB[5] 			Must be 0.
//UsesFillWindingRule 		UB[1] 			If 1, use fill winding rule.
//											Minimum file format version is SWF 10
//UsesNonScalingStrokes 	UB[1] 			If 1, the shape contains at least one non-scaling stroke.
//UsesScalingStrokes 		UB[1] 			If 1, the shape contains at least one scaling stroke.
//Shapes 					SHAPEWITHSTYLE 	Shape information.
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPEWITHSTYLE;
	import flash.utils.ByteArray;
	public class DefineShape4/*{*/implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var ShapeBounds:RECT;
		public var EdgeBounds:RECT;
		public var UsesFillWindingRule:int;
		public var UsesNonScalingStrokes:int;
		public var UsesScalingStrokes:int;
		public var Shapes:SHAPEWITHSTYLE;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			ShapeBounds=new RECT();
			offset=ShapeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			EdgeBounds=new RECT();
			offset=EdgeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			var flags:int=data[offset++];
			//Reserved=(flags<<24)>>>27;				//11111000
			UsesFillWindingRule=(flags<<29)>>>31;		//00000100
			UsesNonScalingStrokes=(flags<<30)>>>31;		//00000010
			UsesScalingStrokes=flags&0x01;				//00000001
			
			Shapes=new SHAPEWITHSTYLE();
			return Shapes.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ShapeBounds.toData(_toDataOptions));
			data.writeBytes(EdgeBounds.toData(_toDataOptions));
			var offset:int=data.length;
			var flags:int=0;
			//flags|=Reserved<<3;						//11111000
			flags|=UsesFillWindingRule<<2;				//00000100
			flags|=UsesNonScalingStrokes<<1;			//00000010
			flags|=UsesScalingStrokes;					//00000001
			data[offset]=flags;
			
			data.position=offset+1;
			data.writeBytes(Shapes.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="DefineShape4"
				id={id}
				UsesFillWindingRule={UsesFillWindingRule}
				UsesNonScalingStrokes={UsesNonScalingStrokes}
				UsesScalingStrokes={UsesScalingStrokes}
			/>;
			xml.appendChild(ShapeBounds.toXML("ShapeBounds",_toXMLOptions));
			xml.appendChild(EdgeBounds.toXML("EdgeBounds",_toXMLOptions));
			xml.appendChild(Shapes.toXML("Shapes",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			id=int(xml.@id.toString());
			ShapeBounds=new RECT();
			ShapeBounds.initByXML(xml.ShapeBounds[0],_initByXMLOptions);
			EdgeBounds=new RECT();
			EdgeBounds.initByXML(xml.EdgeBounds[0],_initByXMLOptions);
			UsesFillWindingRule=int(xml.@UsesFillWindingRule.toString());
			UsesNonScalingStrokes=int(xml.@UsesNonScalingStrokes.toString());
			UsesScalingStrokes=int(xml.@UsesScalingStrokes.toString());
			Shapes=new SHAPEWITHSTYLE();
			Shapes.initByXML(xml.Shapes[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
