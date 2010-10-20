/***
STYLECHANGERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 18:25:15 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.records.shape_records{
	import zero.swf.records.FillAndLineStyles;
	import flash.utils.ByteArray;
	public class STYLECHANGERECORD extends SHAPERECORD{
		//public var TypeFlag:int;
		public var StateNewStyles:int;
		public var StateLineStyle:int;
		public var StateFillStyle1:int;
		public var StateFillStyle0:int;
		public var StateMoveTo:int;
		//public var MoveBits:int;
		public var MoveDeltaX:int;
		public var MoveDeltaY:int;
		public var FillStyle0:int;
		public var FillStyle1:int;
		public var LineStyle:int;
		public var NewStyles:FillAndLineStyles;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			throw new Error("直接在 SHAPEWITHSTYLE 里 initByData");
			return -1;
		}
		override public function toData():ByteArray{
			throw new Error("直接在 SHAPEWITHSTYLE 里 toData");
			return null;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<STYLECHANGERECORD
				//TypeFlag={TypeFlag}
				StateNewStyles={StateNewStyles}
				StateLineStyle={StateLineStyle}
				StateFillStyle1={StateFillStyle1}
				StateFillStyle0={StateFillStyle0}
				StateMoveTo={StateMoveTo}
				//MoveBits={MoveBits}
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
			//TypeFlag=int(xml.@TypeFlag.toString());
			StateNewStyles=int(xml.@StateNewStyles.toString());
			StateLineStyle=int(xml.@StateLineStyle.toString());
			StateFillStyle1=int(xml.@StateFillStyle1.toString());
			StateFillStyle0=int(xml.@StateFillStyle0.toString());
			StateMoveTo=int(xml.@StateMoveTo.toString());
			//MoveBits=int(xml.@MoveBits.toString());
			MoveDeltaX=int(xml.@MoveDeltaX.toString());
			MoveDeltaY=int(xml.@MoveDeltaY.toString());
			FillStyle0=int(xml.@FillStyle0.toString());
			FillStyle1=int(xml.@FillStyle1.toString());
			LineStyle=int(xml.@LineStyle.toString());
			if(StateNewStyles){
				NewStyles=new FillAndLineStyles();
				NewStyles.initByXML(xml.NewStyles.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
