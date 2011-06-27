/***
DefineShape2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineShape2
//DefineShape2 extends the capabilities of DefineShape with the ability to support more than
//255 styles in the style list and multiple style lists in a single shape.
//The minimum file format version is SWF 2.

//DefineShape2
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 22.
//ShapeId 			UI16 			ID for this character.
//ShapeBounds 		RECT 			Bounds of the shape.
//Shapes 			SHAPEWITHSTYLE 	Shape information.
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPEWITHSTYLE;
	import flash.utils.ByteArray;
	public class DefineShape2{//implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var ShapeBounds:RECT;
		public var Shapes:SHAPEWITHSTYLE;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			ShapeBounds=new RECT();
			offset=ShapeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			Shapes=new SHAPEWITHSTYLE();
			return Shapes.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ShapeBounds.toData(_toDataOptions));
			data.writeBytes(Shapes.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineShape2"
				id={id}
			/>;
			xml.appendChild(ShapeBounds.toXML("ShapeBounds",_toXMLOptions));
			xml.appendChild(Shapes.toXML("Shapes",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			ShapeBounds=new RECT();
			ShapeBounds.initByXML(xml.ShapeBounds[0],_initByXMLOptions);
			Shapes=new SHAPEWITHSTYLE();
			Shapes.initByXML(xml.Shapes[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
