package akdcl.media {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	/**
	 * ...
	 * @author ...
	 */
	public class ImageProvider extends MediaProvider {
		override public function get loadProgress():Number {
			return playContent ? playContent.loadProgress : 0;
		}

		override public function get totalTime():uint {
			return 5000;
		}

		override public function get position():uint {
			return 0;
		}

		override protected function init():void {
			super.init();
			playContent = new DisplayLoader();
			playContent.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
			playContent.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
			playContent.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
		}

		override public function remove():void {
			playContent.remove();
			super.remove();
		}

		override public function load(_source:String):void {
			super.load(_source);
			playContent.load(_source);
		}

		override public function play(_startTime:int = -1):void {
			super.play(_startTime);
		}

		override public function pause():void {
			super.pause();
		}

		override public function stop():void {
			super.stop();
		}
	}

}