/***
GLOWFILTER 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 15:26:09 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Glow filter
//The Glow filter works in the same way as the Drop Shadow filter, except that it does not have
//a distance and angle parameter. Therefore, it can run slightly faster.
//
//GLOWFILTER
//Field 			Type 			Comment
//GlowColor 		RGBA 			Color of the shadow
//BlurX 			FIXED 			Horizontal blur amount
//BlurY 			FIXED 			Vertical blur amount
//Strength 			FIXED8 			Strength of the glow
//InnerGlow 		UB[1] 			Inner glow mode
//Knockout 			UB[1] 			Knockout mode
//CompositeSource 	UB[1] 			Composite source Always 1
//Passes 			UB[5] 			Number of blur passes
package zero.swf.records.filters{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class GLOWFILTER extends FILTER{
		public var GlowColor:uint;						//RGBA
		public var BlurX:Number;						//FIXED
		public var BlurY:Number;						//FIXED
		public var Strength:Number;						//FIXED8
		public var InnerGlow:int;
		public var Knockout:int;
		public var CompositeSource:int;
		public var Passes:int;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			GlowColor=(data[offset]<<16)|(data[offset+1]<<8)|data[offset+2]|(data[offset+3]<<24);
			BlurX=data[offset+4]/65536+data[offset+5]/256+data[offset+6]+(data[offset+7]<<8);
			BlurY=data[offset+8]/65536+data[offset+9]/256+data[offset+10]+(data[offset+11]<<8);
			Strength=data[offset+12]/256+data[offset+13];
			var flags:int=data[offset+14];
			InnerGlow=(flags<<24)>>>31;					//10000000
			Knockout=(flags<<25)>>>31;					//01000000
			CompositeSource=(flags<<26)>>>31;			//00100000
			Passes=flags&0x1f;							//00011111
			return offset+15;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=GlowColor>>16;
			data[1]=GlowColor>>8;
			data[2]=GlowColor;
			data[3]=GlowColor>>24;
			data[4]=BlurX*65536;
			data[5]=BlurX*256;
			data[6]=BlurX;
			data[7]=BlurX/256;
			data[8]=BlurY*65536;
			data[9]=BlurY*256;
			data[10]=BlurY;
			data[11]=BlurY/256;
			data[12]=Strength*256;
			data[13]=Strength;
			var flags:int=0;
			flags|=InnerGlow<<7;						//10000000
			flags|=Knockout<<6;							//01000000
			flags|=CompositeSource<<5;					//00100000
			flags|=Passes;								//00011111
			data[14]=flags;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <GLOWFILTER
				GlowColor={"0x"+BytesAndStr16._16V[(GlowColor>>24)&0xff]+BytesAndStr16._16V[(GlowColor>>16)&0xff]+BytesAndStr16._16V[(GlowColor>>8)&0xff]+BytesAndStr16._16V[GlowColor&0xff]}
				BlurX={BlurX}
				BlurY={BlurY}
				Strength={Strength}
				InnerGlow={InnerGlow}
				Knockout={Knockout}
				CompositeSource={CompositeSource}
				Passes={Passes}
			/>;
		}
		override public function initByXML(xml:XML):void{
			GlowColor=uint(xml.@GlowColor.toString());
			BlurX=Number(xml.@BlurX.toString());
			BlurY=Number(xml.@BlurY.toString());
			Strength=Number(xml.@Strength.toString());
			InnerGlow=int(xml.@InnerGlow.toString());
			Knockout=int(xml.@Knockout.toString());
			CompositeSource=int(xml.@CompositeSource.toString());
			Passes=int(xml.@Passes.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
