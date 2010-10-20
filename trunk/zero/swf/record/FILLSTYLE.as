/***
FILLSTYLE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月12日 20:58:16 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.record{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class FILLSTYLE extends Record{
		public var datas:Array;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			var FillStyleType:int=data[offset++];
			switch(FillStyleType){
				case 0x00:
					var Color:int=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
					datas=[FillStyleType,Color];
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					var GradientMatrix:MATRIX=new MATRIX();
					offset=GradientMatrix.initByData(data,offset,endOffset);
					if(FillStyleType==0x13){
						var FocalGradient:FOCALGRADIENT=new FOCALGRADIENT();
						offset=FocalGradient.initByData(data,offset,endOffset);
						datas=[FillStyleType,GradientMatrix,FocalGradient];
					}else{
						var Gradient:GRADIENT=new GRADIENT();
						offset=Gradient.initByData(data,offset,endOffset);
						datas=[FillStyleType,GradientMatrix,Gradient];
					}
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					var BitmapId:int=data[offset++]|(data[offset++]<<8);
					var BitmapMatrix:MATRIX=new MATRIX();
					offset=BitmapMatrix.initByData(data,offset,endOffset);
					datas=[FillStyleType,BitmapId,BitmapMatrix];
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var FillStyleType:int=datas[0];
			data[0]=FillStyleType;
			switch(FillStyleType){
				case 0x00:
					var Color:int=datas[1];
					data[1]=Color>>16;
					data[2]=Color>>8;
					data[3]=Color;
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					data.position=1;
					data.writeBytes(datas[1].toData());
					data.writeBytes(datas[2].toData());
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					var BitmapId:int=datas[1];
					data[1]=BitmapId;
					data[2]=BitmapId>>8;
					data.position=3;
					data.writeBytes(datas[2].toData());
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<FILLSTYLE>
				
			</FILLSTYLE>;
			import zero.BytesAndStr16;
			var FillStyleType:int=datas[0];
			xml.@FillStyleType="0x"+BytesAndStr16._16V[FillStyleType];
			switch(FillStyleType){
				case 0x00:
					var Color:int=datas[1];
					xml.@Color="0x"+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff]
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					var GradientMatrixXML:XML=<GradientMatrix/>;
					GradientMatrixXML.appendChild(datas[1].toXML());
					xml.appendChild(GradientMatrixXML);
					if(FillStyleType==0x13){
						var FocalGradientXML:XML=<FocalGradient/>;
						FocalGradientXML.appendChild(datas[2].toXML());
						xml.appendChild(FocalGradientXML);
					}else{
						var GradientXML:XML=<Gradient/>;
						GradientXML.appendChild(datas[2].toXML());
						xml.appendChild(GradientXML);
					}
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					xml.@BitmapId=datas[1];
					var BitmapMatrixXML:XML=<BitmapMatrix/>;
					BitmapMatrixXML.appendChild(datas[2].toXML());
					xml.appendChild(BitmapMatrixXML);
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var FillStyleType:int=int(xml.@FillStyleType.toString());
			switch(FillStyleType){
				case 0x00:
					var Color:int=int(xml.@Color.toString());
					datas=[FillStyleType,Color];
				break;
				case 0x10:
				case 0x12:
				case 0x13:
					var GradientMatrix:MATRIX=new MATRIX();
					GradientMatrix.initByXML(xml.GradientMatrix.children()[0]);
					if(FillStyleType==0x13){
						var FocalGradient:FOCALGRADIENT=new FOCALGRADIENT();
						FocalGradient.initByXML(xml.FocalGradient.children()[0]);
						datas=[FillStyleType,GradientMatrix,FocalGradient];
					}else{
						var Gradient:GRADIENT=new GRADIENT();
						Gradient.initByXML(xml.Gradient.children()[0]);
						datas=[FillStyleType,GradientMatrix,Gradient];
					}
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					var BitmapId:int=int(xml.@BitmapId.toString());
					var BitmapMatrix:MATRIX=new MATRIX();
					BitmapMatrix.initByXML(xml.BitmapMatrix.children()[0]);
					datas=[FillStyleType,BitmapId,BitmapMatrix];
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
