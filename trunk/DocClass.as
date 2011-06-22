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

	import zero.SWFMetadataGetter;
	import akdcl.net.DataLoader;
	import akdcl.utils.addContextMenu;

	public class DocClass extends MovieClip {
		protected static var instance:*;
		protected var optionsXMLPath:String;
		public var optionsXML:XML;

		public static function getInstance():* {
			return instance;
		}

		public function DocClass(){
			stop();
			if (instance != null){
				throw new Error("ERROR:DocClass Singleton already constructed!");
			}
			instance = this;
			loaderInfo.addEventListener(Event.INIT, onInitHandler);
		}

		protected function onInitHandler(_evt:Event):void {
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			if (stage){
				stage.align = StageAlign.TOP;
				stage.scaleMode = StageScaleMode.SHOW_ALL;
				stage.showDefaultContextMenu = false;
			}
			tabChildren = false;
			__widthOrg = loaderInfo.width;
			__heightOrg = loaderInfo.height;
			flashVars = loaderInfo.parameters;
			paramsObject.width = widthOrg;
			paramsObject.height = heightOrg;
			//decodeURI(this.loaderInfo.url).split("/").pop()
			addContextMenu(this, "size:" + widthOrg + " x " + heightOrg, onWHReleaseHandler);
			//loaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadingHandler);
			loaderInfo.addEventListener(Event.COMPLETE, onLoadedHandler);
			if (onLoaded == null){
				onLoaded = function():void {
					if (currentFrame == 1){
						play();
					}
				}
			}
			optionsXMLPath = flashVars.xml || optionsXMLPath;
			if (optionsXMLPath){
				DataLoader.load(optionsXMLPath, onOptionsXMLLoadingHandler, onOptionsXMLLoadedHandler, onOptionsXMLLoadErrorHandler);
			}
			addEventListener(Event.ENTER_FRAME, onLoadingHandler);
		}
		protected var paramsObject:Object = {};

		protected function onWHReleaseHandler(_evt:ContextMenuEvent):void {
			if (optionsXMLPath){
				paramsObject.xml = optionsXMLPath;
			}

			var _url:String = decodeURI(this.loaderInfo.url);
			var _ary:Array = _url.split("/");
			_url = _ary.pop();
			_url = _ary.pop() + "/" + _url;
			var _str:String = "addSWF('" + _url + "',containerID," + widthOrg + "," + heightOrg + ");";

			_str = "<script src='http://www.wanmei.com/public/js/swfobject.js' type='text/javascript'></script>\r\n\r\n<script type='text/javascript'>\r\n	" + _str;
			_str = _str + "\r\n</script>";
			System.setClipboard(_str);
		}
		public var onLoading:Function;
		public var onLoaded:Function;
		public var loadDelay:Number = 1;
		protected var loaded:Number = 0;

		protected function onLoadingHandler(_evt:*):void {
			gotoAndStop(1);
			var _loaded:Number = loaderInfo.bytesLoaded / getBytesTotal();
			loadingProgress(_loaded);
			if (onLoading != null){
				onLoading(loaded);
			}
			if (loaded == 1 && onLoaded != null){
				removeEventListener(Event.ENTER_FRAME, onLoadingHandler);
				//获取修改时间:
				SWFMetadataGetter.init(this.loaderInfo.bytes);

				var modifyDate:String = SWFMetadataGetter.getModifyDate();
				if (modifyDate){
					modifyDate = modifyDate.split("+")[0];
					var _ary:Array = modifyDate.split("T");
					_ary[0] = _ary[0].split("-");
					_ary[1] = _ary[1].split(":");
					modifyDate = _ary[0][1] + _ary[0][2] + "." + (int(_ary[1][0]) * 60 + int(_ary[1][1]));
					addContextMenu(this, "version:" + _ary[0][0].substr(2, 2) + "." + modifyDate);
				}
				onLoaded();
			}
		}
		private var __bytesTotal:int;

		private function getBytesTotal():int {
			if (loaderInfo.bytesTotal){
				return loaderInfo.bytesTotal;
			}
			return __bytesTotal;
		}

		protected function onLoadedHandler(evt:Event):void {
			//loaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadingHandler);
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadedHandler);
			__bytesTotal = loaderInfo.bytesLoaded;
		}
		protected var loaded_optionsXML:Number = 0;

		protected function onOptionsXMLLoadingHandler(_evt:ProgressEvent):void {
			loaded_optionsXML = int(_evt.bytesLoaded / _evt.bytesTotal * 10000) / 10000;
		}

		protected function onOptionsXMLLoadedHandler(_evt:Event):void {
			optionsXML = XML(_evt.currentTarget.data);
			loaded_optionsXML = 1;
		}

		protected function onOptionsXMLLoadErrorHandler(_evt:IOErrorEvent):void {
			throw new Error("ERROR:未读取到XML，请检查是否配置正确!");
		}
		protected var optionsXMLPerLoad:Number = 0.1;

		protected function loadingProgress(_loaded:Number):void {
			if (optionsXMLPath){
				_loaded = _loaded * (1 - optionsXMLPerLoad) + loaded_optionsXML * optionsXMLPerLoad;
			}
			var _dV:Number = _loaded - loaded;
			if (_dV > 0.01){
				loaded += _dV * loadDelay;
			} else {
				loaded = _loaded;
			}
		}
		private var __widthOrg:int;
		private var __heightOrg:int;

		public function get widthOrg():int {
			return __widthOrg;
		}

		public function get heightOrg():int {
			return __heightOrg;
		}
		private var __flashVars:Object;

		public function set flashVars(_flashVars:Object):void {
			if (loaderInfo.parameters && __flashVars){
				return;
			}
			__flashVars = _flashVars;
		}

		public function get flashVars():Object {
			return __flashVars;
		}
	}
}