/***
MORPHGRADIENT
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月23日 07:23:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//MORPHGRADIENT
//The format of gradient information is described in the following table:
//
//MORPHGRADIENT
//Field 				Type 							Comment
//NumGradients 			UI8 							1 to 8.
//GradientRecords 		MORPHGRADRECORD[NumGradients]	Gradient records (see following).

//MORPHGRADRECORD
//The gradient record format is described in the following table:
//
//MORPHGRADRECORD
//Field 			Type 			Comment
//StartRatio 		UI8 			Ratio value for start shape.
//StartColor 		RGBA 			Color of gradient for start shape.
//EndRatio 			UI8 			Ratio value for end shape.
//EndColor 			RGBA 			Color of gradient for end shape.

package zero.swf.records.shapes{
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	public class MORPHGRADIENT{
		public var StartRatioV:Vector.<int>;
		public var StartColorV:Vector.<uint>;
		public var EndRatioV:Vector.<int>;
		public var EndColorV:Vector.<uint>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			trace("可能不区分 RGB 和 RGBA?");
			var NumGradients:int=data[offset++];
			StartRatioV=new Vector.<int>();
			StartColorV=new Vector.<uint>();
			EndRatioV=new Vector.<int>();
			EndColorV=new Vector.<uint>();
			for(var i:int=0;i<NumGradients;i++){
				StartRatioV[i]=data[offset++];
				if(_initByDataOptions&&_initByDataOptions.ColorUseRGBA){//20110813
					StartColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				}else{
					StartColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
				}
				EndRatioV[i]=data[offset++];
				if(_initByDataOptions&&_initByDataOptions.ColorUseRGBA){//20110813
					EndColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				}else{
					EndColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
				}
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			
			data[0]=StartRatioV.length;//NumGradients;
			
			var offset:int=1;
			var i:int=-1;
			for each(var StartColor:uint in StartColorV){
				i++;
				
				data[offset++]=StartRatioV[i];
				if(_toDataOptions&&_toDataOptions.ColorUseRGBA){//20110813
					data[offset++]=StartColor>>16;
					data[offset++]=StartColor>>8;
					data[offset++]=StartColor;
					data[offset++]=StartColor>>24;
				}else{
					data[offset++]=StartColor>>16;
					data[offset++]=StartColor>>8;
					data[offset++]=StartColor;
				}
				
				data[offset++]=EndRatioV[i];
				var EndColor:uint=EndColorV[i];
				if(_toDataOptions&&_toDataOptions.ColorUseRGBA){//20110813
					data[offset++]=EndColor>>16;
					data[offset++]=EndColor>>8;
					data[offset++]=EndColor;
					data[offset++]=EndColor>>24;
				}else{
					data[offset++]=EndColor>>16;
					data[offset++]=EndColor>>8;
					data[offset++]=EndColor;
				}
			}
			return data;
		}
		
		////
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.MORPHGRADIENT"/>;
				if(StartColorV.length){
					var RatioAndColorListXML:XML=<RatioAndColorList count={StartColorV.length}/>
					var i:int=-1;
					for each(var StartColor:uint in StartColorV){
						i++;
						RatioAndColorListXML.appendChild(<StartRatio value={StartRatioV[i]}/>);
						if(_toXMLOptions&&_toXMLOptions.ColorUseRGBA){//20110813
							RatioAndColorListXML.appendChild(<StartColor value={"0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff]}/>);
						}else{
							RatioAndColorListXML.appendChild(<StartColor value={"0x"+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff]}/>);
						}
						RatioAndColorListXML.appendChild(<EndRatio value={EndRatioV[i]}/>);
						var EndColor:uint=EndColorV[i];
						if(_toXMLOptions&&_toXMLOptions.ColorUseRGBA){//20110813
							RatioAndColorListXML.appendChild(<EndColor value={"0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff]}/>);
						}else{
							RatioAndColorListXML.appendChild(<EndColor value={"0x"+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff]}/>);
						}
					}
					xml.appendChild(RatioAndColorListXML);
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
				StartRatioV=new Vector.<int>();
				StartColorV=new Vector.<uint>();
				EndRatioV=new Vector.<int>();
				EndColorV=new Vector.<uint>();
				var i:int=-1;
				var StartRatioXMLList:XMLList=xml.RatioAndColorList.StartRatio;
				var EndRatioXMLList:XMLList=xml.RatioAndColorList.EndRatio;
				var EndColorXMLList:XMLList=xml.RatioAndColorList.EndColor;
				for each(var StartColorXML:XML in xml.RatioAndColorList.StartColor){
					i++;
					StartRatioV[i]=int(StartRatioXMLList[i].@value.toString());
					StartColorV[i]=uint(StartColorXML.@value.toString());
					EndRatioV[i]=int(EndRatioXMLList[i].@value.toString());
					EndColorV[i]=uint(EndColorXMLList[i].@value.toString());
				}
			}
		}//end of CONFIG::USE_XML
	}
}