/***
MATRIX 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 20:24:25 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//MATRIX
//Field 			Type 								Comment
//HasScale 			UB[1] 								Has scale values if equal to 1
//NScaleBits 		If HasScale = 1, UB[5] 				Bits in each scale value field
//ScaleX 			If HasScale = 1, FB[NScaleBits] 	x scale value
//ScaleY 			If HasScale = 1, FB[NScaleBits] 	y scale value
//HasRotate 		UB[1] 								Has rotate and skew values if equal to 1
//NRotateBits 		If HasRotate = 1, UB[5] 			Bits in each rotate value field
//RotateSkew0 		If HasRotate = 1, FB[NRotateBits]	First rotate and skew value
//RotateSkew1 		If HasRotate = 1, FB[NRotateBits]	Second rotate and skew value
//NTranslateBits 	UB[5] 								Bits in each translate value field
//TranslateX 		SB[NTranslateBits] 					x translate value in twips
//TranslateY 		SB[NTranslateBits] 					y translate value in twips
package zero.swf.record{
	import flash.utils.ByteArray;
	public class MATRIX extends Record{
		public var HasScale:int;				
		public var NScaleBits:int;				
		public var ScaleX:int;					
		public var ScaleY:int;					
		public var HasRotate:int;				
		public var NRotateBits:int;				
		public var RotateSkew0:int;				
		public var RotateSkew1:int;				
		public var NTranslateBits:int;			
		public var TranslateX:int;				
		public var TranslateY:int;				
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			var bGroupValue:int=(data[offset]<<24)|(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3];
			HasScale=((bGroupValue&0x80000000)>>>31);		//10000000 00000000 00000000 00000000
			NScaleBits=((bGroupValue&0x7c000000)>>>26);		//01111100 00000000 00000000 00000000
			var bGroupBitsOffset:int=26;
			ScaleX=((bGroupValue&(~(0xffffffff<<bGroupBitsOffset)))>>>(bGroupBitsOffset-=NScaleBits));
			ScaleY=((bGroupValue&(~(0xffffffff<<bGroupBitsOffset)))>>>(bGroupBitsOffset-=NScaleBits));
			trace("NScaleBits="+NScaleBits);
			trace("ScaleX="+ScaleX,ScaleX/65536);
			trace("ScaleY="+ScaleY,ScaleY/65536);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var bGroupValue:int=0;
			bGroupValue|=(HasScale<<31);					//10000000 00000000 00000000 00000000
			bGroupValue|=(NScaleBits<<26);					//01111100 00000000 00000000 00000000
			bGroupValue|=(ScaleX<<26);
			bGroupValue|=(ScaleY<<26);
			bGroupValue|=(HasRotate<<26);
			bGroupValue|=(NRotateBits<<26);
			bGroupValue|=(RotateSkew0<<26);
			bGroupValue|=(RotateSkew1<<26);
			bGroupValue|=(NTranslateBits<<26);
			bGroupValue|=(TranslateX<<26);
			bGroupValue|=(TranslateY<<26);
			data[0]=bGroupValue;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <MATRIX
				HasScale={HasScale}
				NScaleBits={NScaleBits}
				ScaleX={ScaleX}
				ScaleY={ScaleY}
				HasRotate={HasRotate}
				NRotateBits={NRotateBits}
				RotateSkew0={RotateSkew0}
				RotateSkew1={RotateSkew1}
				NTranslateBits={NTranslateBits}
				TranslateX={TranslateX}
				TranslateY={TranslateY}
			/>;
		}
		override public function initByXML(xml:XML):void{
			HasScale=int(xml.@HasScale.toString());
			NScaleBits=int(xml.@NScaleBits.toString());
			ScaleX=int(xml.@ScaleX.toString());
			ScaleY=int(xml.@ScaleY.toString());
			HasRotate=int(xml.@HasRotate.toString());
			NRotateBits=int(xml.@NRotateBits.toString());
			RotateSkew0=int(xml.@RotateSkew0.toString());
			RotateSkew1=int(xml.@RotateSkew1.toString());
			NTranslateBits=int(xml.@NTranslateBits.toString());
			TranslateX=int(xml.@TranslateX.toString());
			TranslateY=int(xml.@TranslateY.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
