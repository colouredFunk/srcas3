package akdcl.application.openPlatform {
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.net.SharedObject;
	
	import flash.media.StageWebView;
	
	import com.core.microBlogs.qq.api.oauth.DoOauth;
	import com.core.microBlogs.qq.api.broadcast.DoBroadcast;
	
	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author akdcl
	 */
	public class MicroBlogQQ extends UIEventDispatcher {
		public static const MICRO_BLOG_DATA:String = "MicroBlogDataQQ";

		private var doOauth:DoOauth;
		private var doBroadcast:DoBroadcast;
		
		private var shareObject:SharedObject;
		private var stage:Stage;
		private var webView:StageWebView;
		
		private var consumerKey:String = "0000000000";
		private var consumerSecret:String = "00000000000000000000000000000000";
		private var pin:String = "";
		
		public function get isLogin():Boolean {
			return false;
		}

		public function MicroBlogQQ(_stage:Stage, _appKey:String, _appSecret:String):void {
			stage = _stage;
			consumerKey = _appKey;
			consumerSecret = _appSecret;
			
			shareObject = SharedObject.getLocal(MICRO_BLOG_DATA);
			
			webView = new StageWebView();
			webView.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			webView.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			
			doOauth = new DoOauth(onMicroBlogDataHandler,onMicroBlogErrorHandler);
			doBroadcast = new DoBroadcast(onMicroBlogDataHandler,onMicroBlogErrorHandler);
			
			var _consumer:Object = shareObject.data[consumerKey];
			if (_consumer && _consumer.key && _consumer.secret) {
				//microBlog.accessTokenKey = _consumer.key;
				//microBlog.accessTokenSecrect = _consumer.secret;
			}
		}
		
		public function setAccessToken(_key:String, _secret:String):void {
			//microBlog.accessTokenKey = _key;
			//microBlog.accessTokenSecrect = _secret;
			updateShareObject();
		}
		
		public function login():void {
			doOauth.getRequestToken(consumerKey, consumerSecret);
		}
		
		public function logout():void {
			delete shareObject.data[consumerKey];
		}
		
		public function updateStatus(_status:String, _imageData:ByteArray = null):void {
			
		}
		
		private function onMicroBlogDataHandler(_type:String, _data:Object):void 
		{
			trace(_type,_data);
			switch(_type) {
				case DoOauth.CMD_REQUEST_TOKEN:
					break;
				default :
					break;
			}
		}
		
		private function onMicroBlogErrorHandler(_data:Object):void 
		{
			trace("error", _data);
		}
		
		private function updateShareObject():void {
			/*shareObject.data[consumerKey] = { 
				key:microBlog.accessTokenKey, 
				secret:microBlog.accessTokenSecrect
			};*/
			shareObject.flush();
		}
	}
}