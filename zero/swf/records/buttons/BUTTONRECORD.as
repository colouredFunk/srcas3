package zero.swf.records.buttons{
	import zero.swf.records.MATRIX;
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.records.Filter;
	import zero.swf.records.BlendModes;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	public class BUTTONRECORD{
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
			var PlaceMatrixClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					PlaceMatrixClass=_initByDataOptions.classes["zero.swf.records.MATRIX"];
				}
			}
			PlaceMatrix=new (PlaceMatrixClass||MATRIX)();
			offset=PlaceMatrix.initByData(data,offset,endOffset,_initByDataOptions);
			var ColorTransformClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ColorTransformClass=_initByDataOptions.classes["zero.swf.records.CXFORMWITHALPHA"];
				}
			}
			ColorTransform=new (ColorTransformClass||CXFORMWITHALPHA)();
			offset=ColorTransform.initByData(data,offset,endOffset,_initByDataOptions);
			if(flags&0x10){//ButtonHasFilterList			//00010000
				var NumberOfFilters:int=data[offset++];
				if(NumberOfFilters){
					FilterV=new Vector.<*>();
					for(var i:int=0;i<NumberOfFilters;i++){
						var FilterClass:Class;
						if(_initByDataOptions){
							if(_initByDataOptions.classes){
								FilterClass=_initByDataOptions.classes["zero.swf.records.Filter"];
							}
						}
						FilterV[i]=new (FilterClass||Filter)();
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
