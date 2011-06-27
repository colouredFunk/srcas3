/***
SoundStreamBlock
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//SoundStreamBlock
//The SoundStreamBlock tag defines sound data that is interleaved with frame data so that
//sounds can be played as the SWF file is streamed over a network connection. The
//SoundStreamBlock tag must be preceded by a SoundStreamHead or SoundStreamHead2 tag.
//There may only be one SoundStreamBlock tag per SWF frame.
//The minimum file format version is SWF 1.

//SoundStreamBlock
//Field 			Type 							Comment
//Header 			RECORDHEADER (long) 			Tag type = 19.
//StreamSoundData 	UI8[size of compressed data] 	Compressed sound data.

//The contents of StreamSoundData vary depending on the value of the
//StreamSoundCompression field in the SoundStreamHead tag:
//■ If StreamSoundCompression is 0 or 3, StreamSoundData contains raw, uncompressed
//samples.
//■ If StreamSoundCompression is 1, StreamSoundData contains an ADPCM sound data
//record.
//■ If StreamSoundCompression is 2, StreamSoundData contains an MP3 sound data record.
//■ If StreamSoundCompression is 6, StreamSoundData contains a NELLYMOSERDATA
//record.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class SoundStreamBlock/*{*/implements I_zero_swf_CheckCodesRight{
		public var StreamSoundData:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			StreamSoundData=new BytesData();
			return StreamSoundData.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(StreamSoundData.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="SoundStreamBlock"/>;
			xml.appendChild(StreamSoundData.toXML("StreamSoundData",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			StreamSoundData=new BytesData();
			StreamSoundData.initByXML(xml.StreamSoundData[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
