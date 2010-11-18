package akdcl.application{
	import flash.events.Event;
	import akdcl.events.MediaEvent;
	import akdcl.application.MediaPlayer;
	
	import ui.ImageLoader;
	import ui.UISprite;
	import com.greensock.TweenLite;
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
		
		public var btnInfo:*;
		public var btnsContainer:*;
		public var btn_0, btn_1, btn_2, btn_3, btn_4, btn_5, btn_6, btn_7, btn_8, btn_9:*;
		public var autoHideProgress:Boolean;
		protected var btnList:Array;
		
		protected var player:MediaPlayer;
		override protected function init():void {
			super.init();
			if (btn_0) {
				startXBtn = btn_0.x;
				startYBtn = btn_0.y;
				btnsContainer = new UISprite();
				addChildAt(btnsContainer,0);
			}
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
				barVolume.change = null;
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
			player.addEventListener(MediaEvent.PLAY_ID_CHANGE, onIDChangeHandler);
			player.addEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
			player.addEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
			player.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
			enabled = true;
		}
		//
		private var __against:Boolean = false;
		public function get against():Boolean {
			return __against;
		}
		[Inspectable(defaultValue = false, type = "Boolean", name = "逆向对齐")]
		public function set against(_against:Boolean):void {
			__against = _against;
		}
		private var __horizontal:Boolean = true;
		public function get horizontal():Boolean {
			return __horizontal;
		}
		[Inspectable(defaultValue = true, type = "Boolean", name = "水平排布")]
		public function set horizontal(_horizontal:Boolean):void {
			__horizontal = _horizontal;
		}
		private var __distanceBtn:uint = 25;
		public function get distanceBtn():uint {
			return __distanceBtn;
		}
		[Inspectable(defaultValue = 25, type = "uint", name = "标签间距")]
		public function set distanceBtn(_distanceBtn:uint):void {
			__distanceBtn = _distanceBtn;
		}
		protected var startXBtn:int;
		protected var startYBtn:int;
		protected var formatBtnXY:Boolean;
		protected function onListChangeHandler(_evt:MediaEvent):void {
			btnList = [btn_0, btn_1, btn_2, btn_3, btn_4, btn_5, btn_6, btn_7, btn_8, btn_9];
			var _btn:*;
			for (var _i:int = btnList.length - 1; _i >= 0 ; _i--) {
				_btn = btnList[_i];
				if (_btn) {
					_btn.visible = false;
				}else {
					btnList.splice(_i, 1);
				}
			}
			if (!player || player.playlist.length() < 2) {
				return;
			}
			switch(btnList.length) {
				case 0:
				return;
				case 2:
					if (horizontal) {
						distanceBtn = btnList[1].x - btnList[0].x;
					}else {
						distanceBtn = btnList[1].y - btnList[0].y;
					}
					distanceBtn *= against? -1:1;
				case 1:
					formatBtnXY = true;
					break;
				default:
					formatBtnXY = false;
			}
			Common.copyInstanceToArray(btnList[0], Math.max(player.playlist.length(), btnList.length), btnList, setBtn);
		}
		protected function setBtn(_btn:*, _id:uint, ...args):void {
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
			}
			if (_id>=player.playlist.length()) {
				_btn.visible = false;
				return;
			}
			btnsContainer.addChild(_btn);
			_btn.visible = true;
			_btn.userData = { id:_id };
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
				var _label:String = String(player.playlist[_id].@label);
				_btn.autoSize = "center";
				_btn.label = _label || String(_id + 1);
			}catch (_ero:*) {
				
			}
			var _icon:String = String(player.playlist[_id].@icon);
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
				btnNext.visible = player.playlist.length() > 1;
			}
			if (btnPrev) {
				btnPrev.visible = player.playlist.length() > 1;
			}
			if (btnInfo) {
				var _info:String = String(player.playlist[player.playID].info);
				_info=_info.split("\r\n").join("\r");
				if (btnInfo.hasOwnProperty("label")) {
					btnInfo.label = _info;
					
				}else if (btnInfo.hasOwnProperty("htmlText")) {
					btnInfo.htmlText = _info;
				}
			}
			var _btnSelect:*= btnList[player.playID];
			if (_btnSelect) {
				_btnSelect.select = true;
			}
			if (btnsContainer && btnsContainer.mask && _btnSelect) {
				var _x:int;
				btnsContainer.mask.x = int(btnsContainer.mask.x);
				if (btnsContainer.x + _btnSelect.x < btnsContainer.mask.x) {
					_x = btnsContainer.mask.x - _btnSelect.x;
					TweenLite.to(btnsContainer, 0.3, { x:_x } );
				}else if (btnsContainer.x + _btnSelect.x + _btnSelect.width > btnsContainer.mask.x + btnsContainer.mask.width) {
					_x = btnsContainer.mask.x + btnsContainer.mask.width - _btnSelect.width;
					_x = _btnSelect.x - _x;
					TweenLite.to(btnsContainer, 0.3, { x: -_x } );
				}
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