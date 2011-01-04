/***
MORPHLINESTYLE2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 22:58:51 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//MORPHLINESTYLE2 builds upon the capabilities of the MORPHLINESTYLE record by
//allowing the use of new types of joins and caps as well as scaling options and the ability to fill
//morph strokes. In order to use MORPHLINESTYLE2, the shape must be defined with
//DefineMorphShape2—not DefineMorphShape.
//While the MORPHLINESTYLE record permits only rounded joins and round caps,
//MORPHLINESTYLE2 also supports miter and bevel joins, and square caps and no caps. For
//an illustration of the available joins and caps, see the diagram in the LINESTYLE2
//description.
//When using MORPHLINESTYLE for a miter join, a MiterLimitFactor must be specified
//and is used along with StartWidth or EndWidth to calculate the maximum miter length:
//Max miter length = MORPHLINESTYLE2 MiterLimitFactor * MORPHLINESTYLE2
//Width
//If the miter join exceeds the maximum miter length, Flash Player will cut off the miter. Note
//that MiterLimitFactor is an 8.8 fixed-point value.
//MORPHLINESTYLE2 also includes the option for pixel hinting in order to correct blurry
//vertical or horizontal lines.
//
//MORPHLINESTYLE2
//Field 				Type 									Comment
//StartWidth 			UI16 									Width of line in start shape in twips.
//EndWidth 				UI16 									Width of line in end shape in twips.
//StartCapStyle 		UB[2] 									Start-cap style:
//																0 = Round cap
//																1 = No cap
//																2 = Square cap
//JoinStyle 			UB[2] 									Join style:
//																0 = Round join
//																1 = Bevel join
//																2 = Miter join
//HasFillFlag 			UB[1] 									If 1, fill is defined in FillType.
//																If 0, uses StartColor and EndColor fields.
//NoHScaleFlag 			UB[1] 									If 1, stroke thickness will not scale if the object is scaled horizontally.
//NoVScaleFlag 			UB[1] 									If 1, stroke thickness will not scale if the object is scaled vertically.
//PixelHintingFlag 		UB[1] 									If 1, all anchors will be aligned to full pixels.
//Reserved 				UB[5] 									Must be 0.
//NoClose 				UB[1] 									If 1, stroke will not be closed if the stroke's last point matches its first point. Flash Player will apply caps instead of a join.
//EndCapStyle 		UB[2] 									End-cap style:
//															0 = Round cap
//															1 = No cap
//															2 = Square cap
//MiterLimitFactor 	If JoinStyle = 2, UI16 					Miter limit factor as an 8.8 fixed-point value.
//StartColor 			If HasFillFlag = 0, RGBA 				Color value including alpha channel information for start shape.
//EndColor 			If HasFillFlag = 0, RGBA 				Color value including alpha channel information for end shape.
//FillType 			If HasFillFlag = 1, MORPHFILLSTYLE		Fill style.
package zero.swf.records.lineStyles{
	import zero.swf.records.fillStyles.MORPHFILLSTYLE;
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class MORPHLINESTYLE2 extends BaseLineStyle{
		public var StartWidth:int;						//UI16
		public var EndWidth:int;						//UI16
		public var StartCapStyle:int;
		public var JoinStyle:int;
		public var HasFillFlag:int;
		public var NoHScaleFlag:int;
		public var NoVScaleFlag:int;
		public var PixelHintingFlag:int;
		public var NoClose:int;
		public var EndCapStyle:int;
		public var MiterLimitFactor:int;				//UI16
		public var StartColor:uint;						//RGBA
		public var EndColor:uint;						//RGBA
		public var FillType:MORPHFILLSTYLE;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			StartWidth=data[offset]|(data[offset+1]<<8);
			EndWidth=data[offset+2]|(data[offset+3]<<8);
			var flags:int=data[offset+4];
			StartCapStyle=(flags<<24)>>>30;				//11000000
			JoinStyle=(flags<<26)>>>30;					//00110000
			HasFillFlag=(flags<<28)>>>31;				//00001000
			NoHScaleFlag=(flags<<29)>>>31;				//00000100
			NoVScaleFlag=(flags<<30)>>>31;				//00000010
			PixelHintingFlag=flags&0x01;				//00000001
			flags=data[offset+5];
			//Reserved=(flags<<24)>>>27;				//11111000
			NoClose=(flags<<29)>>>31;					//00000100
			EndCapStyle=flags&0x03;						//00000011
			offset+=6;
			if(JoinStyle===2){
				MiterLimitFactor=data[offset++]|(data[offset++]<<8);
			}
			
			if(!HasFillFlag){
				StartColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			}
			
			if(!HasFillFlag){
				EndColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			}
			
			if(HasFillFlag){
			
				FillType=new MORPHFILLSTYLE();
				offset=FillType.initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=StartWidth;
			data[1]=StartWidth>>8;
			data[2]=EndWidth;
			data[3]=EndWidth>>8;
			var flags:int=0;
			flags|=StartCapStyle<<6;					//11000000
			flags|=JoinStyle<<4;						//00110000
			flags|=HasFillFlag<<3;						//00001000
			flags|=NoHScaleFlag<<2;						//00000100
			flags|=NoVScaleFlag<<1;						//00000010
			flags|=PixelHintingFlag;					//00000001
			data[4]=flags;
			
			flags=0;
			//flags|=Reserved<<3;						//11111000
			flags|=NoClose<<2;							//00000100
			flags|=EndCapStyle;							//00000011
			data[5]=flags;
			
			var offset:int=6;
			if(JoinStyle===2){
				data[offset++]=MiterLimitFactor;
				data[offset++]=MiterLimitFactor>>8;
			}
			
			if(!HasFillFlag){
				data[offset++]=StartColor>>16;
				data[offset++]=StartColor>>8;
				data[offset++]=StartColor;
				data[offset++]=StartColor>>24;
			}
			
			if(!HasFillFlag){
				data[offset++]=EndColor>>16;
				data[offset++]=EndColor>>8;
				data[offset++]=EndColor;
				data[offset++]=EndColor>>24;
			}
			if(HasFillFlag){
				data.position=offset;
				data.writeBytes(FillType.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="MORPHLINESTYLE2"
				StartWidth={StartWidth}
				EndWidth={EndWidth}
				StartCapStyle={StartCapStyle}
				JoinStyle={JoinStyle}
				HasFillFlag={HasFillFlag}
				NoHScaleFlag={NoHScaleFlag}
				NoVScaleFlag={NoVScaleFlag}
				PixelHintingFlag={PixelHintingFlag}
				NoClose={NoClose}
				EndCapStyle={EndCapStyle}
				MiterLimitFactor={MiterLimitFactor}
				StartColor={"0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff]}
				EndColor={"0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff]}
			/>;
			if(JoinStyle===2){
				
			}else{
				delete xml.@MiterLimitFactor;
			}
			if(!HasFillFlag){
				
			}else{
				delete xml.@StartColor;
			}
			if(!HasFillFlag){
				
			}else{
				delete xml.@EndColor;
			}
			if(HasFillFlag){
				xml.appendChild(FillType.toXML("FillType"));
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			StartWidth=int(xml.@StartWidth.toString());
			EndWidth=int(xml.@EndWidth.toString());
			StartCapStyle=int(xml.@StartCapStyle.toString());
			JoinStyle=int(xml.@JoinStyle.toString());
			HasFillFlag=int(xml.@HasFillFlag.toString());
			NoHScaleFlag=int(xml.@NoHScaleFlag.toString());
			NoVScaleFlag=int(xml.@NoVScaleFlag.toString());
			PixelHintingFlag=int(xml.@PixelHintingFlag.toString());
			NoClose=int(xml.@NoClose.toString());
			EndCapStyle=int(xml.@EndCapStyle.toString());
			if(JoinStyle===2){
				MiterLimitFactor=int(xml.@MiterLimitFactor.toString());
			}
			if(!HasFillFlag){
				StartColor=uint(xml.@StartColor.toString());
			}
			if(!HasFillFlag){
				EndColor=uint(xml.@EndColor.toString());
			}
			if(HasFillFlag){
				FillType=new MORPHFILLSTYLE();
				FillType.initByXML(xml.FillType[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
