package com{

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
			sound=new Sound();
			sound.addEventListener(ProgressEvent.PROGRESS,progress);
			sound.addEventListener(Event.COMPLETE,$complete);
			sound.load(new URLRequest(musicList.list[playId]));
		}
		public function attachMusic(_musicList:String):void {
			newList(_musicList.split("|"));
			playId=0;
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
		private var __playState:uint;
		public function get playState():uint {
			return __playState;
		}
		public function autoPlay():Boolean{
			if (playState==2) {
				pause();
				return false;
			}
			play();
			return true;
		}
		public function play():void {
			if (playState==2) {
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
			__playState=2;
			dispatchEvent(new Event(SOUND_STATE));
		}
		public function pause():void {
			if (playState!=2) {
				return;
			}
			position=soundChannel.position;
			soundChannel.stop();
			dispatchEvent(new Event(SOUND_PAUSE));
			__playState=1;
			dispatchEvent(new Event(SOUND_STATE));
		}
		public function stop():void {
			if (playState==0) {
				return;
			}
			position=0;
			soundChannel.stop();
			dispatchEvent(new Event(SOUND_STOP));
			__playState=0;
			dispatchEvent(new Event(SOUND_STATE));
		}
		public function next():void {
			playId++;
			play();
		}
		public function prev():void {
			playId--;
			play();
		}
		protected function newList(_list:*):void {
			musicList=<root></root>;
			if (_list is Array) {
				for each (var _e:* in _list) {
					musicList.appendChild(<list>{_e}</list>);
				}
			} else if (_list is XMLList) {
				musicList.list=_list;
			} else if (_list is XML) {
				musicList.list=_list.list;
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