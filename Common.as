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
	import flash.utils.*;
	import flash.geom.ColorTransform;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Capabilities;

	public class Common {
		public static var a2r:Number=180/Math.PI;
		public static function randomOne():Number {
			return random(1)>0?1:-1;
		}
		public static function random(_n:int=2):int {
			_n--;
			return Math.round(Math.random()*_n);
		}
		public static function rdm_2(a:Number,b:Number):Number {
			return Math.random()*b-a+a;
		}
		public static function rdm_0(a:Number,l:Number):Number {
			return a-Math.random()*l+l*0.5;
		}
		//_n小于_nMin返回_nMin，大于_nMax返回_nMax，反之返回_n
		public static function numRange(_n:Number,_nMin:Number,_nMax:Number):Number {
			if (_n<_nMin) {
				return _nMin;
			} else if (_n>_nMax) {
				return _nMax;
			}
			return _n;
		}
		public static function objToString(_obj:Object):String {
			var _str:String="";
			for (var _i:String in _obj) {
				_str+=_i+" : "+_obj[_i]+"\n";
			}
			return _str;
		}
		public static function disorderArray(_a:Array):void {
			var _l:uint=_a.length;
			var _ran:uint;
			var _temp:*;
			for (var i:Number=0; i<_l; i++) {
				_ran=random(_l);
				_temp=_a[i];
				_a[i]=_a[_ran];
				_a[_ran]=_temp;
			}
		}
		public static function removeFromArray(_a:Array,_ai:*):* {
			var _i:int=_a.indexOf(_ai);
			if (_i>=0) {
				return _a.splice(_i,1);
			}
		}
		public static function distance(_x0:Number,_y0:Number,_xt:Number,_yt:Number):Number {
			return Math.sqrt(Math.pow(_xt-_x0,2)+Math.pow(_yt-_y0,2));
		}
		//返回矩形区域最小正边长
		public static function side_min(_x0:Number,_y0:Number,_xt:Number,_yt:Number):Number {
			var _nDx:Number=_xt-_x0;
			_nDx<0&&(_nDx=- _nDx);
			var _nDy:Number=_yt-_y0;
			_nDy<0&&(_nDy=- _nDy);
			return Math.min(_nDx,_nDy);
		}
		//返回矩形区域最大正边长
		public static function side_max(_x0:Number,_y0:Number,_xt:Number,_yt:Number):Number {
			var _nDx:Number=_xt-_x0;
			_nDx<0&&(_nDx=- _nDx);
			var _nDy:Number=_yt-_y0;
			_nDy<0&&(_nDy=- _nDy);
			return Math.max(_nDx,_nDy);
		}//返回正常的弧度数
		public static function rFloor(r:Number):Number {
			if (r>=Math.PI) {
				r-=2*Math.PI;
			}
			if (r<=- Math.PI) {
				r+=2*Math.PI;
			}
			return r;
		}
		//small<n<big；-1，0，1
		public static function s_b(n:Number,a:Number,b:Number):int {
			if (a<n&&n<b) {
				return 0;
			} else if (n<=a) {
				return -1;
			} else {
				return 1;
			}
		}
		//|n|>0,t;|n|<0,-t;|n|==0,0
		public static function vpNum(_n:Number,_t:Number=1):Number {
			if (_n==0) {
				return 0;
			} else if (_n>0) {
				return _t;
			} else {
				return - _t;
			}
		}
		//周期为T，振幅为A，相位为P[0，2PI]的函数对应x的y值（默认中心对称）曲线
		public static function trigonometric(x:Number,T:Number,A:Number):Number {
			var _nT:Number=Math.PI/T;
			return A*Math.sin(_nT*x);
		}
		public static function setRGB(_clip:*, _color:Number):void {
			var _ctf:ColorTransform = _clip.transform.colorTransform;
			_ctf.color = _color;
			_clip.transform.colorTransform = _ctf;
		}
		private static const cmf:ColorMatrixFilter=new ColorMatrixFilter([0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0,0,0,1,0]);
		public static function setGray(_tar:Sprite,_value:Boolean):void {
			if (_value) {
				_tar.filters=null;
				_tar.mouseEnabled=_tar.mouseChildren=true;
			} else {
				_tar.filters=[cmf];
				_tar.mouseEnabled=_tar.mouseChildren=false;
			}
		}
		public static function isValidEmail(_email:String):Boolean {
			var _emailExpression:RegExp=/^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return _emailExpression.test(_email);
		}
		public static function encodeStr(_str:String,_type:String="GBK"):String{
			var _byte:ByteArray = new ByteArray();
			_byte.writeMultiByte(_str,_type);
			return String(_byte);
		}
		//
		public static function urlencodeGB2312(str:String):String{
			var result:String ="";
			var byte:ByteArray =new ByteArray();
			byte.writeMultiByte(str,"gb2312");
			for(var i:int;i<byte.length;i++){
				result += escape(String.fromCharCode(byte));
			}
			return result;
		}
		public static function urlencodeBIG5(str:String):String{
			var result:String ="";
			var byte:ByteArray =new ByteArray();
			byte.writeMultiByte(str,"big5");
			for(var i:int;i<byte.length;i++){
				result += escape(String.fromCharCode(byte));
			}
			return result;
		}
		public static function urlencodeGBK(str:String):String{
			var result:String ="";
			var byte:ByteArray =new ByteArray();
			byte.writeMultiByte(str,"gbk");
			for(var i:int;i<byte.length;i++){
				result += escape(String.fromCharCode(byte));
			}
			return result;
		}
		//
		public static function playerVersion():int{
			return int(flash.system.Capabilities.version.split(",")[0].split(" ")[1]);
		}
		public static function hasPara(_xmlList:XMLList,_key:String,_value:*):XML {
			if (_xmlList.length()>0) {
				var _xmlListTemp:XMLList=_xmlList.attribute(_key).contains(_value);
				if (_xmlListTemp.length()>0) {
					return _xmlListTemp[0];
				}
				return null;
			}
			return null;
		}
		//为监听器传递参数
		public static function EventUp(f:Function,... arg):Function {
			return function(e:Event):void{f.apply(null,[e].concat(arg))};
		}
		//_funLoaded(event:Event):void {event.currentTarget.content as Bitmap;event.currentTarget.loader as Loader};
		public static function loader(_obj:*,_funLoaded:Function=null,_funLoading:Function=null,_funError:Function=null):Loader {
			var _loader:Loader=new Loader  ;
			if (_funLoaded!=null) {
				if (_funLoading!=null) {
					//var _tempLoading:Function=function(event:Event):void{
						//_funLoading(event);
					//};
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
				_loader.load(new URLRequest(_obj));
			}
			return _loader;
		}
		//_funLoaded(event:Event):void {event.currentTarget.data}
		public static function urlLoader(_url:String,_funLoaded:Function=null,_funLoading:Function=null,_funError:Function=null):URLLoader {
			var _loader:URLLoader=new URLLoader  ;
			//_loader.dataFormat=URLLoaderDataFormat.BINARY;
			if (_funLoaded!=null) {
				if (_funLoading!=null) {
					//var _tempLoading:Function=function(event:Event):void{
						//_funLoading(event);
					//};
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
			_loader.load(new URLRequest(_url));
			return _loader;
		}//_funLoaded(event:Event):void {event.currentTarget.data}
		public static function urlStream(_url:String,_funLoaded:Function=null,_funLoading:Function=null,_funError:Function=null):URLStream {
			var _stream:URLStream=new URLStream  ;
			//_loader.dataFormat=URLLoaderDataFormat.BINARY;
			if (_funLoaded!=null) {
				if (_funLoading!=null) {
					//var _tempLoading:Function=function(event:Event):void{
						//_funLoading(event);
					//};
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
		public static function getURL(_url:String,_openType:String,_data:Object=null):void {
			var _request:URLRequest=new URLRequest(_url);
			if(_data){
				var _urlVariables:URLVariables=new URLVariables();
				for(var _i:String in _data){
					_urlVariables[_i]=_data[_i];
				}
				_request.data=_urlVariables;
				_request.method=URLRequestMethod.POST;
			}
			navigateToURL(_request,_openType);
		}
		public static function garbageCallback():void {
			try {
				new LocalConnection().connect("DDT");
				new LocalConnection().connect("DDT");
			} catch (error:Error) {
			}
		}
	}
}