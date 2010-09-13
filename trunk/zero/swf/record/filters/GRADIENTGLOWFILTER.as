/***
GRADIENTGLOWFILTER 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月11日 16:19:17 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Gradient Glow and Gradient Bevel filters
//The Gradient Glow and Gradient Bevel filters are extensions of the normal Glow and Bevel
//Filters and allow a gradient to be specified instead of a single color. Instead of multiplying a
//single color value by the shadow-pixel plane value, the shadow-pixel plane value is mapped
//directly into the gradient ramp to obtain the resulting color pixel value, which is then
//composited by using one of the specified compositing modes.
//
//GRADIENTGLOWFILTER
//Field 			Type 			Comment
//NumColors 		UI8 			Number of colors in the gradient
//GradientColors 	RGBA[NumColors]	Gradient colors
//GradientRatio 	UI8[NumColors] 	Gradient ratios
//BlurX 			FIXED 			Horizontal blur amount
//BlurY 			FIXED 			Vertical blur amount
//Angle 			FIXED 			Radian angle of the gradient glow
//Distance 			FIXED 			Distance of the gradient glow
//Strength 			FIXED8 			Strength of the gradient glow
//InnerShadow 		UB[1] 			Inner glow mode
//Knockout 			UB[1] 			Knockout mode
//CompositeSource 	UB[1] 			Composite source Always 1
//OnTop 			UB[1] 			OnTop mode
//Passes 			UB[4] 			Number of blur passes
package zero.swf.record.filters{
	import flash.utils.ByteArray;
	public class GRADIENTGLOWFILTER extends FILTER{
		public var GradientColorV:Vector.<uint>;
		public var GradientRatioV:Vector.<int>;
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
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			GradientColorV=new Vector.<uint>();
			GradientRatioV=new Vector.<int>();
			//#offsetpp
			var NumColors:int=data[offset++];
			for(var i:int=0;i<NumColors;i++){
				GradientColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				GradientRatioV[i]=data[offset++];
			}
			BlurX=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
			BlurY=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
			Angle=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
			Distance=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
			Strength=data[offset++]/256+data[offset++];
			var flags:int=data[offset++];
			InnerShadow=(flags<<24)>>>31;				//10000000
			Knockout=(flags<<25)>>>31;					//01000000
			CompositeSource=(flags<<26)>>>31;			//00100000
			OnTop=(flags<<27)>>>31;						//00010000
			Passes=flags&0x0f;							//00001111
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var NumColors:int=GradientColorV.length;
			data[0]=NumColors;
			//#offsetpp
			var offset:int=1;
			var i:int=-1;
			for each(var GradientColor:uint in GradientColorV){
				i++;
				data[offset++]=GradientColor>>16;
				data[offset++]=GradientColor>>8;
				data[offset++]=GradientColor;
				data[offset++]=GradientColor>>24;
				data[offset++]=GradientRatioV[i];
			}
			data[offset++]=BlurX*65536;
			data[offset++]=BlurX*256;
			data[offset++]=BlurX;
			data[offset++]=BlurX/256;
			data[offset++]=BlurY*65536;
			data[offset++]=BlurY*256;
			data[offset++]=BlurY;
			data[offset++]=BlurY/256;
			data[offset++]=Angle*65536;
			data[offset++]=Angle*256;
			data[offset++]=Angle;
			data[offset++]=Angle/256;
			data[offset++]=Distance*65536;
			data[offset++]=Distance*256;
			data[offset++]=Distance;
			data[offset++]=Distance/256;
			data[offset++]=Strength*256;
			data[offset++]=Strength;
			var flags:int=0;
			flags|=InnerShadow<<7;						//10000000
			flags|=Knockout<<6;							//01000000
			flags|=CompositeSource<<5;					//00100000
			flags|=OnTop<<4;							//00010000
			flags|=Passes;								//00001111
			data[offset++]=flags;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<GRADIENTGLOWFILTER
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
			>
				<list vNames="GradientColorV,GradientRatioV" count={GradientColorV.length}/>
			</GRADIENTGLOWFILTER>;
			var listXML:XML=xml.list[0];
			var i:int=-1;
			for each(var GradientColor:uint in GradientColorV){
				i++;
				listXML.appendChild(<GradientColor value={GradientColor}/>);
				listXML.appendChild(<GradientRatio value={GradientRatioV[i]}/>);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var listXML:XML=xml.list[0];
			var GradientColorXMLList:XMLList=listXML.GradientColor;
			GradientColorV=new Vector.<uint>();
			var GradientRatioXMLList:XMLList=listXML.GradientRatio;
			GradientRatioV=new Vector.<int>();
			var i:int=-1;
			for each(var GradientColorXML:XML in GradientColorXMLList){
				i++;
				GradientColorV[i]=uint(GradientColorXML.@value.toString());
				GradientRatioV[i]=int(GradientRatioXMLList[i].@value.toString());
			}
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
		}//end of CONFIG::toXMLAndInitByXML
	}
}
