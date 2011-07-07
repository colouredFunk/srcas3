package akdcl.interfaces {

	public interface IPlayer {
		function get playlist():IPlaylist;
		function set playlist(_playlist:*):Boolean;

		function get mute():Boolean;
		function set mute(_mute:Boolean):void;

		function get mute():Boolean;
		function set mute(_mute:Boolean):void;

		function get volume():Number;
		function set volume(_volume:Number):void;

		function get autoPlay():Boolean;
		function set autoPlay(_autoPlay:Boolean):void;

		function get autoRewind():Boolean;
		function set autoRewind(_autoRewind:Boolean):void;

		function get repeat():int;
		function set repeat(_repeat:int):void;

		function play():Boolean;
		function pause():Boolean;
		function stop():Boolean;
		function playOrPause():Boolean;
		function playOrStop():Boolean;
		function next():Boolean;
		function prev():Boolean;

		function get playState():String;

		function seek(_position:Number):Boolean;
	}
}
