/***
SHAPERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 14:09:00
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


package zero.getfonts.swf.records.shapes{
	import flash.utils.ByteArray;
	public class SHAPERECORD{
		
		public var type:String;
		
		public var DeltaX:int;
		public var DeltaY:int;
		
		public var ControlDeltaX:int;
		public var ControlDeltaY:int;
		public var AnchorDeltaX:int;
		public var AnchorDeltaY:int;
		
		public var MoveDeltaXY:Array;
		//public var MoveDeltaX:int;
		//public var MoveDeltaY:int;
		public var FillStyle0:int;//从 1 开始（0 表示没有填充）
		public var FillStyle1:int;//从 1 开始（0 表示没有填充）
		public var LineStyle:int;//从 1 开始（0 表示没有笔触）
		public var FillStyleV:Vector.<FILLSTYLE>;
		public var LineStyleV:Vector.<LINESTYLE>;
		public var LineStyle2V:Vector.<LINESTYLE2>;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			throw new Error("直接在 SHAPEWITHSTYLE 里 initByData");
		}
		public function toData(_toDataOptions:Object):ByteArray{
			throw new Error("直接在 SHAPEWITHSTYLE 里 toData");
		}
	}
}