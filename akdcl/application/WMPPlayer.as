package akdcl.application{
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;
	import akdcl.application.MediaPlayer;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class WMPPlayer extends MediaPlayer {
		public static const WMPPLAYER_JS:XML =<script><![CDATA[
			if(!pwrd){var pwrd={};}
			if(!pwrd.wmpPlayer){pwrd.wmpPlayer={};pwrd.wmpPlayer.player={};pwrd.wmpPlayer.swf={};pwrd.wmpPlayer.mediaLast={};pwrd.wmpPlayer.listener={};}
			pwrd.wmpPlayer.createWMPContainer=function(){
				if(pwrd.wmpPlayer.playerContainer){return;}
				var _wmpContainer=document.createElement("div");
				_wmpContainer.style.height=_wmpContainer.style.width=0;
				_wmpContainer.style.overflow="hidden";
				document.body.appendChild(_wmpContainer);
				pwrd.wmpPlayer.playerContainer=_wmpContainer;
			}
			pwrd.wmpPlayer.getPlayerID=function(_swfID){
				return _swfID+"_wmp";
			}
			pwrd.wmpPlayer.getPlayer=function(_swfID){
				return pwrd.wmpPlayer.player[pwrd.wmpPlayer.getPlayerID(_swfID)];
			}
			pwrd.wmpPlayer.createWMPPlayer=function(_swfID, _listener){
				var _wmpPlayerID=pwrd.wmpPlayer.getPlayerID(_swfID);
				var _object={};
				var _player;
				var _swf=pwrd.getSWFByID(_swfID);
				pwrd.wmpPlayer.swf[_swfID]=_swf;
				_listener=_swf[_listener];
				pwrd.wmpPlayer.listener[_swfID]=_listener;
				switch(pwrd.getBrowserName()){
					case "Firefox":
						pwrd.wmpPlayer.isWMPNow=false;
						_object.id=_wmpPlayerID;
						_object.name=_wmpPlayerID;
						_object.pluginspage="http://microsoft.com/windows/mediaplayer/en/download/";
						_object.type="application/x-mplayer2";
						//_object.type='application/x-ms-wmp';
						_object.showControls=false;
						_object.showstatusbar=false;
						_object.width=0;
						_object.height=0;
						pwrd.wmpPlayer.playerContainer.innerHTML=pwrd.createItem("embed",_object);
						_player=document.getElementById(_wmpPlayerID);
					break;
					default:
						pwrd.wmpPlayer.isWMPNow=true;
						_object.id=_wmpPlayerID;
						_object.width=0;
						_object.height=0;
						_object.classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6";
						_object.param=[
							{name:"uiMode",value:"invisible"},
							{name:"autoStart",value:"true"},
							{name:"enableErrorDialogs",value:"false"}
						];
						pwrd.wmpPlayer.playerContainer.innerHTML=pwrd.createItem("object",_object);
						_player=document.getElementById(_wmpPlayerID);
						if(_player.addEventListener){
							_player.addEventListener('PlayStateChange',_listener,false);
						}else if(_player.attachEvent){
							_player.attachEvent('PlayStateChange',_listener);
						}else{
							_player.PlayStateChange=_listener;
						}
					break;
				}
				pwrd.wmpPlayer.player[_wmpPlayerID]=_player;
				return true;
			}
			pwrd.wmpPlayer.play=function(_swfID,_positionTo){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					if(_positionTo!=0){
						_player.controls.currentPosition=_positionTo;
					}
					_player.controls.play();
				}else{
					_player.src=pwrd.wmpPlayer.mediaLast[_swfID];
					_player.src=pwrd.wmpPlayer.mediaLast[_swfID];
					pwrd.wmpPlayer.listener[_swfID](3);
				}
			}
			pwrd.wmpPlayer.pause=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					_player.controls.pause();
				}else{
					_player.src="";
					_player.src="";
					pwrd.wmpPlayer.listener[_swfID](2);
				}
			}
			pwrd.wmpPlayer.stop=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					_player.controls.stop();
				}else{
					_player.src="";
					_player.src="";
					pwrd.wmpPlayer.listener[_swfID](1);
				}
			}
			pwrd.wmpPlayer.setVolume=function(_swfID,_volume){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					_player.settings.volume=_volume;
				}
			}
			pwrd.wmpPlayer.open=function(_swfID,_mediaSource){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					_player.URL=_mediaSource;
				}else{
					pwrd.wmpPlayer.mediaLast[_swfID]=_mediaSource;
					_player.src=_mediaSource;
					_player.src=_mediaSource;
				}
			}
			pwrd.wmpPlayer.getWMPInfo=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					var _info={};
					var _content=_player.currentMedia;
					_info.title=_content.getItemInfo("Title");
					_info.author=_content.getItemInfo("Author");
					_info.copyright=_content.getItemInfo("Copyright");
					_info.description=_content.getItemInfo("Description");
					_info.fileSize=_content.getItemInfo("FileSize");
					_info.fileType=_content.getItemInfo("FileType");
					_info.sourceURL=_content.getItemInfo("sourceURL");
					_info.duration=_content.getItemInfo("Duration");
					_info.durationString=_content.durationString;
					return _info;
				}
			}
			pwrd.wmpPlayer.getWMPPlayingInfo=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					var _info={};
					_info.positionString=_player.controls.currentPositionString;
					_info.position=_player.controls.currentPosition;
					_info.bufferProgress=_player.network.bufferingProgress;
					_info.loadProgress=_player.network.downloadProgress;
					return _info;
				}
			}
		]]></script>
		public static const WMP_STATE_LIST:Array = ["连接超时", "停止", "暂停", "播放", "向前", "向后", "缓冲", "等待", "完毕", "连接", "就绪", "重新连接"];
		public static var isPlugin:Boolean;
		
		override public function get loadProgress():Number {
			if (isPlugin) {
				var _playingInfo:Object = getWMPPlayingInfo();
				if (_playingInfo) {
					return int(_playingInfo.loadProgress) * 0.01;
				}else {
					return 1;
				}
			}
			return 0;
		}
		override public function get totalTime():uint {
			if (isPlugin && wmpInfo) {
				return wmpInfo.duration * 1000;
			}
			return 0;
		}
		override public function get position():uint {
			if (isPlugin) {
				var _playingInfo:Object = getWMPPlayingInfo();
				if (_playingInfo) {
					return int(_playingInfo.position) * 1000;
				}else {
					return 0;
				}
			}
			return 0;
		}
		override public function set position(value:uint):void {
			if (isPlugin) {
				ExternalInterface.call("pwrd.wmpPlayer.play",swfID, value * 0.001);
			}
		}
		override public function set volume(value:Number):void {
			super.volume = value;
			if (isPlugin) {
				ExternalInterface.call("pwrd.wmpPlayer.setVolume", swfID, volume * 100);
			}
		}
		public var swfID:String;
		protected var wmpInfo:Object;
		public function setJS(_swfID:String):void {
			swfID = _swfID;
			if (swfID && ExternalInterface.available) {
				ExternalInterface.call("eval", PWRDJS.INIT.toString());
				ExternalInterface.call("eval", WMPPLAYER_JS.toString());
				ExternalInterface.call("pwrd.wmpPlayer.createWMPContainer");
				ExternalInterface.addCallback("playStateChange", playStateChange);
				isPlugin = ExternalInterface.call("pwrd.wmpPlayer.createWMPPlayer", swfID, "playStateChange");
			}
		}
		override public function play():Boolean {
			if (playState== STATE_PLAY) {
				return false;
			}
			if (isPlugin) {
				ExternalInterface.call("pwrd.wmpPlayer.play",swfID);
			}
			volume = volume;
			return true;
		}
		override public function pause():Boolean {
			if (playState== STATE_PAUSE) {
				return false;
			}
			if (isPlugin) {
				ExternalInterface.call("pwrd.wmpPlayer.pause",swfID);
			}
			return true;
		}
		override public function stop():Boolean {
			if (playState== STATE_STOP) {
				return false;
			}
			if (isPlugin) {
				ExternalInterface.call("pwrd.wmpPlayer.stop",swfID);
			}
			return true;
		}
		protected function getWMPPlayingInfo():Object {
			if (isPlugin) {
				return ExternalInterface.call("pwrd.wmpPlayer.getWMPPlayingInfo",swfID);
			}
			return null;
		}
		protected function playStateChange(_id:uint, ...args):uint {
			switch (_id) {
				case 0 :
					//连接超时
					setPlayState(MediaPlayer.STATE_CONNECT_TIMEOUT);
					stop();
					setTimeout(play, 300);
					break;
				case 1 :
					//停止
					setPlayState(MediaPlayer.STATE_STOP);
					break;
				case 2 :
					//暂停
					setPlayState(MediaPlayer.STATE_PAUSE);
					break;
				case 3 :
					//播放
					wmpInfo = ExternalInterface.call("pwrd.wmpPlayer.getWMPInfo", swfID);
					addEventListener(Event.ENTER_FRAME, onLoadProgressHander);
					setPlayState(MediaPlayer.STATE_PLAY);
					break;
				case 4 :
					//向前
					break;
				case 5 :
					//向后
					break;
				case 6 :
					//缓冲
					//缓冲时间过长唤醒
					setPlayState(MediaPlayer.STATE_BUFFER);
					break;
				case 7 :
					//等待
					setPlayState(MediaPlayer.STATE_WAIT);
					break;
				case 8 :
					//完毕
					onPlayCompleteHandler();
					break;
				case 9 :
					//连接
					setPlayState(MediaPlayer.STATE_CONNECT);
					break;
				case 10 :
					//就绪
					setPlayState(MediaPlayer.STATE_READY);
					stop();
					setTimeout(play, 300);
					break;
				case 11 :
					//重新连接
					setPlayState(MediaPlayer.STATE_RECONNECT);
					break;
			}
			return _id;
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			wmpInfo = null;
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			super.onPlayIDChangeHandler(_playID);
			stop();
			wmpInfo = null;
			var _mediaSource:String = getMediaByID(_playID);
			if (isPlugin) {
				ExternalInterface.call("pwrd.wmpPlayer.open", swfID, _mediaSource);
			}
			if (autoPlay) {
				play();
			}else {
				stop();
			}
			autoPlay = true;
		}
	}
}