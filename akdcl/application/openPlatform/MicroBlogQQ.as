package akdcl.application.openPlatform {
	import flash.display.Stage;
	import flash.utils.ByteArray;

	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import com.core.microBlogs.standard.Oauth;
	import com.core.microBlogs.standard.OauthKey;
	import com.core.microBlogs.qq.api.oauth.DoOauth;
	import com.core.microBlogs.qq.api.broadcast.DoBroadcast;

	import com.util.OauthUrlUtil;

	public class MicroBlogQQ extends PlatformAPI {

		private var doOauth:DoOauth;
		public var doBroadcast:DoBroadcast;

		override public function get authorized():Boolean {
			return Oauth.currentAccountKey != null;
		}

		public function MicroBlogQQ(_stage:Stage, _appKey:String, _appSecret:String):void {
			super(_stage, _appKey, _appSecret);
			name = "MicroBlogQQ";

			doOauth = new DoOauth(onDataHandler, onErrorHandler);
			doBroadcast = new DoBroadcast(onDataHandler, onErrorHandler);

			updateShareObject();
		}

		override protected function requestAuthorize():void {
			super.requestAuthorize();
			doOauth.getRequestToken(consumerKey, consumerSecret);
		}

		override protected function updateShareObject(_logout:Boolean = false):void {
			super.updateShareObject(_logout);
			if (_logout){
				Oauth.currentAccountKey = null;
			} else if (accessTokenKey && accessTokenSecrect){
				if (!Oauth.currentAccountKey){
					var _oauthKey:OauthKey = new OauthKey();
					_oauthKey.customKey = consumerKey;
					_oauthKey.customSecrect = consumerSecret;
					Oauth.currentAccountKey = _oauthKey;
				}
				Oauth.currentAccountKey.tokenKey = accessTokenKey;
				Oauth.currentAccountKey.tokenSecrect = accessTokenSecrect;
			}
		}

		override protected function onWebViewLocationChangeHandler(_e:Event):void {
			super.onWebViewLocationChangeHandler(_e);
			var _location:String = webView.location;
			var _arr:Array = String(_location.split("?")[1]).split("&");
			for (var _i:int = 0; _i < _arr.length; _i++){
				var _str:String = _arr[_i];
				if (_str.indexOf("v=") >= 0){
					pin = _str.split("=")[1];
				}
			}
			if (pin){
				//用户授权，得到验证码oauth_verifier
				Oauth.oauthingKey.verify = pin;
				doOauth.getAccessToken();
			}
		}

		private function onDataHandler(_type:String, _data:Object):void {
			switch (_type){
				case DoOauth.CMD_REQUEST_TOKEN:
					//得到未授权的Request Token
					var _url:String = DoOauth.OAUTH_TOKEN_URL;
					_url += "?oauth_token=" + OauthUrlUtil.executeString(_data.oauth_token);
					_url += "&oauth_callback=null";
					webView.stage = stage;
					webView.loadURL(_url);
					break;
				case DoOauth.CMD_ACCESS_TOKEN:
					//得到Access Token（Request Token换取）
					accessTokenKey = Oauth.oauthingKey.tokenKey;
					accessTokenSecrect = Oauth.oauthingKey.tokenSecrect;
					//
					updateShareObject();
					removeWebView(true);
					break;
				default:
					
					break;
			}
		}

		private function onErrorHandler(_data:Object):void {
			removeWebView();
		}
	}
}