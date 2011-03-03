package {
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	import flash.system.LoaderContext;
	import flash.geom.ColorTransform;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Capabilities;
	import flash.external.ExternalInterface;
	
	
	import akdcl.net.gotoURL;
	import akdcl.net.DataLoader;

	final public class Common {
		public static function setRGB(_clip:*, _color:Number):void {
			var _ctf:ColorTransform = _clip.transform.colorTransform;
			_ctf.color = _color;
			_clip.transform.colorTransform = _ctf;
		}
		private static const cmf:ColorMatrixFilter = new ColorMatrixFilter([0.3086000084877014, 0.6093999743461609, 0.0820000022649765, 0, 0, 0.3086000084877014, 0.6093999743461609, 0.0820000022649765, 0, 0, 0.3086000084877014, 0.6093999743461609, 0.0820000022649765, 0, 0, 0, 0, 0, 1, 0]);

		public static function setGray(_tar:*, _value:Boolean):void {
			if (_value){
				_tar.filters = null;
				_tar.mouseEnabled = _tar.mouseChildren = true;
			} else {
				_tar.filters = [cmf];
				_tar.mouseEnabled = _tar.mouseChildren = false;
			}
		}

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
		public static function urlLoader(_url:String, _funLoaded:Function = null, _funLoading:Function = null, _funError:Function = null, _data:Object = null):* {
			return DataLoader.load(_url, _funLoading, _funLoaded, _funError, _data);
		}

		public static function getURLByXMLNode(_xml:*):void {
			gotoURL(_xml);
		}

		public static function getURL(_url:String, _target:String = "_blank", _data:Object = null):void {
			gotoURL(_url, _target, _data);
		}
	}
}