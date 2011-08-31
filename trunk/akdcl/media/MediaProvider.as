package akdcl.media {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class MediaProvider extends UIEventDispatcher {

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
			switch (_playState){
				case PlayState.CONNECT:
				case PlayState.WAIT:
				case PlayState.BUFFER:
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

		override protected function init():void {
			super.init();
			timer = new Timer(100);
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
			setPlayState(PlayState.PLAY);
		}

		public function pause():void {
			setPlayState(PlayState.PAUSE);
		}

		public function stop():void {
			setPlayState(PlayState.STOP);
		}
		//
		protected function onLoadErrorHandler(_evt:*= null):void {
			stop();
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_ERROR));
		}
		protected function onLoadProgressHandler(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_PROGRESS));
		}
		protected function onLoadCompleteHandler(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_COMPLETE));
		}
		protected function onPlayProgressHander(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_PROGRESS));
		}
		protected function onBufferProgressHandler(_evt:*= null):void {
			setPlayState(PlayState.BUFFER);
			dispatchEvent(new MediaEvent(MediaEvent.BUFFER_PROGRESS));
		}
		protected function onPlayCompleteHandler(_evt:*= null):void {
			timer.stop();
			setPlayState(PlayState.COMPLETE);
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_COMPLETE));
		}
	}

}