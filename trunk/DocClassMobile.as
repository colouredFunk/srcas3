package {
	import flash.display.MovieClip;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;

	import akdcl.manager.RequestManager;

	/**
	 * ...
	 * @author akdcl
	 */
	public class DocClassMobile extends MovieClip {
		protected static var instanceMap:Object = {};

		public static function getInstance(_key:String = "main"):DocClassMobile {
			var _instance:DocClassMobile;
			_instance = instanceMap[_key];
			return _instance;
		}

		public function DocClassMobile(_key:String = "main"){
			stop();
			if (instanceMap[_key] != null){
				throw new Error("ERROR:DocClassMobile Singleton already constructed!");
			}
			instanceMap[_key] = this;
			loaderInfo.addEventListener(Event.INIT, onInitHandler);
		}

		public var loadDelay:Number = 1;
		public var optionsXML:XML;
		public var onLoading:Function;
		public var onLoaded:Function;

		public var rM:RequestManager;

		protected var loadProgress:Number = 0;
		protected var xmlLoadProgress:Number = 0;
		protected var optionsXMLPath:String;
		protected var optionsXMLPerLoad:Number = 0.1;

		private var isLoadComplete:Boolean;

		protected function onInitHandler(_evt:Event):void {
			if (stage){
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			tabChildren = false;

			rM = RequestManager.getInstance();

			if (onLoaded == null){
				onLoaded = function():void {
					if (currentFrame == 1){
						gotoAndStop(3);
					}
				}
			}
			if (optionsXMLPath){
				rM.load(optionsXMLPath, onXMLLoadedHandler, onXMLErrorHandler, onXMLLoadingHandler);
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
				switch (onLoading.length){
					case 0:
						onLoading();
						break;
					case 1:
					default:
						onLoading(loadProgress);
						break;
				}
			}
			if (loadProgress == 1 && onLoaded != null){
				removeEventListener(Event.ENTER_FRAME, onLoadingHandler);
				switch (onLoaded.length){
					case 0:
						onLoaded();
						break;
					case 1:
					default:
						onLoaded(this);
						break;
				}
			}
		}

		protected function onLoadedHandler():void {

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

		protected function onXMLLoadedHandler(_xml:XML, _url:String):void {
			var _str:String = "ERROR:XML语法错误!\n" + _url;
			if (_xml){
				optionsXML = _xml;
				xmlLoadProgress = 1;
				optionsXMLPath = _url;
			}
		}

		protected function onXMLErrorHandler(_evt:IOErrorEvent, _url:String):void {
			var _str:String;
			if (_evt is IOErrorEvent){
				_str = "ERROR:读取XML失败，请检查XML地址是否正确!\n" + _url;
			} else {
				_str = "ERROR:安全沙箱冲突，无法跨域读取XML!\n" + _url;
			}
		}
	}

}