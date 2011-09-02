package akdcl.media {
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
		public var barLoadProgress:*;
		public var barPlayProgress:*;
		public var txtPlayProgress:*;
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
					barLoadProgress = barPlayProgress.track;
				} else if (barPlayProgress.barLoadProgress){
					barLoadProgress = barPlayProgress.barLoadProgress;
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
			if (barLoadProgress){
				if (barLoadProgress.hasOwnProperty("maximum")){
					barLoadProgress.maximum = 1;
					barLoadProgress.snapInterval = 0.004;
					barLoadProgress.enabled = false;
					barLoadProgress.value = 0;
				}
			}
			player.addEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
			player.addEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
			player.addEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
			player.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
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
			if (barLoadProgress){
				if (barLoadProgress.hasOwnProperty("text")){
					barLoadProgress.text = Math.round(player.loadProgress * 100) + " %";
				} else if (barLoadProgress.hasOwnProperty("value")){
					barLoadProgress.value = player.loadProgress;
				} else if (barLoadProgress.hasOwnProperty("totalFrames")){
					if (player.loadProgress == 1){
						barLoadProgress.stop();
						barLoadProgress.visible = false;
					} else {
						barLoadProgress.play();
						barLoadProgress.visible = true;
					}
				}
			}
		}
	}

}