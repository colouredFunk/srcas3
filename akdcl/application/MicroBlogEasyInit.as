package akdcl.application {
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.net.SharedObject;
	
	import flash.media.StageWebView;
	
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
	public class MicroBlogEasyInit {
		public static const SINA_MICRO_BLOG_DATA:String = "sinaMicroBlogData";
		
		private static const API_BASE_URL:String = "http://api.t.sina.com.cn";
		private static const OAUTH_REQUEST_TOKEN_REQUEST_URL:String = API_BASE_URL + "/oauth/request_token";
		private static const OAUTH_AUTHORIZE_REQUEST_URL:String = API_BASE_URL + "/oauth/authorize";
		private static const OAUTH_ACCESS_TOKEN_REQUEST_URL:String = API_BASE_URL + "/oauth/access_token";

		public var microBlog:MicroBlog;
		public var onLogin:Function;
		
		private var shareObject:SharedObject;
		private var stage:Stage;
		private var webView:StageWebView;
		
		private var consumerKey:String = "0000000000";
		private var consumerSecret:String = "00000000000000000000000000000000";
		private var pin:String = "";
		
		public function get isLogin():Boolean {
			return Boolean(microBlog.accessTokenKey && microBlog.accessTokenSecrect);
		}

		public function MicroBlogEasyInit(_stage:Stage, _appKey:String, _appSecret:String):void {
			stage = _stage;
			consumerKey = _appKey;
			consumerSecret = _appSecret;
			
			shareObject = SharedObject.getLocal(SINA_MICRO_BLOG_DATA);
			
			webView = new StageWebView();
			webView.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			webView.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			
			microBlog = new MicroBlog();
			microBlog.source = consumerKey;
			microBlog.consumerKey = consumerKey;
			microBlog.consumerSecret = consumerSecret;
			microBlog.addEventListener(MicroBlogEvent.VERIFY_CREDENTIALS_RESULT, onVerifyCredentialHandler);
			microBlog.addEventListener(MicroBlogErrorEvent.VERIFY_CREDENTIALS_ERROR, onVerifyCredentialHandler);
			
			var _consumer:Object = shareObject.data[consumerKey];
			if (_consumer && _consumer.key && _consumer.secret) {
				microBlog.accessTokenKey = _consumer.key;
				microBlog.accessTokenSecrect = _consumer.secret;
			}
		}
		
		public function setAccessToken(_key:String, _secret:String):void {
			microBlog.accessTokenKey = _key;
			microBlog.accessTokenSecrect = _secret;
			updateShareObject();
		}
		
		public function login():void {
			if (microBlog.accessTokenKey && microBlog.accessTokenSecrect) {
				
			}else {
				requestAuthorize(OAUTH_REQUEST_TOKEN_REQUEST_URL);
			}
		}
		
		public function logout():void {
			microBlog.accessTokenKey = "";
			microBlog.accessTokenSecrect = "";
			delete shareObject.data[consumerKey];
			//microBlog.logout();
		}
		
		private function updateShareObject():void {
			shareObject.data[consumerKey] = { 
				key:microBlog.accessTokenKey, 
				secret:microBlog.accessTokenSecrect
			};
			shareObject.flush();
		}

		private function requestAuthorize(_url:String):void {
			var _data:Object = {};
			_data.oauth_consumer_key = consumerKey;
			_data.oauth_signature_method = "HMAC-SHA1";
			_data.oauth_timestamp = new Date().time.toString().substr(0, 10);
			_data.oauth_nonce = GUID.createGUID();
			_data.oauth_version = "1.0";

			if (microBlog.accessTokenKey){
				_data.oauth_token = microBlog.accessTokenKey;
			}
			if (pin){
				_data.oauth_verifier = pin;
				_data.oauth_callback = "oob";
			}else {
				_data.oauth_callback = "http://api.t.sina.com.cn/flash/callback.htm";
			}

			var _urlObj:Object = {};
			_urlObj.data = _data;
			_urlObj.url = _url;
			_urlObj.loadFormat = URLLoaderDataFormat.VARIABLES;
			_data.oauth_signature = getOauthSignature(_data, _urlObj.url);
			RequestManager.getInstance().load(_urlObj, onOauthLoaderHandler, onOauthLoaderHandler);
		}

		private function getOauthSignature(_data:Object, _url:String):String {
			var _ary:Array = [];
			for (var _i:String in _data){
				if (_data[_i]){
					_ary.push(_i + "=" + StringEncoders.urlEncodeUtf8String(_data[_i].toString()));
				}
			}
			_ary.sort();

			var _str:String = _ary.join("&");
			var _msgStr:String = StringEncoders.urlEncodeUtf8String(URLRequestMethod.POST.toUpperCase()) + "&";
			_msgStr += StringEncoders.urlEncodeUtf8String(_url);
			_msgStr += "&";
			_msgStr += StringEncoders.urlEncodeUtf8String(_str);

			var _secrectStr:String = consumerSecret + "&";
			if (microBlog.accessTokenSecrect){
				_secrectStr += microBlog.accessTokenSecrect;
			}

			var _sig:String = Base64.encode(HMAC.hash(_secrectStr, _msgStr, SHA1));
			return _sig;
		}

		private function onOauthLoaderHandler(_dataOrEvent:*):void {
			if (_dataOrEvent is IOErrorEvent) {
				removeWebView();
				if (onLogin != null){
					onLogin(false);
				}
			}else if (_dataOrEvent) {
				microBlog.accessTokenKey = _dataOrEvent.oauth_token;
				microBlog.accessTokenSecrect = _dataOrEvent.oauth_token_secret;
				if (pin) {
					microBlog.verifyCredentials();
				} else {
					var _url:String = OAUTH_AUTHORIZE_REQUEST_URL;
					_url += "?oauth_token=" + StringEncoders.urlEncodeUtf8String(microBlog.accessTokenKey);
					_url += "&oauth_callback=http://api.t.sina.com.cn/flash/callback.htm";
					webView.stage = stage;
					webView.loadURL(_url);
				}
			}
		}

		private function onVerifyCredentialHandler(_e:Event):void {
			removeWebView();
			if (_e is MicroBlogEvent) {
				updateShareObject();
				if (onLogin != null){
					onLogin(true);
				}
			}else {
				if (onLogin != null){
					onLogin(false);
				}
			}
		}

		private function onLocationChange(_e:Event):void {
			var _location:String = webView.location;
 
			var _arr:Array = String(_location.split("?")[1]).split("&");
			for (var _i:int = 0; _i < _arr.length; _i++){
				var _str:String = _arr[_i];
				if (_str.indexOf("oauth_verifier=") >= 0){
					pin = _str.split("=")[1];
				}
			}
			
			if (pin) {
				requestAuthorize(OAUTH_ACCESS_TOKEN_REQUEST_URL);
			}else if (onLogin != null){
				onLogin(false);
			}
		}
		
		private function removeWebView():void {
			if (webView.stage) {
				webView.stage = null;
				webView.dispose();
			}
		}
	}
}