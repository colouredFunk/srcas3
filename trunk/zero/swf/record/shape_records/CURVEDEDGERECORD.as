/***
CURVEDEDGERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 14:03:46 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//CurvedEdgeRecord
//The SWF file format differs from most vector file formats by using Quadratic Bezier curves
//rather than Cubic Bezier curves. PostScript™ uses Cubic Bezier curves, as do most drawing
//applications.The SWF file format uses Quadratic Bezier curves because they can be stored
//more compactly, and can be rendered more efficiently.
//The following diagram shows a Quadratic Bezier curve and a Cubic Bezier curve.
//A Quadratic Bezier curve has 3 points: 2 on-curve anchor points, and 1 off-curve control
//point. A Cubic Bezier curve has 4 points: 2 on-curve anchor points, and 2 off-curve control
//points.
//The curved-edge record stores the edge as two X-Y deltas. The three points that define the
//Quadratic Bezier are calculated like this:
//1. The first anchor point is the current drawing position.
//2. The control point is the current drawing position + ControlDelta.
//3. The last anchor point is the current drawing position + ControlDelta + AnchorDelta.
//The last anchor point becomes the current drawing position.
//CURVEDEDGERECORD
//Field 			Type 			Comment
//TypeFlag 			UB[1] 			This is an edge record. Always 1.
//StraightFlag 		UB[1] 			Curved edge. Always 0.
//NumBits 			UB[4] 			Number of bits per value(2 less than the actual number).
//ControlDeltaX 	SB[NumBits+2] 	X control point change.
//ControlDeltaY 	SB[NumBits+2] 	Y control point change.
//AnchorDeltaX 		SB[NumBits+2] 	X anchor point change.
//AnchorDeltaY 		SB[NumBits+2] 	Y anchor point change.
package zero.swf.record.shape_records{
	import flash.utils.ByteArray;
	public class CURVEDEDGERECORD extends SHAPERECORD{
		public var TypeFlag:int;
		public var StraightFlag:int;
		public var NumBits:int;
		public var ControlDeltaX:int;
		public var ControlDeltaY:int;
		public var AnchorDeltaX:int;
		public var AnchorDeltaY:int;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var bGroupValue:int=(data[offset]<<24)|(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3];
			TypeFlag=bGroupValue>>>31;						//10000000 00000000 00000000 00000000
			StraightFlag=(bGroupValue<<1)>>>31;				//01000000 00000000 00000000 00000000
			NumBits=(bGroupValue<<2)>>>28;					//00111100 00000000 00000000 00000000
			ControlDeltaX=(bGroupValue<<6)>>>bGroupRshiftBitsOffset;
			if(ControlDeltaX&bGroupNegMask){ControlDeltaX|=bGroupNeg;}//最高位为1,表示负数
			bGroupBitsOffset+=NumBits+2;
			
			//从 data 读取足够多的位数以备下面使用:
			if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset+4]<<16)|(data[offset+5]<<8)|data[offset+6];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset+7]<<8)|data[offset+8];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset+9];}
			
			ControlDeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
			if(ControlDeltaY&bGroupNegMask){ControlDeltaY|=bGroupNeg;}//最高位为1,表示负数
			bGroupBitsOffset+=NumBits+2;
			
			//从 data 读取足够多的位数以备下面使用:
			if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset+10]<<16)|(data[offset+11]<<8)|data[offset+12];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset+13]<<8)|data[offset+14];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset+15];}
			
			AnchorDeltaX=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
			if(AnchorDeltaX&bGroupNegMask){AnchorDeltaX|=bGroupNeg;}//最高位为1,表示负数
			bGroupBitsOffset+=NumBits+2;
			
			//从 data 读取足够多的位数以备下面使用:
			if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset+16]<<16)|(data[offset+17]<<8)|data[offset+18];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset+19]<<8)|data[offset+20];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset+21];}
			
			AnchorDeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
			if(AnchorDeltaY&bGroupNegMask){AnchorDeltaY|=bGroupNeg;}//最高位为1,表示负数
			bGroupBitsOffset+=NumBits+2;
			
			return offset+22-int(4-bGroupBitsOffset/8);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var bGroupValue:int=0;
			bGroupValue|=TypeFlag<<31;						//10000000 00000000 00000000 00000000
			bGroupValue|=StraightFlag<<30;					//01000000 00000000 00000000 00000000
			bGroupValue|=NumBits<<26;						//00111100 00000000 00000000 00000000
			bGroupValue|=(ControlDeltaX<<bGroupRshiftBitsOffset)>>>6;
			bGroupBitsOffset+=NumBits+2;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[0]=bGroupValue>>24;data[1]=bGroupValue>>16;data[2]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[3]=bGroupValue>>24;data[4]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[5]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(ControlDeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=NumBits+2;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[6]=bGroupValue>>24;data[7]=bGroupValue>>16;data[8]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[9]=bGroupValue>>24;data[10]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[11]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(AnchorDeltaX<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=NumBits+2;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[12]=bGroupValue>>24;data[13]=bGroupValue>>16;data[14]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[15]=bGroupValue>>24;data[16]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[17]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(AnchorDeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=NumBits+2;
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[18]=bGroupValue>>24;data[19]=bGroupValue>>16;data[20]=bGroupValue>>8;data[21]=bGroupValue;}else{data[22]=bGroupValue>>24;data[23]=bGroupValue>>16;data[24]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[25]=bGroupValue>>24;data[26]=bGroupValue>>16;}else{data[27]=bGroupValue>>24;}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <CURVEDEDGERECORD
				TypeFlag={TypeFlag}
				StraightFlag={StraightFlag}
				NumBits={NumBits}
				ControlDeltaX={ControlDeltaX}
				ControlDeltaY={ControlDeltaY}
				AnchorDeltaX={AnchorDeltaX}
				AnchorDeltaY={AnchorDeltaY}
			/>;
		}
		override public function initByXML(xml:XML):void{
			TypeFlag=int(xml.@TypeFlag.toString());
			StraightFlag=int(xml.@StraightFlag.toString());
			NumBits=int(xml.@NumBits.toString());
			ControlDeltaX=int(xml.@ControlDeltaX.toString());
			ControlDeltaY=int(xml.@ControlDeltaY.toString());
			AnchorDeltaX=int(xml.@AnchorDeltaX.toString());
			AnchorDeltaY=int(xml.@AnchorDeltaY.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
