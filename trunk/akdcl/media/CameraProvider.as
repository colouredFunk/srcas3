package akdcl.media {
	import flash.display.DisplayObject;
	import flash.events.ActivityEvent;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Security;
	import flash.system.SecurityPanel;

	import akdcl.media.MediaProvider;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	akdcl.media.MediaEvent.DISPLAY_CHANGE
	[Event(name="displayChange",type="akdcl.media.MediaEvent")]

	final public class CameraProvider extends MediaProvider {
		public var displayContent:DisplayObject;
		private var camera:Camera;
		private var isCameraAdded:Boolean;

		override public function remove():void {
			if (camera){
				camera.removeEventListener(ActivityEvent.ACTIVITY, onCameraHandler);
				camera.removeEventListener(StatusEvent.STATUS, onCameraHandler);
			}
			super.remove();
			playContent = null;
			camera = null;
		}
		
		override protected function loadHandler(_item:*):void {
			//super.loadHandler(_item);
			if (!camera){
				setCameraMode();
			}
			if (camera){
				camera.addEventListener(ActivityEvent.ACTIVITY, onCameraHandler);
				camera.addEventListener(StatusEvent.STATUS, onCameraHandler);
				if (camera.muted && isCameraAdded){
					Security.showSettings(SecurityPanel.PRIVACY);
				}
				playContent.attachCamera(camera);
				playContent.smoothing = true;
			} else {
				onLoadErrorHandler();
			}
		}
		
		override protected function playHandler(_startTime:int = -1):void 
		{
			if (camera && playContent){
				playContent.attachCamera(camera);
				playContent.smoothing = true;
			}
		}
		
		override protected function pauseHandler():void 
		{
			if (playContent){
				playContent.attachCamera(null);
			}
		}
		
		override protected function stopHandler():void 
		{
			if (playContent){
				playContent.attachCamera(null);
				playContent.clear();
			}
		}

		public function setCameraMode(_width:int = 0, _height:int = 0):void {
			camera = Camera.getCamera();
			if (camera){
				camera.setMode(_width || 1280, _height || 960, camera.fps);
				if (playContent){

				} else {
					playContent = new Video(camera.width, camera.height);
				}
				trace("camera:", camera.width, camera.height);
				trace("video:", playContent.width, playContent.height);
			}
		}

		private function onCameraHandler(_evt:* = null):void {
			if (_evt is StatusEvent){
				switch (_evt.code){
					case "Camera.Muted":
						if (!isCameraAdded){
							onLoadErrorHandler();
						}
						isCameraAdded = true;
						break;
					case "Camera.Unmuted":
						isCameraAdded = true;
						break;
					default:
						trace("CameraStatusEvent:" + _evt);
						break;
				}
			} else if (_evt is ActivityEvent){
				onDisplayChange();
				onLoadCompleteHandler();
				if (camera){
					camera.removeEventListener(ActivityEvent.ACTIVITY, onCameraHandler);
				}
			}
		}

		private function onDisplayChange():void {
			//加载显示对象
			//playContent;
			displayContent = playContent;
			if (hasEventListener(MediaEvent.DISPLAY_CHANGE)){
				dispatchEvent(new MediaEvent(MediaEvent.DISPLAY_CHANGE));
			}
		}

	}
}