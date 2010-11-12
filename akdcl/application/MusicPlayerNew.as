package akdcl.application{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import akdcl.media.Sound;
	
	public class MusicPlayerNew extends MediaPlayer {
		override public function get loadProgress():Number {
			return sound?sound.loadProgress:0; 
		}
		override public function get totalTime():uint { 
			return sound?sound.totalTime:0;
		}
		override public function get position():uint {
			return sound?sound.position:0;
		}
		override public function set position(value:uint):void {
			if (sound) {
				sound.position = value;
				setPlayState(MediaPlayer.STATE_PLAY);
			}
		}
		override public function set volume(value:Number):void {
			super.volume = value;
			if (sound) {
				sound.volume = volume;
			}
		}
		protected var sound:Sound;
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			if (sound) {
				sound.stop(true);
				sound = null;
			}
		}
		override public function play():Boolean {
			if (!isPlaying && sound) {
				sound.play();
			}
			return super.play();
		}
		override public function pause():Boolean {
			if (sound) {
				sound.pause();
			}
			return super.pause();
		}
		override public function stop():Boolean {
			if (sound) {
				sound.stop();
			}
			return super.stop();
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			super.onPlayIDChangeHandler(_playID);
			stop();
			if (sound) {
				//sound.removeEventListener(Event.ID3, onID3Loaded);
				sound.removeEventListener(ProgressEvent.PROGRESS, onLoadProgressHander);
				//sound.removeEventListener(Event.COMPLETE, onSoundLoadCompleteHandle);
				sound.removeEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
				sound.stop(true);
			}
			var _musicSource:String = getMediaByID(_playID);
			sound = Sound.loadSound(_musicSource);
			//sound.addEventListener(Event.ID3, onID3Loaded);
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHander);
			//sound.addEventListener(Event.COMPLETE, onSoundLoadCompleteHandle);
			sound.addEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
			if (autoPlay) {
				play();
			}else {
				stop();
			}
			autoPlay = true;
		}
	}
}