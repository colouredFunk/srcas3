/***
MORPHLINESTYLE
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月23日 15:36:42
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//MORPHLINESTYLE
//The format of a line style value within the file is described in the following table.
//
//MORPHLINESTYLE
//Field 			Type 			Comment
//StartWidth 		UI16 			Width of line in start shape in twips.
//EndWidth 			UI16 			Width of line in end shape in twips.
//StartColor 		RGBA 			Color value including alpha channel information for start shape.
//EndColor 			RGBA 			Color value including alpha channel information for end shape.

package zero.swf.records.shapes{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class MORPHLINESTYLE{
		public var StartWidth:int;//UI16
		public var StartColor:uint;
		public var EndWidth:int;//UI16
		public var EndColor:uint;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			trace("可能不区分 RGB 和 RGBA?");
			StartWidth=data[offset++]|(data[offset++]<<8);
			EndWidth=data[offset++]|(data[offset++]<<8);
			if(_initByDataOptions&&_initByDataOptions.ColorUseRGBA){//20110813
				StartColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				EndColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			}else{
				StartColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
				EndColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			
			data[0]=StartWidth;
			data[1]=StartWidth>>8;
			data[2]=EndWidth;
			data[3]=EndWidth>>8;
			if(_toDataOptions&&_toDataOptions.ColorUseRGBA){//20110813
				data[4]=StartColor>>16;
				data[5]=StartColor>>8;
				data[6]=StartColor;
				data[7]=StartColor>>24;
				data[8]=EndColor>>16;
				data[9]=EndColor>>8;
				data[10]=EndColor;
				data[11]=EndColor>>24;
			}else{
				data[4]=StartColor>>16;
				data[5]=StartColor>>8;
				data[6]=StartColor;
				data[7]=EndColor>>16;
				data[8]=EndColor>>8;
				data[9]=EndColor;
			}
			
			return data;
		}
		
		////
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.MORPHLINESTYLE"
					StartWidth={StartWidth}
					EndWidth={EndWidth}
				/>;
				
				if(_toXMLOptions&&_toXMLOptions.ColorUseRGBA){//20110813
					xml.@StartColor="0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff];
					xml.@EndColor="0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff];
				}else{
					xml.@StartColor="0x"+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff];
					xml.@EndColor="0x"+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff];
				}
				
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
				StartWidth=int(xml.@StartWidth.toString());
				EndWidth=int(xml.@EndWidth.toString());
				StartColor=uint(xml.@StartColor.toString());
				EndColor=uint(xml.@EndColor.toString());
			}
		}//end of CONFIG::USE_XML
	}
}