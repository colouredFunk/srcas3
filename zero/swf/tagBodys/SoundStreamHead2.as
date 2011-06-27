/***
SoundStreamHead2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//SoundStreamHead2
//The SoundStreamHead2 tag is identical to the SoundStreamHead tag, except it allows
//different values for StreamSoundCompression and StreamSoundSize (SWF 3 file format).

//SoundStreamHead2
//Field 					Type 									Comment
//Header 					RECORDHEADER 							Tag type = 45
//Reserved 					UB[4] 									Always zero.
//PlaybackSoundRate 		UB[2] 									Playback sampling rate.
//																	0 = 5.5 kHz
//																	1 = 11 kHz
//																	2 = 22 kHz
//																	3 = 44 kHz
//PlaybackSoundSize 		UB[1] 									Playback sample size.
//																	0 = 8-bit
//																	1 = 16-bit
//PlaybackSoundType 		UB[1] 									Number of playback channels.
//																	0 = sndMono
//																	1 = sndStereo
//StreamSoundCompression 	UB[4] 									Format of SoundData. See "Audio coding formats" on page 201.
//StreamSoundRate 			UB[2] 									The sampling rate of the streaming sound data.
//																	5.5 kHz is not allowed for MP3.
//																	0 = 5.5 kHz
//																	1 = 11 kHz
//																	2 = 22 kHz
//																	3 = 44 kHz
//StreamSoundSize 			UB[1] 									Size of each sample. Always 16 bit for compressed formats. May be 8 or 16 bit for uncompressed formats.
//																	0 = 8-bit
//																	1 = 16-bit
//StreamSoundType 			UB[1] 									Number of channels in the streaming sound data.
//																	0 = sndMono
//																	1 = sndStereo
//StreamSoundSampleCount 	UI16 									Average number of samples in each SoundStreamBlock. Not affected by mono/stereo setting; for stereo sounds this is the number of sample pairs.
//LatencySeek 				If StreamSoundCompression = 2, SI16		See "MP3 sound data" on page 216. The value here should match the SeekSamples field in the first SoundStreamBlock for this stream.
//							Otherwise absent

//The PlaybackSoundRate, PlaybackSoundSize, and PlaybackSoundType fields are advisory
//only; Flash Player may ignore them.
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class SoundStreamHead2{//implements I_zero_swf_CheckCodesRight{
		public var PlaybackSoundRate:int;
		public var PlaybackSoundSize:int;
		public var PlaybackSoundType:int;
		public var StreamSoundCompression:int;
		public var StreamSoundRate:int;
		public var StreamSoundSize:int;
		public var StreamSoundType:int;
		public var StreamSoundSampleCount:int;			//UI16
		public var LatencySeek:int;						//SI16
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var flags:int=data[offset];
			//Reserved=(flags<<24)>>>28;				//11110000
			PlaybackSoundRate=(flags<<28)>>>30;			//00001100
			PlaybackSoundSize=(flags<<30)>>>31;			//00000010
			PlaybackSoundType=flags&0x01;				//00000001
			flags=data[offset+1];
			StreamSoundCompression=(flags<<24)>>>28;	//11110000
			StreamSoundRate=(flags<<28)>>>30;			//00001100
			StreamSoundSize=(flags<<30)>>>31;			//00000010
			StreamSoundType=flags&0x01;					//00000001
			StreamSoundSampleCount=data[offset+2]|(data[offset+3]<<8);
			offset+=4;
			if(StreamSoundCompression==2){
				LatencySeek=data[offset++]|(data[offset++]<<8);
				if(LatencySeek&0x00008000){LatencySeek|=0xffff0000}//最高位为1,表示负数
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			//flags|=Reserved<<4;						//11110000
			flags|=PlaybackSoundRate<<2;				//00001100
			flags|=PlaybackSoundSize<<1;				//00000010
			flags|=PlaybackSoundType;					//00000001
			data[0]=flags;
			
			flags=0;
			flags|=StreamSoundCompression<<4;			//11110000
			flags|=StreamSoundRate<<2;					//00001100
			flags|=StreamSoundSize<<1;					//00000010
			flags|=StreamSoundType;						//00000001
			data[1]=flags;
			
			data[2]=StreamSoundSampleCount;
			data[3]=StreamSoundSampleCount>>8;
			if(StreamSoundCompression==2){
				data[4]=LatencySeek;
				data[5]=LatencySeek>>8;
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="SoundStreamHead2"
				PlaybackSoundRate={PlaybackSoundRate}
				PlaybackSoundSize={PlaybackSoundSize}
				PlaybackSoundType={PlaybackSoundType}
				StreamSoundCompression={StreamSoundCompression}
				StreamSoundRate={StreamSoundRate}
				StreamSoundSize={StreamSoundSize}
				StreamSoundType={StreamSoundType}
				StreamSoundSampleCount={StreamSoundSampleCount}
				LatencySeek={LatencySeek}
			/>;
			if(StreamSoundCompression==2){
				
			}else{
				delete xml.@LatencySeek;
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			PlaybackSoundRate=int(xml.@PlaybackSoundRate.toString());
			PlaybackSoundSize=int(xml.@PlaybackSoundSize.toString());
			PlaybackSoundType=int(xml.@PlaybackSoundType.toString());
			StreamSoundCompression=int(xml.@StreamSoundCompression.toString());
			StreamSoundRate=int(xml.@StreamSoundRate.toString());
			StreamSoundSize=int(xml.@StreamSoundSize.toString());
			StreamSoundType=int(xml.@StreamSoundType.toString());
			StreamSoundSampleCount=int(xml.@StreamSoundSampleCount.toString());
			if(StreamSoundCompression==2){
				LatencySeek=int(xml.@LatencySeek.toString());
			}
		}
		}//end of CONFIG::USE_XML
	}
}
