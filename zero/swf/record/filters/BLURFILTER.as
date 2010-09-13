﻿/***
BLURFILTER 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月11日 16:19:17 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Blur filter
//The blur filter is based on a sub-pixel precise median filter (also known as a box filter). The
//filter is applied on each of the RGBA color channels.
//The general mathematical representation of a simple non-sub-pixel precise median filter is as
//follows, and can be easily extended to support sub-pixel precision.
//NOTE
//This representation assumes that BlurX and BlurY are odd integers in order to get the
//same result as Flash Player. The filter window is always centered on a pixel in Flash
//Player.
//When the number of passes is set to three, it closely approximates a Gaussian Blur filter. A
//higher number of passes is possible, but for performance reasons, Adobe does not recommend
//it.
//
//BLURFILTER
//Field 		Type 		Comment
//BlurX 		FIXED 		Horizontal blur amount
//BlurY 		FIXED 		Vertical blur amount
//Passes 		UB[5] 		Number of blur passes
//Reserved 		UB[3] 		Must be 0
package zero.swf.record.filters{
	import flash.utils.ByteArray;
	public class BLURFILTER extends FILTER{
		public var BlurX:Number;						//FIXED
		public var BlurY:Number;						//FIXED
		public var Passes:int;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			BlurX=data[offset]/65536+data[offset+1]/256+data[offset+2]+(data[offset+3]<<8);
			BlurY=data[offset+4]/65536+data[offset+5]/256+data[offset+6]+(data[offset+7]<<8);
			var flags:int=data[offset+8];
			Passes=(flags<<24)>>>27;					//11111000
			//Reserved=flags&0x07;						//00000111
			return offset+9;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=BlurX*65536;
			data[1]=BlurX*256;
			data[2]=BlurX;
			data[3]=BlurX/256;
			data[4]=BlurY*65536;
			data[5]=BlurY*256;
			data[6]=BlurY;
			data[7]=BlurY/256;
			var flags:int=0;
			flags|=Passes<<3;							//11111000
			//flags|=Reserved;							//00000111
			data[8]=flags;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <BLURFILTER
				BlurX={BlurX}
				BlurY={BlurY}
				Passes={Passes}
			/>;
		}
		override public function initByXML(xml:XML):void{
			BlurX=Number(xml.@BlurX.toString());
			BlurY=Number(xml.@BlurY.toString());
			Passes=int(xml.@Passes.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
