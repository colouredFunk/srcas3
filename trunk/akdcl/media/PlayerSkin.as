package akdcl.media {
	import akdcl.media.MediaEvent;
	import ui.SimpleBtn;
	import akdcl.utils.copyInstanceToArray;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class PlayerSkin extends SimpleBtn {
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
			if (_n < 60){
				minutes = 0;
				seconds = _n;
			} else if (_n < 3600){
				minutes = Math.floor(_n / 60);
				seconds = _n % 60;
			}
			var s_m:String = minutes < 10 ? "0" + String(minutes) : String(minutes);
			var s_s:String = seconds < 10 ? "0" + String(seconds) : String(seconds);
			return s_m + ":" + s_s;
		}

		public var btnPlay:*;
		public var btnPause:*;
		public var btnStop:*;
		public var btnPlayPause:*;
		public var btnPlayStop:*;
		public var btnPrev:*;
		public var btnNext:*;
		public var btnVolume:*;
		public var barVolume:*;
		public var barPlayProgress:*;
		public var txtPlayProgress:*;
		public var loadProgressClip:*;
		public var bufferProgressClip:*;
		protected var player:MediaProvider;

		override protected function onRemoveToStageHandler():void {
			setPlayer(null);
			super.onRemoveToStageHandler();
		}

		public function setPlayer(_player:MediaProvider):void {
			if (!_player){
				if (player){
					player.removeEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
					player.removeEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
					player.removeEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
					player.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
					player.removeEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				}
				player = null;
				return;
			}
			player = _player;
			if (btnPlay){
				btnPlay.release = player.play;
			}
			if (btnPause){
				btnPause.release = player.pause;
			}
			if (btnStop){
				btnStop.release = player.stop;
			}
			if (btnPlayPause){
				btnPlayPause.release = playOrPause;
			}
			if (btnPlayStop){
				btnPlayStop.release = playOrStop;
			}
			if (player is MediaPlayer) {
				if (btnNext) {
					btnNext.release = player["next"];
				}
				if (btnPrev) {
					btnPrev.release = player["prev"];
				}
			}
			onVolumeChangeHandler(null);
			if (btnVolume){
				btnVolume.release = function():void {
					player.mute = !player.mute;
				}
			}
			if (barVolume){
				barVolume.maximum = 1;
				barVolume.snapInterval = 0.004;
				barVolume.change = null;
				barVolume.value = player.volume;
				barVolume.change = function(_value:Number):void {
					player.volume = _value;
				}
			}
			if (barPlayProgress){
				if (barPlayProgress.track && barPlayProgress.track.hasOwnProperty("value")){
					loadProgressClip = barPlayProgress.track;
				} else if (barPlayProgress.progressClip){
					loadProgressClip = barPlayProgress.progressClip;
				}
				if (txtPlayProgress){
					barPlayProgress.txt = txtPlayProgress;
				}
				barPlayProgress.maximum = 1;
				barPlayProgress.snapInterval = 0.004;
				barPlayProgress.labelFunction = timeLabelFunction;
				barPlayProgress.setStyle();
				barPlayProgress.change = null;
				barPlayProgress.value = 0;
				//barPlayProgress.press = 
				barPlayProgress.change = function(_value:Number):void {
					if (barPlayProgress.isHold){

					}
				}
				barPlayProgress.release = function():void {
					player.playProgress = barPlayProgress.value * 0.999;
				}
			}
			if (loadProgressClip){
				if (loadProgressClip.hasOwnProperty("maximum")){
					loadProgressClip.maximum = 1;
					loadProgressClip.snapInterval = 0.004;
					loadProgressClip.enabled = false;
					loadProgressClip.value = 0;
				}
			}
			player.addEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
			player.addEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
			player.addEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
			player.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
			player.addEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
			onStateChangeHandler(null);
		}

		protected function playOrPause():void {
			if (player.playState == PlayState.PLAY){
				player.pause();
			} else {
				player.play();
			}
		}

		protected function playOrStop():void {
			if (player.playState == PlayState.PLAY){
				player.stop();
			} else {
				player.play();
			}
		}

		//
		protected function timeLabelFunction(_value:Number):String {
			var _totalTime:uint = player.totalTime;
			var _str:String = complexTime(_totalTime * _value, _totalTime);
			return _str;
		}

		//
		protected function onStateChangeHandler(_evt:MediaEvent):void {
			if (btnPlay){
				btnPlay.selected = player.playState == PlayState.PLAY;
			}
			if (btnPlayPause){
				btnPlayPause.selected = player.playState == PlayState.PLAY;
			}
			if (btnPlayStop){
				btnPlayStop.selected = player.playState == PlayState.PLAY;
			}
			if (btnPause){
				btnPause.selected = player.playState == PlayState.PAUSE;
			}
			if (btnStop){
				btnStop.selected = player.playState == PlayState.STOP;
			}
		}

		protected function onVolumeChangeHandler(_evt:MediaEvent):void {
			if (btnVolume){
				btnVolume.selected = player.mute;
				if (btnVolume.valueClip){
					if (btnVolume.selected){
						btnVolume.valueClip.gotoAndStop(1);
					} else {
						btnVolume.valueClip.gotoAndStop(1 + 1 + int(player.volume * (btnVolume.valueClip.totalFrames - 2)));
					}
				}
			}
			if (barVolume){
				barVolume.value = player.volume;
			}
		}

		protected function onPlayProgressHandler(_evt:MediaEvent):void {
			if (barPlayProgress && !barPlayProgress.isHold){
				barPlayProgress.value = player.playProgress;
			}
		}

		protected function onLoadProgressHandler(_evt:MediaEvent):void {
			if (loadProgressClip){
				if (loadProgressClip.hasOwnProperty("text")){
					loadProgressClip.text = Math.round(player.loadProgress * 100) + " %";
				} else if (loadProgressClip.hasOwnProperty("value")){
					loadProgressClip.value = player.loadProgress;
				} else if (loadProgressClip.hasOwnProperty("play")){
					if (player.loadProgress == 1){
						loadProgressClip.stop();
						loadProgressClip.visible = false;
					} else {
						loadProgressClip.play();
						loadProgressClip.visible = true;
					}
				}
			}
		}

		protected function onBufferProgressHandler(_evt:MediaEvent):void {
			if (bufferProgressClip){
				if (bufferProgressClip.hasOwnProperty("text")){
					bufferProgressClip.text = Math.round(player.bufferProgress * 100) + " %";
				} else if (bufferProgressClip.hasOwnProperty("value")){
					bufferProgressClip.value = player.bufferProgress;
				} else if (bufferProgressClip.hasOwnProperty("play")){
					if (player.bufferProgress == 1){
						bufferProgressClip.stop();
						bufferProgressClip.visible = false;
					} else {
						bufferProgressClip.play();
						bufferProgressClip.visible = true;
					}
				}
			}
		}
	}

}