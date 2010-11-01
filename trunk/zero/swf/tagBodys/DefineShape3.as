/***
DefineShape3 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 22:43:31 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.tagBodys{
	import zero.swf.records.gardents.GRADIENT_Color_RGBA;
	import zero.swf.records.gardents.FOCALGRADIENT_Color_RGBA;
	import zero.swf.records.lineStyles.LINESTYLE_Color_RGBA;
	import zero.swf.records.RECT;
	import zero.swf.records.SHAPEWITHSTYLE;
	import flash.utils.ByteArray;
	public class DefineShape3{
		public var id:int;								//UI16
		public var ShapeBounds:RECT;
		
		public var Shapes:SHAPEWITHSTYLE;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			ShapeBounds=new RECT();
			offset=ShapeBounds.initByData(data,offset,endOffset);
			SHAPEWITHSTYLE.currSolidFillUseRGBA=true;
			SHAPEWITHSTYLE.currGradientClass=GRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currFocalGradientClass=FOCALGRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currLineStyleClass=LINESTYLE_Color_RGBA;
			
			Shapes=new SHAPEWITHSTYLE();
			return Shapes.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ShapeBounds.toData());
			var offset:int=data.length;
			SHAPEWITHSTYLE.currSolidFillUseRGBA=true;
			SHAPEWITHSTYLE.currGradientClass=GRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currFocalGradientClass=FOCALGRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currLineStyleClass=LINESTYLE_Color_RGBA;
			data.position=offset;
			data.writeBytes(Shapes.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineShape3"
				id={id}
			/>;
			xml.appendChild(ShapeBounds.toXML("ShapeBounds"));
			SHAPEWITHSTYLE.currSolidFillUseRGBA=true;
			SHAPEWITHSTYLE.currGradientClass=GRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currFocalGradientClass=FOCALGRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currLineStyleClass=LINESTYLE_Color_RGBA;
			xml.appendChild(Shapes.toXML("Shapes"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			ShapeBounds=new RECT();
			ShapeBounds.initByXML(xml.ShapeBounds[0]);
			SHAPEWITHSTYLE.currSolidFillUseRGBA=true;
			SHAPEWITHSTYLE.currGradientClass=GRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currFocalGradientClass=FOCALGRADIENT_Color_RGBA;
			SHAPEWITHSTYLE.currLineStyleClass=LINESTYLE_Color_RGBA;
			Shapes=new SHAPEWITHSTYLE();
			Shapes.initByXML(xml.Shapes[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
