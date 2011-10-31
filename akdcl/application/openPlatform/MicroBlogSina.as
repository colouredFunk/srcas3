package akdcl.application.openPlatform {
	import flash.display.Stage;
	import flash.utils.ByteArray;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	
	import com.adobe.crypto.HMAC;
	import com.adobe.crypto.SHA1;
	
	import com.hurlant.util.Base64;
	
	import com.util.OauthUrlUtil;

	import com.sina.microblog.MicroBlog;
	import com.sina.microblog.utils.GUID;
	import com.sina.microblog.events.MicroBlogErrorEvent;
	import com.sina.microblog.events.MicroBlogEvent;
	
	import akdcl.manager.RequestManager;

	/**
	 * ...
	 * @author akdcl
	 */
	final public class MicroBlogSina extends PlatformAPI {
		
		private static const API_BASE_URL:String = "http://api.t.sina.com.cn/oauth";
		private static const OAUTH_REQUEST_TOKEN_REQUEST_URL:String = API_BASE_URL + "/request_token";
		private static const OAUTH_AUTHORIZE_REQUEST_URL:String = API_BASE_URL + "/authorize";
		private static const OAUTH_ACCESS_TOKEN_REQUEST_URL:String = API_BASE_URL + "/access_token";

		public var microBlog:MicroBlog;
		
		override public function get authorized():Boolean {
			return Boolean(accessTokenKey&&accessTokenSecrect);
		}
		
		public function MicroBlogSina(_stage:Stage, _appKey:String, _appSecret:String):void {
			super(_stage, _appKey, _appSecret);
			name = "MicroBlogSina";
			
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
			var _urlObj:Object = { };
			_urlObj.url = OauthUrlUtil.getOauthUrl(
				pin?OAUTH_ACCESS_TOKEN_REQUEST_URL:OAUTH_REQUEST_TOKEN_REQUEST_URL,
				"GET",
				consumerKey,
				consumerSecret,
				accessTokenKey,
				accessTokenSecrect,
				pin,
				pin?OAUTH_ACCESS_TOKEN_REQUEST_URL:OAUTH_REQUEST_TOKEN_REQUEST_URL,
				[]
			);
			_urlObj.loadFormat = URLLoaderDataFormat.VARIABLES;
			
			RequestManager.getInstance().load(_urlObj, onOauthLoaderHandler, onOauthLoaderHandler);
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
				//用户授权，得到验证码oauth_verifier
				requestAuthorize();
			}
		}
		
		private function onMicroBlogDataHandler(_e:MicroBlogEvent):void 
		{
			switch(_e.type) {
				case MicroBlogEvent.VERIFY_CREDENTIALS_RESULT:
					removeWebView(true);
					updateShareObject();
					if (onLogin!=null) {
						onLogin();
					}
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
			removeWebView();
			if (_dataOrEvent is IOErrorEvent) {
			}else if (_dataOrEvent) {
				accessTokenKey = _dataOrEvent.oauth_token;
				accessTokenSecrect = _dataOrEvent.oauth_token_secret;
				if (pin) {
					//得到Access Token（Request Token换取）
					microBlog.accessTokenKey = accessTokenKey;
					microBlog.accessTokenSecrect = accessTokenSecrect;
					microBlog.verifyCredentials();
				} else {
					//得到未授权的Request Token
					var _url:String = OAUTH_AUTHORIZE_REQUEST_URL;
					_url += "?oauth_token=" + OauthUrlUtil.executeString(accessTokenKey);
					_url += "&oauth_callback=http://api.t.sina.com.cn/flash/callback.htm";
					webView.stage = stage;
					webView.loadURL(_url);
				}
			}
		}
	}
}