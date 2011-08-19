/***
DefineShape
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月18日 01:29:23（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineShape
//The DefineShape tag defines a shape for later use by control tags such as PlaceObject. The
//ShapeId uniquely identifies this shape as 'character' in the Dictionary. The ShapeBounds field
//is the rectangle that completely encloses the shape. The SHAPEWITHSTYLE structure
//includes all the paths, fill styles and line styles that make up the shape.
//The minimum file format version is SWF 1.

//DefineShape
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 2.
//ShapeId 			UI16 			ID for this character.
//ShapeBounds 		RECT 			Bounds of the shape.
//Shapes 			SHAPEWITHSTYLE 	Shape information.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPEWITHSTYLE;
	
	public class DefineShape{
		
		public var id:int;//UI16
		public var ShapeBounds:RECT;
		public var Shapes:SHAPEWITHSTYLE;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object();
			}
			_initByDataOptions.ColorUseRGBA=false;//20110813
			_initByDataOptions.LineStyleUseLINESTYLE2=false;//20110814
			
			id=data[offset++]|(data[offset++]<<8);
			
			ShapeBounds=new RECT();
			offset=ShapeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			Shapes=new SHAPEWITHSTYLE();
			offset=Shapes.initByData(data,offset,endOffset,_initByDataOptions);
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			if(_toDataOptions){
			}else{
				_toDataOptions=new Object();
			}
			_toDataOptions.ColorUseRGBA=false;//20110813
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data.position=data.length;
			data.writeBytes(ShapeBounds.toData(_toDataOptions));
			
			data.position=data.length;
			data.writeBytes(Shapes.toData(_toDataOptions));
			
			return data;
			
		}
		
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				if(_toXMLOptions){
				}else{
					_toXMLOptions=new Object();
				}
				_toXMLOptions.ColorUseRGBA=false;//20110813
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineShape"
					id={id}
				/>;
				
				xml.appendChild(ShapeBounds.toXML("ShapeBounds",_toXMLOptions));
				
				xml.appendChild(Shapes.toXML("Shapes",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				ShapeBounds=new RECT();
				ShapeBounds.initByXML(xml.ShapeBounds[0],_initByXMLOptions);
				
				Shapes=new SHAPEWITHSTYLE();
				Shapes.initByXML(xml.Shapes[0],_initByXMLOptions);
				
			}
		}
	}
}