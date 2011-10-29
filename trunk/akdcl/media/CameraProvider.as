package akdcl.media {
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
		private var camera:Camera;
		private var isCameraAdded:Boolean;

		override protected function init():void {
			super.init();
			camera = Camera.getCamera();
			if (camera) {
				playContent = new Video(camera.width, camera.height);
				playContent.smoothing = true;
			}
		}

		override public function remove():void {
			if (camera){
				camera.removeEventListener(ActivityEvent.ACTIVITY, onCameraHandler);
				camera.removeEventListener(StatusEvent.STATUS, onCameraHandler);
			}
			super.remove();
			playContent = null;
			camera = null;
		}

		override public function load(_item:*):void {
			super.load(null);
			if (camera){
				camera.addEventListener(ActivityEvent.ACTIVITY, onCameraHandler);
				camera.addEventListener(StatusEvent.STATUS, onCameraHandler);
				if (camera.muted && isCameraAdded){
					Security.showSettings(SecurityPanel.PRIVACY);
				}
				playContent.attachCamera(camera);
				isCameraAdded = true;
			} else {
				onLoadErrorHandler();
			}
		}

		override public function play(_startTime:int = -1):void {
			super.play(_startTime);
			if (camera && playContent){
				playContent.attachCamera(camera);
			}
		}

		override public function pause():void {
			super.pause();
			if (playContent){
				playContent.attachCamera(null);
			}
		}

		override public function stop():void {
			super.stop();
			if (playContent){
				playContent.attachCamera(null);
				playContent.clear();
			}
		}
		
		public function setCameraMode(_width:int, _height:int):void 
		{
			camera.setMode(_width, _height, camera.fps);
			//playContent.width = camera.width;
			//playContent.height = camera.height;
		}

		private function onCameraHandler(_evt:* = null):void {
			if (_evt is StatusEvent){
				switch (_evt.code){
					case "Camera.Muted":
						break;
					case "Camera.Unmuted":
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
			dispatchEvent(new MediaEvent(MediaEvent.DISPLAY_CHANGE));
		}

	}
}