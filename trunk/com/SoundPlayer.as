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
		public static var SOUND_PROGRESS:String="soundProgress";
		public static var SOUND_COMPLETE:String="soundComplete";
		public static var COMPLETE:String="complete";
		public function SoundPlayer() {
			
		}
		protected var __isPlaying:Boolean;
		public function get isPlaying():Boolean {
			return __isPlaying;
		}
		protected var __playId:uint;
		public function get playId():uint{
			return __playId;
		}
		public function set playId(_playId:uint):void{
			trace(_playId);
			if (_playId==musicList.list.length()) {
				_playId=0;
			}else if (_playId>musicList.list.length()){
				_playId=musicList.list.length()-1;
			}
			__playId=_playId;
			stop();
			if (sound) {
				sound.removeEventListener(ProgressEvent.PROGRESS,$soundProgress);
				sound.removeEventListener(Event.COMPLETE,$complete);
			}
			position=0;
			sound=new Sound();
			sound.addEventListener(ProgressEvent.PROGRESS,$soundProgress);
			sound.addEventListener(Event.COMPLETE,$complete);
			sound.load(new URLRequest(musicList.list[playId]));
		}
		public function autoPlay():Boolean{
			if (isPlaying) {
				pause();
			}else{
				play();
			}
			return isPlaying;
		}
		public function play():void {
			if (isPlaying) {
				return;
			}
			if (soundChannel) {
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE,$soundComplete);
			}
			soundChannel=sound.play(position);
			soundChannel.addEventListener(Event.SOUND_COMPLETE,$soundComplete);
			__isPlaying=true;
			dispatchEvent(new Event(SOUND_START));
		}
		public function pause():void {
			if (! isPlaying) {
				return;
			}
			position=soundChannel.position;
			soundChannel.stop();
			__isPlaying=false;
			dispatchEvent(new Event(SOUND_PAUSE));
		}
		public function stop():void {
			if (! isPlaying) {
				return;
			}
			position=0;
			soundChannel.stop();
			__isPlaying=false;
			dispatchEvent(new Event(SOUND_STOP));
		}
		public function next():void {
			playId++;
			play();
		}
		public function prev():void {
			playId--;
			play();
		}
		public function attachMusic(_musicList:String):void {
			newList(_musicList.split("|"));
			playId=0;
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
		protected function $soundProgress(_evt:ProgressEvent):void {
			dispatchEvent(new Event(SOUND_PROGRESS));
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
					
					break;
			}
			dispatchEvent(new Event(SOUND_COMPLETE));
		}
	}
}