package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.FullScreenEvent;
	import flash.events.ContextMenuEvent;
	import flash.events.IOErrorEvent;
	
	import flash.system.Security;
	import flash.system.System;
	
	import com.adobe.serialization.json.JSON;
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
			loaderInfo.addEventListener(Event.INIT, onInitHandle);
		}
		protected function init():void {
			
		}
		protected function onInitHandle(_evt:Event):void {
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.showDefaultContextMenu = false;
			__widthOrg = loaderInfo.width;
			__heightOrg = loaderInfo.height;
			__flashVars = loaderInfo.parameters;
			paramsObject = { };
			paramsObject.width = widthOrg;
			paramsObject.height = heightOrg;
			paramsObject.flashVars = { };
			Common.addContextMenu(this, "SWF:"+widthOrg + " x " + heightOrg, onWHReleaseHandle);
			//loaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			//loaderInfo.addEventListener(Event.COMPLETE,onLoadedHandle);
			onLoaded=function():void{
				if(currentFrame==1){
					play();
				}
			}
			optionsXMLPath = flashVars.xml || optionsXMLPath;
			if (optionsXMLPath) {
				Common.urlLoader(optionsXMLPath, onOptionsXMLLoadedHandle, onOptionsXMLLoadingHandle,onOptionsXMLLoadErrorHandle);
			}
			addEventListener(Event.ENTER_FRAME,onLoadingHandle);
		}
		protected var paramsObject:Object;
		protected function onWHReleaseHandle(_evt:ContextMenuEvent):void {
			if (optionsXMLPath) {
				paramsObject.flashVars.xml = optionsXMLPath;
			}
			var _jsonStr:String = JSON.encode(paramsObject);
			_jsonStr = Common.replaceStr(_jsonStr, '{"', '{');
			_jsonStr = Common.replaceStr(_jsonStr, '":', ':');
			_jsonStr = Common.replaceStr(_jsonStr, ',"', ',');
			_jsonStr = Common.replaceStr(_jsonStr, '"', "'");
			var _url:String = this.loaderInfo.url;
			var _ary:Array = _url.split("/");
			_url = _ary.pop();
			//_url = _ary.pop() +"/" + _url;
			var _str:String = "addSWF('" + _url + "'," +_jsonStr + ");";
			
			_str = "<script src='http://www.wanmei.com/public/js/flash.js' language='JavaScript' type='text/javascript'></script>\n\n<script language='JavaScript' type='text/javascript'>\n	" + _str;
			_str = _str + "\n</script>";
			trace(_str);
			System.setClipboard(_str);
		}
		public var onLoading:Function;
		public var onLoaded:Function;
		public var loadDelay:Number = 1;
		protected var loaded:Number = 0;
		protected function onLoadingHandle(_evt:*):void{
			gotoAndStop(1);
			var _loaded:Number = loaderInfo.bytesLoaded / loaderInfo.bytesTotal;
			loadingProgress(_loaded);
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
			}
			loaded += (_loaded - loaded) * loadDelay;
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