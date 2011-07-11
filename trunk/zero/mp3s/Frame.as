/***
Frame 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月7日 13:42:30
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

/*
每个帧都有一个帧头Header，长度是4Byte（32bit）,帧头后面可能有两个字节的CRC 校验值，
这两个字节的是否存在决定于Header 信息的第16bit，为0 则帧头后面无校验，为1 则有校验，(好像搞错了?)
校验值长度为2 个字节，紧跟在Header 后面，接着就是帧的实体数据了，格式如下： 
HEADER 		4 BYTE 
CRC（free）	0 OR 2 BYTE 
MAIN_DATA 	长度由帧头计算得出

1）每帧的播放时间：无论帧长是多少，每帧的播放时间都是26ms； 
2）数据帧大小: 
Size = (((MpegVersion == MPEG1 ? 144 : 72) * Bitrate) / SamplingRate) + PaddingBit 
例如: Bitrate ＝ 128000, a SamplingRate ＝44100, and PaddingBit ＝ 1 
Size = (144 * 128000) / 44100 + 1 = 417 bytes

*/

package zero.mp3s{
	import flash.utils.*;
	public class Frame{
		private var headOffset:int;
		public var HEADER:FrameHeader;
		public var CRC:int;
		//public var MAIN_DATA:ByteArray;
		public function Frame(){
		}
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			headOffset=offset;
			HEADER=new FrameHeader();
			offset=HEADER.initByData(data,offset,endOffset);
			if(HEADER.protection==0){
				CRC=(data[offset++]>>8)|data[offset++];
			}else{
				CRC=-1;
			}
			if(HEADER.bitrate>0){
				if(HEADER.frequency>0){
					var Size:int=(HEADER.version==1?144:72)*HEADER.bitrate*1000/HEADER.frequency+HEADER.padding;
					trace("Size="+Size);
					offset=headOffset+Size;
				}else{
					throw new Error("奇怪的 SamplingRate:"+HEADER.frequency);
				}
			}else{
				throw new Error("奇怪的 BitRate:"+HEADER.bitrate);
			}
			return offset;
		}
		public function toData():ByteArray{
			return null;
		}
	}
}

