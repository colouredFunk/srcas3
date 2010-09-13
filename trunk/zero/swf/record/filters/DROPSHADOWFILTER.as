/***
DROPSHADOWFILTER 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月11日 16:19:17 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Drop Shadow filter
//The Drop Shadow filter is based on the same median filter as the blur filter, but the filter is
//applied only on the alpha color channel to obtain a shadow pixel plane.
//The angle parameter is in radians. With angle set to 0, the shadow shows on the right side of
//the object. The distance is measured in pixels. The shadow pixel plane values are interpolated
//bilinearly if sub-pixel values are used.
//The strength of the shadow normalized is 1.0 in fixed point. The strength value is applied by
//multiplying each value in the shadow pixel plane.
//Various compositing options are available for the drop shadow to support both inner and
//outer shadows in regular or knockout modes.
//The resulting color value of each pixel is obtained by multiplying the color channel of the
//provided RGBA color value by the associated value in the shadow pixel plane. The resulting
//pixel value is composited on the original input pixel plane by using one of the specified
//compositing modes.
//
//DROPSHADOWFILTER
//Field 			Type 			Comment
//DropShadowColor 	RGBA 			Color of the shadow
//BlurX 			FIXED 			Horizontal blur amount
//BlurY 			FIXED 			Vertical blur amount
//Angle 			FIXED 			Radian angle of the drop shadow
//Distance 			FIXED 			Distance of the drop shadow
//Strength 			FIXED8 			Strength of the drop shadow
//InnerShadow 		UB[1] 			Inner shadow mode
//Knockout 			UB[1] 			Knockout mode
//CompositeSource 	UB[1] 			Composite source Always 1
//Passes 			UB[5] 			Number of blur passes
package zero.swf.record.filters{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class DROPSHADOWFILTER extends FILTER{
		public var DropShadowColor:uint;				//RGBA
		public var BlurX:Number;						//FIXED
		public var BlurY:Number;						//FIXED
		public var Angle:Number;						//FIXED
		public var Distance:Number;						//FIXED
		public var Strength:Number;						//FIXED8
		public var InnerShadow:int;
		public var Knockout:int;
		public var CompositeSource:int;
		public var Passes:int;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			DropShadowColor=(data[offset]<<16)|(data[offset+1]<<8)|data[offset+2]|(data[offset+3]<<24);
			BlurX=data[offset+4]/65536+data[offset+5]/256+data[offset+6]+(data[offset+7]<<8);
			BlurY=data[offset+8]/65536+data[offset+9]/256+data[offset+10]+(data[offset+11]<<8);
			Angle=data[offset+12]/65536+data[offset+13]/256+data[offset+14]+(data[offset+15]<<8);
			Distance=data[offset+16]/65536+data[offset+17]/256+data[offset+18]+(data[offset+19]<<8);
			Strength=data[offset+20]/256+data[offset+21];
			var flags:int=data[offset+22];
			InnerShadow=(flags<<24)>>>31;				//10000000
			Knockout=(flags<<25)>>>31;					//01000000
			CompositeSource=(flags<<26)>>>31;			//00100000
			Passes=flags&0x1f;							//00011111
			return offset+23;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=DropShadowColor>>16;
			data[1]=DropShadowColor>>8;
			data[2]=DropShadowColor;
			data[3]=DropShadowColor>>24;
			data[4]=BlurX*65536;
			data[5]=BlurX*256;
			data[6]=BlurX;
			data[7]=BlurX/256;
			data[8]=BlurY*65536;
			data[9]=BlurY*256;
			data[10]=BlurY;
			data[11]=BlurY/256;
			data[12]=Angle*65536;
			data[13]=Angle*256;
			data[14]=Angle;
			data[15]=Angle/256;
			data[16]=Distance*65536;
			data[17]=Distance*256;
			data[18]=Distance;
			data[19]=Distance/256;
			data[20]=Strength*256;
			data[21]=Strength;
			var flags:int=0;
			flags|=InnerShadow<<7;						//10000000
			flags|=Knockout<<6;							//01000000
			flags|=CompositeSource<<5;					//00100000
			flags|=Passes;								//00011111
			data[22]=flags;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <DROPSHADOWFILTER
				DropShadowColor={"0x"+BytesAndStr16._16V[(DropShadowColor>>24)&0xff]+BytesAndStr16._16V[(DropShadowColor>>16)&0xff]+BytesAndStr16._16V[(DropShadowColor>>8)&0xff]+BytesAndStr16._16V[DropShadowColor&0xff]}
				BlurX={BlurX}
				BlurY={BlurY}
				Angle={Angle}
				Distance={Distance}
				Strength={Strength}
				InnerShadow={InnerShadow}
				Knockout={Knockout}
				CompositeSource={CompositeSource}
				Passes={Passes}
			/>;
		}
		override public function initByXML(xml:XML):void{
			DropShadowColor=uint(xml.@DropShadowColor.toString());
			BlurX=Number(xml.@BlurX.toString());
			BlurY=Number(xml.@BlurY.toString());
			Angle=Number(xml.@Angle.toString());
			Distance=Number(xml.@Distance.toString());
			Strength=Number(xml.@Strength.toString());
			InnerShadow=int(xml.@InnerShadow.toString());
			Knockout=int(xml.@Knockout.toString());
			CompositeSource=int(xml.@CompositeSource.toString());
			Passes=int(xml.@Passes.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
