package akdcl.application{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ui.UIEventDispatcher;
	
	import akdcl.events.MediaEvent;
	import akdcl.application.IDPart;
	
	/// @eventType	akdcl.events.MediaEvent.LIST_CHANGE
	[Event(name = "listChange", type = "akdcl.events.MediaEvent")]
	
	/// @eventType	akdcl.events.MediaEvent.VOLUME_CHANGE
	[Event(name = "volumeChange", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.STATE_CHANGE
	[Event(name = "stateChange", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.PLAY_PROGRESS
	[Event(name = "playProgress", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.PLAY_COMPLETE
	[Event(name = "playComplete", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.LOAD_PROGRESS
	[Event(name = "loadProgress", type = "akdcl.events.MediaEvent")]
	
	/// @eventType	akdcl.events.MediaEvent.LOAD_ERROR
	[Event(name = "loadError", type = "akdcl.events.MediaEvent")]
	
	/// @eventType	akdcl.events.MediaEvent.LOAD_COMPLETE
	[Event(name = "loadComplete", type = "akdcl.events.MediaEvent")]
	
	/// @eventType	akdcl.events.MediaEvent.PLAY_ID_CHANGE
	[Event(name = "playIDChange", type = "akdcl.events.MediaEvent")]
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MediaPlayer extends UIEventDispatcher {
		public static const STATE_PLAY:String = "play";
		public static const STATE_PAUSE:String = "pause";
		public static const STATE_STOP:String = "stop";
		public static const STATE_BUFFER:String = "buffer";
		public static const STATE_WAIT:String = "wait";
		public static const STATE_COMPLETE:String = "complete";
		public static const STATE_CONNECT:String = "connect";
		public static const STATE_READY:String = "ready";
		public static const STATE_RECONNECT:String = "reconnect";
		
		
		public static const VALUE_PERCENTAGE:Number = 0.004;
		public static const VOLUME_DEFAULT:Number = 0.8;
		//
		public static function createList(_list:*):XMLList {
			var _xml:XML;
			if ((_list is String) || (_list is Array)) {
				if (_list is String) {
					_list = _list.split("|");
				}
				_xml =<root/>;
				for each (var _each:String in _list) {
					_xml.appendChild(<list source={_each}/>);
				}
				_list = _xml.list;
			}else if (_list is XMLList || _list is XML) {
				if (_list is XML) {
					_list = _list.list;
				}
				if (_list.@source.length()==0) {
					return null;
				}
			}else {
				return null;
			}
			return _list;
		}
		
		//0~1
		public function get loadProgress():Number {
			return 0;
		}
		//毫秒为单位
		public function get totalTime():uint {
			return 0;
		}
		//
		public function get isPlaying():Boolean {
			return playState == STATE_PLAY;
		}
		//毫秒为单位
		public function get position():uint {
			return 0;
		}
		public function set position(_position:uint):void {
		}
		//0~1
		public function get playProgress():Number {
			return position / totalTime;
		}
		public function set playProgress(value:Number):void {
			position = totalTime * value;
		}
		//0~1
		private var __volume:Number = VOLUME_DEFAULT;
		public function get volume():Number {
			return __volume;
		}
		public function set volume(_volume:Number):void {
			if (_volume < 0) {
				_volume = 0;
			}else if (_volume > 1) {
				_volume = 1;
			}
			__volume = _volume;
			dispatchEvent(new MediaEvent(MediaEvent.VOLUME_CHANGE));
		}
		//
		private var volumeLast:Number = 0;
		public function get mute():Boolean {
			return volume == 0;
		}
		public function set mute(_mute:Boolean):void {
			if (_mute && (volume == 0)) {
				return;
			}
			if (_mute) {
				volumeLast = volume;
				volume = 0;
			}else{
				if (volumeLast < VALUE_PERCENTAGE) {
					volumeLast = VOLUME_DEFAULT;
				}
				volume = volumeLast;
			}
		}
		//
		public function get playID():int {
			return idPart.id;
		}
		public function set playID(_playID:int):void {
			if (playlist) {
				if (playlist.length() == 1) {
					idPart.setID( -1);
				}
			}
			idPart.id = _playID;
		}
		//0:不循环，1:单首循环，2:顺序循环(全部播放完毕后停止)，3:顺序循环，4:随机播放
		private var __repeat:uint = 3;
		public function get repeat():uint {
			return __repeat;
		}
		public function set repeat(_repeat:uint):void {
			__repeat = _repeat;
		}
		//
		private var __playState:String = STATE_STOP;
		public function get playState():String{
			return __playState;
		}
		protected function setPlayState(_playState:String):void {
			if (__playState == _playState) {
				return;
			}
			switch(_playState) {
				case STATE_PLAY:
					timer.start();
					break;
				case STATE_PAUSE:
					if (__playState == STATE_STOP) {
						return;
					}
					timer.stop();
					break;
				case STATE_STOP:
					timer.reset();
					timer.stop();
					onPlayProgressHander();
					break;
				default:
					timer.stop();
			}
			__playState = _playState;
			dispatchEvent(new MediaEvent(MediaEvent.STATE_CHANGE));
		}
		//
		private var __contentWidth:uint;
		public function get contentWidth():uint {
			return __contentWidth;
		}
		public function set contentWidth(value:uint):void {
			__contentWidth = value;
		}
		private var __contentHeight:uint;
		public function get contentHeight():uint {
			return __contentHeight;
		}
		public function set contentHeight(value:uint):void {
			__contentHeight = value;
		}
		private var __content:*;
		public function get content():* {
			return __content;
		}
		public function set content(_content:*):* {
			__content = _content;
		}
		private var __container:*;
		public function get container():*{
			return __container;
		}
		public function set container(_cotainer:*):void {
			if (_cotainer == __container || !_cotainer) {
				return;
			}
			__container = _cotainer;
		}
		//
		private var __playlist:XMLList;
		public function get playlist():XMLList{
			return __playlist;
		}
		public function set playlist(_playlist:*):void{
			_playlist = createList(_playlist);
			if (!_playlist) {
				return;
			}
			stop();
			__playlist = _playlist;
			idPart.length = __playlist.length();
			idPart.setID( -1);
			dispatchEvent(new MediaEvent(MediaEvent.LIST_CHANGE));
			if (autoPlay) {
				play();
			}
			autoPlay = true;
		}
		//
		public var autoPlay:Boolean = true;
		public var updateInterval:uint = 20;
		protected var timer:Timer;
		protected var idPart:IDPart;
		//
		override protected function init():void {
			super.init();
			timer = new Timer(updateInterval);
			timer.addEventListener(TimerEvent.TIMER, onPlayProgressHander);
			idPart = new IDPart();
			idPart.onIDChange = onPlayIDChangeHandler;
		}
		override public function remove():void {
			super.remove();
			stop();
			timer.removeEventListener(TimerEvent.TIMER, onPlayProgressHander);
			timer = null;
			idPart.remove();
			idPart = null;
			playlist = null;
		}
		//
		public function getMediaByID(_playID:int):String {
			return playlist?String(playlist[_playID].@source):null
		}
		//
		public function play():Boolean {
			if (playID<0) {
				playID = 0;
			}
			if (isPlaying) {
				return false;
			}
			onLoadProgressHander();
			setPlayState(STATE_PLAY);
			return true;
		}
		public function pause():void {
			setPlayState(STATE_PAUSE);
		}
		public function stop():void {
			setPlayState(STATE_STOP);
		}
		public function playOrPause():Boolean {
			if (playState== STATE_PLAY) {
				pause();
				return false;
			}else {
				play();
				return true;
			}
		}
		public function playOrStop():Boolean {
			if (playState == STATE_PLAY) {
				stop();
				return false;
			}else {
				play();
				return true;
			}
		}
		public function next():void {
			playID++;
		}
		public function prev():void {
			playID--;
		}
		//
		public function hideContent():void {
		}
		//
		protected function onPlayIDChangeHandler(_playID:int):void {
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_ID_CHANGE));
		}
		//
		protected function onLoadErrorHandler(_evt:*= null):void {
			onPlayCompleteHandler();
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_ERROR));
		}
		protected function onLoadProgressHander(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_PROGRESS));
		}
		protected function onLoadCompleteHandler(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_COMPLETE));
		}
		//
		protected function onPlayCompleteHandler(_evt:*= null):void {
			switch(repeat) {
				case 0:
					stop();
					break;
				case 1:
					stop();
					play();
					break;
				case 2:
					if (playID == idPart.length - 1) {
						stop();
					}else {
						next();
					}
					break;
				case 3:
					next();
					break;
				case 4:
					//待完善
					stop();
					break;
			}
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_COMPLETE));
		}
		protected function onPlayProgressHander(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_PROGRESS));
		}
	}
	
}