package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.IOErrorEvent;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.FullScreenEvent;
	
	import flash.system.Security;
	public class DocClass extends MovieClip {
		protected static var instance:DocClass;
		protected var optionsXMLPath:String;
		public var optionsXML:XML;
		public static function getInstance():DocClass {
			return instance;
		}
		public function DocClass() {
			stop();
			if (instance != null) {
				throw new Error ("ERROR:DocClass Singleton already constructed!");
			}
			instance = this;
			addEventListener(Event.ENTER_FRAME, onDelayFrameHandle);
		}
		private function onDelayFrameHandle(_evt:Event):void {
			init();
			removeEventListener(Event.ENTER_FRAME, onDelayFrameHandle);
		}
		private var isInit:Boolean;
		protected function init(_optionsXMLPath:String = ""):void {
			if (isInit) {
				return;
			}
			isInit = true;
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
			optionsXMLPath = flashVars.xml || _optionsXMLPath;
			if (optionsXMLPath) {
				Common.urlLoader(optionsXMLPath, onOptionsXMLLoadedHandle, onOptionsXMLLoadingHandle,onOptionsXMLLoadErrorHandle);
			}
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
		/*protected function onLoadedHandle(evt:Event):void{
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			loaderInfo.removeEventListener(Event.COMPLETE,onLoadedHandle);
			if(onLoaded!=null){
				onLoaded();
			}
		}*/
		protected var loaded_optionsXML:Number = 0;
		protected function onOptionsXMLLoadingHandle(_evt:ProgressEvent):void {
			loaded_optionsXML = int(_evt.bytesLoaded / _evt.bytesTotal * 1000) * 0.001;
		}
		protected function onOptionsXMLLoadedHandle(_evt:Event):void {
			optionsXML = XML(_evt.currentTarget.data);
			loaded_optionsXML = 1;
		}
		protected function onOptionsXMLLoadErrorHandle(_evt:IOErrorEvent):void {
			throw new Error ("ERROR:未读取到XML，请检查是否配置正确!");
		}
		protected function loadingProgress(_loaded:Number):void {
			if (optionsXMLPath) {
				_loaded = _loaded * 0.9 + loaded_optionsXML * 0.1;
				loaded += (_loaded - loaded) * loadDelay;
			}else {
				loaded += (_loaded - loaded) * loadDelay;
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