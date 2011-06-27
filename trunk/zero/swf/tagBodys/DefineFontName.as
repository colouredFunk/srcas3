/***
DefineFontName
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The DefineFontName tag contains the name and copyright information for a font embedded in the SWF file.
//
//The minimum file format version is SWF 9.
//
//DefineFontName
//Field 				Type 				Comment
//Header 				RECORDHEADER 		Tag type = 88
//FontID 				UI16 				ID for this font to which this refers
//FontName 				STRING 				Name of the font. 
//											For fonts starting as Type 1, this is the PostScript FullName.
//											For fonts starting in sfnt formats such as TrueType and OpenType, this is name ID 4, platform ID 1, language ID 0 (Full name, Mac OS, English).
//FontCopyright			STRING 				Arbitrary string of copyright information
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class DefineFontName{//implements I_zero_swf_CheckCodesRight{
		public var FontID:int;							//UI16
		public var FontName:String;						//STRING
		public var FontCopyright:String;				//STRING
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			FontID=data[offset]|(data[offset+1]<<8);
			offset+=2;
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			FontName=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			
			get_str_size=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			FontCopyright=data.readUTFBytes(get_str_size);
			return offset+get_str_size;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=FontID;
			data[1]=FontID>>8;
			data.position=2;
			data.writeUTFBytes(FontName+"\x00");
			data.writeUTFBytes(FontCopyright+"\x00");
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			return <{xmlName} class="DefineFontName"
				FontID={FontID}
				FontName={FontName}
				FontCopyright={FontCopyright}
			/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			FontID=int(xml.@FontID.toString());
			FontName=xml.@FontName.toString();
			FontCopyright=xml.@FontCopyright.toString();
		}
		}//end of CONFIG::USE_XML
	}
}