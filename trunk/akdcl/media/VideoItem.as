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
			//Math.min((totalTime * loadProgress - position) / netStream.bufferTime, 1);
			
			return netStream.bufferLength / netStream.bufferTime;
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
			if (netStream > 0) {
				return netStream.time * 1000;
			} else {
				return 0;
			}
		}

		public function set position(_position:uint):void {
			if (netStream) {
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
			
		}
		
		public function load(_source:String):void {
			netStream = sM.getSource(SourceManager.NETSTREAM_GROUP, _source);
			if (!sound) {
				sound = new Sound();
				sM.addSource(SourceManager.SOUND_GROUP, _source, sound);
			}
			sound.load(new URLRequest(_source), new SoundLoaderContext(1000, true));
		}

		public function play(_startTime:Number = -1, _loops:uint = 0, _tempVolume:Number = 1, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundChannel {
			if (!sound) {
				return;
			}
			if (_startTime < 0){
				_startTime = 0;
			} else if (_startTime <= 1){
				//0~1（playProgress）
				if (_startTime >= loadProgress){
					_startTime = loadProgress * 0.999;
				}
				_startTime = totalTime * _startTime;
			} else {
				//1~XX（playTime毫秒为单位）
				var _loadTime:uint = totalTime * loadProgress;
				if (_startTime >= _loadTime){
					_startTime = _loadTime * 0.999;
				}
			}

			try {
				soundTransform.volume = volume * _tempVolume;
				var _channel:SoundChannel = sound.play(_startTime, _loops, soundTransform);
				_channel.addEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
				channelList.push(_channel);
				channelNow = _channel;
				//volume淡入
				if (_tweenIn == 0){

				} else if (_tweenIn <= 1){
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, totalTime * _tweenIn * 0.001, 0, 1, _tempVolume);
				} else {
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, _tweenIn * 0.001, 0, 1, _tempVolume);
				}
				//volume淡出
				if (_tweenOut == 0){

				} else if (_tweenOut <= 1){
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, totalTime * _tweenOut * 0.001, totalTime * (1 - _tweenOut) * 0.001, 0, _tempVolume);
				} else {
					(eM.getElement(ELEMENT_ID) as TweenObject).tweenChannel(this, channelNow, _tweenOut * 0.001, (totalTime - _tweenOut) * 0.001, 0, _tempVolume);
				}
			} catch (_error:*){
				
			}
			return _channel;
		}

		public function stop():void {
			removeAllChannel();
		}
		
		public function remove():void {
			stop();
			sound = null;
			soundTransform = null;
			channelNow = null;
			channelList = null;
		}
	}

}