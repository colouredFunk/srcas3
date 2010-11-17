package akdcl.events {
	import flash.events.Event;
	/**
	 * ...
	 * @author Akdcl
	 */
	/// @eventType	akdcl.events.MediaEvent.VOLUME_CHANGE
	[Event(name = "volumeChange", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.STATE_CHANGE
	[Event(name = "stateChange", type = "akdcl.events.MediaEvent")]
	
	/// @eventType	akdcl.events.MediaEvent.PLAY_ID_CHANGE
	[Event(name = "playIDChange", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.PLAY_PROGRESS
	[Event(name = "playProgress", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.PLAY_COMPLETE
	[Event(name = "playComplete", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.LOAD_PROGRESS
	[Event(name = "loadProgress", type = "akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.LOAD_ERROR
	[Event(name = "loadError", type = "akdcl.events.MediaEvent")]
	
	/// @eventType	akdcl.events.MediaEvent.LOAD_COMPLETE
	[Event(name = "loadComplete", type = "akdcl.events.MediaEvent")]
	
	public class MediaEvent extends Event {
		public static const VOLUME_CHANGE : String = "volumeChange";
		public static const STATE_CHANGE : String = "stateChange";
		public static const PLAY_ID_CHANGE : String = "playIDChange";
		public static const PLAY_PROGRESS : String = "playProgress";
		public static const PLAY_COMPLETE : String = "playComplete";
		public static const LOAD_PROGRESS : String = "loadProgress";
		public static const LOAD_ERROR : String = "loadError";
		public static const LOAD_COMPLETE : String = "loadComplete";
		public function MediaEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void {
			super(type, bubbles, cancelable);
		}
	}
	
}