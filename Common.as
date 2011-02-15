package {
	import flash.events.*;
	import flash.display.*;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.LocalConnection;
	import flash.net.navigateToURL;
	import flash.net.URLStream;
	import flash.system.LoaderContext;
	import flash.utils.*;
	import flash.geom.ColorTransform;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Capabilities;
	import flash.external.ExternalInterface;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.ui.ContextMenuBuiltInItems;
			
	final public class Common {
		public static function addContextMenu(
			obj:*,
			caption:String,
			onSelect:Function=null
		):ContextMenuItem {
			var menu:ContextMenu = obj?obj.contextMenu:null;
			if(!menu){
				//trace("新建menu");
				menu=new ContextMenu();
				menu.hideBuiltInItems();
			}
			var item:ContextMenuItem=new ContextMenuItem(caption);
			if (onSelect != null) {
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,onSelect);
			}
			menu.customItems.push(item);
			if (obj) {
				obj.contextMenu = menu;
			}
			return item;
		}
		//_eachFun(_instanceCopy, _i, _ary, _length);
		public static function copyInstanceToArray(_instance:*, _length:uint, _ary:Array, _eachFun:Function, ...args):Array {
			if (!_ary) {
				_ary = new Array();
			}
			var _instanceCopy:*;
			var _instanceClass:Class = _instance.constructor as Class;
			for (var _i:uint = 0; _i < _length;_i++ ) {
				_instanceCopy = _ary[_i];
				if (!_instanceCopy) {
					_instanceCopy = new _instanceClass();
					_ary[_i] = _instanceCopy;
				}
				if (_eachFun != null) {
					_eachFun.apply(Common, [_instanceCopy, _i, _ary, _length].concat(args));
				}
			}
			return _ary;
		}
		public static function objectToString(_obj:Object):String {
			var _str:String="";
			for (var _i:String in _obj) {
				_str+=_i+" : "+_obj[_i]+"\n";
			}
			return _str;
		}
		public static function removeFromArray(_a:Array,_ai:*):* {
			var _i:int=_a.indexOf(_ai);
			if (_i>=0) {
				return _a.splice(_i,1);
			}
		}
		public static function getValueString(_value:uint, _dw:uint = 2):String {
			var _str:String = String(_value);
			_dw--;
			var _d:uint = Math.pow(10, _dw);
			if (_value<_d) {
				_value += _d;
				_str = "0" + String(_value).substr(1);
			}
			return _str;
		}
		//将数格式化为时间xx:xx
		public static function formatTime_2(_n:uint):String {
			var minutes:uint;
			var seconds:uint;
			if (_n<60) {
				minutes = 0;
				seconds = _n;
			} else if (_n<3600) {
				minutes = Math.floor(_n/60);
				seconds = _n%60;
			}
			var s_m:String = minutes<10 ? "0"+String(minutes) : String(minutes);
			var s_s:String = seconds<10 ? "0"+String(seconds) : String(seconds);
			return s_m+":"+s_s;
		}
		public static function setRGB(_clip:*, _color:Number):void {
			var _ctf:ColorTransform = _clip.transform.colorTransform;
			_ctf.color = _color;
			_clip.transform.colorTransform = _ctf;
		}
		private static const cmf:ColorMatrixFilter=new ColorMatrixFilter([0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0,0,0,1,0]);
		public static function setGray(_tar:*,_value:Boolean):void {
			if (_value) {
				_tar.filters=null;
				_tar.mouseEnabled=_tar.mouseChildren=true;
			} else {
				_tar.filters=[cmf];
				_tar.mouseEnabled=_tar.mouseChildren=false;
			}
		}
		public static function replaceStr(_strOld:String, _str:String=null, _rep:String=null):String{
			if(!_str){
				_str="\r\n";
				_rep="\r";
			}
			return _strOld.split(_str).join(_rep);
		}
		public static function stringIsTrue(_str:String):Boolean {
			if(!_str||_str==""||_str=="0"||_str==" "||_str=="false"){
				return false;
			}
			return true;
		}
		public static function isValidQQ(_qq:String):Boolean {
			return /\d{5,12}/.test(_qq) || isValidEmail(_qq);
		}
		public static function isValidEmail(_email:String):Boolean {
			var _emailExpression:RegExp =/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+(w+([.-]\w+))*/;
			/////^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return _emailExpression.test(_email);
		}
		//
		public static function playerVersion():int{
			return int(flash.system.Capabilities.version.split(",")[0].split(" ")[1]);
		}
		//
		public static function clone(_source:Object):* {
			var _copy:ByteArray = new ByteArray();
			_copy.writeObject(_source);
			_copy.position = 0;
			return(_copy.readObject());
		}
		//_funLoaded(event:Event):void {event.currentTarget.content as Bitmap;event.currentTarget.loader as Loader};
		public static function loader(_obj:*,_funLoaded:Function=null,_funLoading:Function=null,_funError:Function=null):Loader {
			var _loader:Loader=new Loader();
			if (_funLoaded!=null) {
				if (_funLoading!=null) {
					_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,_funLoading);
				}
				var _tempLoaded:Function=function(event:Event):void{
					_funLoaded(event);
					if(_funLoading!=null){
						_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,_funLoading);
					}
					_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,_tempLoaded);
				};
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,_tempLoaded);
			}
			if(_funError!=null){
				var _tempError:Function=function(event:IOErrorEvent):void{
					_funError(event);
					if(_funLoading!=null){
						_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,_funLoading);
					}
					_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,_tempLoaded);
					_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,_tempError);
				};
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,_tempError);
			}
			if (_obj is ByteArray) {
				_loader.loadBytes(_obj);
			} else {
				_loader.load(new URLRequest(_obj), new LoaderContext(true));
			}
			return _loader;
		}
		//_funLoaded(event:Event):void {event.currentTarget.data}
		public static function urlLoader(_url:String,_funLoaded:Function=null,_funLoading:Function=null,_funError:Function=null,_data:Object=null):URLLoader {
			var _loader:URLLoader=new URLLoader();
			
			if (_funLoaded!=null) {
				if (_funLoading!=null) {
					_loader.addEventListener(ProgressEvent.PROGRESS,_funLoading);
				}
				var _tempLoaded:Function=function(event:Event):void{
					_funLoaded(event);
					if(_funLoading!=null){
						_loader.removeEventListener(ProgressEvent.PROGRESS,_funLoading);
					}
					_loader.removeEventListener(Event.COMPLETE,_tempLoaded);
				};
				_loader.addEventListener(Event.COMPLETE,_tempLoaded);
			}
			if(_funError!=null){
				var _tempError:Function=function(event:IOErrorEvent):void{
					_funError(event);
					if(_funLoading!=null){
						_loader.removeEventListener(ProgressEvent.PROGRESS,_funLoading);
					}
					_loader.removeEventListener(Event.COMPLETE,_tempLoaded);
					_loader.removeEventListener(IOErrorEvent.IO_ERROR,_tempError);
				};
				_loader.addEventListener(IOErrorEvent.IO_ERROR,_tempError);
			}
			var _request:URLRequest=new URLRequest(_url);
			if (_data) {
				//_loader.dataFormat=URLLoaderDataFormat.VARIABLES;
				var _urlVariables:URLVariables=new URLVariables();
				for(var _i:String in _data){
					_urlVariables[_i] = _data[_i];
				}
				_request.data=_urlVariables;
				_request.method=URLRequestMethod.POST;
			}
			_loader.load(_request);
			return _loader;
		}//_funLoaded(event:Event):void {event.currentTarget.data}
		public static function urlStream(_url:String,_funLoaded:Function=null,_funLoading:Function=null,_funError:Function=null):URLStream {
			var _stream:URLStream=new URLStream();
			//_loader.dataFormat=URLLoaderDataFormat.BINARY;
			if (_funLoaded!=null) {
				if (_funLoading!=null) {
					_stream.addEventListener(ProgressEvent.PROGRESS,_funLoading);
				}
				var _tempLoaded:Function=function(event:Event):void{
					_funLoaded(event);
					if(_funLoading!=null){
						_stream.removeEventListener(ProgressEvent.PROGRESS,_funLoading);
					}
					_stream.removeEventListener(Event.COMPLETE,_tempLoaded);
				};
				_stream.addEventListener(Event.COMPLETE,_tempLoaded);
			}
			if(_funError!=null){
				var _tempError:Function=function(event:IOErrorEvent):void{
					_funError(event);
					if(_funLoading!=null){
						_stream.removeEventListener(ProgressEvent.PROGRESS,_funLoading);
					}
					_stream.removeEventListener(Event.COMPLETE,_tempLoaded);
					_stream.removeEventListener(IOErrorEvent.IO_ERROR,_tempError);
				};
				_stream.addEventListener(IOErrorEvent.IO_ERROR,_tempError);
			}
			_stream.load(new URLRequest(_url));
			return _stream;
		}
		public static var call:Function = ExternalInterface.call;
		public static function getPageHREF():String {
			var _href:String;
			if (ExternalInterface.available) {
				_href = ExternalInterface.call("eval", "window.location.href");
			}
			return _href;
		}
		public static function getURLByXMLNode(_xml:*, _data:Object = null, _hrefKey:String = "href", _jsKey:String = "js", _targetKey:String = "target"):void {
			if (_xml is XMLList) {
				_xml = _xml[0];
			}else if (!(_xml is XML)) {
				throw Error("ERROR:need XML Source");
			}
			var _href:String = String(_xml.attribute(_hrefKey));
			if (_href) {
				getURL(_href, String(_xml.attribute(_targetKey)||"_blank"), _data);
				return;
			}
			var _js:String = String(_xml.attribute(_jsKey));
			if (_js&&ExternalInterface.available) {
				ExternalInterface.call("eval", _js);
			}
		}
		public static function getURL(_url:String, _target:String="_blank", _data:Object = null):void {
			var _request:URLRequest = new URLRequest(_url);
			if(_data){
				var _urlVariables:URLVariables = new URLVariables();
				for(var _i:String in _data){
					_urlVariables[_i] = _data[_i];
				}
				_request.data = _urlVariables;
				_request.method = URLRequestMethod.POST;
				navigateToURL(_request, _target);
				return;
			}
			var WINDOW_OPEN_FUNCTION:String = "window.open";
			var _browserName:String = getBrowserName();
			var _features:String = "";
			switch(_browserName) {
				case "Firefox":
				case "IE":
					if (ExternalInterface.available) {
						ExternalInterface.call(WINDOW_OPEN_FUNCTION, _url, _target, "");
					}else {
						navigateToURL(_request,_target);
					}
					break;
				case "Safari":
				case "Opera":
					navigateToURL(_request,_target);
					break;
				default:
					navigateToURL(_request,_target);
					break;
			}
		}
		public static function getBrowserName():String
		{
			var _browserName:String;
			var _browserAgent:String;
			if (ExternalInterface.available) {
				_browserAgent = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
			}
			if (_browserAgent) {
				if (_browserAgent.indexOf("Firefox") >= 0) {
					_browserName = "Firefox";
				}else if (_browserAgent.indexOf("Safari") >= 0) {
					_browserName = "Safari";
				}else if (_browserAgent.indexOf("MSIE") >= 0) {
					_browserName = "IE";
				}else if (_browserAgent.indexOf("Opera") >= 0) {
					_browserName = "Opera";
				}else {
					_browserName = "Unknown";
				}
			}else {
				//_browserName = "undefined";
			}
			return _browserName;
		}
		public static function garbageCallback():void {
			try {
				new LocalConnection().connect("GC");
				new LocalConnection().connect("GC");
			} catch (error:Error) {
			}
		}
	}
}