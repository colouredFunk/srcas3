package com{
	import flash.events.Event;
	final public class EventParam extends Event {
		private var object:*;
		public function MyEvent(_type:String,_object:*=null) {
			super(_type);
			object=_object;
		}
		public function get param():* {
			return object;
		}
	}
}