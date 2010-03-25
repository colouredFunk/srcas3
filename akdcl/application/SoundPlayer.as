package akdcl.application{

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundLoaderContext;

	import flash.net.URLRequest;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import flash.events.EventDispatcher;

	public class SoundPlayer extends EventDispatcher{
		protected var soundChannel:SoundChannel;
		protected var sound:Sound;
		protected var musicList:XML;
		protected var position:uint;
		
		public var repeatMode:uint=2;//0,1,2,3
		
		public static var SOUND_START:String="soundStart";
		public static var SOUND_STOP:String="soundStop";
		public static var SOUND_PAUSE:String="soundPause";
		public static var SOUND_COMPLETE:String="soundComplete";
		public static var SOUND_STATE:String="soundState";
		public static var PROGRESS:String="progress";
		public static var COMPLETE:String="complete";
		public function SoundPlayer() {
			
		}
		public function get loaded():Number{
			if(!sound){
				return 0;
			}
			return sound.bytesLoaded/sound.bytesTotal;
		}
		public function get played():Number{
			if(playState==SOUND_STOP){
				return 0;
			}
			return soundChannel.position/sound.length;
		}
		public function get totalTime():uint {
			if (!sound) {
				return 0;
			}
			return sound.length;
		}
		private var __playId:uint;
		public function get playId():uint{
			return __playId;
		}
		public function set playId(_playId:uint):void{
			if (_playId==musicList.list.length()) {
				_playId=0;
			}else if (_playId>musicList.list.length()){
				_playId=musicList.list.length()-1;
			}
			__playId=_playId;
			stop();
			if (sound) {
				sound.removeEventListener(ProgressEvent.PROGRESS,progress);
				sound.removeEventListener(Event.COMPLETE,$complete);
			}
			position=0;
			try{
				sound.close();
			}catch (error:*){
				
			}
			sound=new Sound();
			sound.addEventListener(ProgressEvent.PROGRESS,progress);
			sound.addEventListener(Event.COMPLETE,$complete);
			sound.load(new URLRequest(musicList.list[playId].@src.toString()));
		}
		public function attachMusic(_musicList:*):void {
			newList(_musicList);
			playId=0;
		}
		private var volumePrev:Number=0;
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
		public var defaultVolume:Number=0.8;
		private var __volume:Number;
		public function get volume():Number{
			if(isNaN(__volume)){
				return defaultVolume;
			}
			return __volume;
		}
		public function set volume(_volume:Number):void{
			if(!soundChannel){
				return;
			}
            var _trans:SoundTransform = soundChannel.soundTransform;
            _trans.volume = _volume;
            soundChannel.soundTransform = _trans;
			__volume=_volume;
		}
		private var __playState:String;
		public function get playState():String {
			return __playState;
		}
		public function autoPlay():Boolean{
			if (playState==SOUND_START) {
				pause();
				return false;
			}
			play();
			return true;
		}
		public function play():void {
			if (playState==SOUND_START) {
				return;
			}
			if (soundChannel) {
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE,$soundComplete);
			}
			soundChannel=sound.play(position);
			volume=volume;
			soundChannel.addEventListener(Event.SOUND_COMPLETE,$soundComplete);
			dispatchEvent(new Event(SOUND_START));
			__playState=SOUND_START;
			dispatchEvent(new Event(SOUND_STATE));
		}
		public function pause():void {
			if (playState!=SOUND_START) {
				return;
			}
			position=soundChannel.position;
			if (soundChannel) {
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE,$soundComplete);
			}
			dispatchEvent(new Event(SOUND_PAUSE));
			__playState=SOUND_PAUSE;
			dispatchEvent(new Event(SOUND_STATE));
		}
		public function stop():void {
			if (playState==SOUND_STOP) {
				return;
			}
			position=0;
			if (soundChannel) {
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE,$soundComplete);
			}
			dispatchEvent(new Event(SOUND_STOP));
			__playState=SOUND_STOP;
			dispatchEvent(new Event(SOUND_STATE));
		}
		public function prev():void {
			playId--;
			play();
		}
		public function next():void {
			playId++;
			play();
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
		protected function progress(_evt:ProgressEvent):void {
			dispatchEvent(new Event(PROGRESS));
		}
		protected function $complete(_evt:Event):void {
			dispatchEvent(new Event(COMPLETE));
		}
		protected function $soundComplete(_evt:Event):void {
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
	}
}