﻿/***
GRADIENT 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 21:46:22 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//SWF 8 and later supports up to 15 gradient control points, spread modes and a new
//interpolation type.
//Note that for the DefineShape, DefineShape2 or DefineShape3 tags, the SpreadMode and
//InterpolationMode fields must be 0, and the NumGradients field can not exceed 8.
//GRADIENT
//Field 				Type 				Comment
//SpreadMode 			UB[2] 				0 = Pad mode
//											1 = Reflect mode
//											2 = Repeat mode
//											3 = Reserved
//InterpolationMode 	UB[2] 				0 = Normal RGB mode interpolation
//											1 = Linear RGB mode interpolation
//											2 and 3 = Reserved
//NumGradients 			UB[4] 				1 to 15
//GradientRecords 		GRADRECORD[nGrads] 	Gradient records (see following)

//The GRADRECORD defines a gradient control point:
//GRADRECORD
//Field 		Type 					Comment
//Ratio 		UI8 					Ratio value
//Color 		RGB (Shape1 or Shape2)	Color of gradient
//				RGBA (Shape3)
package zero.swf.records.gardents{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class GRADIENT extends BaseGardent{
		public var SpreadMode:int;
		public var InterpolationMode:int;
		public var NumGradients:int;
		public var RatioV:Vector.<int>;
		public var ColorV:Vector.<int>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var flags:int=data[offset];
			SpreadMode=(flags<<24)>>>30;				//11000000
			InterpolationMode=(flags<<26)>>>30;			//00110000
			NumGradients=flags&0x0f;					//00001111
			++offset;
			RatioV=new Vector.<int>(NumGradients);
			ColorV=new Vector.<int>(NumGradients);
			for(var i:int=0;i<NumGradients;i++){
				RatioV[i]=data[offset++];
				ColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			flags|=SpreadMode<<6;						//11000000
			flags|=InterpolationMode<<4;				//00110000
			flags|=NumGradients;						//00001111
			data[0]=flags;
			
			var offset:int=1;
			var i:int=-1;
			for each(var Ratio:int in RatioV){
				i++;
				data[offset++]=Ratio;
				data[offset++]=ColorV[i]>>16;
				data[offset++]=ColorV[i]>>8;
				data[offset++]=ColorV[i];
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="GRADIENT"
				SpreadMode={SpreadMode}
				InterpolationMode={InterpolationMode}
				NumGradients={NumGradients}
			/>;
			if(RatioV.length){
				var listXML:XML=<RatioAndColorList count={RatioV.length}/>
				var i:int=-1;
				for each(var Ratio:int in RatioV){
					i++;
					listXML.appendChild(<Ratio value={Ratio}/>);
					listXML.appendChild(<Color value={"0x"+BytesAndStr16._16V[(ColorV[i]>>16)&0xff]+BytesAndStr16._16V[(ColorV[i]>>8)&0xff]+BytesAndStr16._16V[ColorV[i]&0xff]}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			SpreadMode=int(xml.@SpreadMode.toString());
			InterpolationMode=int(xml.@InterpolationMode.toString());
			NumGradients=int(xml.@NumGradients.toString());
			if(xml.RatioAndColorList.length()){
				var listXML:XML=xml.RatioAndColorList[0];
				var RatioXMLList:XMLList=listXML.Ratio;
				var ColorXMLList:XMLList=listXML.Color;
				var i:int=-1;
				RatioV=new Vector.<int>(RatioXMLList.length());
				ColorV=new Vector.<int>(ColorXMLList.length());
				for each(var RatioXML:XML in RatioXMLList){
					i++;
					RatioV[i]=int(RatioXML.@value.toString());
					ColorV[i]=int(ColorXMLList[i].@value.toString());
				}
			}else{
				RatioV=new Vector.<int>();
				ColorV=new Vector.<int>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}