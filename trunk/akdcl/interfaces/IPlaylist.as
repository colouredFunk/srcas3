package akdcl.interfaces {

	public interface IPlaylist {

		function insertItem(_item:IPlaylistItem, _index:int = -1):void;

		function getItemAt(_index:int):IPlaylistItem;

		function removeItemAt(_index:int):void;

		function get length():uint;

		function contains(_item:IPlaylistItem):Boolean;

	}
}
