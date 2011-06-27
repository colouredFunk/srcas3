/***
BEVELFILTER
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//Bevel filter
//The Bevel filter creates a smooth bevel on display list objects.
//
//BEVELFILTER
//Field 			Type 			Comment
//ShadowColor 		RGBA 			Color of the shadow
//HighlightColor 	RGBA 			Color of the highlight
//BlurX 			FIXED 			Horizontal blur amount
//BlurY 			FIXED 			Vertical blur amount
//Angle 			FIXED 			Radian angle of the drop shadow
//Distance 			FIXED 			Distance of the drop shadow
//Strength 			FIXED8 			Strength of the drop shadow
//InnerShadow 		UB[1] 			Inner shadow mode
//Knockout 			UB[1] 			Knockout mode
//CompositeSource 	UB[1] 			Composite source Always 1
//OnTop 			UB[1] 			OnTop mode
//Passes 			UB[4] 			Number of blur passes
package zero.swf.records.filters{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class BEVELFILTER{//implements I_zero_swf_CheckCodesRight{
		public var ShadowColor:uint;					//RGBA
		public var HighlightColor:uint;					//RGBA
		public var BlurX:Number;						//FIXED
		public var BlurY:Number;						//FIXED
		public var Angle:Number;						//FIXED
		public var Distance:Number;						//FIXED
		public var Strength:Number;						//FIXED8
		public var InnerShadow:int;
		public var Knockout:int;
		public var CompositeSource:int;
		public var OnTop:int;
		public var Passes:int;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			ShadowColor=(data[offset]<<16)|(data[offset+1]<<8)|data[offset+2]|(data[offset+3]<<24);
			HighlightColor=(data[offset+4]<<16)|(data[offset+5]<<8)|data[offset+6]|(data[offset+7]<<24);
			BlurX=data[offset+8]/65536+data[offset+9]/256+data[offset+10]+(data[offset+11]<<8);
			BlurY=data[offset+12]/65536+data[offset+13]/256+data[offset+14]+(data[offset+15]<<8);
			Angle=data[offset+16]/65536+data[offset+17]/256+data[offset+18]+(data[offset+19]<<8);
			Distance=data[offset+20]/65536+data[offset+21]/256+data[offset+22]+(data[offset+23]<<8);
			Strength=data[offset+24]/256+data[offset+25];
			var flags:int=data[offset+26];
			InnerShadow=(flags<<24)>>>31;				//10000000
			Knockout=(flags<<25)>>>31;					//01000000
			CompositeSource=(flags<<26)>>>31;			//00100000
			OnTop=(flags<<27)>>>31;						//00010000
			Passes=flags&0x0f;							//00001111
			return offset+27;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=ShadowColor>>16;
			data[1]=ShadowColor>>8;
			data[2]=ShadowColor;
			data[3]=ShadowColor>>24;
			data[4]=HighlightColor>>16;
			data[5]=HighlightColor>>8;
			data[6]=HighlightColor;
			data[7]=HighlightColor>>24;
			data[8]=BlurX*65536;
			data[9]=BlurX*256;
			data[10]=BlurX;
			data[11]=BlurX/256;
			data[12]=BlurY*65536;
			data[13]=BlurY*256;
			data[14]=BlurY;
			data[15]=BlurY/256;
			data[16]=Angle*65536;
			data[17]=Angle*256;
			data[18]=Angle;
			data[19]=Angle/256;
			data[20]=Distance*65536;
			data[21]=Distance*256;
			data[22]=Distance;
			data[23]=Distance/256;
			data[24]=Strength*256;
			data[25]=Strength;
			var flags:int=0;
			flags|=InnerShadow<<7;						//10000000
			flags|=Knockout<<6;							//01000000
			flags|=CompositeSource<<5;					//00100000
			flags|=OnTop<<4;							//00010000
			flags|=Passes;								//00001111
			data[26]=flags;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			return <{xmlName} class="BEVELFILTER"
				ShadowColor={"0x"+BytesAndStr16._16V[(ShadowColor>>24)&0xff]+BytesAndStr16._16V[(ShadowColor>>16)&0xff]+BytesAndStr16._16V[(ShadowColor>>8)&0xff]+BytesAndStr16._16V[ShadowColor&0xff]}
				HighlightColor={"0x"+BytesAndStr16._16V[(HighlightColor>>24)&0xff]+BytesAndStr16._16V[(HighlightColor>>16)&0xff]+BytesAndStr16._16V[(HighlightColor>>8)&0xff]+BytesAndStr16._16V[HighlightColor&0xff]}
				BlurX={BlurX}
				BlurY={BlurY}
				Angle={Angle}
				Distance={Distance}
				Strength={Strength}
				InnerShadow={InnerShadow}
				Knockout={Knockout}
				CompositeSource={CompositeSource}
				OnTop={OnTop}
				Passes={Passes}
			/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			ShadowColor=uint(xml.@ShadowColor.toString());
			HighlightColor=uint(xml.@HighlightColor.toString());
			BlurX=Number(xml.@BlurX.toString());
			BlurY=Number(xml.@BlurY.toString());
			Angle=Number(xml.@Angle.toString());
			Distance=Number(xml.@Distance.toString());
			Strength=Number(xml.@Strength.toString());
			InnerShadow=int(xml.@InnerShadow.toString());
			Knockout=int(xml.@Knockout.toString());
			CompositeSource=int(xml.@CompositeSource.toString());
			OnTop=int(xml.@OnTop.toString());
			Passes=int(xml.@Passes.toString());
		}
		}//end of CONFIG::USE_XML
	}
}
