package akdcl.interfaces {

	public interface IMediaProvider {

		function play():Boolean;
		function pause():Boolean;
		function stop():Boolean;
		function playOrPause():Boolean;
		function playOrStop():Boolean;

		function get playState():String;
	}
}