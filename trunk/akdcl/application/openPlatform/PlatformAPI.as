package akdcl.application.openPlatform {
	import flash.events.Event;
	import akdcl.events.UIEventDispatcher;
	import akdcl.manager.ShareObjectManager;

	/**
	 * ...
	 * @author ...
	 */
	public class Platform extends UIEventDispatcher {
		private static const PLATFORM_DATA:String = "akdcl/platformData";
		
		private static const APPLICATION_NAME:String = "applicationName";
		private static const LAST_USER:String = "lastUser";

		private static const USERS:String = "users";
		private static const ACCESS_TOKEN:String = "accessToken";
		private static const RECOED_SECONDS:String = "recordSeconds";
		private static const EXPIRES_IN:String = "expiresIn";

		protected static const soM:ShareObjectManager = ShareObjectManager.getInstance();

		protected var name:String = "platformName";

		protected var consumerKey:String;
		protected var consumerSecret:String;

		public function PlatformAPI(_appKey:String, _appSecret:String):void {
			consumerKey = _appKey;
			consumerSecret = _appSecret;
			super();
		}

		override protected function init():void {
			super.init();
			soM.setLocal(PLATFORM_DATA);
			soM.setGroup(name +"_" + consumerKey);
		}
		

		protected function getAccessToken():String {
			//创建用户列表
			soM.autoValue(USERS, { } );
			
			var _userID:String;
			
			var _lastUserID:String;
			var _user:Object;
			
			var _accessToken:String;
			_lastUserID = soM.getValue(LAST_USER);
			
			if (_lastUserID) {
				getUserAccessToken(_lastUserID);
			}
			return null;
		}
		
		protected function getUserAccessToken(_userID:String):String {
			//创建用户列表
			soM.autoValue(USERS, { } );
			var _users:Object = soM.getValue(USERS);
			var _user:Object;
			var _accessToken:String;
			if (_users) {
				_user = _users[_lastUserID];
				if (_user) {
					_accessToken = _user[ACCESS_TOKEN];
					if (_accessToken) {
						if (new Date().time * 0.001 - int(_user[RECOED_SECONDS]) < int(_user[EXPIRES_IN])) {
							return _accessToken;
						}
					}
				}
			}
			return null;
		}

		private function setAccessToken(_accessToken:String, _expiresIn:String):void {
			soM.setValue("recordIn", int(new Date().time * 0.001));
			soM.setValue("accessToken", _accessToken);
			soM.setValue("expiresIn", _expiresIn);
			soM.flush();
		}

		public function login():void {
			if (authorized){

			} else {
				requestAuthorize();
			}
		}

		public function logout():void {

		}

		protected function requestAuthorize():void {

		}

		protected function onWebViewLocationChangeHandler(_e:Event):void {

		}

		public function removeWebView(_success:Boolean = false):void {
			var hasStage:Boolean;
			try {
				if (webView.stage){
					hasStage = true;
				} else {
					hasStage = false;
				}
			} catch (e:Error){
				hasStage = false;
			}
			if (hasStage){
				webView.stage = null;
				if (_success){
					webView.removeEventListener(Event.LOCATION_CHANGE, onWebViewLocationChangeHandler);
					webView.dispose();
				} else {
					accessTokenKey = "";
					accessTokenSecrect = "";
				}
			} else {
				accessTokenKey = "";
				accessTokenSecrect = "";
			}
			if (onLogin != null){
				onLogin(_success);
			}
		}
	}

}