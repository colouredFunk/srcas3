/***
STYLECHANGERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 14:03:46 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//StyleChangeRecord
//The style change record is also a non-edge record. It can be used to do the following:
//1. Select a fill or line style for drawing.
//2. Move the current drawing position (without drawing).
//3. Replace the current fill and line style arrays with a new set of styles.
//Because fill and line styles often change at the start of a new path, it is useful to perform more
//than one action in a single record. For example, say a DefineShape tag defines a red circle and
//a blue square. After the circle is closed, it is necessary to move the drawing position, and
//replace the red fill with the blue fill. The style change record can achieve this with a single
//shape record.
//STYLECHANGERECORD
//Field 				Type 								Comment
//TypeFlag 				UB[1] 								Non-edge record flag. Always 0.
//StateNewStyles 		UB[1] 								New styles flag. Used by DefineShape2 and DefineShape3 only.
//StateLineStyle 		UB[1] 								Line style change flag.
//StateFillStyle1 		UB[1] 								Fill style 1 change flag.
//StateFillStyle0 		UB[1] 								Fill style 0 change flag.
//StateMoveTo 			UB[1] 								Move to flag.
//MoveBits 				If StateMoveTo, UB[5] 				Move bit count.
//MoveDeltaX 			If StateMoveTo, SB[MoveBits] 		Delta X value.
//MoveDeltaY 			If StateMoveTo, SB[MoveBits] 		Delta Y value.
//FillStyle0 			If StateFillStyle0, UB[FillBits] 	Fill 0 Style.
//FillStyle1 			If StateFillStyle1, UB[FillBits] 	Fill 1 Style.
//LineStyle 			If StateLineStyle, UB[LineBits] 	Line Style.
//FillStyles 			If StateNewStyles, FILLSTYLEARRAY	Array of new fill styles.
//LineStyles 			If StateNewStyles, LINESTYLEARRAY	Array of new line styles.
//NumFillBits 			If StateNewStyles, UB[4] 			Number of fill index bits for new styles.
//NumLineBits 			If StateNewStyles, UB[4] 			Number of line index bits for new styles.
//In the first shape record MoveDeltaX and MoveDeltaY are relative to the shape origin.
//In subsequent shape records, MoveDeltaX and MoveDeltaY are relative to the current
//drawing position.
//The style arrays begin at index 1, not index 0. FillStyle = 1 refers to the first style in the fill
//style array, FillStyle = 2 refers to the second style in the fill style array, and so on. A fill style
//index of zero means the path is not filled, and a line style index of zero means the path has no
//stroke. Initially the fill and line style indices are set to zero—no fill or stroke.
package zero.swf.record.shape_records{
	import zero.swf.record.NEWSTYLES;
	import flash.utils.ByteArray;
	public class STYLECHANGERECORD extends SHAPERECORD{
		public var TypeFlag:int;
		public var StateNewStyles:int;
		public var StateLineStyle:int;
		public var StateFillStyle1:int;
		public var StateFillStyle0:int;
		public var StateMoveTo:int;
		public var MoveBits:int;
		public var MoveDeltaX:int;
		public var MoveDeltaY:int;
		public var FillStyle0:int;
		public var FillStyle1:int;
		public var LineStyle:int;
		public var NewStyles:NEWSTYLES;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var bGroupValue:int=(data[offset]<<24)|(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3];
			TypeFlag=bGroupValue>>>31;						//10000000 00000000 00000000 00000000
			StateNewStyles=(bGroupValue<<1)>>>31;			//01000000 00000000 00000000 00000000
			//#offsetpp
			offset+=4;
			StateLineStyle=(bGroupValue<<2)>>>31;			//00100000 00000000 00000000 00000000
			//#offsetpp
			
			StateFillStyle1=(bGroupValue<<3)>>>31;			//00010000 00000000 00000000 00000000
			//#offsetpp
			
			StateFillStyle0=(bGroupValue<<4)>>>31;			//00001000 00000000 00000000 00000000
			//#offsetpp
			
			StateMoveTo=(bGroupValue<<5)>>>31;				//00000100 00000000 00000000 00000000
			//#offsetpp
			
			var bGroupBitsOffset:int=6;
			
			if(StateMoveTo){
				MoveBits=(bGroupValue<<6)>>>27;					//00000011 11100000 00000000 00000000
				bGroupBitsOffset=11;
				
				
				if(MoveBits){
					var bGroupRshiftBitsOffset:int=32-MoveBits;
					var bGroupNegMask:int=1<<(MoveBits-1);
					var bGroupNeg:int=0xffffffff<<MoveBits;
					
					MoveDeltaX=(bGroupValue<<11)>>>bGroupRshiftBitsOffset;
					if(MoveDeltaX&bGroupNegMask){MoveDeltaX|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=MoveBits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					MoveDeltaY=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(MoveDeltaY&bGroupNegMask){MoveDeltaY|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=MoveBits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
				}
			}
			if(StateFillStyle0){
				FillStyle0=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
				bGroupBitsOffset+=FillBits;
				
				//从 data 读取足够多的位数以备下面使用:
				if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				
			}
			if(StateFillStyle1){
				FillStyle1=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
				bGroupBitsOffset+=FillBits;
				
				//从 data 读取足够多的位数以备下面使用:
				if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				
			}
			if(StateLineStyle){
				LineStyle=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
				bGroupBitsOffset+=LineBits;
			}
			
			offset-=int(4-bGroupBitsOffset/8);
			
			//#offsetpp
			
			if(StateNewStyles){
				//#offsetpp
			
				NewStyles=new NEWSTYLES();
				offset=NewStyles.initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var bGroupValue:int=0;
			bGroupValue|=TypeFlag<<31;						//10000000 00000000 00000000 00000000
			bGroupValue|=StateNewStyles<<30;				//01000000 00000000 00000000 00000000
			//#offsetpp
			var offset:int=0;
			bGroupValue|=StateLineStyle<<29;				//00100000 00000000 00000000 00000000
			//#offsetpp
			
			bGroupValue|=StateFillStyle1<<28;				//00010000 00000000 00000000 00000000
			//#offsetpp
			
			bGroupValue|=StateFillStyle0<<27;				//00001000 00000000 00000000 00000000
			//#offsetpp
			
			bGroupValue|=StateMoveTo<<26;					//00000100 00000000 00000000 00000000
			//#offsetpp
			
			var bGroupBitsOffset:int=6;
			
			if(StateMoveTo){
			
				//计算所需最小位数:
				var bGroupMixNum:int=((MoveDeltaX<0?-MoveDeltaX:MoveDeltaX)<<1)|((MoveDeltaY<0?-MoveDeltaY:MoveDeltaY)<<1);
				if(bGroupMixNum>>>16){if(bGroupMixNum>>>24){if(bGroupMixNum>>>28){if(bGroupMixNum>>>30){if(bGroupMixNum>>>31){MoveBits=32;}else{MoveBits=31;}}else{if(bGroupMixNum>>>29){MoveBits=30;}else{MoveBits=29;}}}else{if(bGroupMixNum>>>26){if(bGroupMixNum>>>27){MoveBits=28;}else{MoveBits=27;}}else{if(bGroupMixNum>>>25){MoveBits=26;}else{MoveBits=25;}}}}else{if(bGroupMixNum>>>20){if(bGroupMixNum>>>22){if(bGroupMixNum>>>23){MoveBits=24;}else{MoveBits=23;}}else{if(bGroupMixNum>>>21){MoveBits=22;}else{MoveBits=21;}}}else{if(bGroupMixNum>>>18){if(bGroupMixNum>>>19){MoveBits=20;}else{MoveBits=19;}}else{if(bGroupMixNum>>>17){MoveBits=18;}else{MoveBits=17;}}}}}else{if(bGroupMixNum>>>8){if(bGroupMixNum>>>12){if(bGroupMixNum>>>14){if(bGroupMixNum>>>15){MoveBits=16;}else{MoveBits=15;}}else{if(bGroupMixNum>>>13){MoveBits=14;}else{MoveBits=13;}}}else{if(bGroupMixNum>>>10){if(bGroupMixNum>>>11){MoveBits=12;}else{MoveBits=11;}}else{if(bGroupMixNum>>>9){MoveBits=10;}else{MoveBits=9;}}}}else{if(bGroupMixNum>>>4){if(bGroupMixNum>>>6){if(bGroupMixNum>>>7){MoveBits=8;}else{MoveBits=7;}}else{if(bGroupMixNum>>>5){MoveBits=6;}else{MoveBits=5;}}}else{if(bGroupMixNum>>>2){if(bGroupMixNum>>>3){MoveBits=4;}else{MoveBits=3;}}else{if(bGroupMixNum>>>1){MoveBits=2;}else{MoveBits=bGroupMixNum;}}}}}
				
				bGroupValue|=MoveBits<<21;						//00000011 11100000 00000000 00000000
				bGroupBitsOffset=11;
				
				var bGroupRshiftBitsOffset:int=32-MoveBits;
				bGroupValue|=(MoveDeltaX<<bGroupRshiftBitsOffset)>>>11;
				bGroupBitsOffset+=MoveBits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(MoveDeltaY<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=MoveBits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
			}
			if(StateFillStyle0){
				bGroupValue|=FillStyle0<<(32-(bGroupBitsOffset+=FillBits));
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
			}
			if(StateFillStyle1){
				bGroupValue|=FillStyle1<<(32-(bGroupBitsOffset+=FillBits));
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
			}
			if(StateLineStyle){
				bGroupValue|=LineStyle<<(32-(bGroupBitsOffset+=LineBits));
			}
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
			if(StateNewStyles){
				data.position=offset;
				data.writeBytes(NewStyles.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<STYLECHANGERECORD
				TypeFlag={TypeFlag}
				StateNewStyles={StateNewStyles}
				StateLineStyle={StateLineStyle}
				StateFillStyle1={StateFillStyle1}
				StateFillStyle0={StateFillStyle0}
				StateMoveTo={StateMoveTo}
				MoveBits={MoveBits}
				MoveDeltaX={MoveDeltaX}
				MoveDeltaY={MoveDeltaY}
				FillStyle0={FillStyle0}
				FillStyle1={FillStyle1}
				LineStyle={LineStyle}
			>
				<NewStyles/>
			</STYLECHANGERECORD>;
			if(StateNewStyles){
				xml.NewStyles.appendChild(NewStyles.toXML());
			}else{
				delete xml.NewStyles;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			TypeFlag=int(xml.@TypeFlag.toString());
			StateNewStyles=int(xml.@StateNewStyles.toString());
			StateLineStyle=int(xml.@StateLineStyle.toString());
			StateFillStyle1=int(xml.@StateFillStyle1.toString());
			StateFillStyle0=int(xml.@StateFillStyle0.toString());
			StateMoveTo=int(xml.@StateMoveTo.toString());
			MoveBits=int(xml.@MoveBits.toString());
			MoveDeltaX=int(xml.@MoveDeltaX.toString());
			MoveDeltaY=int(xml.@MoveDeltaY.toString());
			FillStyle0=int(xml.@FillStyle0.toString());
			FillStyle1=int(xml.@FillStyle1.toString());
			LineStyle=int(xml.@LineStyle.toString());
			if(StateNewStyles){
				NewStyles=new NEWSTYLES();
				NewStyles.initByXML(xml.NewStyles.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
