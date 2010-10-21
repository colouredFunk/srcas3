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
		protected static var instance:*;
		protected var optionsXMLPath:String;
		protected var isTopAndNoScale:Boolean;
		public var optionsXML:XML;
		public static function getInstance():* {
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
		protected function onInitHandle(_evt:Event):void {
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			if (isTopAndNoScale) {
				stage.align=StageAlign.TOP;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}else {
				stage.align=StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.SHOW_ALL;
			}
			stage.showDefaultContextMenu = false;
			tabChildren = false;
			__widthOrg = loaderInfo.width;
			__heightOrg = loaderInfo.height;
			__flashVars = loaderInfo.parameters;
			paramsObject.width = widthOrg;
			paramsObject.height = heightOrg;
			Common.addContextMenu(this, decodeURI(this.loaderInfo.url).split("/").pop() + ":" + widthOrg + " x " + heightOrg, onWHReleaseHandle);
			//loaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			loaderInfo.addEventListener(Event.COMPLETE,onLoadedHandle);
			if (onLoaded==null) {
				onLoaded=function():void{
					if(currentFrame==1){
						play();
					}
				}
			}
			optionsXMLPath = flashVars.xml || optionsXMLPath;
			if (optionsXMLPath) {
				Common.urlLoader(optionsXMLPath, onOptionsXMLLoadedHandle, onOptionsXMLLoadingHandle,onOptionsXMLLoadErrorHandle);
			}
			addEventListener(Event.ENTER_FRAME,onLoadingHandle);
		}
		protected var paramsObject:Object = { width:0, height:0, flashVars: { }};
		protected function onWHReleaseHandle(_evt:ContextMenuEvent):void {
			if (optionsXMLPath) {
				paramsObject.flashVars.xml = optionsXMLPath;
			}
			var _jsonStr:String = JSON.encode(paramsObject);
			_jsonStr = Common.replaceStr(_jsonStr, '{"', '{');
			_jsonStr = Common.replaceStr(_jsonStr, '":', ':');
			_jsonStr = Common.replaceStr(_jsonStr, ',"', ',');
			_jsonStr = Common.replaceStr(_jsonStr, '"', "'");
			var _url:String = decodeURI(this.loaderInfo.url);
			var _ary:Array = _url.split("/");
			_url = _ary.pop();
			_url = _ary.pop() +"/" + _url;
			var _str:String = "addSWF('" + _url + "'," +_jsonStr + ");";
			
			_str = "<script src='http://www.wanmei.com/public/js/flash.js' type='text/javascript'></script>\r\n\r\n<script type='text/javascript'>\r\n	" + _str;
			_str = _str + "\r\n</script>";
			System.setClipboard(_str);
		}
		public var onLoading:Function;
		public var onLoaded:Function;
		public var loadDelay:Number = 1;
		protected var loaded:Number = 0;
		protected function onLoadingHandle(_evt:*):void{
			gotoAndStop(1);
			var _loaded:Number = loaderInfo.bytesLoaded / getBytesTotal();
			loadingProgress(_loaded);
			if (onLoading != null) {
				onLoading(loaded);
			}
			if (loaded == 1 && onLoaded != null) {
				removeEventListener(Event.ENTER_FRAME, onLoadingHandle);
				onLoaded();
			}
		}
		private var __bytesTotal:int;
		private function getBytesTotal():int {
			if (loaderInfo.bytesTotal) {
				return loaderInfo.bytesTotal;
			}
			return __bytesTotal;
		}
		protected function onLoadedHandle(evt:Event):void{
			//loaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadingHandle);
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadedHandle);
			__bytesTotal = loaderInfo.bytesLoaded;
		}
		protected var loaded_optionsXML:Number = 0;
		protected function onOptionsXMLLoadingHandle(_evt:ProgressEvent):void {
			loaded_optionsXML = int(_evt.bytesLoaded / _evt.bytesTotal * 10000) / 10000;
		}
		protected function onOptionsXMLLoadedHandle(_evt:Event):void {
			optionsXML = XML(_evt.currentTarget.data);
			loaded_optionsXML = 1;
		}
		protected function onOptionsXMLLoadErrorHandle(_evt:IOErrorEvent):void {
			throw new Error ("ERROR:未读取到XML，请检查是否配置正确!");
		}
		protected var optionsXMLPerLoad:Number = 0.1;
		protected function loadingProgress(_loaded:Number):void {
			if (optionsXMLPath) {
				_loaded = _loaded * (1-optionsXMLPerLoad) + loaded_optionsXML * optionsXMLPerLoad;
			}
			var _dV:Number = _loaded - loaded;
			if (_dV > 0.01) {
				loaded += _dV * loadDelay;
			}else {
				loaded = _loaded;
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