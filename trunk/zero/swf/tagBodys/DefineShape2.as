/***
DefineShape2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 22:43:31 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DefineShape2
//DefineShape2 extends the capabilities of DefineShape with the ability to support more than
//255 styles in the style list and multiple style lists in a single shape.
//The minimum file format version is SWF 2.
//
//DefineShape2
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 22.
//ShapeId 			UI16 			ID for this character.
//ShapeBounds 		RECT 			Bounds of the shape.
//Shapes 			SHAPEWITHSTYLE 	Shape information.
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPEWITHSTYLE;
	public class DefineShape2{
		public var id:int;								//UI16
		public var ShapeBounds:*;
		public var Shapes:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object();
			}
			_initByDataOptions.ColorUseRGBA=false;//20110813
			_initByDataOptions.LineStyleUseLINESTYLE2=false;//20110814
			
			id=data[offset++]|(data[offset++]<<8);
			var ShapeBoundsClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ShapeBoundsClass=_initByDataOptions.classes["zero.swf.records.RECT"];
				}
			}
			ShapeBounds=new (ShapeBoundsClass||RECT)();
			offset=ShapeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			var ShapesClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ShapesClass=_initByDataOptions.classes["zero.swf.records.shapes.SHAPEWITHSTYLE"];
				}
			}
			Shapes=new (ShapesClass||SHAPEWITHSTYLE)();
			return Shapes.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			
			if(_toDataOptions){
			}else{
				_toDataOptions=new Object();
			}
			_toDataOptions.ColorUseRGBA=false;//20110813
			
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
			
			if(_toXMLOptions){
			}else{
				_toXMLOptions=new Object();
			}
			_toXMLOptions.ColorUseRGBA=false;//20110813
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineShape2"
				id={id}
			/>;
			xml.appendChild(ShapeBounds.toXML("ShapeBounds",_toXMLOptions));
			xml.appendChild(Shapes.toXML("Shapes",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			var ShapeBoundsXML:XML=xml.ShapeBounds[0];
			ShapeBounds=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[ShapeBoundsXML["@class"].toString()]||RECT)();
			ShapeBounds.initByXML(ShapeBoundsXML,_initByXMLOptions);
			var ShapesXML:XML=xml.Shapes[0];
			Shapes=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[ShapesXML["@class"].toString()]||SHAPEWITHSTYLE)();
			Shapes.initByXML(ShapesXML,_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}