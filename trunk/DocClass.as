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
			//this.addEventListener(FullScreenEvent.FULL_SCREEN,$onFullScreen);
			//this.loaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			//this.loaderInfo.addEventListener(Event.COMPLETE,onLoadedHandle);
			this.addEventListener(Event.ENTER_FRAME,onLoadingHandle);
			onLoaded=function():void{
				if(this.currentFrame==1){
					play();
				}
			}
		}
		public var onLoading:Function;
		protected var loadedPct:Number;//0~1
		protected function onLoadingHandle(evt:*):void{
			var _loaded:Number=loaderInfo.bytesLoaded/loaderInfo.bytesTotal;
			if(onLoading!=null){
				onLoading(_loaded);
			}
			loadedPct=_loaded;
			if(_loaded==1&&onLoaded!=null){
				this.removeEventListener(Event.ENTER_FRAME,onLoadingHandle);
				onLoaded();
			}
		}
		public var onLoaded:Function;
		protected function onLoadedHandle(evt:Event):void{
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			loaderInfo.removeEventListener(Event.COMPLETE,onLoadedHandle);
			if(onLoaded!=null){
				onLoaded();
			}
		}
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