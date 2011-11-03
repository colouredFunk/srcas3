package akdcl.application.openPlatform {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.SharedObject;
	
	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author ...
	 */
	public class PlatformAPI extends UIEventDispatcher {
		public static const PLATFORM_DATA:String = "akdcl/platformData";

		public var onLogin:Function;

		protected var shareObject:SharedObject;

		protected var stage:Stage;
		protected var webView:StageWebView;

		protected var name:String;

		protected var consumerKey:String;
		protected var consumerSecret:String;
		protected var pin:String = "";

		protected var accessTokenKey:String = "";
		protected var accessTokenSecrect:String = "";

		public function get authorized():Boolean {
			return false;
		}

		public function PlatformAPI(_stage:Stage, _appKey:String, _appSecret:String, _viewPort:Rectangle=null):void {
			stage = _stage;
			consumerKey = _appKey;
			consumerSecret = _appSecret;

			shareObject = SharedObject.getLocal(PLATFORM_DATA);

			webView = new StageWebView();
			webView.viewPort = _viewPort||new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			webView.addEventListener(Event.LOCATION_CHANGE, onWebViewLocationChangeHandler);

		}

		public function setAccessToken(_key:String, _secret:String):void {
			accessTokenKey = _key;
			accessTokenSecrect = _secret;
			updateShareObject();
		}

		public function login():void {
			if (authorized){

			} else {
				requestAuthorize();
			}
		}

		public function logout():void {
			updateShareObject(true);
		}

		protected function updateShareObject(_logout:Boolean = false):void {
			if (!shareObject.data[name]){
				shareObject.data[name] = {};
			}
			if (!shareObject.data[name][consumerKey]){
				shareObject.data[name][consumerKey] = {key: "", secret: ""};
			}
			if (_logout){
				delete shareObject.data[name][consumerKey];
				accessTokenKey = "";
				accessTokenSecrect = "";
			} else {
				if (accessTokenKey){
					shareObject.data[name][consumerKey].key = accessTokenKey;
				}
				if (accessTokenSecrect){
					shareObject.data[name][consumerKey].secret = accessTokenSecrect;
				}
				accessTokenKey = shareObject.data[name][consumerKey].key;
				accessTokenSecrect = shareObject.data[name][consumerKey].secret;
			}
			shareObject.flush();
		}

		protected function requestAuthorize():void {

		}

		protected function onWebViewLocationChangeHandler(_e:Event):void {

		}

		public function removeWebView(_success:Boolean = false):void {
			if (webView.stage){
				webView.stage = null;
				if (_success){
					webView.removeEventListener(Event.LOCATION_CHANGE, onWebViewLocationChangeHandler);
					webView.dispose();
				}
			}
			if (onLogin != null){
				onLogin(_success);
			}
		}
	}

}