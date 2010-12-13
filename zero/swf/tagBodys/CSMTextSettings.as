/***
CSMTextSettings 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 17:41:45 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class CSMTextSettings{
		public var TextID:int;							//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			TextID=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=TextID;
			data[1]=TextID>>8;
			data.position=2;
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="CSMTextSettings"
				TextID={TextID}
			/>;
			xml.appendChild(restDatas.toXML("restDatas"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			TextID=int(xml.@TextID.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
