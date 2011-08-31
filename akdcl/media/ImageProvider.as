package akdcl.media {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author ...
	 */
	final public class ImageProvider extends MediaProvider {
		override public function get loadProgress():Number {
			return playContent ? playContent.loadProgress : 0;
		}

		override public function get totalTime():uint {
			return 5000;
		}

		override public function get position():uint {
			return 0;
		}
		
		public function set container(_container:DisplayObjectContainer):void {
			if (_container) {
				if (playContent) {
					_container.addChild(playContent);
				}
			}else {
				if (playContent && playContent.parent) {
					playContent.parent.removeChild(playContent);
				}
			}
		}
		
		public function updateRect(_rect:Rectangle = null):void {
			if (_rect) {
				playContent.x = _rect.x;
				playContent.y = _rect.y;
				playContent.areaRect.width = _rect.width;
				playContent.areaRect.height = _rect.height;
				playContent.updateRect();
			}
		}

		override protected function init():void {
			super.init();
			playContent = new DisplayLoader();
			playContent.autoRemove = false;
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
	}

}