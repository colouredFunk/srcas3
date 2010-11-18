package akdcl.application{
	import flash.events.Event;
	
	import akdcl.events.MediaEvent;
	import akdcl.application.MediaPlayer;
	
	import ui.UISprite;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MediaPlayerSkin extends UISprite {
		protected static function complexTime(_position:uint, _totalTime:uint):String {
			var _timePlayed:String;
			var _timeTotal:String;
			_timePlayed = formatTime(_position * 0.001);
			_timeTotal = formatTime(_totalTime * 0.001);
			return _timePlayed + " / " + _timeTotal;
		}
		//格式化时间
		protected static function formatTime(_n:uint):String {
			var minutes:uint;
			var seconds:uint;
			if (_n<60) {
				minutes = 0;
				seconds = _n;
			} else if (_n<3600) {
				minutes = Math.floor(_n/60);
				seconds = _n%60;
			}
			var s_m:String = minutes<10 ? "0"+String(minutes) : String(minutes);
			var s_s:String = seconds<10 ? "0"+String(seconds) : String(seconds);
			return s_m+":"+s_s;
		}
		public var btnPlay:*;
		public var btnPause:*;
		public var btnStop:*;
		public var btnPlayPause:*;
		public var btnPlayStop:*;
		public var btnNext:*;
		public var btnPrev:*;
		public var btnVolume:*;
		public var barVolume:*;
		public var barPlayProgress:*;
		public var barLoadProgress:*;
		
		protected var player:MediaPlayer;
		override protected function init():void {
			super.init();
			enabled = false;
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
		}
		public function setPlayer(_player:MediaPlayer):void {
			player = _player;
			if (btnPlay) {
				btnPlay.release = player.play;
			}
			if (btnPause) {
				btnPause.release = player.pause;
			}
			if (btnStop) {
				btnStop.release = player.stop;
			}
			if (btnPlayPause) {
				btnPlayPause.release = player.playOrPause;
			}
			if (btnPlayStop) {
				btnPlayStop.release = player.playOrStop;
			}
			if (btnNext) {
				btnNext.release = player.next;
			}
			if (btnPrev) {
				btnPrev.release = player.prev;
			}
			if (btnVolume) {
				btnVolume.release = function():void {
					player.mute = !player.mute;
				}
			}
			if (barVolume) {
				barVolume.maximum = 1;
				barVolume.snapInterval = MediaPlayer.VALUE_PERCENTAGE;
				barVolume.value = player.volume;
				barVolume.change = function(_value:Number):void {
					player.volume = _value;
				}
			}
			if (barPlayProgress) {
				if (barPlayProgress.barLoadProgress) {
					barLoadProgress = barPlayProgress.barLoadProgress;
				}
				barPlayProgress.maximum = 1;
				barPlayProgress.snapInterval = MediaPlayer.VALUE_PERCENTAGE;
				barPlayProgress.labelFunction = timeLabelFunction;
				barPlayProgress.setStyle();
				//barPlayProgress.press = 
				barPlayProgress.change = function(_value:Number):void {
					if (barPlayProgress.isHold) {
						
					}
				}
				barPlayProgress.release = function():void {
					player.playProgress = barPlayProgress.value * 0.99;
				}
			}
			if (barLoadProgress) {
				if (barLoadProgress.hasOwnProperty("maximum")) {
					barLoadProgress.maximum = 1;
					barLoadProgress.snapInterval = MediaPlayer.VALUE_PERCENTAGE;
					barLoadProgress.enabled = false;
					barLoadProgress.value = 0;
				}
			}
			player.addEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
			player.addEventListener(MediaEvent.PLAY_ID_CHANGE, onIDChangeHandler);
			player.addEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
			player.addEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
			player.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
			enabled = true;
		}
		protected function timeLabelFunction(_value:Number):String {
			var _totalTime:uint = player.totalTime;
			var _str:String = complexTime(_totalTime * _value, _totalTime);
			return _str;
		}
		protected function onStateChangeHandler(_evt:MediaEvent):void {
			if (btnPlay) {
				btnPlay.select = player.playState == MediaPlayer.STATE_PLAY;
			}
			if (btnPlayPause) {
				btnPlayPause.select = player.playState == MediaPlayer.STATE_PLAY;
			}
			if (btnPlayStop) {
				btnPlayStop.select = player.playState == MediaPlayer.STATE_PLAY;
			}
			if (btnPause) {
				btnPause.select = player.playState == MediaPlayer.STATE_PAUSE;
			}
			if (btnStop) {
				btnStop.select = player.playState == MediaPlayer.STATE_STOP;
			}
			switch(player.playState) {
				case MediaPlayer.STATE_PLAY:
				break;
				case MediaPlayer.STATE_PAUSE:
				break;
				case MediaPlayer.STATE_STOP:
				break;
			}
		}
		protected function onIDChangeHandler(_evt:MediaEvent):void {
			if (btnNext) {
				btnNext.visible = player.playList.length() > 1;
			}
			if (btnPrev) {
				btnPrev.visible = player.playList.length() > 1;
			}
		}
		protected function onVolumeChangeHandler(_evt:MediaEvent):void {
			if (btnVolume) {
				btnVolume.select = player.mute;
			}
			if (barVolume) {
				barVolume.value = player.volume;
			}
		}
		protected function onPlayProgressHandler(_evt:MediaEvent):void {
			if (barPlayProgress && !barPlayProgress.isHold) {
				barPlayProgress.value = player.playProgress;
			}
		}
		protected function onLoadProgressHandler(_evt:MediaEvent):void {
			if (barLoadProgress) {
				barLoadProgress.value = player.loadProgress;
			}
		}
	}
	
}