package akdcl.manager {
	import flash.display.Stage;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author ...
	 */
	public class MouseManager {
		private static var instance:MouseManager;

		public static function getInstance():MouseManager {
			if (instance){
			} else {
				instance = new MouseManager();
			}
			return instance;
		}

		public function MouseManager(){
			if (instance){
				throw new Error("ERROR:MouseManager Singleton already constructed!");
			}
			instance = this;
		}
		private var stage:Stage;

		public function init(_stage:Stage):void {
			stage = _stage;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUpHandler);
		}

		private function onStageMouseDownHandler(e:MouseEvent):void {
			trace("MOUSE_DOWN", e);
			trace(e.target.name);
		}

		private function onStageMouseUpHandler(e:MouseEvent):void {
			trace("MOUSE_UP", e);
			trace(e.target.name);
		}
	}

}