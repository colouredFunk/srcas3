/***
CSMTextSettings
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 21:16:23（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//In addition to the advanced text rendering tags discussed earlier in this chapter, the rendering
//engine also supports a tag for modifying text fields. The CSMTextSettings tag modifies a
//previously streamed DefineText, DefineText2, or DefineEditText tag. The CSMTextSettings
//tag turns advanced anti-aliasing on or off for a text field, and can also be used to define quality
//and options.
//
//The minimum file format version is SWF 8.
//
//Header 				RECORDHEADER 				Tag type = 74.
//TextID 				UI16 						ID for the DefineText, DefineText2, or DefineEditText to which this tag applies.
//UseFlashType 			UB[2] 						0 = use normal renderer.
//													1 = use advanced text rendering engine.
//GridFit 				UB[3] 						0 = Do not use grid fitting.
//													AlignmentZones and LCD sub-pixel information will not be used.
//													1 = Pixel grid fit. Only supported for left-aligned dynamic text. This setting provides the ultimate in advanced anti-aliased text readability, with crisp letters aligned to pixels.
//													2 = Sub-pixel grid fit. Align letters to the 1/3 pixel used by LCD monitors. Can also improve quality for CRT output.
//Reserved 				UB[3] 						Must be 0.
//Thickness 			F32 						The thickness attribute for the associated text field. Set to 0.0 to use the default (anti-aliasing table) value.
//Sharpness 			F32 						The sharpness attribute for the associated text field. Set to 0.0 to use the default (anti-aliasing table) value.
//Reserved 				UI8 						Must be 0.
//
//The Thickness and Sharpness fields are interpretations of the CSM parameters, applied to a
//particular text field. The thickness and sharpness setting will override the default CSM setting
//for that text field.
//The CSM parameters, at render time, are computed from the thickness and sharpness:
//outsideCutoff = (0.5f * sharpness - thickness) * fontSize;
//insideCutoff = (-0.5f * sharpness - thickness) * fontSize;
//Using the font size in the cutoff calculations results in linear scaling of CSM parameters, and
//linear scaling tends to be a poor approximation when significant scaling is applied. When a
//text field will scale, it is usually better to use the default table or provide your own antialiasing
//table.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	public class CSMTextSettings{
		
		public var TextID:int;//UI16
		public var UseFlashType:int;//11000000
		public var GridFit:int;//00111000
		//public var Reserved:int;//00000111
		public var Thickness:Number;//F32
		public var Sharpness:Number;//F32
		//public var Reserved:int;//UI8
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var flags:int;
			
			TextID=data[offset++]|(data[offset++]<<8);
			
			flags=data[offset++];
			UseFlashType=(flags&0xc0)>>>6;//11000000
			GridFit=(flags&0x38)>>>3;//00111000
			//Reserved=flags&0x07;//00000111
			
			data.position=offset;
			Thickness=data.readFloat();
			offset+=4;
			
			data.position=offset;
			Sharpness=data.readFloat();
			offset+=4;
			
			//Reserved=data[offset++];
			return offset+1;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var flags:int;
			
			var data:ByteArray=new ByteArray();
			
			data[0]=TextID;
			data[1]=TextID>>8;
			
			flags=0;
			flags|=UseFlashType<<6;//11000000
			flags|=GridFit<<3;//00111000
			//flags|=Reserved;//00000111
			data[2]=flags;
			
			data.position=data.length;
			data.writeFloat(Thickness);
			
			data.position=data.length;
			data.writeFloat(Sharpness);
			
			data[3]=0x00;
			
			return data;
			
		}
		
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.CSMTextSettings"
					TextID={TextID}
					UseFlashType={UseFlashType}
					GridFit={GridFit}
					Thickness={Thickness}
					Sharpness={Sharpness}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				TextID=int(xml.@TextID.toString());
				
				UseFlashType=int(xml.@UseFlashType.toString());
				GridFit=int(xml.@GridFit.toString());
				
				Thickness=Number(xml.@Thickness.toString());
				
				Sharpness=Number(xml.@Sharpness.toString());
				
			}
		}
	}
}