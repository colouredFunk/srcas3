/***
VideoFrame 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 18:19:20 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//VideoFrame
//VideoFrame provides a single frame of video data for a video character that is already defined
//with DefineVideoStream.
//In playback, the time sequencing of video frames depends on the SWF frame rate only. When
//SWF playback reaches a particular SWF frame, the video images from any VideoFrame tags in
//that SWF frame are rendered. Any timing mechanisms built into the video payload are
//ignored.
//A VideoFrame tag is not needed for every video character in every frame number specified. A
//VideoFrame tag merely sets video data associated with a particular frame number; it does not
//automatically display a video frame. To display a video frame, specify the frame number as the
//Ratio field in PlaceObject2 or PlaceObject3.
//
//VideoFrame
//Field 				Type 									Comment
//Header 				RECORDHEADER 							Tag type = 61
//StreamID 				UI16 									ID of video stream character of which this frame is a part
//FrameNum 				UI16 									Sequence number of this frame within its video stream
//VideoData 			if CodecID = 2 H263VIDEOPACKET			Video frame payload
//						if CodecID = 3 SCREENVIDEOPACKET
//						if CodecID = 4 VP6SWFVIDEOPACKET
//						if CodecID = 5 VP6SWFALPHAVIDEOPACKET
//						if CodecID = 6 SCREENV2VIDEOPACKET
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class VideoFrame{
		public var StreamID:int;						//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			StreamID=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=StreamID;
			data[1]=StreamID>>8;
			data.position=2;
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="VideoFrame"
				StreamID={StreamID}
			/>;
			xml.appendChild(restDatas.toXML("restDatas"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			StreamID=int(xml.@StreamID.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
