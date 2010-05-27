package akdcl.application.flvPlayer{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	import flash.geom.Point;

	import flash.events.Event;
	import flash.events.FullScreenEvent;

	import fl.video.FLVPlayback;
	import fl.video.VideoEvent;
	import fl.video.VideoProgressEvent;
	import fl.video.VideoState;
	import com.greensock.TweenMax;
	import akdcl.application.flvPlayer.FLVPlayerSkin;

	public class FLVPlayer extends Sprite{
		public var playerSkin:FLVPlayerSkin;
		public var background:*;
		public var player:FLVPlayback;
		public function FLVPlayer(){
			buttonMode = false;
			playerSkin.player = this;
			
			__videoWidth = player.width;
			__videoHeight = player.height;
			this.addEventListener(Event.ADDED_TO_STAGE, added);
		}
		protected function added(_evt:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, added);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
			if (parent== root) {
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			setStyle();
			setPlayerEvent();
		}
		protected function removed(_evt:Event):void {
			mute = false;
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			player.removeEventListener(VideoProgressEvent.PROGRESS, $progress);
			player.removeEventListener(VideoEvent.READY, $ready);
			player.removeEventListener(VideoEvent.PLAYHEAD_UPDATE, $playheadUpdate);
			player.removeEventListener(VideoEvent.COMPLETE, $complete);
			player.removeEventListener(VideoEvent.STATE_CHANGE, $stateChange);
			if (playerSkin) {
				playerSkin.remove();
				removeChild(playerSkin);
			}
			removeChild(background);
			removeChild(player);
			videoStop();
			viedoClose();
			playerSkin= null;
			background = null;
			player = null;
		}
		protected function setPlayerEvent():void {
			
			player.mouseEnabled = false;
			player.mouseChildren = false;
			player.autoRewind = true;
			player.fullScreenTakeOver = false;
			player.bufferTime = 5;
			
			player.addEventListener(VideoProgressEvent.PROGRESS, $progress);
			player.addEventListener(VideoEvent.READY, $ready);
			player.addEventListener(VideoEvent.PLAYHEAD_UPDATE, $playheadUpdate);
			player.addEventListener(VideoEvent.COMPLETE, $complete);
			player.addEventListener(VideoEvent.STATE_CHANGE, $stateChange);
		}
		protected function $progress(_evt:VideoProgressEvent):void {
			if (playerSkin) {
				playerSkin.progress(_evt.bytesLoaded,_evt.bytesTotal);
			}
			dispatchEvent(_evt);
		}
		protected function $ready(_evt:VideoEvent):void {
			trace(_evt.type);
			if (playerSkin) {
				playerSkin.ready(_evt.playheadTime,player.totalTime);
			}
			dispatchEvent(_evt);
		}
		protected function $playheadUpdate(_evt:VideoEvent):void {
			if (playerSkin) {
				playerSkin.playheadUpdate(_evt.playheadTime,player.totalTime);
			}
			dispatchEvent(_evt);
		}
		protected function $complete(_evt:VideoEvent):void {
			trace(_evt.type);
			switch(repeatMode) {
				case 0:
					player.autoPlay = true;
					break;
				case 1:
					if (playId==listLength-1) {
						player.autoPlay = false;
						playId = 0;
					}else {
						player.autoPlay = true;
						playId++;
					}
					break;
				case 2:
					player.autoPlay = true;
					playId++;
					break;
			}
			dispatchEvent(_evt);
		}
		protected function $stateChange(_evt:VideoEvent):void {
			trace("state: " + _evt.state);
			if (playerSkin) {
				playerSkin.stateChange(_evt.state);
			}
			dispatchEvent(_evt);
			switch(_evt.state) {
				case VideoState.LOADING:
					darkPlayer(true);
					break;
				case VideoState.BUFFERING:
					darkPlayer(true);
					break;
				case VideoState.PLAYING:
					darkPlayer(false);
					break;
				case VideoState.PAUSED:
					darkPlayer(true);
					break;
				case VideoState.SEEKING:
					break;
				case VideoState.REWINDING:
					break;
				case VideoState.STOPPED:
					darkPlayer(true);
					break;
				case VideoState.DISCONNECTED:
					darkPlayer(true);
					break;
				case VideoState.CONNECTION_ERROR:
					darkPlayer(true);
					break;
				case VideoState.RESIZING:
					break;
			}
		}
		private const darkAlpha:Number = 0.5;
		private function darkPlayer(_b:Boolean):void {
			if (_b) {
				TweenMax.to(player, player.alpha-darkAlpha, { alpha:darkAlpha} );
			}else {
				TweenMax.to(player,1-player.alpha,{alpha:1});
			}
		}
		public function get isFullScreen():Boolean{
			return (stage.displayState==StageDisplayState.FULL_SCREEN);
		}
		public function setFullScreen(_isFullScreen:Boolean=false):void {
			if(isFullScreen){
				stage.displayState = StageDisplayState.NORMAL;
			}else{
				if (parent!=root) {
					var _pt:Point = new Point(0,0);
					_pt=localToGlobal(_pt);
					stage.fullScreenSourceRect = new Rectangle(_pt.x, _pt.y, videoWidth,videoHeight);
				}else {
					stage.fullScreenSourceRect = null;
				}
				stage.addEventListener(FullScreenEvent.FULL_SCREEN,fullScreenChange);
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		}
		protected function fullScreenChange(_evt:FullScreenEvent):void{
			if (_evt.fullScreen) {
				if (stage.fullScreenSourceRect == null) {
					setStyle(stage.fullScreenWidth,stage.fullScreenHeight);
				}
			}else{
				setStyle();
				stage.removeEventListener(FullScreenEvent.FULL_SCREEN,fullScreenChange);
			}
		}
		public function setStyle(_width:uint = 0, _height:uint = 0):void {
			background.width=player.width=_width||videoWidth;
			background.height = player.height = _height || videoHeight;
			if (playerSkin) {
				playerSkin.setSize(background.width, background.height);
			}
		}
		protected var videoList:XML;
		public function createList(_list:*):void {
			videoList=<root></root>;
			if(_list is String){
				_list=_list.split("|");
			}
			if (_list is Array) {
				for each (var _e:* in _list) {
					videoList.appendChild(<list>{_e}</list>);
				}
			} else if (_list is XMLList) {
				videoList.list=_list;
			} else if (_list is XML) {
				videoList.list=_list.list;
			}
		}
		public function get listLength():uint{
			return videoList?videoList.list.length():0;
		}
		private var __playId:uint;
		public function get playId():uint{
			return __playId;
		}
		public function get loadedPercentage():Number {
			return player.bytesLoaded / player.bytesTotal;
		}
		public function set playId(_playId:uint):void{
			if (_playId==listLength) {
				_playId=0;
			}else if (_playId>listLength){
				_playId=listLength-1;
			}
			__playId = _playId;
			if (player.playing || player.buffering) {
				videoStop();
			}
			player.source = videoList.list[__playId];
		}
		/*protected var params:XML;
		private function createParams(_ob:*):void{
			params=new XML();
			params.appendChild(<width>_ob.width||width</width>);
			params.appendChild(<height>_ob.height||height</height>);
			
			
			
			params.appendChild(<showBar>_ob.showBar||1</showBar>);//0,1,2,3
			params.appendChild(<glowColor>_ob.glowColor||0x00ff00</glowColor>);
			params.appendChild(<barColor>_ob.barColor||0x000000</barColor>);
			params.appendChild(<barAlpha>_ob.barAlpha||50</barAlpha>);
			params.appendChild(<showTime>_ob.showTime||true</showTime>);
			params.appendChild(<allowFullScreen>_ob.allowFullScreen||true</allowFullScreen>);
			
			//data
			//obData.videoTitle = Common.setParams(container.videoTitle.split("|"),obData.videoTitle, []);
			
			//
		}*/
		public function get state():String {
			return player.state;
		}
		public function get totalTime():uint {
			return player.totalTime;
		}
		private var __videoWidth:uint;
		public function get videoWidth():uint{
			return __videoWidth;
		}
		public function set videoWidth(_videoWidth:uint):void{
			__videoWidth=_videoWidth;
			setStyle();
		}
		private var __videoHeight:uint;
		public function get videoHeight():uint{
			return __videoHeight;
		}
		public function set videoHeight(_videoHeight:uint):void{
			__videoHeight=_videoHeight;
			setStyle();
		}
		public function seekPercent(_value:Number):void {
			_value = Math.min(loadedPercentage*100,_value);
			player.seekPercent(_value);
		}
		private var __repeatMode:uint=1;//0:不播放下一个,1:按顺序播放到尾停止,2:按顺序播放自动回到头停止,3:重复顺序播放
		public function get repeatMode():uint{
			return __repeatMode;
		}
		public function set repeatMode(_repeatMode:uint):void{
			__repeatMode=_repeatMode;
		}
		public function set bufferTime(_bufferTime:uint):void{
			player.bufferTime = _bufferTime;
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
					volumePrev = 0.8;
				}
				volume=volumePrev;
			}
		}
		public function get volume():Number{
			return player.volume;
		}
		public function set volume(_volume:Number):void {
			player.volume = _volume;
			if (playerSkin) {
				playerSkin.updateValue(_volume);
			}
		}
		public function videoPlay(_play:Boolean=false):void{
			if (_play ? false : (player.playing || player.buffering)) {
				player.pause();
			} else {
				player.play();
			}
		}
		public function videoPause():void {
			player.pause();
		}
		public function videoStop():void{
			player.stop();
		}
		public function viedoClose():void {
			try {
				player.closeVideoPlayer(0);
			}catch (_ero:*) {
				
			}
		}
		public function videoPrev():void {
			playId--;
		}
		public function videoNext():void {
			playId++;
		}
		public function playFiles(_list:*,_autoPlay:Boolean=false):void{
			if(!_list){
				return;
			}
			createList(_list);
			playId=0;
			if(_autoPlay){
				videoPlay(true);
			}
			setStyle();
		}
	} 
}