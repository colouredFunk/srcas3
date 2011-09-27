package akdcl.events {
	import flash.events.Event;

	/**
	 * ...
	 * @author ...
	 */
	public class InteractionEvent extends Event {
		public static const ROLL_OVER:String = "interactionRollOver";
		public static const ROLL_OUT:String = "interactionRollOut";
		public static const PRESS:String = "interactionPress";
		public static const RELEASE:String = "interactionPelease";
		public static const RELEASE_OUTSIDE:String = "interactionReleaseOutside";
		public static const DRAG_OVER:String = "interactionDragOver";
		public static const DRAG_OUT:String = "interactionDragOut";
		public static const DRAG_MOVE:String = "interactionDragMove";
		public static const UPDATE_STYLE:String = "interactionUpdateStyle";

		public var isActive:Boolean;
		public function InteractionEvent(_type:String, _isActive:Boolean = false) {
			super(_type, false, false);
			isActive = _isActive;
		}
	}

}