/***
BUTTONRECORD
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
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
package zero.swf.records.buttons{
	import zero.swf.records.MATRIX;
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.records.Filter;
	import zero.swf.records.BlendModes;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	public class BUTTONRECORD{//implements I_zero_swf_CheckCodesRight{
		public var ButtonStateHitTest:Boolean;
		public var ButtonStateDown:Boolean;
		public var ButtonStateOver:Boolean;
		public var ButtonStateUp:Boolean;
		public var CharacterID:int;						//UI16
		public var PlaceDepth:int;						//UI16
		public var PlaceMatrix:MATRIX;
		public var ColorTransform:CXFORMWITHALPHA;
		public var FilterV:Vector.<*>;
		public var BlendMode:int;						//UI8
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var flags:int=data[offset++];
			//Reserved=flags&0xc0;							//11000000
			ButtonStateHitTest=((flags&0x08)?true:false);			//00001000
			ButtonStateDown=((flags&0x04)?true:false);			//00000100
			ButtonStateOver=((flags&0x02)?true:false);			//00000010
			ButtonStateUp=((flags&0x01)?true:false);				//00000001
			CharacterID=data[offset++]|(data[offset++]<<8);
			PlaceDepth=data[offset++]|(data[offset++]<<8);
			PlaceMatrix=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.records.MATRIX"]||MATRIX)();
			offset=PlaceMatrix.initByData(data,offset,endOffset,_initByDataOptions);
			ColorTransform=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.records.CXFORM"]||CXFORMWITHALPHA)();
			offset=ColorTransform.initByData(data,offset,endOffset,_initByDataOptions);
			if(flags&0x10){//ButtonHasFilterList			//00010000
				var NumberOfFilters:int=data[offset++];
				if(NumberOfFilters){
					FilterV=new Vector.<*>();
					for(var i:int=0;i<NumberOfFilters;i++){
						FilterV[i]=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.records.Filter"]||Filter)();
						offset=FilterV[i].initByData(data,offset,endOffset,_initByDataOptions);
					}
				}else{
					FilterV=null;
				}
			}else{
				FilterV=null;
			}
			if(flags&0x20){//ButtonHasBlendMode				//00100000
				BlendMode=data[offset++];
			}else{
				BlendMode=-1;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			//flags|=Reserved;								//11000000
			if(ButtonStateHitTest){
				flags|=0x08;								//00001000
			}
			if(ButtonStateDown){
				flags|=0x04;								//00000100
			}
			if(ButtonStateOver){
				flags|=0x02;								//00000010
			}
			if(ButtonStateUp){
				flags|=0x01;								//00000001
			}					
			data[1]=CharacterID;
			data[2]=CharacterID>>8;
			data[3]=PlaceDepth;
			data[4]=PlaceDepth>>8;
			data.position=5;
			//import zero.BytesAndStr16;
			//trace(BytesAndStr16.bytes2str16(data,0,data.length));
			data.writeBytes(PlaceMatrix.toData(_toDataOptions));
			//trace(BytesAndStr16.bytes2str16(data,0,data.length));
			data.writeBytes(ColorTransform.toData(_toDataOptions));
			//trace(BytesAndStr16.bytes2str16(data,0,data.length));
			var offset:int=data.length;
			if(FilterV){
				var NumberOfFilters:int=FilterV.length;
				if(NumberOfFilters){
					flags|=0x10;//ButtonHasFilterList		//00010000
					data[offset++]=NumberOfFilters;
					data.position=offset;
					for each(var Filter:* in FilterV){
						data.writeBytes(Filter.toData(_toDataOptions));
					}
					offset=data.length;
				}
			}
			//trace(BytesAndStr16.bytes2str16(data,0,data.length));
			if(BlendMode>-1){
				flags|=0x20;//ButtonHasBlendMode			//00100000
				data[offset]=BlendMode;
			}
			data[0]=flags;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.records.buttons.BUTTONRECORD"
				ButtonStateHitTest={ButtonStateHitTest}
				ButtonStateDown={ButtonStateDown}
				ButtonStateOver={ButtonStateOver}
				ButtonStateUp={ButtonStateUp}
				CharacterID={CharacterID}
				PlaceDepth={PlaceDepth}
			/>;
			xml.appendChild(PlaceMatrix.toXML("PlaceMatrix",_toXMLOptions));
			xml.appendChild(ColorTransform.toXML("ColorTransform",_toXMLOptions));
			if(FilterV){
				if(FilterV.length){
					var FilterListXML:XML=<FilterList count={FilterV.length}/>
					for each(var Filter:* in FilterV){
						FilterListXML.appendChild(Filter.toXML("Filter",_toXMLOptions));
					}
					xml.appendChild(FilterListXML);
				}
			}
			if(BlendMode>-1){
				xml.@BlendMode=BlendModes.blendModeV[BlendMode];
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			ButtonStateHitTest=(xml.@ButtonStateHitTest.toString()=="true");
			ButtonStateDown=(xml.@ButtonStateDown.toString()=="true");
			ButtonStateOver=(xml.@ButtonStateOver.toString()=="true");
			ButtonStateUp=(xml.@ButtonStateUp.toString()=="true");
			CharacterID=int(xml.@CharacterID.toString());
			PlaceDepth=int(xml.@PlaceDepth.toString());
			var PlaceMatrixXML:XML=xml.PlaceMatrix[0];
			PlaceMatrix=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[PlaceMatrixXML["@class"].toString()]||MATRIX)();
			PlaceMatrix.initByXML(PlaceMatrixXML,_initByXMLOptions);
			var ColorTransformXML:XML=xml.ColorTransform[0];
			ColorTransform=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[ColorTransformXML["@class"].toString()]||CXFORMWITHALPHA)();
			ColorTransform.initByXML(ColorTransformXML,_initByXMLOptions);
			var FilterXMLList:XMLList=xml.FilterList.Filter;
			if(FilterXMLList.length()){
				var i:int=-1;
				FilterV=new Vector.<*>();
				for each(var FilterXML:XML in FilterXMLList){
					i++;
					FilterV[i]=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[FilterXML["@class"].toString()]||Filter)();
					FilterV[i].initByXML(FilterXML,_initByXMLOptions);
				}
			}else{
				FilterV=null;
			}
			var BlendModeXML:XML=xml.@BlendMode[0];
			if(BlendModeXML){
				BlendMode=BlendModes[BlendModeXML.toString()];
			}else{
				BlendMode=-1;
			}
		}
		}//end of CONFIG::USE_XML
	}
}
