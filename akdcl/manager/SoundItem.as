package {

	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.Event;

	/**
	 * ...
	 * @author ...
	 */

	class SoundItem {
		private var sound:Sound;
		private var soundTransform:SoundTransform;
		private var channelList:Array;
		private var positionLast:uint;

		public function get totalTime():uint {
			var _totalTime:uint;
			if (sound){
				_totalTime = sound.length / loadProgress;
			} else {
				_totalTime = 0;
			}
			return _totalTime;
		}

		public function get loadProgress():Number {
			var _loadProgress:Number;
			if (sound){
				_loadProgress = sound.bytesLoaded / sound.bytesTotal;
			} else {
				_loadProgress = 0;
			}
			return _loadProgress;
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
			if (channelList && channelList.length > 0){
				var _channel:SoundChannel = channelList[channelList.length - 1];
				return _channel.position;
			} else {
				return positionLast;
			}
		}

		public function set position(_position:uint):void {
			if (channelList && channelList.length > 0){
				var _channel:SoundChannel = channelList[channelList.length - 1];
				removeChannel(_channel);
				play(_position);
			} else {
				positionLast = _position;
			}
		}
		private var __volume:Number = 0.8;

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
			soundTransform.volume = __volume;

			for each (var _channel:SoundChannel in channelList){
				_channel.soundTransform = soundTransform;
			}
		}

		public function SoundItem(){
			channelList = [];
			soundTransform = new SoundTransform(0.8, 0);
		}

		public function play(startTime:Number = -1, _loops:int = 0):void {
			if (startTime < 0){
				return;
			}
			if (startTime > totalTime * loadProgress){
				startTime = totalTime * loadProgress * 0.99;
			}
			if (positionLast > 0){
				startTime = positionLast;
			}
			positionLast = 0;
			if (startTime < 0){
				startTime = 0;
			}
			try {
				var _channel:SoundChannel = sound.play(startTime, loops, soundTransform);
			} catch (_error:*){
				//dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				trace("soundItem play error!");
				return;
			}
			addChannel(_channel);
		}

		public function pause():void {
			positionLast = position;
			removeAllChannel();
		}

		public function stop():void {
			positionLast = 0;
			removeAllChannel();
		}

		private function addChannel(_channel:SoundChannel):void {
			channelList.push(_channel);
			_channel.addEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
		}

		private function removeChannel(_channel:SoundChannel):void {
			removeFromObject(channelList, _channel);
			_channel.stop();
			_channel.removeEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
		}

		private function removeAllChannel():void {
			for each (var _channel:SoundChannel in channelList){
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
			}
			channelList = [];
		}

		private function onChannelCompleteHandler(_evt:Event):void {
			var _channel:SoundChannel = _evt.currentTarget as SoundChannel;
			removeChannel(_channel);
		}
	}

}