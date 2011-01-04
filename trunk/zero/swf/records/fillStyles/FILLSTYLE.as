/***
FILLSTYLE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 20:49:59 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The format of a fill style value within the file is described in the following table:
//FILLSTYLE
//Field 			Type 													Comment
//FillStyleType 	UI8 													Type of fill style:
//																			0x00 = solid fill
//																			0x10 = linear gradient fill
//																			0x12 = radial gradient fill
//																			0x13 = focal radial gradient fill (SWF 8 file format and later only)
//																			0x40 = repeating bitmap fill
//																			0x41 = clipped bitmap fill
//																			0x42 = non-smoothed repeating bitmap
//																			0x43 = non-smoothed clipped bitmap
//Color 			If type = 0x00, RGBA (if Shape3);
//									RGB (if Shape1 or Shape2) 				Solid fill color with opacity information.
//GradientMatrix 	If type = 0x10, 0x12, or 0x13, MATRIX					Matrix for gradient fill.
//Gradient 			If type = 0x10 or 0x12, GRADIENT						Gradient fill.
//					If type = 0x13, FOCALGRADIENT (SWF 8 and later only)
//BitmapId 			If type = 0x40, 0x41, 0x42 or 0x43, UI16				ID of bitmap character for fill.
//BitmapMatrix 		If type = 0x40, 0x41, 0x42 or 0x43, MATRIX				Matrix for bitmap fill.
package zero.swf.records.fillStyles{
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	
	import zero.swf.records.MATRIX;
	import zero.swf.records.SHAPE;
	import zero.swf.records.gardents.BaseGardent;

	public class FILLSTYLE{
		public var FillStyleType:int;
		
		public var Color:int;
		
		public var GradientMatrix:MATRIX;
		public var Gradient:BaseGardent;
		public var FocalGradient:BaseGardent;
		
		public var BitmapId:int;
		public var BitmapMatrix:MATRIX;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			FillStyleType=data[offset++];
			switch(FillStyleType){
				case 0x00:
					if(SHAPE.currSolidFill_use_RGBA){
						Color=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
					}else{
						Color=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
					}
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					GradientMatrix=new MATRIX();
					offset=GradientMatrix.initByData(data,offset,endOffset);
					if(FillStyleType==0x13){
						FocalGradient=new SHAPE.currFocalGradientClass();
						offset=FocalGradient.initByData(data,offset,endOffset);
					}else{
						Gradient=new SHAPE.currGradientClass();
						offset=Gradient.initByData(data,offset,endOffset);
					}
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					BitmapId=data[offset++]|(data[offset++]<<8);
					BitmapMatrix=new MATRIX();
					offset=BitmapMatrix.initByData(data,offset,endOffset);
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=FillStyleType;
			switch(FillStyleType){
				case 0x00:
					if(SHAPE.currSolidFill_use_RGBA){
						data[1]=Color>>16;
						data[2]=Color>>8;
						data[3]=Color;
						data[4]=Color>>24;
					}else{
						data[1]=Color>>16;
						data[2]=Color>>8;
						data[3]=Color;
					}
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					data.position=1;
					data.writeBytes(GradientMatrix.toData());
					if(FillStyleType==0x13){
						data.writeBytes(FocalGradient.toData());
					}else{
						data.writeBytes(Gradient.toData());
					}
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					data[1]=BitmapId;
					data[2]=BitmapId>>8;
					data.position=3;
					data.writeBytes(BitmapMatrix.toData());
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="FILLSTYLE"/>;
			xml.@FillStyleType="0x"+BytesAndStr16._16V[FillStyleType];
			switch(FillStyleType){
				case 0x00:
					if(SHAPE.currSolidFill_use_RGBA){
						xml.@Color="0x"+BytesAndStr16._16V[(Color>>24)&0xff]+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff];
					}else{
						xml.@Color="0x"+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff];
					}
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					xml.appendChild(GradientMatrix.toXML("GradientMatrix"));
					if(FillStyleType==0x13){
						xml.appendChild(FocalGradient.toXML("FocalGradient"));
					}else{
						xml.appendChild(Gradient.toXML("Gradient"));
					}
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					xml.@BitmapId=BitmapId;
					xml.appendChild(BitmapMatrix.toXML("BitmapMatrix"));
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			FillStyleType=int(xml.@FillStyleType.toString());
			switch(FillStyleType){
				case 0x00:
					Color=int(xml.@Color.toString());
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					GradientMatrix=new MATRIX();
					GradientMatrix.initByXML(xml.GradientMatrix[0]);
					if(FillStyleType==0x13){
						FocalGradient=new SHAPE.currFocalGradientClass();
						FocalGradient.initByXML(xml.FocalGradient[0]);
					}else{
						Gradient=new SHAPE.currGradientClass();
						Gradient.initByXML(xml.Gradient[0]);
					}
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					BitmapId=int(xml.@BitmapId.toString());
					BitmapMatrix=new MATRIX();
					BitmapMatrix.initByXML(xml.BitmapMatrix[0]);
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
