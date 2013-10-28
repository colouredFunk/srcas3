/***
MP3Player
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月24日 15:53:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.media{
	
	import fl.video.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class MP3Player extends Sprite{
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		
		public var state:String;
		
		public var autoPlay:Boolean;
		public var autoRewind:Boolean;//兼容VideoPlayer
		public var bufferTime:Number;//兼容VideoPlayer
		public var scaleMode:String;//兼容VideoPlayer
		
		private var currPlayheadTime:Number;
		private var isReady:Boolean;
		
		public function MP3Player(){
			volume=1;
		}
		
		public function get bytesLoaded():int{
			return sound.bytesLoaded;
		}
		public function get bytesTotal():int{
			return sound.bytesTotal;
		}
		
		public function get source():String{
			if(sound){
				return sound.url;
			}
			return null;
		}
		public function set source(_source:String):void{
			if(autoPlay){
				play(_source);
			}else{
				load(_source);
			}
		}
		
		public function load(_source:String):void{
			stop();
			initSound(_source);
		}
		
		public function play(_source:String=null):void{
			if(_source){
				stop();
				initSound(_source);
				initSoundChannel(0);
			}else{
				initSoundChannel(currPlayheadTime);
			}
		}
		
		public function stop():void{
			clearSoundChannel();
			clearSound();
			currPlayheadTime=0;
			state=VideoState.STOPPED;
		}
		
		public function close():void{
			stop();
		}
		
		private function updateState(_state:String):void{
			if(state==_state){
			}else{
				state=_state;
				this.dispatchEvent(new VideoEvent(VideoEvent.STATE_CHANGE,false,false,state));
			}
		}
		
		private function initSoundChannel(playheadTime:Number):void{
			soundChannel=sound.play(playheadTime*1000);
			soundChannel.addEventListener(Event.SOUND_COMPLETE,playComplete);
			volume=volume;
		}
		private function clearSoundChannel():void{
			if(soundChannel){
				try{
					soundChannel.stop();
				}catch(e:Error){}
				soundChannel.removeEventListener(Event.SOUND_COMPLETE,playComplete);
				soundChannel=null;
			}
		}
		private function playComplete(...args):void{
			updateState(VideoState.STOPPED);
			this.dispatchEvent(new VideoEvent(VideoEvent.COMPLETE));
			if(autoRewind){
				updateState(VideoState.REWINDING);
			}
		}
		
		private function initSound(_source:String):void{
			isReady=false;
			state=null;
			sound=new Sound(new URLRequest(_source));
			sound.addEventListener(ProgressEvent.PROGRESS,loadSoundProgress);
			sound.addEventListener(Event.COMPLETE,loadSoundComplete);
			sound.addEventListener(IOErrorEvent.IO_ERROR,loadSoundError);
			updateState(VideoState.LOADING);
		}
		private function clearSound():void{
			if(sound){
				try{
					sound.close();
				}catch(e:Error){}
				sound.removeEventListener(ProgressEvent.PROGRESS,loadSoundProgress);
				sound.removeEventListener(Event.COMPLETE,loadSoundComplete);
				sound.removeEventListener(IOErrorEvent.IO_ERROR,loadSoundError);
				sound=null;
			}
		}
		
		private function loadSoundProgress(...args):void{
			_progress(sound.isBuffering);
			this.dispatchEvent(new VideoProgressEvent(VideoProgressEvent.PROGRESS));
		}
		private function loadSoundComplete(...args):void{
			_progress(false);
		}
		private function _progress(isBuffering:Boolean):void{
			if(isBuffering){
				updateState(VideoState.BUFFERING);
			}else{
				if(isReady){
				}else{
					isReady=true;
					this.dispatchEvent(new VideoEvent(VideoEvent.READY));
					if(soundChannel){
						updateState(VideoState.PLAYING);
					}else{
						updateState(VideoState.STOPPED);
					}
				}
			}
		}
		private function loadSoundError(...args):void{
			state=VideoState.CONNECTION_ERROR;
			this.dispatchEvent(new VideoEvent(VideoEvent.STATE_CHANGE,false,false,state));
		}
		
		public function pause():void{
			currPlayheadTime=playheadTime;
			clearSoundChannel();
			state=VideoState.PAUSED;
		}
		
		public function get playheadTime():Number{
			if(soundChannel){
				return soundChannel.position/1000;
			}
			return currPlayheadTime;
		}
		public function set playheadTime(_playheadTime:Number):void{
			currPlayheadTime=playheadTime;
			clearSoundChannel();
			initSoundChannel(currPlayheadTime);
		}
		
		public function get totalTime():Number{
			if(sound){
				if(sound.bytesTotal>0){
					if(sound.bytesLoaded>0){
						return sound.length/1000/sound.bytesLoaded*sound.bytesTotal;
					}
				}
				return 0;
			}
			return NaN;
		}
		
		private var __volume:Number;
		public function get volume():Number{
			return __volume;
		}
		public function set volume(_volume:Number):void{
			__volume=_volume;
			if(soundChannel){
				var soundTransform:SoundTransform=soundChannel.soundTransform;
				soundTransform.volume=__volume;
				soundChannel.soundTransform=soundTransform;
			}
		}
		
		public function setSize(wid:int,hei:int):void{}//兼容VideoPlayer
		
	}
	
}