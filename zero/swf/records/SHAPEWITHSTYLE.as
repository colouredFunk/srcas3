/***
SHAPEWITHSTYLE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 15:53:44 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//SHAPEWITHSTYLE
//Field 		Type 						Comment
//FillStyles 	FILLSTYLEARRAY 				Array of fill styles
//LineStyles 	LINESTYLEARRAY 				Array of line styles
//NumFillBits 	UB[4] 						Number of fill index bits
//NumLineBits 	UB[4] 						Number of line index bits
//ShapeRecords 	SHAPERECORD[one or more] 	Shape records (see following)
//A fill style array itself has three fields. The first field is an 8-bit integer count which indicates
//how many fill styles are in the array. This count works similar to the tag's length field in that if
//it is all 1s, you have to look at the next 16 bits to get the actual length.
package zero.swf.records{
	import flash.utils.ByteArray;
	
	import zero.swf.records.shape_records.CURVEDEDGERECORD;
	import zero.swf.records.shape_records.SHAPERECORD;
	import zero.swf.records.shape_records.STRAIGHTEDGERECORD;
	import zero.swf.records.shape_records.STYLECHANGERECORD;

	public class SHAPEWITHSTYLE extends Record{
		public var fillAndLineStyles:FillAndLineStyles;
		
		public var ShapeRecordV:Vector.<SHAPERECORD>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var newStyles:FillAndLineStyles=new FillAndLineStyles();
			offset=newStyles.initByData(data,offset,endOffset);
			//trace("newStyles.NumFillBits="+newStyles.NumFillBits,"newStyles.NumLineBits="+newStyles.NumLineBits);
			fillAndLineStyles=newStyles;
			
			ShapeRecordV=new Vector.<SHAPERECORD>();
			
			//var startOffset:int=offset;
			
			var i:int=-1;
			var bGroupValue:int=(data[offset++]<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			var bGroupBitsOffset:int=0;
			
			var bGroupRshiftBitsOffset:int;
			var bGroupNegMask:int;
			var bGroupNeg:int;
			
			while(true){
				i++;
				
				var TypeFlag:int=(bGroupValue<<bGroupBitsOffset)>>>31;
				bGroupBitsOffset++;
				
				if(TypeFlag){
					var StraightFlag:int=(bGroupValue<<bGroupBitsOffset)>>>31;
					bGroupBitsOffset++;
					
					var NumBits:int=((bGroupValue<<bGroupBitsOffset)>>>28)+2;
					bGroupBitsOffset+=4;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					//trace("NumBits="+NumBits);
					
					bGroupRshiftBitsOffset=32-NumBits;
					bGroupNegMask=1<<(NumBits-1);
					bGroupNeg=0xffffffff<<NumBits;
					
					if(StraightFlag){
						var StraightEdgeRecord:STRAIGHTEDGERECORD=new STRAIGHTEDGERECORD();
						
						StraightEdgeRecord.GeneralLineFlag=(bGroupValue<<bGroupBitsOffset)>>>31;
						bGroupBitsOffset++;
						
						if(StraightEdgeRecord.GeneralLineFlag){
							StraightEdgeRecord.VertLineFlag=0;
						}else{
							StraightEdgeRecord.VertLineFlag=(bGroupValue<<bGroupBitsOffset)>>>31;
							bGroupBitsOffset++;
						}
						
						//从 data 读取足够多的位数以备下面使用:
						if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
						
						if(StraightEdgeRecord.GeneralLineFlag||!StraightEdgeRecord.VertLineFlag){
							StraightEdgeRecord.DeltaX=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
							if(StraightEdgeRecord.DeltaX&bGroupNegMask){StraightEdgeRecord.DeltaX|=bGroupNeg;}//最高位为1,表示负数
							bGroupBitsOffset+=NumBits;
							
							//从 data 读取足够多的位数以备下面使用:
							if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
							
						}
						if(StraightEdgeRecord.GeneralLineFlag||StraightEdgeRecord.VertLineFlag){
							StraightEdgeRecord.DeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
							if(StraightEdgeRecord.DeltaY&bGroupNegMask){StraightEdgeRecord.DeltaY|=bGroupNeg;}//最高位为1,表示负数
							bGroupBitsOffset+=NumBits;
						}
						
						//trace("StraightEdgeRecord.DeltaX="+StraightEdgeRecord.DeltaX,"StraightEdgeRecord.DeltaY="+StraightEdgeRecord.DeltaY);
						
						ShapeRecordV[i]=StraightEdgeRecord;
					}else{
						var CurvedEdgeRecord:CURVEDEDGERECORD=new CURVEDEDGERECORD();
						
						CurvedEdgeRecord.ControlDeltaX=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
						if(CurvedEdgeRecord.ControlDeltaX&bGroupNegMask){CurvedEdgeRecord.ControlDeltaX|=bGroupNeg;}//最高位为1,表示负数
						bGroupBitsOffset+=NumBits;
						
						//从 data 读取足够多的位数以备下面使用:
						if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
						
						CurvedEdgeRecord.ControlDeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
						if(CurvedEdgeRecord.ControlDeltaY&bGroupNegMask){CurvedEdgeRecord.ControlDeltaY|=bGroupNeg;}//最高位为1,表示负数
						bGroupBitsOffset+=NumBits;
						
						//从 data 读取足够多的位数以备下面使用:
						if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
						
						CurvedEdgeRecord.AnchorDeltaX=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
						if(CurvedEdgeRecord.AnchorDeltaX&bGroupNegMask){CurvedEdgeRecord.AnchorDeltaX|=bGroupNeg;}//最高位为1,表示负数
						bGroupBitsOffset+=NumBits;
						
						//从 data 读取足够多的位数以备下面使用:
						if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
						
						CurvedEdgeRecord.AnchorDeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
						if(CurvedEdgeRecord.AnchorDeltaY&bGroupNegMask){CurvedEdgeRecord.AnchorDeltaY|=bGroupNeg;}//最高位为1,表示负数
						bGroupBitsOffset+=NumBits;
						
						ShapeRecordV[i]=CurvedEdgeRecord;
					}
				}else{
					if((bGroupValue<<bGroupBitsOffset)>>>27){
						var styleChangeRecord:STYLECHANGERECORD=new STYLECHANGERECORD();
						
						styleChangeRecord.StateNewStyles=(bGroupValue<<bGroupBitsOffset)>>>31;
						bGroupBitsOffset++;
						styleChangeRecord.StateLineStyle=(bGroupValue<<bGroupBitsOffset)>>>31;
						bGroupBitsOffset++;
						styleChangeRecord.StateFillStyle1=(bGroupValue<<bGroupBitsOffset)>>>31;
						bGroupBitsOffset++;
						styleChangeRecord.StateFillStyle0=(bGroupValue<<bGroupBitsOffset)>>>31;
						bGroupBitsOffset++;
						styleChangeRecord.StateMoveTo=(bGroupValue<<bGroupBitsOffset)>>>31;
						bGroupBitsOffset++;
						
						//从 data 读取足够多的位数以备下面使用:
						if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
						
						if(styleChangeRecord.StateMoveTo){
							var MoveBits:int=(bGroupValue<<bGroupBitsOffset)>>>27;
							bGroupBitsOffset+=5;
							
							//从 data 读取足够多的位数以备下面使用:
							if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
							
							//trace("MoveBits="+MoveBits);
							if(MoveBits){
								bGroupRshiftBitsOffset=32-MoveBits;
								bGroupNegMask=1<<(MoveBits-1);
								bGroupNeg=0xffffffff<<MoveBits;
								//trace("bGroupNegMask="+bGroupNegMask.toString(2));
								//trace("bGroupNeg="+bGroupNeg.toString(2));
								styleChangeRecord.MoveDeltaX=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
								//trace("styleChangeRecord.MoveDeltaX="+styleChangeRecord.MoveDeltaX);
								if(styleChangeRecord.MoveDeltaX&bGroupNegMask){styleChangeRecord.MoveDeltaX|=bGroupNeg;}//最高位为1,表示负数
								bGroupBitsOffset+=MoveBits;
								
								//trace("styleChangeRecord.MoveDeltaX="+styleChangeRecord.MoveDeltaX);
								
								//从 data 读取足够多的位数以备下面使用:
								if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
								
								styleChangeRecord.MoveDeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
								//trace("styleChangeRecord.MoveDeltaY="+styleChangeRecord.MoveDeltaY);
								if(styleChangeRecord.MoveDeltaY&bGroupNegMask){styleChangeRecord.MoveDeltaY|=bGroupNeg;}//最高位为1,表示负数
								bGroupBitsOffset+=MoveBits;
								
								//trace("styleChangeRecord.MoveDeltaY="+styleChangeRecord.MoveDeltaY);
								
								//从 data 读取足够多的位数以备下面使用:
								if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
								
							}
						}
						if(newStyles.NumFillBits){
							if(styleChangeRecord.StateFillStyle0){
								styleChangeRecord.FillStyle0=(bGroupValue<<bGroupBitsOffset)>>>(32-newStyles.NumFillBits);
								bGroupBitsOffset+=newStyles.NumFillBits;
								
								//从 data 读取足够多的位数以备下面使用:
								if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
								
							}
							if(styleChangeRecord.StateFillStyle1){
								styleChangeRecord.FillStyle1=(bGroupValue<<bGroupBitsOffset)>>>(32-newStyles.NumFillBits);
								bGroupBitsOffset+=newStyles.NumFillBits;
								
								//从 data 读取足够多的位数以备下面使用:
								if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
								
							}
						}
						if(newStyles.NumLineBits){
							if(styleChangeRecord.StateLineStyle){
								styleChangeRecord.LineStyle=(bGroupValue<<bGroupBitsOffset)>>>(32-newStyles.NumLineBits);
								bGroupBitsOffset+=newStyles.NumLineBits;
							}
						}
						
						if(styleChangeRecord.StateNewStyles){
							offset-=int(4-bGroupBitsOffset/8);
							
							newStyles=new FillAndLineStyles();//3. Replace the current fill and line style arrays with a new set of styles.
							offset=newStyles.initByData(data,offset,endOffset);
							//trace("newStyles.NumFillBits="+newStyles.NumFillBits,"newStyles.NumLineBits="+newStyles.NumLineBits);
							styleChangeRecord.NewStyles=newStyles;
							
							bGroupValue=(data[offset++]<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
							bGroupBitsOffset=0;
						}
						
						ShapeRecordV[i]=styleChangeRecord;
					}else{
						//ENDSHAPERECORD
						bGroupBitsOffset+=5;
						break;
					}
				}
				
				//if(offset<endOffset){
				//}else{
				//	break;
				//}
				
				//import zero.BytesAndStr2;
				//trace("==="+BytesAndStr2.bytes2str2(data,startOffset,offset-int(4-bGroupBitsOffset/8)-startOffset));
				
				//从 data 读取足够多的位数以备下面使用:
				if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
			}
			return offset-int(4-bGroupBitsOffset/8);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			
			data.writeBytes(fillAndLineStyles.toData());
			//trace("fillAndLineStyles.NumFillBits="+fillAndLineStyles.NumFillBits);
			//trace("fillAndLineStyles.NumLineBits="+fillAndLineStyles.NumLineBits);
			var newStyles:FillAndLineStyles=fillAndLineStyles;
			
			var bGroupValue:int=0;
			var bGroupBitsOffset:int=0;
			var offset:int=data.length;
			
			var bGroupRshiftBitsOffset:int;
			var NumBits:int;
			var bGroupMixNum:int;
			
			//var startOffset:int=offset;
			
			//trace("ShapeRecordV.length="+ShapeRecordV.length);
			for each(var ShapeRecord:SHAPERECORD in ShapeRecordV){
				switch(ShapeRecord["constructor"]){
					case STYLECHANGERECORD:
						var styleChangeRecord:STYLECHANGERECORD=ShapeRecord as STYLECHANGERECORD;
						//bGroupValue|=(0<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						
						bGroupValue|=(styleChangeRecord.StateNewStyles<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						bGroupValue|=(styleChangeRecord.StateLineStyle<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						bGroupValue|=(styleChangeRecord.StateFillStyle1<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						bGroupValue|=(styleChangeRecord.StateFillStyle0<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						bGroupValue|=(styleChangeRecord.StateMoveTo<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						
						//向 data 写入满8位(1字节)的数据:
						if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
						
						if(styleChangeRecord.StateMoveTo){
							
							//计算所需最小位数:
							bGroupMixNum=((styleChangeRecord.MoveDeltaX<0?-styleChangeRecord.MoveDeltaX:styleChangeRecord.MoveDeltaX)<<1)|((styleChangeRecord.MoveDeltaY<0?-styleChangeRecord.MoveDeltaY:styleChangeRecord.MoveDeltaY)<<1);
							var MoveBits:int;
							if(bGroupMixNum>>>16){if(bGroupMixNum>>>24){if(bGroupMixNum>>>28){if(bGroupMixNum>>>30){if(bGroupMixNum>>>31){MoveBits=32;}else{MoveBits=31;}}else{if(bGroupMixNum>>>29){MoveBits=30;}else{MoveBits=29;}}}else{if(bGroupMixNum>>>26){if(bGroupMixNum>>>27){MoveBits=28;}else{MoveBits=27;}}else{if(bGroupMixNum>>>25){MoveBits=26;}else{MoveBits=25;}}}}else{if(bGroupMixNum>>>20){if(bGroupMixNum>>>22){if(bGroupMixNum>>>23){MoveBits=24;}else{MoveBits=23;}}else{if(bGroupMixNum>>>21){MoveBits=22;}else{MoveBits=21;}}}else{if(bGroupMixNum>>>18){if(bGroupMixNum>>>19){MoveBits=20;}else{MoveBits=19;}}else{if(bGroupMixNum>>>17){MoveBits=18;}else{MoveBits=17;}}}}}else{if(bGroupMixNum>>>8){if(bGroupMixNum>>>12){if(bGroupMixNum>>>14){if(bGroupMixNum>>>15){MoveBits=16;}else{MoveBits=15;}}else{if(bGroupMixNum>>>13){MoveBits=14;}else{MoveBits=13;}}}else{if(bGroupMixNum>>>10){if(bGroupMixNum>>>11){MoveBits=12;}else{MoveBits=11;}}else{if(bGroupMixNum>>>9){MoveBits=10;}else{MoveBits=9;}}}}else{if(bGroupMixNum>>>4){if(bGroupMixNum>>>6){if(bGroupMixNum>>>7){MoveBits=8;}else{MoveBits=7;}}else{if(bGroupMixNum>>>5){MoveBits=6;}else{MoveBits=5;}}}else{if(bGroupMixNum>>>2){if(bGroupMixNum>>>3){MoveBits=4;}else{MoveBits=3;}}else{if(bGroupMixNum>>>1){MoveBits=2;}else{MoveBits=bGroupMixNum;}}}}}
							//trace("MoveBits="+MoveBits);
							
							bGroupValue|=(MoveBits<<27)>>>bGroupBitsOffset;
							bGroupBitsOffset+=5;
							
							//向 data 写入满8位(1字节)的数据:
							if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
							
							bGroupRshiftBitsOffset=32-MoveBits;
							bGroupValue|=(styleChangeRecord.MoveDeltaX<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
							bGroupBitsOffset+=MoveBits;
							
							//向 data 写入满8位(1字节)的数据:
							if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
							
							bGroupValue|=(styleChangeRecord.MoveDeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
							bGroupBitsOffset+=MoveBits;
							
							//向 data 写入满8位(1字节)的数据:
							if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
							
						}
						if(styleChangeRecord.StateFillStyle0){
							bGroupValue|=styleChangeRecord.FillStyle0<<(32-(bGroupBitsOffset+=newStyles.NumFillBits));
							
							//向 data 写入满8位(1字节)的数据:
							if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
							
						}
						if(styleChangeRecord.StateFillStyle1){
							bGroupValue|=styleChangeRecord.FillStyle1<<(32-(bGroupBitsOffset+=newStyles.NumFillBits));
							
							//向 data 写入满8位(1字节)的数据:
							if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
							
						}
						if(styleChangeRecord.StateLineStyle){
							bGroupValue|=styleChangeRecord.LineStyle<<(32-(bGroupBitsOffset+=newStyles.NumLineBits));
						}
						
						if(styleChangeRecord.StateNewStyles){
							//向 data 写入有效的数据:
							if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
							data.position=offset;
							data.writeBytes(styleChangeRecord.NewStyles.toData());
							newStyles=styleChangeRecord.NewStyles;
							bGroupValue=0;
							bGroupBitsOffset=0;
							offset=data.length;
						}
					break;
					case STRAIGHTEDGERECORD:
						var straightEdgeRecord:STRAIGHTEDGERECORD=ShapeRecord as STRAIGHTEDGERECORD;
						bGroupValue|=(1<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						bGroupValue|=(1<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						
						//计算所需最小位数:
						bGroupMixNum=((straightEdgeRecord.DeltaX<0?-straightEdgeRecord.DeltaX:straightEdgeRecord.DeltaX)<<1)|((straightEdgeRecord.DeltaY<0?-straightEdgeRecord.DeltaY:straightEdgeRecord.DeltaY)<<1);
						if(bGroupMixNum>>>16){if(bGroupMixNum>>>24){if(bGroupMixNum>>>28){if(bGroupMixNum>>>30){if(bGroupMixNum>>>31){NumBits=32;}else{NumBits=31;}}else{if(bGroupMixNum>>>29){NumBits=30;}else{NumBits=29;}}}else{if(bGroupMixNum>>>26){if(bGroupMixNum>>>27){NumBits=28;}else{NumBits=27;}}else{if(bGroupMixNum>>>25){NumBits=26;}else{NumBits=25;}}}}else{if(bGroupMixNum>>>20){if(bGroupMixNum>>>22){if(bGroupMixNum>>>23){NumBits=24;}else{NumBits=23;}}else{if(bGroupMixNum>>>21){NumBits=22;}else{NumBits=21;}}}else{if(bGroupMixNum>>>18){if(bGroupMixNum>>>19){NumBits=20;}else{NumBits=19;}}else{if(bGroupMixNum>>>17){NumBits=18;}else{NumBits=17;}}}}}else{if(bGroupMixNum>>>8){if(bGroupMixNum>>>12){if(bGroupMixNum>>>14){if(bGroupMixNum>>>15){NumBits=16;}else{NumBits=15;}}else{if(bGroupMixNum>>>13){NumBits=14;}else{NumBits=13;}}}else{if(bGroupMixNum>>>10){if(bGroupMixNum>>>11){NumBits=12;}else{NumBits=11;}}else{if(bGroupMixNum>>>9){NumBits=10;}else{NumBits=9;}}}}else{if(bGroupMixNum>>>4){if(bGroupMixNum>>>6){if(bGroupMixNum>>>7){NumBits=8;}else{NumBits=7;}}else{if(bGroupMixNum>>>5){NumBits=6;}else{NumBits=5;}}}else{if(bGroupMixNum>>>2){if(bGroupMixNum>>>3){NumBits=4;}else{NumBits=3;}}else{if(bGroupMixNum>>>1){NumBits=2;}else{NumBits=bGroupMixNum;}}}}}
						//trace("NumBits="+NumBits);
						if(NumBits<2){
							NumBits=2;//- -
						}
						
						bGroupValue|=((NumBits-2)<<28)>>>bGroupBitsOffset;
						bGroupBitsOffset+=4;
						
						bGroupRshiftBitsOffset=32-NumBits;
						bGroupValue|=(straightEdgeRecord.GeneralLineFlag<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						
						if(straightEdgeRecord.GeneralLineFlag){
						}else{
							bGroupValue|=(straightEdgeRecord.VertLineFlag<<31)>>>bGroupBitsOffset;
							bGroupBitsOffset++;
						}
						
						//向 data 写入满8位(1字节)的数据:
						if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
						
						if(straightEdgeRecord.GeneralLineFlag||!straightEdgeRecord.VertLineFlag){
							bGroupValue|=(straightEdgeRecord.DeltaX<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
							bGroupBitsOffset+=NumBits;
							
							//向 data 写入满8位(1字节)的数据:
							if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
							
						}
						if(straightEdgeRecord.GeneralLineFlag||straightEdgeRecord.VertLineFlag){
							//trace("straightEdgeRecord.DeltaY="+straightEdgeRecord.DeltaY);
							bGroupValue|=(straightEdgeRecord.DeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
							bGroupBitsOffset+=NumBits;
						}
					break;
					case CURVEDEDGERECORD:
						var curvedEdgeRecord:CURVEDEDGERECORD=ShapeRecord as CURVEDEDGERECORD;
						bGroupValue|=(1<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						//bGroupValue|=(0<<31)>>>bGroupBitsOffset;
						bGroupBitsOffset++;
						
						//计算所需最小位数:
						bGroupMixNum=((curvedEdgeRecord.ControlDeltaX<0?-curvedEdgeRecord.ControlDeltaX:curvedEdgeRecord.ControlDeltaX)<<1)|((curvedEdgeRecord.ControlDeltaY<0?-curvedEdgeRecord.ControlDeltaY:curvedEdgeRecord.ControlDeltaY)<<1)|((curvedEdgeRecord.AnchorDeltaX<0?-curvedEdgeRecord.AnchorDeltaX:curvedEdgeRecord.AnchorDeltaX)<<1)|((curvedEdgeRecord.AnchorDeltaY<0?-curvedEdgeRecord.AnchorDeltaY:curvedEdgeRecord.AnchorDeltaY)<<1);
						if(bGroupMixNum>>>16){if(bGroupMixNum>>>24){if(bGroupMixNum>>>28){if(bGroupMixNum>>>30){if(bGroupMixNum>>>31){NumBits=32;}else{NumBits=31;}}else{if(bGroupMixNum>>>29){NumBits=30;}else{NumBits=29;}}}else{if(bGroupMixNum>>>26){if(bGroupMixNum>>>27){NumBits=28;}else{NumBits=27;}}else{if(bGroupMixNum>>>25){NumBits=26;}else{NumBits=25;}}}}else{if(bGroupMixNum>>>20){if(bGroupMixNum>>>22){if(bGroupMixNum>>>23){NumBits=24;}else{NumBits=23;}}else{if(bGroupMixNum>>>21){NumBits=22;}else{NumBits=21;}}}else{if(bGroupMixNum>>>18){if(bGroupMixNum>>>19){NumBits=20;}else{NumBits=19;}}else{if(bGroupMixNum>>>17){NumBits=18;}else{NumBits=17;}}}}}else{if(bGroupMixNum>>>8){if(bGroupMixNum>>>12){if(bGroupMixNum>>>14){if(bGroupMixNum>>>15){NumBits=16;}else{NumBits=15;}}else{if(bGroupMixNum>>>13){NumBits=14;}else{NumBits=13;}}}else{if(bGroupMixNum>>>10){if(bGroupMixNum>>>11){NumBits=12;}else{NumBits=11;}}else{if(bGroupMixNum>>>9){NumBits=10;}else{NumBits=9;}}}}else{if(bGroupMixNum>>>4){if(bGroupMixNum>>>6){if(bGroupMixNum>>>7){NumBits=8;}else{NumBits=7;}}else{if(bGroupMixNum>>>5){NumBits=6;}else{NumBits=5;}}}else{if(bGroupMixNum>>>2){if(bGroupMixNum>>>3){NumBits=4;}else{NumBits=3;}}else{if(bGroupMixNum>>>1){NumBits=2;}else{NumBits=bGroupMixNum;}}}}}
						//trace("NumBits="+NumBits);
						if(NumBits<2){
							NumBits=2;//- -
						}
						
						bGroupValue|=((NumBits-2)<<28)>>>bGroupBitsOffset;
						bGroupBitsOffset+=4;
						
						//向 data 写入满8位(1字节)的数据:
						if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
						
						bGroupRshiftBitsOffset=32-NumBits;
						bGroupValue|=(curvedEdgeRecord.ControlDeltaX<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
						bGroupBitsOffset+=NumBits;
						
						//向 data 写入满8位(1字节)的数据:
						if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
						
						bGroupValue|=(curvedEdgeRecord.ControlDeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
						bGroupBitsOffset+=NumBits;
						
						//向 data 写入满8位(1字节)的数据:
						if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
						
						bGroupValue|=(curvedEdgeRecord.AnchorDeltaX<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
						bGroupBitsOffset+=NumBits;
						
						//向 data 写入满8位(1字节)的数据:
						if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
						
						bGroupValue|=(curvedEdgeRecord.AnchorDeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
						bGroupBitsOffset+=NumBits;
						
					break;
					default:
						throw new Error('奇怪的 ShapeRecord["constructor"]: '+ShapeRecord["constructor"]);
					break;
				}
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
			
				//import zero.BytesAndStr2;
				//trace("==="+BytesAndStr2.bytes2str2(data,startOffset,offset-startOffset));
				
			}
			
			//trace(data[data.length-1]);
			
			//ENDSHAPERECORD
			//bGroupValue|=(0<<26)>>>bGroupBitsOffset;
			bGroupBitsOffset+=6;
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
			
			//import zero.BytesAndStr2;
			//trace("==="+BytesAndStr2.bytes2str2(data,startOffset,offset-startOffset));
			
			//trace(data[data.length-1]);
			
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<SHAPEWITHSTYLE>
				<fillAndLineStyles/>
				<ShapeRecordList/>
			</SHAPEWITHSTYLE>;
			xml.fillAndLineStyles.appendChild(fillAndLineStyles.toXML());
			if(ShapeRecordV.length){
				var listXML:XML=xml.ShapeRecordList[0];
				listXML.@count=ShapeRecordV.length;
				for each(var ShapeRecord:SHAPERECORD in ShapeRecordV){
					var itemXML:XML=<ShapeRecord/>;
					itemXML.appendChild(ShapeRecord.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.ShapeRecordList;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			fillAndLineStyles=new FillAndLineStyles();
			fillAndLineStyles.initByXML(xml.fillAndLineStyles.children()[0]);
			
			if(xml.ShapeRecordList.length()){
				var listXML:XML=xml.ShapeRecordList[0];
				var ShapeRecordXMLList:XMLList=listXML.ShapeRecord;
				var i:int=-1;
				ShapeRecordV=new Vector.<SHAPERECORD>(ShapeRecordXMLList.length());
				for each(var ShapeRecordXML:XML in ShapeRecordXMLList){
					i++;
					var ShapeRecordXMLNode:XML=ShapeRecordXML.children()[0];
					switch(ShapeRecordXMLNode.name().toString()){
						case "STYLECHANGERECORD":
							ShapeRecordV[i]=new STYLECHANGERECORD();
						break;
						case "STRAIGHTEDGERECORD":
							ShapeRecordV[i]=new STRAIGHTEDGERECORD();
						break;
						case "CURVEDEDGERECORD":
							ShapeRecordV[i]=new CURVEDEDGERECORD();
						break;
						default:
							throw new Error("奇怪的 ShapeRecordXMLNode.name(): "+ShapeRecordXMLNode.name().toString());
						break;
					}
					ShapeRecordV[i].initByXML(ShapeRecordXMLNode);
				}
			}else{
				ShapeRecordV=new Vector.<SHAPERECORD>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
