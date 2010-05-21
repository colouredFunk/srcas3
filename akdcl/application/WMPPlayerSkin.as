package 
{
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class WMPPlayerSkin extends Sprite 
	{
		public static const:Array = ["停止", "暂停", "播放", "向前", "向后", "缓冲", "等待", "完毕", "连接", "就绪"];
		private var btn_play:MovieClip;
		private var btn_vol:MovieClip;
		private var contentPath:String;
		private var contentInfo:Object;
		public var onStateChange:Function;
		public var repeatMode:uint;//0,1,2,3
		public function WMPPlayer() {
			init();
		}
		private function init():Void {
			ExternalInterface.addCallback("playStateChange",$playStateChange);
			btn_vol.change = function(_vol:Number):Void  {
				this._parent.setVolume(_vol);
			};
			btn_play.release = function():Void  {
				if (this.bGray) {
					this.bGray = false;
					return;
				}
				if (this.bSelect) {
					this._parent.pauseContent();
				} else {
					this._parent.playContent();
				}
			};
			$playStateChange(10);
			btn_vol.value = 80;
		}
	public function setContent(_path:String):Void {
		//if(contentPath==_path){
			//return;
		//}
		contentPath=_path;
		//ExternalInterface.call("setContent",contentPath);
		ExternalInterface.call("evalWMP", ".URL=" + contentPath + ";");
	}
	public function playContent(_path:String):Void {
		if(_path){
			setContent(_path);
		}
		ExternalInterface.call("evalWMP",".controls.play();");
		setVolume(volume);
	}
	public function playContentTo(_currentPosition:Number):Void{
		ExternalInterface.call("evalWMP",".controls.currentPosition="+_currentPosition+";");
	}
	public function pauseContent():Void {
		ExternalInterface.call("evalWMP",".controls.pause();");
	}
	public function stopContent():Void {
		ExternalInterface.call("evalWMP",".controls.stop();");
	}
	private var volume:Number;
	public function setVolume(_vol:Number):Void {
		volume=_vol;
		ExternalInterface.call("evalWMP",".settings.volume="+_vol+";");
	}
	public function getContentInfo(_ob:Object):Object {
		return ExternalInterface.call("getContentInfo");
	}
	public function getContentPlaying(_ob:Object):Object {
		return ExternalInterface.call("getContentPlaying");
	}
	private function $playStateChange(_id:Number):Void {
		switch (_id) {
			case 1 :
				//停止
				btn_play.bSelect = false;
				break;
			case 2 :
				//暂停
				btn_play.bSelect = false;
				break;
			case 3 :
				//播放
				contentInfo = getContentInfo();
				btn_play.bGray = false;
				btn_play.bSelect = true;
				break;
			case 4 :
				//向前
				break;
			case 5 :
				//向后
				break;
			case 6 :
				//缓冲
				btn_play.bGray = true;
				break;
			case 7 :
				//等待
				btn_play.bGray = true;
				break;
			case 8 :
				//完毕
				btn_play.bSelect = false;
				switch(repeatMode){
					case 0:
						break;
					case 1:
						playContent();
						break;
					case 2:
						break;
					case 3:
						break;
				}
				break;
			case 9 :
				//连接
				break;
			case 10 :
				//就绪
				btn_play.bGray = false;
				break;
		}
		if (onStateChange!=null) {
			onStateChange(_id);
		}
	}
	}
	
}