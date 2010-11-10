package akdcl.application.interfaces {
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public interface IMediaPlayer  {
		//0~1
		public function get loadProgress():Number;
		//0~1
		public function get playProgress():Number;
		public function set playProgress(_progress:Number):Number;
		//毫秒为单位
		public function get position():uint;
		public function set position(_position:uint):void;
		//毫秒为单位
		public function get totalTime():uint;
		//
		public function get playID():int;
		public function set PlayID(_playID:int):void;
		//
		public function get mute():Boolean;
		public function set mute(_mute:Boolean):void;
		//0~1
		public function get volume():Number;
		public function set volume(_volume:Number):void;
		
		//
		public function play():void;
		public function pause():void;
		public function stop():void;
		public function playOrPause():void;
		public function playOrStop():void;
		public function next():void;
		public function prev():void;
		//毫秒为单位
		public function playTo(_position:uint=0):void {
			
		}
	}
	
}