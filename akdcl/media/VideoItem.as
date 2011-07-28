package akdcl.media {
	
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.net.NetConnection;
	
	import flash.media.SoundTransform;
	
	import flash.events.Event;

	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;

	import akdcl.manager.SourceManager;

	import akdcl.interfaces.IPlaylistItem;
	import akdcl.interfaces.IVolume;

	/**
	 * ...
	 * @author akdcl
	 */
	public class VideoItem implements IPlaylistItem, IVolume {
		//private static const ELEMENT_ID:String = "TweenObject_SoundItem";
		
		//private static var eM:ElementManager = ElementManager.getInstance();
		private static var sM:SourceManager = SourceManager.getInstance();
		//eM.register(ELEMENT_ID, TweenObject);
		
		private var netConnection:NetConnection;
		private var netStream:NetStream;
		
		private var soundTransform:SoundTransform;
		
		public var metaData:Object;

		public function get loadProgress():Number {
			var _loadProgress:Number;
			if (sound){
				_loadProgress = netStream.bytesLoaded / netStream.bytesTotal;
			} else {
				_loadProgress = 0;
			}
			return _loadProgress;
		}

		public function get bufferProgress():Number {
			return netStream.;
		}
		
		public function get totalTime():uint {
			var _totalTime:uint;
			if (metaData){
				_totalTime = metaData.duration * 1000 / loadProgress;
			} else {
				_totalTime = 0;
			}
			return _totalTime;
		}

		public function get playProgress():Number {
			var _playProgress:Number = position / totalTime;
			if (isNaN(_playProgress)){
				_playProgress = 0;
			}
			return _playProgress;
		}

		public function set playProgress(_playProgress:Number):void {
			position = _playProgress * totalTime;
		}

		public function get position():uint {
			if (channelNow && sound.length > 0){
				return channelNow.position;
			} else {
				return 0;
			}
		}

		public function set position(_position:uint):void {
			if (channelNow && sound.length > 0){
				//channelNow
				play(_position);
			}
		}
		
		private var __volume:Number = 1;
		public function get volume():Number {
			return __volume;
		}

		public function set volume(_volume:Number):void {
			if (_volume < 0){
				_volume = 0;
			} else if (_volume > 1){
				_volume = 1;
			}
			__volume = _volume;
			/*if (channelNow){
				setChannelVolume(channelNow, __volume * maxVolume);
			}*/
		}

		public function VideoItem() {
            soundTransform = new SoundTransform();
			
			
			netConnection = new NetConnection();
			netConnection.connect(null);
			
			netStream = new NetStream(netConnection);
			//netStream.addEventListener(NetStatusEvent.NET_STATUS
			//netStream.addEventListener(IOErrorEvent.IO_ERROR
			//netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR
			netStream.bufferTime = 2000;
			
			//netStream.client
			
			/*if (_video) {
				video = _video;
				video.smoothing = config.smoothing;
			}
			video.attachNetStream(netStream);*/
		}
	}

}