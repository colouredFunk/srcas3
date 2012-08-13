﻿/***
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
package zero.getfonts.swf.records.shapes{
	import flash.utils.ByteArray;
	import zero.BytesAndStr16;
	import zero.getfonts.swf.records.MATRIX;
	public class FILLSTYLE{
		public var FillStyleType:int;
		
		public var Color:uint;
		
		public var GradientMatrix:MATRIX;
		public var Gradient:GRADIENT;
		public var FocalGradient:FOCALGRADIENT;
		
		public var BitmapId:int;
		public var BitmapMatrix:MATRIX;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			FillStyleType=data[offset++];
			switch(FillStyleType){
				case 0x00:
					if(_initByDataOptions&&_initByDataOptions.ColorUseRGBA){//20110813
						Color=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
					}else{
						Color=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
					}
				break;
				case 0x10:
				case 0x12:
					GradientMatrix=new MATRIX();
					offset=GradientMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					Gradient=new GRADIENT();
					offset=Gradient.initByData(data,offset,endOffset,_initByDataOptions);
				break;
				case 0x13:
					GradientMatrix=new MATRIX();
					offset=GradientMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					FocalGradient=new FOCALGRADIENT();
					offset=FocalGradient.initByData(data,offset,endOffset,_initByDataOptions);
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					BitmapId=data[offset++]|(data[offset++]<<8);
					BitmapMatrix=new MATRIX();
					offset=BitmapMatrix.initByData(data,offset,endOffset,_initByDataOptions);
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=FillStyleType;
			switch(FillStyleType){
				case 0x00:
					if(_toDataOptions&&_toDataOptions.ColorUseRGBA){//20110813
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
					data.position=1;
					data.writeBytes(GradientMatrix.toData(_toDataOptions));
					data.writeBytes(Gradient.toData(_toDataOptions));
				break;
				case 0x13:
					data.position=1;
					data.writeBytes(GradientMatrix.toData(_toDataOptions));
					data.writeBytes(FocalGradient.toData(_toDataOptions));
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					data[1]=BitmapId;
					data[2]=BitmapId>>8;
					data.position=3;
					data.writeBytes(BitmapMatrix.toData(_toDataOptions));
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return data;
		}
	}
}