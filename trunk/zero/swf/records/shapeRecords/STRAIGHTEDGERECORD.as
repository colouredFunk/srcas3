/***
STRAIGHTEDGERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 15:06:30 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.records.shapeRecords{
	import flash.utils.ByteArray;
	public class STRAIGHTEDGERECORD extends SHAPERECORD{
		//public var TypeFlag:int;
		//public var StraightFlag:int;
		//public var NumBits:int;
		public var GeneralLineFlag:int;
		public var VertLineFlag:int;
		public var DeltaX:int;
		public var DeltaY:int;
		//
		
		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			return <{xmlName} class="STRAIGHTEDGERECORD"
				//TypeFlag={TypeFlag}
				//StraightFlag={StraightFlag}
				//NumBits={NumBits}
				GeneralLineFlag={GeneralLineFlag}
				VertLineFlag={VertLineFlag}
				DeltaX={DeltaX}
				DeltaY={DeltaY}
			/>;
		}
		override public function initByXML(xml:XML):void{
			//TypeFlag=int(xml.@TypeFlag.toString());
			//StraightFlag=int(xml.@StraightFlag.toString());
			//NumBits=int(xml.@NumBits.toString());
			GeneralLineFlag=int(xml.@GeneralLineFlag.toString());
			VertLineFlag=int(xml.@VertLineFlag.toString());
			DeltaX=int(xml.@DeltaX.toString());
			DeltaY=int(xml.@DeltaY.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
