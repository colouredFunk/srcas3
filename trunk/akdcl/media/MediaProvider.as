package akdcl.media {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author Akdcl
	 */
	/// @eventType	akdcl.media.MediaEvent.VOLUME_CHANGE
	[Event(name = "volumeChange", type = "akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.STATE_CHANGE
	[Event(name="stateChange",type="akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.PLAY_PROGRESS
	[Event(name="playProgress",type="akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.PLAY_COMPLETE
	[Event(name="playComplete",type="akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.LOAD_ERROR
	[Event(name="loadError",type="akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.LOAD_PROGRESS
	[Event(name="loadProgress",type="akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.BUFFER_PROGRESS
	[Event(name="bufferProgress",type="akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.LOAD_COMPLETE
	[Event(name="loadComplete",type="akdcl.media.MediaEvent")]

	public class MediaProvider extends UIEventDispatcher {
		public static const VOLUME_DEFAULT:Number = 0.8;
		public static var TIMER_INTERVAL:uint = 100;

		protected var playContent:*;
		protected var timer:Timer;

		public function get loadProgress():Number {
			return 0;
		}

		public function get totalTime():uint {
			return 0;
		}

		public function get bufferProgress():Number {
			return 1;
		}

		public function get position():uint {
			return 0;
		}

		public function set position(_position:uint):void {
			play(Math.min(_position, totalTime));
		}

		public function get playProgress():Number {
			return totalTime > 0 ? (position / totalTime) : 0;
		}

		public function set playProgress(_playProgress:Number):void {
			if (_playProgress < 0){
				_playProgress = 0;
			} else if (_playProgress > 1){
				_playProgress = 1;
			}
			position = totalTime * _playProgress;
		}

		private var __playState:String;

		public function get playState():String {
			return __playState;
		}

		protected function setPlayState(_playState:String):Boolean {
			if (__playState == _playState){
				return false;
			}
			onPlayProgressHander(_playState);
			switch (_playState){
				case PlayState.CONNECT:
				case PlayState.WAIT:
				case PlayState.RECONNECT:
				case PlayState.PLAY:
					timer.addEventListener(TimerEvent.TIMER, onPlayProgressHander);
					break;
				case PlayState.READY:
				case PlayState.PAUSE:
				case PlayState.STOP:
				case PlayState.COMPLETE:
					timer.removeEventListener(TimerEvent.TIMER, onPlayProgressHander);
					break;
			}
			__playState = _playState;
			dispatchEvent(new MediaEvent(MediaEvent.STATE_CHANGE));
			return true;
		}

		private var __volume:Number = VOLUME_DEFAULT;
		public function get volume():Number {
			return __volume;
		}

		public function set volume(_volume:Number):void {
			if (_volume < 0){
				_volume = 0;
			} else if (_volume > 1){
				_volume = 1;
			}
			if (__volume == _volume){
				return;
			}
			__volume = _volume;
			dispatchEvent(new MediaEvent(MediaEvent.VOLUME_CHANGE));
		}
		//静音
		private var volumeLast:Number = 0;
		public function get mute():Boolean {
			return volume == 0;
		}
		public function set mute(_mute:Boolean):void {
			if (_mute && (volume == 0)) {
				return;
			}
			if (_mute) {
				volumeLast = volume;
				volume = 0;
			}else{
				if (volumeLast < 0.004) {
					volumeLast = VOLUME_DEFAULT;
				}
				volume = volumeLast;
			}
		}

		override protected function init():void {
			super.init();
			timer = new Timer(TIMER_INTERVAL);
			setPlayState(PlayState.READY);
		}

		override public function remove():void {
			stop();
			timer.stop();
			timer = null;
			playContent = null;
			super.remove();
		}

		public function load(_source:String):void {
			timer.reset();
			timer.start();
		}

		public function play(_startTime:int = -1):void {
			timer.start();
			setPlayState(PlayState.PLAY);
		}

		public function pause():void {
			setPlayState(PlayState.PAUSE);
		}

		public function stop():void {
			setPlayState(PlayState.STOP);
		}

		//
		protected function onLoadErrorHandler(_evt:* = null):void {
			stop();
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_ERROR));
		}

		protected function onLoadProgressHandler(_evt:* = null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_PROGRESS));
		}

		protected function onLoadCompleteHandler(_evt:* = null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_COMPLETE));
		}

		protected function onPlayProgressHander(_evt:* = null):void {
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_PROGRESS));
		}

		protected function onBufferProgressHandler(_evt:* = null):void {
			dispatchEvent(new MediaEvent(MediaEvent.BUFFER_PROGRESS));
		}

		protected function onPlayCompleteHandler(_evt:* = null):void {
			timer.stop();
			setPlayState(PlayState.COMPLETE);
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_COMPLETE));
		}
	}

}