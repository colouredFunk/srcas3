package akdcl.media{
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.display.StageDisplayState;
	
	import ui.manager.ButtonManager;
	import ui.UISprite;
	import ui.SimpleBtn;
	import ui.ImageLoader;
	
	import akdcl.utils.copyInstanceToArray;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class PlayerSkin extends SimpleBtn {
		public static var labelAutoSize:String = "center";
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
		public var barLoadProgress:*;
		public var barPlayProgress:*;
		public var txtPlayProgress:*;
		protected var player:MediaPlayer;
		override protected function init():void {
			super.init();
			enabled = false;
		}
		override protected function onRemoveToStageHandler():void {
			setPlayer(null);
			super.onRemoveToStageHandler();
		}
		public function setPlayer(_player:MediaPlayer):void {
			if (!_player) {
				if (player) {
					//player.removeEventListener(MediaEvent.LIST_CHANGE, onListChangeHandler);
					player.removeEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
					//player.removeEventListener(MediaEvent.PLAY_ITEM_CHANGE, onPlayItemChangeHandler);
					//player.removeEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
					player.removeEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
					player.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				}
				player = null;
				return;
			}
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
				//btnPlayPause.release = player.playOrPause;
			}
			if (btnPlayStop) {
				//btnPlayStop.release = player.playOrStop;
			}
			if (btnNext) {
				btnNext.release = player.next;
			}
			if (btnPrev) {
				btnPrev.release = player.prev;
			}
			onVolumeChangeHandler(null);
			if (btnVolume) {
				btnVolume.release = function():void {
					player.mute = !player.mute;
				}
			}
			if (barVolume) {
				barVolume.maximum = 1;
				barVolume.snapInterval = MediaPlayer.VALUE_PERCENTAGE;
				barVolume.change = null;
				barVolume.value = player.volume;
				barVolume.change = function(_value:Number):void {
					player.volume = _value;
				}
			}
			if (barPlayProgress) {
				if (barPlayProgress.track && barPlayProgress.track.hasOwnProperty("value")) {
					barLoadProgress = barPlayProgress.track;
				}else if (barPlayProgress.barLoadProgress) {
					barLoadProgress = barPlayProgress.barLoadProgress;
				}
				if (txtPlayProgress) {
					barPlayProgress.txt = txtPlayProgress;
				}
				barPlayProgress.maximum = 1;
				barPlayProgress.snapInterval = MediaPlayer.VALUE_PERCENTAGE;
				barPlayProgress.labelFunction = timeLabelFunction;
				barPlayProgress.setStyle();
				barPlayProgress.change = null;
				barPlayProgress.value = 0;
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
			player.addEventListener(MediaEvent.LIST_CHANGE, onListChangeHandler);
			player.addEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
			player.addEventListener(MediaEvent.PLAY_ID_CHANGE, onPlayItemChangeHandler);
			player.addEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
			player.addEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
			player.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
		}
		
		protected function onListChangeHandler(_evt:MediaEvent):void {
			
		}
		protected function setBtn(_btn:*, _id:uint, ...args):void {
			var _offID:int = _id + btnOffID;
			if (formatBtnXY) {
				if (horizontal) {
					_btn.y = startYBtn;
					if (against) {
						_btn.x = startXBtn + (_id - args[1]) * distanceBtn;
					}else {
						_btn.x = startXBtn + _id * distanceBtn;
					}
				}else {
					_btn.x = startXBtn;
					if (against) {
						_btn.y = startYBtn + (_id - args[1]) * distanceBtn;
					}else {
						_btn.y = startYBtn + _id * distanceBtn;
					}
					_btn.y = startYBtn + _id * (against? -distanceBtn:distanceBtn);
				}
			}else {
				
			}
			if (_offID >= player.playlist.length()) {
				_btn.visible = false;
				return;
			}
			btnsContainer.addChild(_btn);
			_btn.visible = true;
			if (!_btn.userData) {
				_btn.userData = { };
			}
			_btn.userData.id = _offID;
			_btn.release = function():void {
				player.playID = this.userData.id;
			}
			/*if (isRollOver) {
				_btn.rollOver = _btn.release;
			}*/
			if (!_btn.group) {
				_btn.group = "btnGroup_" + name;
			}
			try {
				var _label:String = String(player.playlist[_offID].@label);
				_btn.autoSize = labelAutoSize;
				_btn.label = _label || String(_offID + 1);
			}catch (_ero:*) {
				
			}
			var _icon:String = String(player.playlist[_offID].@icon);
			if (_icon.length > 0) {
				if (_btn is ImageLoader) {
					_btn.load(_icon, _id);
				}else {
					if (!_btn.icon) {
						_btn.icon = new ImageLoader();
						_btn.addChild(_btn.icon);
					}
					_btn.icon.load(_icon, _id);
				}
			}
			if (everyNumBtn!=null) {
				everyNumBtn(_btn, player.playlist[_offID]);
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
			if (btnPlay) {
				btnPlay.selected = player.playState == MediaPlayer.STATE_PLAY;
			}
			if (btnPlayPause) {
				btnPlayPause.selected = player.playState == MediaPlayer.STATE_PLAY;
			}
			if (btnPlayStop) {
				btnPlayStop.selected = player.playState == MediaPlayer.STATE_PLAY;
			}
			if (btnPause) {
				btnPause.selected = player.playState == MediaPlayer.STATE_PAUSE;
			}
			if (btnStop) {
				btnStop.selected = player.playState == MediaPlayer.STATE_STOP;
			}
			switch(player.playState) {
				case MediaPlayer.STATE_PAUSE:
				case MediaPlayer.STATE_STOP:
					if (player.content&&(player.content is ContentDisplay)) {
						TweenMax.to(player.content, 0.5, { colorTransform: { brightness:0.5 }} );
					}
				break;
				case MediaPlayer.STATE_PLAY:
				default:
					if (player.content&&(player.content is ContentDisplay)) {
						TweenMax.to(player.content, 0.5, { colorTransform: { brightness:1 }} );
					}
				break;
			}
		}
		protected function onPlayItemChangeHandler(_evt:MediaEvent):void {
			if (btnNext) {
				btnNext.visible = player.playlist.length() > 1;
			}
			if (btnPrev) {
				btnPrev.visible = player.playlist.length() > 1;
			}
			if (btnInfo) {
				XML.prettyIndent = -1;
				var _info:String = String(player.playlist[player.playID].info);
				_info=_info.split("\r\n").join("\r");
				if (btnInfo.hasOwnProperty("label")) {
					btnInfo.label = _info;
					
				}else if (btnInfo.hasOwnProperty("htmlText")) {
					btnInfo.htmlText = _info;
				}
			}
			var _btnSelect:*; 
			if (btnsContainer && btnsContainer.mask) {
				_btnSelect = btnLabelList[player.playID];
				if (_btnSelect) {
					_btnSelect.selected = true;
					if (horizontal) {
						var _x:int;
						btnsContainer.mask.x = int(btnsContainer.mask.x);
						if (btnsContainer.x + _btnSelect.x < btnsContainer.mask.x) {
							_x = btnsContainer.mask.x - _btnSelect.x;
							TweenMax.to(btnsContainer, 0.3, { x:_x } );
						}else if (btnsContainer.x + _btnSelect.x + _btnSelect.width > btnsContainer.mask.x + btnsContainer.mask.width) {
							_x = btnsContainer.mask.x + btnsContainer.mask.width - _btnSelect.width;
							_x = _btnSelect.x - _x;
							TweenMax.to(btnsContainer, 0.3, { x: -_x } );
						}
					}else {
						var _y:int;
						btnsContainer.mask.y = int(btnsContainer.mask.y);
						if (btnsContainer.y + _btnSelect.y < btnsContainer.mask.y) {
							_y = btnsContainer.mask.y - _btnSelect.y;
							TweenMax.to(btnsContainer, 0.3, { y:_y } );
						}else if (btnsContainer.y + _btnSelect.y + _btnSelect.height > btnsContainer.mask.y + btnsContainer.mask.height) {
							_y = btnsContainer.mask.y + btnsContainer.mask.height - _btnSelect.height;
							_y = _btnSelect.y - _y;
							TweenMax.to(btnsContainer, 0.3, { y: -_y } );
						}
					}
				}
			}else {
				//if (btnLabelList.length > 0 && player.playID - btnOffID >= btnLabelList.length) {
					//btnOffID = player.playID;
					//btnLabelList.forEach(setBtn);
				//}else {
					//btnOffID = 0;
				//}
				_btnSelect = btnLabelList[player.playID - btnOffID];
				if (_btnSelect) {
					_btnSelect.selected = true;
				}
			}
		}
		protected function onVolumeChangeHandler(_evt:MediaEvent):void {
			if (btnVolume) {
				btnVolume.selected = player.mute;
				if (btnVolume.valueClip) {
					if (btnVolume.selected) {
						btnVolume.valueClip.gotoAndStop(1);
					}else {
						btnVolume.valueClip.gotoAndStop(1 + 1 + int(player.volume * (btnVolume.valueClip.totalFrames - 2)));
					}
				}
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
				if (barLoadProgress.hasOwnProperty("text")) {
					barLoadProgress.text = Math.round(player.loadProgress * 100) + " %";
				}else if (barLoadProgress.hasOwnProperty("value")) {
					barLoadProgress.value = player.loadProgress;
				}else if (barLoadProgress.hasOwnProperty("totalFrames")) {
					if (player.loadProgress==1) {
						barLoadProgress.stop();
					}else {
						barLoadProgress.play();
					}
				}
				if (autoHideProgress) {
					if (player.loadProgress < 1) {
						barLoadProgress.visible = true;
					}else {
						barLoadProgress.visible = false;
					}
				}
			}
		}
	}
	
}