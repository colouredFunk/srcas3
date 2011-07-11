package akdcl.interfaces {

	public interface IPlayer extends IMediaProvider {

		function get playlist():IPlaylist;
		function set playlist(_playlist:*):Boolean;

		function get repeatMode():int;
		function set repeatMode(_repeatMode:int):void;

		function get currentIndex():int;
		function set currentIndex(_index:int):void;

		function get currentItem():IPlaylistItem;

		function next():Boolean;
		function prev():Boolean;

		function get playState():String;
		
		function playOrPause():Boolean;
		function playOrStop():Boolean;
	}
}