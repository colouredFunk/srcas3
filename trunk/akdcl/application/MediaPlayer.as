package akdcl.application{
	import flash.events.Event;
	import ui.UISprite;
	
	import akdcl.events.MediaEvent;
	import akdcl.application.IDPart;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MediaPlayer extends UISprite {
		public static const STATE_PLAY:String = "play";
		public static const STATE_PAUSE:String = "pause";
		public static const STATE_STOP:String = "stop";
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
		protected var __loadProgress:Number = 0;
		public function get loadProgress():Number {
			return __loadProgress;
		}
		//毫秒为单位
		protected var __totalTime:Number = 0;
		public function get totalTime():uint {
			return 0;
		}
		//
		protected var __playState:String = STATE_STOP;
		public function get playState():String{
			return __playState;
		}
		//0~1
		private var __playProgress:Number = 0;
		public function get playProgress():Number {
			return __playProgress;
		}
		public function set playProgress(_playProgress:Number):void {
			if (isNaN(_playProgress)||_playProgress < 0) {
				_playProgress = 0;
			}else if (_playProgress > loadProgress) {
				_playProgress = loadProgress;
			}
			__playProgress = _playProgress;
		}
		//毫秒为单位
		private var __position:Number = 0;
		public function get position():uint {
			return __position;
		}
		public function set position(_position:uint):void {
			if (_position > totalTime * loadProgress) {
				_position = totalTime * loadProgress;
			}
			__position = _position;
		}
		//
		private var __autoPlay:Boolean = true;
		public function get autoPlay():Boolean{
			return __autoPlay;
		}
		public function set autoPlay(_autoPlay:Boolean):void {
			__autoPlay = _autoPlay;
		}
		//
		private var volumeRecord:Number = 0;
		public function get mute():Boolean {
			return volume == 0;
		}
		public function set mute(_mute:Boolean):void {
			if (_mute && (volume == 0)) {
				return;
			}
			if (_mute) {
				volumeRecord = volume;
				volume = 0;
			}else{
				if (volumeRecord < VALUE_PERCENTAGE) {
					volumeRecord = VOLUME_DEFAULT;
				}
				volume = volumeRecord;
			}
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
		//0:不循环，1:单首循环，2:顺序循环(全部播放完毕后停止)，3:顺序循环，4:随机播放
		public function get repeat():uint {
			return 3;
		}
		public function set repeat(_repeat:uint):void {
			
		}
		//
		public function get playID():int {
			return idPart.id;
		}
		public function set playID(_playID:int):void {
			idPart.id = _playID;
		}
		//
		protected var idPart:IDPart;
		protected var playList:XMLList;
		//
		override protected function init():void {
			super.init();
			idPart = new IDPart();
			idPart.onIDChange = onPlayIDChangeHandler;
		}
		//
		public function open(_list:*, _autoPlay:Boolean = false):void {
			playList = createList(_list);
			if (!playList) {
				return;
			}
			idPart.length = playList.length();
			idPart.setID( -1);
			autoPlay = _autoPlay;
			playID = 0;
		}
		//
		public function play():Boolean {
			if (playState== STATE_PLAY) {
				return false;
			}
			__playState = STATE_PLAY;
			addEventListener(Event.ENTER_FRAME, onPlayProgressHander);
			dispatchEvent(new MediaEvent(MediaEvent.STATE_CHANGE));
			return true;
		}
		public function pause():Boolean {
			if (playState== STATE_PAUSE) {
				return false;
			}
			__playState = STATE_PAUSE;
			removeEventListener(Event.ENTER_FRAME, onPlayProgressHander);
			dispatchEvent(new MediaEvent(MediaEvent.STATE_CHANGE));
			return true;
		}
		public function stop():Boolean {
			if (playState== STATE_STOP) {
				return false;
			}
			__playState = STATE_STOP;
			removeEventListener(Event.ENTER_FRAME, onPlayProgressHander);
			dispatchEvent(new MediaEvent(MediaEvent.STATE_CHANGE));
			return true;
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
		protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
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
					idPart.autoID = false;
					next();
					idPart.autoID = true;
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