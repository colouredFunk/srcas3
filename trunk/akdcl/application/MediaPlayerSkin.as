package akdcl.application{
	import flash.events.Event;
	
	import ui.UISprite;
	import akdcl.events.MediaEvent;
	import akdcl.application.MediaPlayer;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MediaPlayerSkin extends UISprite {
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
				barLoadProgress.maximum = 1;
				barLoadProgress.snapInterval = MediaPlayer.VALUE_PERCENTAGE;
				barLoadProgress.enabled = false;
			}
			player.addEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
			player.addEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
			player.addEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
			player.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
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