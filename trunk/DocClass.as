package {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ContextMenuEvent;
	import flash.events.IOErrorEvent;

	import flash.system.Security;
	import flash.system.System;

	import zero.SWFMetadataGetter;
	
	import akdcl.net.DataLoader;
	import akdcl.utils.addContextMenu;
	import akdcl.manager.ExternalInterfaceManager;

	public class DocClass extends MovieClip {
		protected static var instance:*;

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

		public var loadDelay:Number = 1;
		public var optionsXML:XML;
		public var onLoading:Function;
		public var onLoaded:Function;
		
		public var eiM:ExternalInterfaceManager;

		protected var loadProgress:Number = 0;
		protected var xmlLoadProgress:Number = 0;
		protected var optionsXMLPath:String;
		protected var optionsXMLPerLoad:Number = 0.1;

		private var isLoadComplete:Boolean;

		private var __flashVars:Object;

		public function set flashVars(_flashVars:Object):void {
			if (loaderInfo.parameters && __flashVars){
				return;
			}
			__flashVars = _flashVars;
		}

		public function get flashVars():Object {
			return __flashVars || loaderInfo.parameters;
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
			
			eiM = ExternalInterfaceManager.getInstance();
			
			if (onLoaded == null){
				onLoaded = function():void {
					if (currentFrame == 1){
						play();
					}
				}
			}
			optionsXMLPath = flashVars.xml || optionsXMLPath;
			if (optionsXMLPath){
				DataLoader.load(optionsXMLPath, onXMLLoadingHandler, onXMLLoadedHandler, onXMLErrorHandler);
			}
			addEventListener(Event.ENTER_FRAME, onLoadingHandler);
		}

		protected function onLoadingHandler(_evt:*):void {
			gotoAndStop(1);
			var _loaded:Number = (loaderInfo.bytesTotal > 0) ? (loaderInfo.bytesLoaded / loaderInfo.bytesTotal) : loadProgress;
			if (_loaded == 1 && !isLoadComplete){
				isLoadComplete = true;
				onLoadedHandler();
			}
			onLoadingStepFix(_loaded);
			if (onLoading != null){
				onLoading(loadProgress);
			}
			if (loadProgress == 1 && onLoaded != null){
				removeEventListener(Event.ENTER_FRAME, onLoadingHandler);
				onLoaded();
			}
		}

		protected function onLoadedHandler():void {
			SWFMetadataGetter.init(this.loaderInfo.bytes);
			var _modifyDate:String = SWFMetadataGetter.getModifyDate();
			if (_modifyDate){
				_modifyDate = _modifyDate.split("+")[0];
				var _ary:Array = _modifyDate.split("T");
				_ary[0] = _ary[0].split("-");
				_ary[1] = _ary[1].split(":");
				_modifyDate = _ary[0][1] + _ary[0][2] + "." + (int(_ary[1][0]) * 60 + int(_ary[1][1]));
				_modifyDate = " V:" + _ary[0][0].substr(2, 2) + "." + _modifyDate;
			}else {
				_modifyDate = "";
			}
			
			addContextMenu(
				this, 
				"S:" + loaderInfo.width + "x" + loaderInfo.height + _modifyDate,
				onWHReleaseHandler
			);
			
			eiM.dispatchSWFEvent("LoadComplete");
		}

		protected function onLoadingStepFix(_loaded:Number):void {
			if (optionsXMLPath){
				_loaded = _loaded * (1 - optionsXMLPerLoad) + xmlLoadProgress * optionsXMLPerLoad;
			}
			var _dV:Number = _loaded - loadProgress;
			if (_dV > 0.01){
				loadProgress += _dV * loadDelay;
			} else {
				loadProgress = _loaded;
			}
		}

		protected function onXMLLoadingHandler(_evt:ProgressEvent):void {
			xmlLoadProgress = (_evt.bytesTotal > 0) ? (_evt.bytesLoaded / _evt.bytesTotal) : xmlLoadProgress;
		}

		protected function onXMLLoadedHandler(_evt:Event):void {
			optionsXML = XML(_evt.currentTarget.data);
			xmlLoadProgress = 1;
		}

		protected function onXMLErrorHandler(_evt:IOErrorEvent):void {
			if (eiM.isAvailable) {
				eiM.debugMessage("未读取到XML，请检查是否配置正确!");
			}else {
				throw new Error("ERROR:未读取到XML，请检查是否配置正确!");
			}
			
		}

		protected function onWHReleaseHandler(_evt:ContextMenuEvent):void {
			var _url:String = decodeURI(this.loaderInfo.url);
			var _ary:Array = _url.split("/");
			_url = _ary.pop();
			_url = _ary.pop() + "/" + _url;
			var _str:String = "addSWF('" + _url + "','containerID'," + loaderInfo.width + "," + loaderInfo.height + ");";
			_str = "<script src='http://www.wanmei.com/public/js/swfobject.js' type='text/javascript'></script>\r\n\r\n<script type='text/javascript'>\r\n	" + _str;
			_str = _str + "\r\n</script>";
			System.setClipboard(_str);
		}
	}
}