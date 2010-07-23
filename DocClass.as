package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.FullScreenEvent;
	
	import flash.system.Security;
	public class DocClass extends MovieClip {
		private static var instance:DocClass;
		public static function getInstance():DocClass {
			return instance;
		}
		public function DocClass() {
			if (instance) {
				throw new Error ("ERROR:DocClass is a Singleton Class!");
			}
			instance = this;
			init();
		}
		protected function init():void {
			stop();
			__widthOrg=stage.stageWidth;
			__heightOrg=stage.stageHeight;
			__flashVars=stage.loaderInfo.parameters;
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			stage.align=StageAlign.TOP;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu=false;
			//loaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			//loaderInfo.addEventListener(Event.COMPLETE,onLoadedHandle);
			addEventListener(Event.ENTER_FRAME,onLoadingHandle);
			onLoaded=function():void{
				if(currentFrame==1){
					play();
				}
			}
		}
		public var onLoading:Function;
		public var onLoaded:Function;
		public var loadDelay:Number = 1;
		protected var loaded:Number = 0;
		protected function onLoadingHandle(_evt:*):void{
			gotoAndStop(1);
			loadingProgress(loaderInfo.bytesLoaded / loaderInfo.bytesTotal);
			if (onLoading != null) {
				onLoading(loaded);
			}
			if (loaded == 1 && onLoaded != null) {
				removeEventListener(Event.ENTER_FRAME, onLoadingHandle);
				onLoaded();
			}
		}
		protected function loadingProgress(_loaded:Number):void {
			loaded += (_loaded - loaded) * loadDelay;
		}
		/*protected function onLoadedHandle(evt:Event):void{
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			loaderInfo.removeEventListener(Event.COMPLETE,onLoadedHandle);
			if(onLoaded!=null){
				onLoaded();
			}
		}*/
		private var __widthOrg:int;
		private var __heightOrg:int;
		public function get widthOrg():int{
			return __widthOrg;
		}
		public function get heightOrg():int{
			return __heightOrg;
		}
		private var __flashVars:Object;
		public function get flashVars():Object {
			return __flashVars;
		}
		public function get swfVersion():uint{
			return loaderInfo.swfVersion;
		}
	}
}