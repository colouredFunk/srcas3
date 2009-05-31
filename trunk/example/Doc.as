package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class Doc extends MovieClip {
		public function Doc() {
			init();
		}
		protected function init():void {
			stop();
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,loading);
			loaderInfo.addEventListener(Event.COMPLETE,loaded);
		}
		protected function loading(evt:*):void{
			
		}
		protected function loaded(evt:Event):void{
			play();
		}
	}
}