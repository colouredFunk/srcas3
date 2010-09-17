package akdcl.application{

	import flash.display.Sprite;
	import flash.media.SoundTransform;
	import akdcl.media.Sound;
	import ui.UISprite;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import flash.external.ExternalInterface;

	public class MusicPlayer extends UISprite {
		public static const WMP_STATE_LIST:Array = ["停止", "暂停", "播放", "向前", "向后", "缓冲", "等待", "完毕", "连接", "就绪"];
		
		public static var SOUND_PLAY:String = "soundPlay";
		public static var SOUND_PAUSE:String = "soundPause";
		public static var SOUND_STOP:String = "soundStop";
		public static var SOUND_COMPLETE:String = "soundComplete";
		public static var SOUND_IDCHANGE:String = "soundIdChange";
		public static var SOUND_STATE_CHANGE:String = "soundStateChange";
		public static var PROGRESS:String = "soundLoadProgress";
		public static var COMPLETE:String = "soundLoadComplete";
		
		public var btn_play:*;
		public var btn_stop:*;
		public var btn_prev:*;
		public var btn_next:*;
		public var bar_volume:*;
		public var btn_volume:*;
		public var bar_playProgress:*;
		public var bar_loadProgress:*;
		public var txt_playProgress:*;
		public var onWMPStateChange:Function;
		
		//0:不循环，1:单首循环，2:顺序循环，3:未设置
		public var repeatMode:uint = 2;
		public var autoPlayForStop:Boolean;
		
		protected var sound:Sound;
		protected var musicInfo:Object;
		protected var musicList:XML;
		protected var isPlugin:Boolean;
		protected var isPluginMode:Boolean;
		
		//0~1
		public function get loaded():Number {
			if (isPluginMode) {
				return 1;
			}else if (sound) {
				return sound.loaded;
			}else{
				return 0;
			}
		}
		//0~1
		public function get played():Number {
			if (isPluginMode) {
				var _playingInfo:Object = getMusicPlayingInfo();
				if (_playingInfo && musicInfo) {
					return int(_playingInfo.currentPosition) / int(musicInfo.duration);
				}else {
					return 0;
				}
			}else if (sound) {
				return sound.played;
			}else{
				return 0;
			}
		}
		//毫秒为单位
		public function get totalTime():uint {
			if (isPluginMode && musicInfo) {
				return musicInfo.duration * 1000;
			}else if (sound) {
				return sound.totalTime;
			}else{
				return 0;
			}
		}
		//毫秒为单位
		protected var positionRecord:uint;
		public function get position():uint {
			if (isPluginMode) {
				var _playingInfo:Object = getMusicPlayingInfo();
				if (_playingInfo) {
					return int(_playingInfo.currentPosition) * 1000;
				}else {
					return 0;
				}
			}else if (sound) {
				return sound.position;
			}else{
				return 0;
			}
		}
		public function timeInfo():String {
			var _timePlay:String;
			var _timeTotal:String;
			_timePlay = formatTime_2(position * 0.001);
			_timeTotal = formatTime_2(totalTime * 0.001);
			return _timePlay + " / " + _timeTotal;
		}
		//将数格式化为时间xx:xx
		public static function formatTime_2(_n:uint):String {
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
		public function get isPlaying():Boolean {
			return playState == SOUND_PLAY;
		}
		private var __playId:int = -1;
		public function get playId():int{
			return __playId;
		}
		public function set playId(_playId:int):void{
			if (_playId<0) {
				_playId = musicList.list.length() - 1;
			}else if (_playId>musicList.list.length()-1){
				_playId = 0;
			}
			if (__playId == _playId) {
				return;
			}
			__playId = _playId;
			stop();
			positionRecord = 0;
			musicInfo = null;
			
			if (sound) {
				sound.removeEventListener(Event.ID3, onID3Loaded);
				sound.removeEventListener(ProgressEvent.PROGRESS,onSoundLoadProgressHandle);
				sound.removeEventListener(Event.COMPLETE, onSoundLoadCompleteHandle);
				sound.removeEventListener(Event.SOUND_COMPLETE, onSoundPlayCompleteHandle);
				sound.stop(true);
			}
			var _musicSOURCE:String = String(musicList.list[playId].@src).toLowerCase();
			
			if (_musicSOURCE.indexOf(".mp3") < 0) {
				sound = null;
				if (!isPlugin) {
					isPluginMode = false;
					return;
				}
				isPluginMode = true;
				ExternalInterface.call("musicSetSource", _musicSOURCE);
			}else {
				isPluginMode = false;
				sound = Sound.loadSound(_musicSOURCE);
				sound.addEventListener(Event.ID3, onID3Loaded);
				sound.addEventListener(ProgressEvent.PROGRESS,onSoundLoadProgressHandle);
				sound.addEventListener(Event.COMPLETE, onSoundLoadCompleteHandle);
				sound.addEventListener(Event.SOUND_COMPLETE, onSoundPlayCompleteHandle);
			}
			dispatchEvent(new Event(SOUND_IDCHANGE));
			if (isAutoPlay) {
				play();
			}
		}
		protected function onID3Loaded(_evt:Event):void {
			//sound.id3;
		}
		public var isAutoPlay:Boolean;
		public var musicInfoMore:Object;
		public function attachMusic(_musicList:*, _isAutoPlay:Boolean = true, _obj:Object = null):void {
			isAutoPlay = _isAutoPlay;
			newList(_musicList);
			__playId = -1;
			playId = 0;
			musicInfoMore = _obj;
		}
		public var defaultVolume:Number = 0.5;
		private var volumePrev:Number = 0;
		public function get mute():Boolean{
			return volume==0;
		}
		public function set mute(_mute:Boolean):void{
			if(_mute==(volume==0)){
				return;
			}
			if(_mute){
				volumePrev=volume;
				volume=0;
			}else{
				if (volumePrev <0.01) {
					volumePrev = defaultVolume;
				}
				volume=volumePrev;
			}
		}
		private var __volume:Number;
		public function get volume():Number{
			if(isNaN(__volume)){
				return defaultVolume;
			}
			return __volume;
		}
		public function set volume(_volume:Number):void {
			__volume = _volume;
			if (isPluginMode) {
				ExternalInterface.call("musicVolume", (__volume * 100));
			}else if(sound) {
				sound.volume = __volume;
			}
			if (bar_volume) {
				bar_volume.value = __volume;
			}
			if (btn_volume) {
				btn_volume.select = __volume==0;
			}
		}
		public function setVolume(_volume:Number):void {
			volume=_volume;
		}
		public function get volumeForTweenMax():Number{
			return volume;
		}
		public function set volumeForTweenMax(_volume:Number):void {
			volume = _volume;
		}
		private var __playState:String;
		public function get playState():String {
			return __playState;
		}
		public function autoPlay():Boolean {
			switch(playState) {
				case SOUND_PAUSE:
				case SOUND_STOP:
				case WMP_STATE_LIST[9]:
					play();
					return true;
				case SOUND_PLAY:
				default:
					if (autoPlayForStop) {
						stop();
					}else {
						pause();
					}
					return false;
			}
		}
		public function play(_positionTo:uint = 0):void {
			if (_positionTo!=0) {
				positionRecord = _positionTo;
			}else {
				if (playState==SOUND_PLAY) {
					return;
				}
			}
			if (isPluginMode) {
				ExternalInterface.call("musicPlay", _positionTo * 0.001);
			}else if(sound){
				sound.play(positionRecord);
			}
			volume = volume;
			__playState = SOUND_PLAY;
			dispatchEvent(new Event(SOUND_STATE_CHANGE));
			addEventListener(Event.ENTER_FRAME, onSoundPlayProgressHandle);
		}
		public function pause():void {
			if (playState == SOUND_PAUSE) {
				return;
			}
			positionRecord = position;
			if(isPluginMode){
				ExternalInterface.call("musicPause");
			}else if(sound){
				sound.stop();
			}
			__playState=SOUND_PAUSE;
			dispatchEvent(new Event(SOUND_STATE_CHANGE));
			removeEventListener(Event.ENTER_FRAME, onSoundPlayProgressHandle);
		}
		public function stop():void {
			if (playState==SOUND_STOP) {
				return;
			}
			positionRecord=0;
			if (isPluginMode) {
				ExternalInterface.call("musicStop");
			}else if(sound){
				sound.stop();
			}
			__playState=SOUND_STOP;
			dispatchEvent(new Event(SOUND_STATE_CHANGE));
			removeEventListener(Event.ENTER_FRAME, onSoundPlayProgressHandle);
			onSoundPlayProgressHandle(null);
		}
		public function prev():void {
			playId--;
			play();
		}
		public function next():void {
			playId++;
			play();
		}
		protected function getMusicPlayingInfo():Object {
			if (isPluginMode) {
				return ExternalInterface.call("getMusicPlayingInfo");
			}
			return null;
		}
		protected function $pluginPlayStateChange(_id:uint):void {
			switch (_id) {
				case 1 :
					//停止
					stop();
					break;
				case 2 :
					//暂停
					pause();
					break;
				case 3 :
					//播放
					musicInfo = ExternalInterface.call("getMusicInfo");
					__playState = SOUND_PLAY;
					break;
				case 4 :
					//向前
					__playState = WMP_STATE_LIST[_id - 1];
					break;
				case 5 :
					//向后
					__playState = WMP_STATE_LIST[_id - 1];
					break;
				case 6 :
					//缓冲
					__playState = WMP_STATE_LIST[_id - 1];
					break;
				case 7 :
					//等待
					__playState = WMP_STATE_LIST[_id - 1];
					break;
				case 8 :
					//完毕
					onSoundPlayCompleteHandle(null);
					break;
				case 9 :
					//连接
					__playState = WMP_STATE_LIST[_id - 1];
					break;
				case 10 :
					//就绪
					__playState = WMP_STATE_LIST[_id - 1];
					break;
			}
			if (onWMPStateChange!=null) {
				onWMPStateChange(_id);
			}
		}
		override protected function init():void {
			super.init();
			addEventListener(SOUND_STATE_CHANGE, onSoundStageChangeHandle);
			__playState = SOUND_STOP;
			if (btn_play) {
				btn_play.release = autoPlay;
			}
			if (btn_stop) {
				btn_stop.release = stop;
			}
			if (btn_prev) {
				btn_prev.release = prev;
			}
			if (btn_next) {
				btn_next.release = next;
			}
			if (btn_volume) {
				btn_volume.release = function():void {
					mute = !mute;
				}
			}
			if (bar_volume) {
				bar_volume.snapInterval = 0.01;
				bar_volume.minimum = 0;
				bar_volume.maximum = 1;
				bar_volume.change = function(_value:Number,...arg):void {
					volume = _value;
				}
			}
			if (bar_playProgress) {
				bar_playProgress.snapInterval = 0.01;
				bar_playProgress.minimum = 0;
				bar_playProgress.maximum = 1;
				bar_playProgress.release = function(_value:Number):void {
					play(totalTime * Math.min(_value, loaded));
				}
			}
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("playStateChange", $pluginPlayStateChange);
				ExternalInterface.addCallback("attachMusic", attachMusic);
				ExternalInterface.addCallback("play", play);
				ExternalInterface.addCallback("setVolume", setVolume);
				ExternalInterface.addCallback("stop", stop);
				isPlugin = ExternalInterface.call("initMusicPlayer");
			}
		}
		protected function newList(_list:*):void {
			if (_list is XML) {
				musicList = _list;
			}else {
				musicList =<root></root>;
				if ((_list is Array)||(_list is String)) {
					if(_list is String){
						_list=_list.split("|");
					}
					for each (var _e:* in _list) {
						musicList.appendChild(<list src={_e}/>);
					}
				} else if (_list is XMLList) {
					musicList.list=_list;
				} 
			}
		}
		protected function onSoundPlayProgressHandle(_evt:Event):void {
			if (bar_playProgress) {
				bar_playProgress.value = played;
			}
			if (txt_playProgress) {
				txt_playProgress.text = timeInfo();
			}
		}
		protected function onSoundLoadProgressHandle(_evt:ProgressEvent):void {
			dispatchEvent(new Event(PROGRESS));
		}
		protected function onSoundLoadCompleteHandle(_evt:Event):void {
			dispatchEvent(new Event(COMPLETE));
		}
		protected function onSoundPlayCompleteHandle(_evt:Event):void {
			switch(repeatMode){
				case 0:
					stop();
					break;
				case 1:
					stop();
					play();
					break;
				case 2:
					next();
					break;
				case 3:
					stop();
					break;
			}
			dispatchEvent(new Event(SOUND_COMPLETE));
		}
		protected function onSoundStageChangeHandle(_evt:Event):void {
			switch(playState) {
				case SOUND_PLAY:
					if (btn_play) {
						btn_play.select = true;
					}
					break;
				case SOUND_PAUSE:
					if (btn_play) {
						btn_play.select = false;
					}
					break;
				case SOUND_STOP:
					if (btn_play) {
						btn_play.select = false;
					}
					break;
			}
		}
	}
}