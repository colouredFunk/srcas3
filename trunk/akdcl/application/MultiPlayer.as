package akdcl.application{
	import akdcl.events.MediaEvent;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MultiPlayer extends MediaPlayer{
		override public function get loadProgress():Number {
			return currentPlayer?currentPlayer.loadProgress:0; 
		}
		override public function get totalTime():uint { 
			return currentPlayer?currentPlayer.totalTime:0;
		}
		override public function get position():uint {
			return currentPlayer?currentPlayer.position:0;
		}
		override public function set position(value:uint):void {
			if (currentPlayer) {
				currentPlayer.position = value;
			}
		}
		override public function set contentWidth(value:uint):void {
			super.contentWidth = value;
			musicPlayer.contentWidth = contentWidth;
			imagePlayer.contentWidth = contentWidth;
			videoPlayer.contentWidth = contentWidth;
			wmpPlayer.contentWidth = contentWidth;
		}
		override public function set contentHeight(value:uint):void {
			super.contentHeight = value;
			musicPlayer.contentHeight = contentHeight;
			imagePlayer.contentHeight = contentHeight;
			videoPlayer.contentHeight = contentHeight;
			wmpPlayer.contentHeight = contentHeight;
		}
		override public function set volume(value:Number):void {
			super.volume = value;
			musicPlayer.volume = volume;
			imagePlayer.volume = volume;
			videoPlayer.volume = volume;
			wmpPlayer.volume = volume;
		}
		protected var imagePlayer:ImagePlayer;
		protected var musicPlayer:MusicPlayerNew;
		protected var videoPlayer:VideoPlayer;
		protected var wmpPlayer:WMPPlayer;
		protected var currentPlayer:MediaPlayer;
		override protected function init():void {
			super.init();
			musicPlayer = new MusicPlayerNew();
			imagePlayer = new ImagePlayer();
			videoPlayer = new VideoPlayer();
			wmpPlayer = new WMPPlayer();
		}
		override public function remove():void {
			super.remove();
			imagePlayer.remove();
			musicPlayer.remove();
			videoPlayer.remove();
			wmpPlayer.remove();
			imagePlayer = null;
			musicPlayer = null;
			videoPlayer = null;
			wmpPlayer = null;
			currentPlayer = null;
		}
		override public function play():Boolean {
			var _isPlay:Boolean = super.play();
			if (_isPlay&&currentPlayer) {
				currentPlayer.play();
			}
			return _isPlay;
		}
		override public function pause():void {
			super.pause();
			if (currentPlayer) {
				currentPlayer.pause();
			}
		}
		override public function stop():void {
			if (currentPlayer) {
				currentPlayer.stop();
			}
			super.stop();
		}
		override public function hideContent():void {
			super.hideContent();
			if (currentPlayer) {
				currentPlayer.hideContent();
			}
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
			if (currentPlayer) {
				currentPlayer.removeEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				currentPlayer.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHander);
				currentPlayer.removeEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				currentPlayer.removeEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);	
			}
			hideContent();
			var _mediaSource:String = getMediaByID(_playID);
			var _mediaType:String = String(_mediaSource.split(".").pop()).toLowerCase();
			switch(_mediaType) {
				case "mp3":
				case "wav":
					currentPlayer = musicPlayer;
					break;
				case "bmp":
				case "gif":
				case "jpg":
				case "png":
					currentPlayer = imagePlayer;
					break;
				case "flv":
				case "mov":
				case "mp4":
				case "f4v":
					currentPlayer = videoPlayer;
					break;
				case "wma":
				case "mms":
				default:
					currentPlayer = wmpPlayer;
					break;
			}
			currentPlayer.addEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
			currentPlayer.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHander);
			currentPlayer.addEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
			currentPlayer.addEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
			currentPlayer.container = container;
			currentPlayer.openList(_mediaSource, false);
			if (autoPlay) {
				play();
			}
			autoPlay = true;
			super.onPlayIDChangeHandler(_playID);
		}
	}
}