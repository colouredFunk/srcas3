package akdcl.media {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import akdcl.manager.RequestManager;

	/**
	 * ...
	 * @author ...
	 */
	/// @eventType	flash.events.Event.COMPLETE
	[Event(name = "complete", type = "flash.events.Event")]
	
	public class DisplayLoader extends DisplayRect {
		protected static var rM:RequestManager = RequestManager.getInstance();
		private const eventComplete:Event = new Event(Event.COMPLETE);
		
		public var progressClip:*;
		public var sameChange:Boolean;
		protected var loadProgress:Number = 0;
		public function DisplayLoader(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = -1):void {
			super(_rectWidth, _rectHeight, _bgColor);
			setProgressClip(false);
		}

		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			progressClip = null;
		}

		public function load(_url:String, _tweenMode:int = 2, _alignX:Number = 0.5, _alignY:Number = 0.5, _scaleMode:Number = 1):void {
			if (!sameChange && _url && label == _url) {
				return;
			}
			setContent(null, tweenMode);
			loadProgress = 0;
			label = _url;
			alignXReady = _alignX;
			alignYReady = _alignY;
			scaleModeReady = _scaleMode;
			tweenMode = _tweenMode;
			rM.loadDisplay(_url, onImageHandler, onImageHandler, onImageHandler);
		}

		protected function onImageHandler(_p:*, _url:String = null):void {
			if (_p is IOErrorEvent){
				setProgressClip(false);
			} else if (!_p || _p is ProgressEvent) {
				if (_p) {
					loadProgress = _p.bytesLoaded / _p.bytesTotal;
				}else {
					loadProgress = 1;
				}
				if (isNaN(loadProgress)){
					loadProgress = 0;
				}
				setProgressClip(loadProgress);
			} else {
				setProgressClip(false);
				setContent(_p, tweenMode, alignXReady, alignYReady, scaleModeReady);
				dispatchEvent(eventComplete);
			}
		}
		override protected function showContent():void {
			if (isHidding && loadProgress < 0) {
				
			}else {
				super.showContent();
			}
		}

		protected function setProgressClip(_progress:*):void {
			if (!progressClip){
				return;
			}
			if (_progress is Number){
				progressClip.visible = true;
				if ("text" in progressClip){
					progressClip.text = Math.round(_progress * 100) + " %";
				} else if ("value" in progressClip){
					progressClip.value = _progress;
				} else if (progressClip is MovieClip){
					progressClip.play();
				}
			} else {
				progressClip.visible = _progress;
				if (progressClip is MovieClip){
					if (_progress){
						progressClip.play();
					} else {
						progressClip.stop();
					}
				}
			}
		}
	}

}