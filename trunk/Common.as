package {
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	import flash.system.LoaderContext;
	import flash.geom.ColorTransform;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Capabilities;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.URLStream;

	final public class Common {
		//_funLoaded(event:Event):void {event.currentTarget.content as Bitmap;event.currentTarget.loader as Loader};
		public static function loader(_obj:*, _funLoaded:Function = null, _funLoading:Function = null, _funError:Function = null):Loader {
			var _loader:Loader = new Loader();
			if (_funLoaded != null){
				if (_funLoading != null){
					_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _funLoading);
				}
				var _tempLoaded:Function = function(event:Event):void {
					_funLoaded(event);
					if (_funLoading != null){
						_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _funLoading);
					}
					_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _tempLoaded);
				};
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _tempLoaded);
			}
			if (_funError != null){
				var _tempError:Function = function(event:IOErrorEvent):void {
					_funError(event);
					if (_funLoading != null){
						_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _funLoading);
					}
					_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _tempLoaded);
					_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _tempError);
				};
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _tempError);
			}
			if (_obj is ByteArray){
				_loader.loadBytes(_obj);
			} else {
				_loader.load(new URLRequest(_obj), new LoaderContext(true));
			}
			return _loader;
		}
	}
}