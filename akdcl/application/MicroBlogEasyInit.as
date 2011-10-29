package akdcl.application {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	
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
		private static const API_BASE_URL:String = "http://api.t.sina.com.cn";
		private static const OAUTH_REQUEST_TOKEN_REQUEST_URL:String = API_BASE_URL + "/oauth/request_token";
		private static const OAUTH_AUTHORIZE_REQUEST_URL:String = API_BASE_URL + "/oauth/authorize";
		private static const OAUTH_ACCESS_TOKEN_REQUEST_URL:String = API_BASE_URL + "/oauth/access_token";

		public var microBlog:MicroBlog;
		public var onLoginComplete:Function;
		public var onLoginError:Function;
		
		private var stage:Stage;
		private var webView:StageWebView;
		private var consumerKey:String = "0000000000";
		private var consumerSecret:String = "00000000000000000000000000000000";
		private var accessTokenKey:String = "";
		private var accessTokenSecret:String = "";
		private var pin:String = "";

		public function MicroBlogEasyInit(_stage:Stage):void {
			stage = _stage;
			webView = new StageWebView();
			webView.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			webView.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			microBlog = new MicroBlog();
			microBlog.addEventListener(MicroBlogEvent.VERIFY_CREDENTIALS_RESULT, onVerifyCredentialResult);
		}
		
		public function setConsumer(_appKey:String, _appSecret:String):void {
			consumerKey = _appKey;
			consumerSecret = _appSecret;
			microBlog.source = consumerKey;
			microBlog.consumerKey = consumerKey;
			microBlog.consumerSecret = consumerSecret;
		}
		
		public function setAccessToken(_key:String, _secret:String):void {
			isLogin = true;
			accessTokenKey = _key;
			accessTokenSecret = _secret;
			
			microBlog.accessTokenKey = accessTokenKey;
			microBlog.accessTokenSecrect = accessTokenSecret;
			microBlog.verifyCredentials();
		}
		
		public function get isLogin():Boolean {
			return accessTokenKey && accessTokenSecret;
		}
		
		public function login():void {
			checkLogin(OAUTH_REQUEST_TOKEN_REQUEST_URL);
		}

		private function checkLogin(_url:String, _oauth_token:String = null, _oauth_verifier:String = null):void {
			var _data:Object = {};
			_data.oauth_consumer_key = consumerKey;
			_data.oauth_signature_method = "HMAC-SHA1";
			_data.oauth_timestamp = new Date().time.toString().substr(0, 10);
			_data.oauth_nonce = GUID.createGUID();
			_data.oauth_version = "1.0";
			_data.oauth_callback = "http://api.t.sina.com.cn/flash/callback.htm";

			if (_oauth_token){
				_data.oauth_token = _oauth_token;
			}
			if (_oauth_verifier){
				_data.oauth_verifier = _oauth_verifier;
				_data.oauth_callback = "oob";
			}

			var _urlObj:Object = {};
			_urlObj.data = _data;
			_urlObj.url = _url;
			_urlObj.loadFormat = URLLoaderDataFormat.VARIABLES;
			_data.oauth_signature = getOauthSignature(_data, _urlObj.url);
			RequestManager.getInstance().load(_urlObj, onOauthLoaderCompleteHandler, onOauthLoaderErrorHandler);
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
			if (accessTokenSecret){
				_secrectStr += accessTokenSecret;
			}

			var _sig:String = Base64.encode(HMAC.hash(_secrectStr, _msgStr, SHA1));
			return _sig;
		}

		private function onOauthLoaderErrorHandler(_e:Event):void {
			if (webView.stage) {
				webView.stage = null;
				webView.dispose();
			}
			isLogin = false;
			if (onLoginError != null){
				onLoginError();
			}
		}

		private function onOauthLoaderCompleteHandler(_data:*):void {
			var _needRequestAuthorize:Boolean = accessTokenKey.length == 0;
			if (_data){
				accessTokenKey = _data.oauth_token;
				accessTokenSecret = _data.oauth_token_secret;
				if (_needRequestAuthorize){
					requestAuthorize();
				} else {
					microBlog.accessTokenKey = accessTokenKey;
					microBlog.accessTokenSecrect = accessTokenSecret;
					microBlog.verifyCredentials();
				}
			}
		}

		private function onVerifyCredentialResult(_e:MicroBlogEvent):void {
			//var user:MicroBlogUser = _e.result as MicroBlogUser;
			//var str:String = "当前登录用户: " + user.name + "<br/>";
			//str += "用户id: " + user.id + "<br/>";
			//str += "最近一条微博: " + user.status.text;
			//txtInfo.htmlText = str;
			//Alert.show(microBlog.currentResult.toString());
			if (webView.stage) {
				webView.stage = null;
				webView.dispose();
			}
			isLogin = true;
			if (onLoginComplete != null){
				onLoginComplete();
			}
			trace(accessTokenKey, accessTokenSecret, pin);
		}

		private function requestAuthorize():void {
			var _url:String = OAUTH_AUTHORIZE_REQUEST_URL;
			_url += "?oauth_token=" + StringEncoders.urlEncodeUtf8String(accessTokenKey);
			_url += "&oauth_callback=http://api.t.sina.com.cn/flash/callback.htm";
			webView.stage = stage;
			webView.loadURL(_url);
		}

		private function onLocationChange(_e:Event):void {
			var _location:String = webView.location;

			var _arr:Array = String(_location.split("?")[1]).split("&");
			var _oauth_token:String = "";
			var _oauth_verifier:String = "";
			for (var _i:int = 0; _i < _arr.length; _i++){
				var _str:String = _arr[_i];
				if (_str.indexOf("oauth_token=") >= 0){
					_oauth_token = _str.split("=")[1];
				}
				if (_str.indexOf("oauth_verifier=") >= 0){
					_oauth_verifier = _str.split("=")[1];
				}
			}
			if (_oauth_verifier) {
				pin = _oauth_verifier;
				checkLogin(OAUTH_ACCESS_TOKEN_REQUEST_URL, _oauth_token, _oauth_verifier);
			}
		}
	}

}