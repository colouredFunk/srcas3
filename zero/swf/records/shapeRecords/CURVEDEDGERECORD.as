/***
CURVEDEDGERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 14:58:18
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
package zero.swf.records.shapeRecords{
	import flash.utils.ByteArray;
	public class CURVEDEDGERECORD extends SHAPERECORD{
		//public var TypeFlag:int;
		//public var StraightFlag:int;
		//public var NumBits:int;
		public var ControlDeltaX:int;
		public var ControlDeltaY:int;
		public var AnchorDeltaX:int;
		public var AnchorDeltaY:int;
		//
		
		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			return <{xmlName} class="CURVEDEDGERECORD"
				//TypeFlag={TypeFlag}
				//StraightFlag={StraightFlag}
				//NumBits={NumBits}
				ControlDeltaX={ControlDeltaX}
				ControlDeltaY={ControlDeltaY}
				AnchorDeltaX={AnchorDeltaX}
				AnchorDeltaY={AnchorDeltaY}
			/>;
		}
		override public function initByXML(xml:XML):void{
			//TypeFlag=int(xml.@TypeFlag.toString());
			//StraightFlag=int(xml.@StraightFlag.toString());
			//NumBits=int(xml.@NumBits.toString());
			ControlDeltaX=int(xml.@ControlDeltaX.toString());
			ControlDeltaY=int(xml.@ControlDeltaY.toString());
			AnchorDeltaX=int(xml.@AnchorDeltaX.toString());
			AnchorDeltaY=int(xml.@AnchorDeltaY.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
