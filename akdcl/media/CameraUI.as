package akdcl.media {

	import flash.display.BitmapData;

	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import akdcl.media.CameraProvider;
	import akdcl.media.DisplayRect;
	import akdcl.media.MediaEvent;
	import akdcl.utils.setDisplayWH;

	import ui.Alert;

	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	flash.events.Event.COMPLETE
	[Event(name="complete",type="flash.events.Event")]
	/// @eventType	flash.events.IOErrorEvent.IO_ERROR
	[Event(name="ioError",type="flash.events.IOErrorEvent")]

	public class CameraUI extends UIEventDispatcher {
		private static const CAMERA_WIDTH:uint = 320;
		private static const CAMERA_HEIGHT:uint = 240;

		protected var eventComplete:Event = new Event(Event.COMPLETE);

		protected var cameraP:CameraProvider;
		protected var displayRect:DisplayRect;

		public var data:BitmapData;

		override protected function init():void {
			super.init();
			displayRect = new DisplayRect(CAMERA_WIDTH, CAMERA_HEIGHT, 0);
			displayRect.autoRemove = false;
			displayRect.enabled = false;

			cameraP = new CameraProvider();
			cameraP.addEventListener(MediaEvent.DISPLAY_CHANGE, onCameraChangeHandler);
			cameraP.addEventListener(MediaEvent.LOAD_ERROR, onCameraErrorHandler);
		}

		public function launch():void {
			cameraP.load(null);
		}

		public function setCameraMode(_width:int = 0, _height:int = 0):void {
			cameraP.setCameraMode(_width, _height);
		}

		protected function onCameraErrorHandler(_e:MediaEvent):void {
			if (hasEventListener(IOErrorEvent.IO_ERROR)){
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}
		}

		protected function onCameraChangeHandler(_e:MediaEvent):void {
			displayRect.autoUpdate = false;
			displayRect.rectWidth = cameraP.playContent.width;
			displayRect.rectHeight = cameraP.playContent.height;
			
			setDisplayWH(displayRect, CAMERA_WIDTH, CAMERA_HEIGHT, "rectWidth", "rectHeight");
			
			displayRect.autoUpdate = true;
			displayRect.setContent(cameraP.playContent, 0);

			var _alert:Alert = Alert.show("", "拍照|取消", onAlertHandler);
			_alert.addItem(displayRect);
		}

		protected function onAlertHandler(_b:Boolean):Boolean {
			if (_b){
				if (!data || data.width != cameraP.playContent.width || data.height != cameraP.playContent.height){
					if (data){
						data.dispose();
					}
					data = new BitmapData(cameraP.playContent.width / cameraP.playContent.scaleX, cameraP.playContent.height / cameraP.playContent.scaleY, false, 0);
				}
				data.draw(cameraP.playContent);
				if (hasEventListener(Event.COMPLETE)){
					dispatchEvent(eventComplete);
				}
				cameraP.stop();
				return true;
			} else {
				cameraP.stop();
				return true;
			}
		}
	}

}