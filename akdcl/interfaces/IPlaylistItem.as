package akdcl.interfaces {

	public interface IPlaylistItem {

		function get loadProgress():Number;

		function get bufferProgress():Number;

		function get totalTime():uint;

		function get playProgress():Number;
		function set playProgress(value:Number):void;

		function get position():uint;
		function set position(_position:uint):void;
	}
}
