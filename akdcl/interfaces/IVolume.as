package akdcl.interfaces {

	public interface IVolume {
		function get mute():Boolean;
		function set mute(_mute:Boolean):void;

		function get volume():Number;
		function set volume(_volume:Number):void;
	}
}