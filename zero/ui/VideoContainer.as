/***
VideoContainer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年2月15日 14:10:26
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class VideoContainer extends Sprite{
		
		private var videoURL:String;
		private var bufferTime:Number;
		private var connection:NetConnection;
		public var stream:NetStream;
		
		public var onPlayComplete:Function;
		public var onFirstFull:Function;
		
		public var btnSkip:Btn;
		
		public var bg:Sprite;
		public var container:Sprite;
		
		public function VideoContainer() {
		}
		public function init(_videoURL:String,_bufferTime:Number):void{
			videoURL=_videoURL;
			bufferTime=_bufferTime;
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connection.connect(null);
			
			btnSkip.release=skip;
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			//trace("event.info.code="+event.info.code);
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
				break;
				case "NetStream.Buffer.Full":
					if(onFirstFull==null){
					}else{
						onFirstFull();
						onFirstFull=null;
					}
				break;
				case "NetStream.Play.StreamNotFound":
					trace("Unable to locate video: " + videoURL);
				break;
				case "NetStream.Play.Stop":
					//stream.client=null;
					if(onPlayComplete==null){
					}else{
						onPlayComplete();
						onPlayComplete=null;
					}
				break;
			}
		}
		
		private function skip():void{
			stream.pause();
			//stream.client=null;
			try{
				stream.close();
			}catch(e:Error){}
			if(onPlayComplete==null){
			}else{
				onPlayComplete();
				onPlayComplete=null;
			}
		}
		
		private function connectStream():void {
			stream = new NetStream(connection);
			stream.client={onMetaData:function(...args):void{}};//用于解决：ReferenceError: Error #1069: 在 flash.net.NetStream 上找不到属性 onMetaData，且没有默认值。
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			var video:Video = new Video();
			video.attachNetStream(stream);
			video.width=bg.width;
			video.height=bg.height;
			stream.bufferTime=bufferTime;
			//trace("stream.bufferTime="+stream.bufferTime);
			stream.play(videoURL);
			container.addChild(video);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}
	}
}