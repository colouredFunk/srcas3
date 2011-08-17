/***
DefineSound
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineSound
//The DefineSound tag defines an event sound. It includes the audio coding format, sampling
//rate, size of each sample (8 or 16 bit), a stereo/mono flag, and an array of audio samples. Note
//that not all of these parameters will be honored depending on the audio coding format.
//The minimum file format version is SWF 1.
//Define Sound
//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 14
//SoundId 			UI16 						ID for this sound.
//SoundFormat 		UB[4] 						Format of SoundData. See "Audio coding formats" on page 201.
//SoundRate 		UB[2] 						The sampling rate. This is ignored for Nellymoser and Speex codecs.
//												5.5kHz is not allowed for MP3.
//												0 = 5.5 kHz
//												1 = 11 kHz
//												2 = 22 kHz
//												3 = 44 kHz
//SoundSize 		UB[1] 						Size of each sample. This parameter only pertains to uncompressed formats. This is ignored for compressed formats which always decode to 16 bits internally.
//												0 = snd8Bit
//												1 = snd16Bit
//SoundType 		UB[1] 						Mono or stereo sound This is ignored for Nellymoser and Speex.
//												0 = sndMono
//												1 = sndStereo
//SoundSampleCount 	UI32 						Number of samples. Not affected by mono/stereo setting; for stereo sounds this is the number of sample pairs.
//SoundData 		UI8[size of sound data] 	The sound data; varies by format.

//The SoundId field uniquely identifies the sound so it can be played by StartSound.
//Format 0 (uncompressed) and Format 3 (uncompressed little-endian) are similar. Both
//encode uncompressed audio samples. For 8-bit samples, the two formats are identical. For 16-
//bit samples, the two formats differ in byte ordering. Using format 0, 16-bit samples are
//encoded and decoded according to the native byte ordering of the platform on which the
//encoder and Flash Player, respectively, are running. Using format 3, 16-bit samples are always
//encoded in little-endian order (least significant byte first), and are byte-swapped if necessary
//in Flash Player before playback. Format 0 is clearly disadvantageous because it introduces a
//playback platform dependency. For 16-bit samples, format 3 is highly preferable to format 0
//for SWF 4 or later.
//The contents of SoundData vary depending on the value of the SoundFormat field in the
//SoundStreamHead tag:
//■ If SoundFormat is 0 or 3, SoundData contains raw, uncompressed samples.
//■ If SoundFormat is 1, SoundData contains an ADPCM sound data record.
//■ If SoundFormat is 2, SoundData contains an MP3 sound data record.
//■ If SoundFormat is 4, 5, or 6, SoundData contains Nellymoser data (see "Nellymoser
//compression" on page 219).
//■ If SoundFormat is 11, SoundData contains Speex data (see "Speex compression"
//on page 220).
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineSound{//implements I_zero_swf_CheckCodesRight{
		public var SoundId:int;							//UI16
		public var SoundFormat:int;
		public var SoundRate:int;
		public var SoundSize:int;
		public var SoundType:int;
		public var SoundSampleCount:uint;				//UI32
		public var SoundData:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			SoundId=data[offset]|(data[offset+1]<<8);
			var flags:int=data[offset+2];
			SoundFormat=(flags<<24)>>>28;				//11110000
			SoundRate=(flags<<28)>>>30;					//00001100
			SoundSize=(flags<<30)>>>31;					//00000010
			SoundType=flags&0x01;						//00000001
			SoundSampleCount=data[offset+3]|(data[offset+4]<<8)|(data[offset+5]<<16)|(data[offset+6]<<24);
			offset+=7;
			SoundData=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.BytesData"]||BytesData)();
			return SoundData.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=SoundId;
			data[1]=SoundId>>8;
			var flags:int=0;
			flags|=SoundFormat<<4;						//11110000
			flags|=SoundRate<<2;						//00001100
			flags|=SoundSize<<1;						//00000010
			flags|=SoundType;							//00000001
			data[2]=flags;
			
			data[3]=SoundSampleCount;
			data[4]=SoundSampleCount>>8;
			data[5]=SoundSampleCount>>16;
			data[6]=SoundSampleCount>>24;
			data.position=7;
			data.writeBytes(SoundData.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineSound"
				SoundId={SoundId}
				SoundFormat={SoundFormat}
				SoundRate={SoundRate}
				SoundSize={SoundSize}
				SoundType={SoundType}
				SoundSampleCount={SoundSampleCount}
			/>;
			xml.appendChild(SoundData.toXML("SoundData",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			SoundId=int(xml.@SoundId.toString());
			SoundFormat=int(xml.@SoundFormat.toString());
			SoundRate=int(xml.@SoundRate.toString());
			SoundSize=int(xml.@SoundSize.toString());
			SoundType=int(xml.@SoundType.toString());
			SoundSampleCount=uint(xml.@SoundSampleCount.toString());
			SoundData=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[xml.SoundData[0]["@class"].toString()]||BytesData)();
			SoundData.initByXML(xml.SoundData[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
