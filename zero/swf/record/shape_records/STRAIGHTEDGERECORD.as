/***
STRAIGHTEDGERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 14:03:46 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//StraightEdgeRecord
//The StraightEdgeRecord stores the edge as an X-Y delta. The delta is added to the current
//drawing position, and this becomes the new drawing position. The edge is rendered between
//the old and new drawing positions.
//Straight edge records support three types of lines:
//1. General lines.
//2. Horizontal lines.
//3. Vertical lines.
//General lines store both X and Y deltas, the horizontal and vertical lines store only the X delta
//and Y delta respectively.
//STRAIGHTEDGERECORD
//Field 				Type 															Comment
//TypeFlag 				UB[1] 															This is an edge record. Always 1.
//StraightFlag 			UB[1] 															Straight edge. Always 1.
//NumBits 				UB[4] 															Number of bits per value(2 less than the actual number).
//GeneralLineFlag 		UB[1] 															General Line equals 1.
//																						Vert/Horz Line equals 0.
//VertLineFlag 			If GeneralLineFlag = 0, SB[1]									Vertical Line equals 1.
//																						Horizontal Line equals 0.
//DeltaX 				If GeneralLineFlag = 1 or if VertLineFlag = 0, SB[NumBits+2]	X delta.
//DeltaY 				If GeneralLineFlag = 1 or if VertLineFlag = 1, SB[NumBits+2]	Y delta.
package zero.swf.record.shape_records{
	import flash.utils.ByteArray;
	public class STRAIGHTEDGERECORD extends SHAPERECORD{
		public var TypeFlag:int;
		public var StraightFlag:int;
		public var NumBits:int;
		public var GeneralLineFlag:int;
		public var VertLineFlag:int;
		public var DeltaX:int;
		public var DeltaY:int;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var bGroupValue:int=(data[offset]<<24)|(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3];
			TypeFlag=bGroupValue>>>31;						//10000000 00000000 00000000 00000000
			StraightFlag=(bGroupValue<<1)>>>31;				//01000000 00000000 00000000 00000000
			NumBits=(bGroupValue<<2)>>>28;					//00111100 00000000 00000000 00000000
			GeneralLineFlag=(bGroupValue<<6)>>>31;			//00000010 00000000 00000000 00000000
			var bGroupBitsOffset:int=7;
			
			if(!GeneralLineFlag){
				VertLineFlag=(bGroupValue<<7)>>>31;				//00000001 00000000 00000000 00000000
			}
			bGroupBitsOffset=8;
			
			if(GeneralLineFlag||!VertLineFlag){
				DeltaX=(bGroupValue<<8)>>>bGroupRshiftBitsOffset;
				if(DeltaX&bGroupNegMask){DeltaX|=bGroupNeg;}//最高位为1,表示负数
				bGroupBitsOffset+=NumBits+2;
				
				//从 data 读取足够多的位数以备下面使用:
				if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset+4]<<16)|(data[offset+5]<<8)|data[offset+6];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset+7]<<8)|data[offset+8];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset+9];}
				
			}
			if(GeneralLineFlag||VertLineFlag){
				DeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
				if(DeltaY&bGroupNegMask){DeltaY|=bGroupNeg;}//最高位为1,表示负数
				bGroupBitsOffset+=NumBits+2;
			}
			
			return offset+10-int(4-bGroupBitsOffset/8);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var bGroupValue:int=0;
			bGroupValue|=TypeFlag<<31;						//10000000 00000000 00000000 00000000
			bGroupValue|=StraightFlag<<30;					//01000000 00000000 00000000 00000000
			bGroupValue|=NumBits<<26;						//00111100 00000000 00000000 00000000
			bGroupValue|=GeneralLineFlag<<25;				//00000010 00000000 00000000 00000000
			var bGroupBitsOffset:int=7;
			
			if(!GeneralLineFlag){
				bGroupValue|=VertLineFlag<<24;					//00000001 00000000 00000000 00000000
			}
			bGroupBitsOffset=8;
			
			if(GeneralLineFlag||!VertLineFlag){
				bGroupValue|=(DeltaX<<bGroupRshiftBitsOffset)>>>8;
				bGroupBitsOffset+=NumBits+2;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[0]=bGroupValue>>24;data[1]=bGroupValue>>16;data[2]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[3]=bGroupValue>>24;data[4]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[5]=bGroupValue>>24;bGroupValue<<=8;}
				
			}
			if(GeneralLineFlag||VertLineFlag){
				bGroupValue|=(DeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=NumBits+2;
			}
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[6]=bGroupValue>>24;data[7]=bGroupValue>>16;data[8]=bGroupValue>>8;data[9]=bGroupValue;}else{data[10]=bGroupValue>>24;data[11]=bGroupValue>>16;data[12]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[13]=bGroupValue>>24;data[14]=bGroupValue>>16;}else{data[15]=bGroupValue>>24;}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <STRAIGHTEDGERECORD
				TypeFlag={TypeFlag}
				StraightFlag={StraightFlag}
				NumBits={NumBits}
				GeneralLineFlag={GeneralLineFlag}
				VertLineFlag={VertLineFlag}
				DeltaX={DeltaX}
				DeltaY={DeltaY}
			/>;
		}
		override public function initByXML(xml:XML):void{
			TypeFlag=int(xml.@TypeFlag.toString());
			StraightFlag=int(xml.@StraightFlag.toString());
			NumBits=int(xml.@NumBits.toString());
			GeneralLineFlag=int(xml.@GeneralLineFlag.toString());
			VertLineFlag=int(xml.@VertLineFlag.toString());
			DeltaX=int(xml.@DeltaX.toString());
			DeltaY=int(xml.@DeltaY.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
