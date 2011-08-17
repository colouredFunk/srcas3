/***
DefineFont
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月16日 23:27:08
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineFont
//The DefineFont tag defines the shape outlines of each glyph used in a particular font. Only
//the glyphs that are used by subsequent DefineText tags are actually defined.
//DefineFont tags cannot be used for dynamic text. Dynamic text requires the DefineFont2 tag.
//The minimum file format version is SWF 1.
//
//DefineFont
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 10
//FontID 			UI16 			ID for this font character
//OffsetTable 		UI16[nGlyphs] 	Array of shape offsets
//GlyphShapeTable 	SHAPE[nGlyphs] 	Array of shapes
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPE;
	public class DefineFont{
		public var id:int;								//UI16
		public var GlyphShapeV:Vector.<*>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			id=data[offset++]|(data[offset++]<<8);
			var GlyphShapeCount:int=(data[offset++]|(data[offset++]<<8))/2;//- -
			offset+=GlyphShapeCount*2-2;
			
			var GlyphShapeClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					GlyphShapeClass=_initByDataOptions.classes["zero.swf.records.shapes.SHAPE"];
				}
			}
			if(GlyphShapeClass){
			}else{
				GlyphShapeClass=SHAPE;
			}
			GlyphShapeV=new Vector.<*>();
			for(var i:int=0;i<GlyphShapeCount;i++){
				GlyphShapeV[i]=new GlyphShapeClass();
				offset=GlyphShapeV[i].initByData(data,offset,endOffset,_initByDataOptions);
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=data.length=2+GlyphShapeV.length*2;
			var j:int=2;
			for each(var GlyphShape:* in GlyphShapeV){
				var Offset:int=data.length-2;
				data[j++]=Offset;
				data[j++]=Offset>>8;
				data.writeBytes(GlyphShape.toData(_toDataOptions));
			}
			return data;
		}
		
		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineFont"
				id={id}
			/>;
			if(GlyphShapeV.length){
				var GlyphShapeListXML:XML=<GlyphShapeList count={GlyphShapeV.length}/>
				for each(var GlyphShape:* in GlyphShapeV){
					GlyphShapeListXML.appendChild(GlyphShape.toXML("GlyphShape",_toXMLOptions));
				}
				xml.appendChild(GlyphShapeListXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			GlyphShapeV=new Vector.<*>();
			var i:int=-1;
			GlyphShapeV=new Vector.<*>();
			for each(var GlyphShapeXML:XML in xml.GlyphShapeList.GlyphShape){
				i++;
				GlyphShapeV[i]=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[GlyphShapeXML["@class"].toString()]||SHAPE)();
				GlyphShapeV[i].initByXML(GlyphShapeXML,_initByXMLOptions);
			}
		}
		}//end of CONFIG::USE_XML
	}
}