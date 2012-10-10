/***
MusicCtrl
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月16日 11:39:36
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import akdcl.events.MediaEvent;
	import akdcl.manager.ExternalInterfaceManager;
	import akdcl.media.MediaPlayer;
	import akdcl.media.PlayerSkin;
	import akdcl.utils.stringToBoolean;
	
	import com.greensock.TweenNano;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;

	public class MusicCtrl extends Sprite{
		public var player:MediaPlayer;
		public var btnSound:*;
		public var soundView:*;
		
		private var so:SharedObject;
		
		public function MusicCtrl(){
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
		}
		
		public function init(src:String):void{
			
			player=new MediaPlayer();
			player.addEventListener(MediaEvent.STATE_CHANGE, onPlayStateChangeHandler);
			
			//;
			soundView = btnSound.soundView;
			if(soundView){
				soundView.getMove=function():int{
					return player.isPlaying?4:-4;
				};
				soundView.run();
			}
			
			//;
			//player.playlist = "http://10.8.1.44/test.mp3";
			//player.playlist = this.loaderInfo.parameters.mp3;
			player.playlist = src;
			
			btnSound.release = clickBtnSound;
			//DocClass.getInstance().eiM.addEventListener(ExternalInterfaceManager.CALL, onInterfaceCallHandler);
			
			if(ExternalInterface.available){
				ExternalInterface.addCallback("music_play",music_play);
				ExternalInterface.addCallback("music_stop",music_stop);
			}
			
			so=SharedObject.getLocal("musicctrl","/");
			
			if(this.loaderInfo.parameters.on=="false"){
			}else if(ExternalInterface.available){
				if(ExternalInterface.call("eval","musicPlaying")===true){
					player.play();
				}else if(ExternalInterface.call("eval","musicPlaying")===false){
				}else{
					if(so.data.musicPlaying===false){
					}else{
						player.play();
					}
					//throw new Error("so.data.musicPlaying="+so.data.musicPlaying);
				}
			}else{
				if(so.data.musicPlaying===false){
				}else{
					player.play();
				}
				//throw new Error("so.data.musicPlaying="+so.data.musicPlaying);
			}
			
			
			//import zero.net.getPageParams;
			//throw new Error(getPageParams().info);
			
			//bgMusicOn=ctrlOn;
			//bgMusicOff=ctrlOff;
		}
		private function music_play():void{
			 btnSound.selected=true;
			 changePlayerPlay();
		}
		private function music_stop():void{
			 btnSound.selected=false;
			 changePlayerPlay();
		}
		private function ctrlOn():void{
			//trace("so.data.musicPlaying="+so.data.musicPlaying);
			if(so.data.musicPlaying===false){
			}else{
				music_play();
			}
		}
		private function ctrlOff():void{
			music_stop();
		}
		private function clickBtnSound():void{
			changePlayerPlay();
			so.data.musicPlaying=!btnSound.selected;
			//throw new Error("so.data.musicPlaying="+so.data.musicPlaying);
		}
		public function changePlayerPlay():void
		{
			btnSound.selected = ! btnSound.selected;
			if (btnSound.selected)
			{
				TweenNano.to(player,1,{volume:0, onComplete:player.pause});
			}
			else
			{
				player.play();
				var volume:Number=Number(this.loaderInfo.parameters.volume);
				if(volume>=0){
				}else{
					volume=0.6;
				}
				TweenNano.to(player,1,{volume:volume});
			}
		}
		public function onPlayStateChangeHandler(_e:MediaEvent):void
		{
			btnSound.selected = ! player.isPlaying;
		}
		public function onInterfaceCallHandler(_evt:Event):void
		{
			switch (DocClass.getInstance().eiM.eventType)
			{
				case "play" :
					player.play();
					break;
				case "pause" :
					player.pause();
					break;
				case "stop" :
					player.stop();
					break;
				case "next" :
					player.next();
					break;
				case "prev" :
					player.prev();
					break;
				case "setPlaylist" :
					player.playlist = DocClass.getInstance().eiM.eventParams[0];
					break;
				case "setRepeat" :
					player.repeat = int(DocClass.getInstance().eiM.eventParams[0]);
					break;
				case "setPlayID" :
					player.playID = int(DocClass.getInstance().eiM.eventParams[0]);
					break;
				case "setVolume" :
					player.volume = Number(DocClass.getInstance().eiM.eventParams[0]);
					break;
				case "setMute" :
					player.mute = stringToBoolean(DocClass.getInstance().eiM.eventParams[0]);
					break;
			}
		}
	}
}