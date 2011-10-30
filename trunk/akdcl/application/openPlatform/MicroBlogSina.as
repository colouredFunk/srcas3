package akdcl.application.openPlatform {
	import flash.display.Stage;
	import flash.utils.ByteArray;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	
	import com.adobe.crypto.HMAC;
	import com.adobe.crypto.SHA1;
	import com.dynamicflash.util.Base64;

	import com.sina.microblog.MicroBlog;
	import com.sina.microblog.utils.GUID;
	import com.sina.microblog.utils.StringEncoders;
	import com.sina.microblog.events.MicroBlogErrorEvent;
	import com.sina.microblog.events.MicroBlogEvent;
	
	import akdcl.manager.RequestManager;

	/**
	 * ...
	 * @author akdcl
	 */
	final public class MicroBlogSina extends PlatformAPI {
		
		private static const API_BASE_URL:String = "http://api.t.sina.com.cn";
		private static const OAUTH_REQUEST_TOKEN_REQUEST_URL:String = API_BASE_URL + "/oauth/request_token";
		private static const OAUTH_AUTHORIZE_REQUEST_URL:String = API_BASE_URL + "/oauth/authorize";
		private static const OAUTH_ACCESS_TOKEN_REQUEST_URL:String = API_BASE_URL + "/oauth/access_token";

		private var microBlog:MicroBlog;
		
		override public function get authorized():Boolean {
			return Boolean(accessTokenKey&&accessTokenSecrect);
		}
		
		public function MicroBlogSina(_stage:Stage, _appKey:String, _appSecret:String):void {
			super(_stage, _appKey, _appSecret);
			name = "SinaMicroBlog";
			
			microBlog = new MicroBlog();
			microBlog.source = consumerKey;
			microBlog.consumerKey = consumerKey;
			microBlog.consumerSecret = consumerSecret;
			
			microBlog.addEventListener(MicroBlogEvent.VERIFY_CREDENTIALS_RESULT, onMicroBlogDataHandler);
			microBlog.addEventListener(MicroBlogErrorEvent.VERIFY_CREDENTIALS_ERROR, onMicroBlogErrorHandler);
			microBlog.addEventListener(MicroBlogEvent.UPDATE_STATUS_RESULT, onMicroBlogDataHandler);
			microBlog.addEventListener(MicroBlogErrorEvent.UPDATE_STATUS_ERROR, onMicroBlogErrorHandler);
			
			//logout();
			
			updateShareObject();
		}
		
		override protected function updateShareObject(_logout:Boolean = false):void 
		{
			super.updateShareObject(_logout);
			microBlog.accessTokenKey = accessTokenKey;
			microBlog.accessTokenSecrect = accessTokenSecrect;
		}
		
		override protected function requestAuthorize():void 
		{
			super.requestAuthorize();
			var _data:Object = {};
			_data.oauth_consumer_key = consumerKey;
			_data.oauth_signature_method = "HMAC-SHA1";
			_data.oauth_timestamp = new Date().time.toString().substr(0, 10);
			_data.oauth_nonce = GUID.createGUID();
			_data.oauth_version = "1.0";

			if (accessTokenKey){
				_data.oauth_token = accessTokenKey;
			}
			if (pin){
				_data.oauth_verifier = pin;
				_data.oauth_callback = "oob";
			}else {
				_data.oauth_callback = "http://api.t.sina.com.cn/flash/callback.htm";
			}

			var _urlObj:Object = {};
			_urlObj.data = _data;
			_urlObj.url = pin?OAUTH_ACCESS_TOKEN_REQUEST_URL:OAUTH_REQUEST_TOKEN_REQUEST_URL;
			_urlObj.loadFormat = URLLoaderDataFormat.VARIABLES;
			//
			var _ary:Array = [];
			for (var _i:String in _data){
				if (_data[_i]){
					_ary.push(_i + "=" + StringEncoders.urlEncodeUtf8String(_data[_i].toString()));
				}
			}
			_ary.sort();

			var _str:String = _ary.join("&");
			var _msgStr:String = StringEncoders.urlEncodeUtf8String(URLRequestMethod.POST.toUpperCase()) + "&";
			_msgStr += StringEncoders.urlEncodeUtf8String(_urlObj.url);
			_msgStr += "&";
			_msgStr += StringEncoders.urlEncodeUtf8String(_str);

			var _secrectStr:String = consumerSecret + "&";
			if (pin){
				_secrectStr += accessTokenSecrect;
			}

			var _sig:String = Base64.encode(HMAC.hash(_secrectStr, _msgStr, SHA1));
			//
			_data.oauth_signature = _sig;
			
			RequestManager.getInstance().load(_urlObj, onOauthLoaderHandler, onOauthLoaderHandler);
		}
		
		private function onMicroBlogDataHandler(_e:MicroBlogEvent):void 
		{
			switch(_e.type) {
				case MicroBlogEvent.VERIFY_CREDENTIALS_RESULT:
					removeWebView(true);
					updateShareObject();
					break;
				case MicroBlogEvent.UPDATE_STATUS_RESULT:
					break;
			}
		}
		
		private function onMicroBlogErrorHandler(_e:MicroBlogErrorEvent):void 
		{
			switch(_e.type) {
				case MicroBlogErrorEvent.VERIFY_CREDENTIALS_ERROR:
					removeWebView();
					break;
				case MicroBlogErrorEvent.UPDATE_STATUS_ERROR:
					break;
			}
		}

		private function onOauthLoaderHandler(_dataOrEvent:*):void {
			if (_dataOrEvent is IOErrorEvent) {
				removeWebView();
			}else if (_dataOrEvent) {
				accessTokenKey = _dataOrEvent.oauth_token;
				accessTokenSecrect = _dataOrEvent.oauth_token_secret;
				if (pin) {
					microBlog.accessTokenKey = accessTokenKey;
					microBlog.accessTokenSecrect = accessTokenSecrect;
					microBlog.verifyCredentials();
				} else {
					var _url:String = OAUTH_AUTHORIZE_REQUEST_URL;
					_url += "?oauth_token=" + StringEncoders.urlEncodeUtf8String(accessTokenKey);
					_url += "&oauth_callback=http://api.t.sina.com.cn/flash/callback.htm";
					webView.stage = stage;
					webView.loadURL(_url);
				}
			}
		}
		override protected function onWebViewLocationChangeHandler(_e:Event):void 
		{
			super.onWebViewLocationChangeHandler(_e);
			var _location:String = webView.location;
 
			var _arr:Array = String(_location.split("?")[1]).split("&");
			for (var _i:int = 0; _i < _arr.length; _i++){
				var _str:String = _arr[_i];
				if (_str.indexOf("oauth_verifier=") >= 0){
					pin = _str.split("=")[1];
				}
			}
			if (pin) {
				requestAuthorize();
			}
		}
	}
}