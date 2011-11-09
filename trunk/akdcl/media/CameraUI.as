package akdcl.media {

	import flash.display.BitmapData;
	import flash.events.Event;

	import akdcl.media.CameraProvider;
	import akdcl.media.DisplayRect;
	import akdcl.media.MediaEvent;

	import ui.Alert;

	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	flash.events.Event.CANCEL;
	[Event(name="cancel",type="flash.events.Event")]
	/// @eventType	akdcl.media.MediaEvent.LOAD_COMPLETE
	[Event(name="loadComplete",type="akdcl.media.MediaEvent")]
	/// @eventType	akdcl.media.MediaEvent.LOAD_ERROR;
	[Event(name="loadError",type="akdcl.media.MediaEvent")]

	public class CameraUI extends UIEventDispatcher {

		protected var eventCancel:Event = new Event(Event.CANCEL);
		protected var eventComplete:Event = new MediaEvent(MediaEvent.LOAD_COMPLETE);

		protected var cameraP:CameraProvider;
		protected var displayRect:DisplayRect;

		public var data:BitmapData;

		override protected function init():void {
			super.init();
			displayRect = new DisplayRect(320, 240, 0);
			displayRect.autoRemove = false;
			displayRect.enabled = false;

			cameraP = new CameraProvider();
			cameraP.addEventListener(MediaEvent.DISPLAY_CHANGE, onCameraChangeHandler);
			cameraP.addEventListener(MediaEvent.LOAD_ERROR, onCameraErrorHandler);
			data = new BitmapData(cameraP.playContent.width, cameraP.playContent.height, false, 0);
		}

		public function launch():void {
			cameraP.load(null);
			trace(1);
		}

		protected function onCameraErrorHandler(_e:MediaEvent):void {
			if (hasEventListener(_e.type)){
				dispatchEvent(_e);
			}
		}

		protected function onCameraChangeHandler(_e:MediaEvent):void {
			displayRect.setContent(cameraP.playContent, 0);

			var _alert:Alert = Alert.show("", "拍照|取消", onAlertHandler);
			_alert.barWidth = 350;
			_alert.barHeight = 270 + 30;
			_alert.addChild(displayRect);
			displayRect.x = 15;
			displayRect.y = 15;
		}

		protected function onAlertHandler(_b:Boolean):Boolean {
			if (_b){
				data.draw(cameraP.playContent);
				if (hasEventListener(MediaEvent.LOAD_COMPLETE)){
					dispatchEvent(eventComplete);
				}
				return true;
			} else {
				if (hasEventListener(Event.CANCEL)){
					dispatchEvent(eventCancel);
				}
				return true;
			}
		}
	}

}