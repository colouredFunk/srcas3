﻿/***
BUTTONRECORD_within_DefineButton 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月12日 18:24:49 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A button record defines a character to be displayed in one or more button states. The
//ButtonState flags indicate which state (or states) the character belongs to.
//A one-to-one relationship does not exist between button records and button states. A single
//button record can apply to more than one button state (by setting multiple ButtonState flags),
//and multiple button records can be present for any button state.
//Each button record also includes a transformation matrix and depth (stacking-order)
//information. These apply just as in a PlaceObject tag, except that both pieces of information
//are relative to the button character itself.
//SWF 8 and later supports the new ButtonHasBlendMode and ButtonHasFilterList fields to
//support blend modes and bitmap filters on buttons. Flash Player 7 and earlier ignores these
//two fields.

//BUTTONRECORD
//Field 				Type 															Comment
//ButtonReserved 		UB[2] 															Reserved bits; always 0
//ButtonHasBlendMode 	UB[1] 															0 = No blend mode
//																						1 = Has blend mode (SWF 8 and later only)
//ButtonHasFilterList 	UB[1] 															0 = No filter list
//																						1 = Has filter list (SWF 8 and later only)
//ButtonStateHitTest 	UB[1] 															Present in hit test state
//ButtonStateDown 		UB[1] 															Present in down state
//ButtonStateOver 		UB[1] 															Present in over state
//ButtonStateUp 		UB[1] 															Present in up state
//CharacterID 			UI16 															ID of character to place
//PlaceDepth 			UI16 															Depth at which to place character
//PlaceMatrix 			MATRIX 															Transformation matrix for character placement
//ColorTransform 		If within DefineButton2,CXFORMWITHALPHA							Character color transform
//FilterList 			If within DefineButton2 and	ButtonHasFilterList = 1,FILTERLIST	List of filters on this button
//BlendMode 			If within DefineButton2 and ButtonHasBlendMode = 1,UI8			0 or 1 = normal
//																						2 = layer
//																						3 = multiply
//																						4 = screen
//																						5 = lighten
//																						6 = darken
//																						7 = difference
//																						8 = add
//																						9 = subtract
//																						10 = invert
//																						11 = alpha
//																						12 = erase
//																						13 = overlay
//																						14 = hardlight
//																						Values 15 to 255 are reserved.
package zero.swf.records{
	import zero.swf.records.MATRIX;
	import flash.utils.ByteArray;
	public class BUTTONRECORD_within_DefineButton extends Record{
		public var ButtonHasBlendMode:int;
		public var ButtonHasFilterList:int;
		public var ButtonStateHitTest:int;
		public var ButtonStateDown:int;
		public var ButtonStateOver:int;
		public var ButtonStateUp:int;
		public var CharacterID:int;						//UI16
		public var PlaceDepth:int;						//UI16
		public var PlaceMatrix:MATRIX;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var flags:int=data[offset];
			//Reserved=(flags<<24)>>>30;				//11000000
			ButtonHasBlendMode=(flags<<26)>>>31;		//00100000
			ButtonHasFilterList=(flags<<27)>>>31;		//00010000
			ButtonStateHitTest=(flags<<28)>>>31;		//00001000
			ButtonStateDown=(flags<<29)>>>31;			//00000100
			ButtonStateOver=(flags<<30)>>>31;			//00000010
			ButtonStateUp=flags&0x01;					//00000001
			CharacterID=data[offset+1]|(data[offset+2]<<8);
			PlaceDepth=data[offset+3]|(data[offset+4]<<8);
			//#offsetpp
			offset+=5;
			PlaceMatrix=new MATRIX();
			return PlaceMatrix.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var flags:int=0;
			//flags|=Reserved<<6;						//11000000
			flags|=ButtonHasBlendMode<<5;				//00100000
			flags|=ButtonHasFilterList<<4;				//00010000
			flags|=ButtonStateHitTest<<3;				//00001000
			flags|=ButtonStateDown<<2;					//00000100
			flags|=ButtonStateOver<<1;					//00000010
			flags|=ButtonStateUp;						//00000001
			data[0]=flags;
			
			data[1]=CharacterID;
			data[2]=CharacterID>>8;
			data[3]=PlaceDepth;
			data[4]=PlaceDepth>>8;
			data.position=5;
			data.writeBytes(PlaceMatrix.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<BUTTONRECORD_within_DefineButton
				ButtonHasBlendMode={ButtonHasBlendMode}
				ButtonHasFilterList={ButtonHasFilterList}
				ButtonStateHitTest={ButtonStateHitTest}
				ButtonStateDown={ButtonStateDown}
				ButtonStateOver={ButtonStateOver}
				ButtonStateUp={ButtonStateUp}
				CharacterID={CharacterID}
				PlaceDepth={PlaceDepth}
			>
				<PlaceMatrix/>
			</BUTTONRECORD_within_DefineButton>;
			xml.PlaceMatrix.appendChild(PlaceMatrix.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			ButtonHasBlendMode=int(xml.@ButtonHasBlendMode.toString());
			ButtonHasFilterList=int(xml.@ButtonHasFilterList.toString());
			ButtonStateHitTest=int(xml.@ButtonStateHitTest.toString());
			ButtonStateDown=int(xml.@ButtonStateDown.toString());
			ButtonStateOver=int(xml.@ButtonStateOver.toString());
			ButtonStateUp=int(xml.@ButtonStateUp.toString());
			CharacterID=int(xml.@CharacterID.toString());
			PlaceDepth=int(xml.@PlaceDepth.toString());
			PlaceMatrix=new MATRIX();
			PlaceMatrix.initByXML(xml.PlaceMatrix.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
