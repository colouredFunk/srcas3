package akdcl.application{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
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
		override public function remove():void {
			super.remove();
			if (sound) {
				sound.stop(true);
				sound = null;
			}
		}
		override public function play():Boolean {
			var _isPlay:Boolean = super.play();
			if (_isPlay && sound) {
				sound.play();
			}
			return _isPlay;
		}
		override public function pause():void {
			super.pause();
			sound&&sound.pause();
		}
		override public function stop():void {
			sound && sound.stop();
			super.stop();
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
			if (sound) {
				sound.removeEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
				sound.removeEventListener(ProgressEvent.PROGRESS, onLoadProgressHander);
				sound.removeEventListener(Event.COMPLETE, onLoadCompleteHandler);
				sound.removeEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
				sound.stop(true);
			}
			
			super.onPlayIDChangeHandler(_playID);
			
			var _musicSource:String = getMediaByID(_playID);
			sound = Sound.loadSound(_musicSource);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHander);
			sound.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			sound.addEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
			play();
		}
	}
}