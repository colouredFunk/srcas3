package akdcl.application {
	import com.sina.microblog.events.MicroBlogEvent;
	import com.sina.microblog.events.MicroBlogErrorEvent;
	import com.sina.microblog.MicroBlog;

	import flash.display.BitmapData;
	import flash.events.Event;

	import ui.Alert;

	import zero.codec.JPEGEncoder;

	import akdcl.events.UIEventDispatcher;
	import akdcl.utils.objectToString;
	
	import akdcl.manager.LoggerManager;
	import akdcl.manager.ShareObjectManager;

	/**
	 * ...
	 * @author akdcl
	 */
	/// @eventType	akdcl.application.ModelMicroBlog.LOGIN_COMPLETE
	[Event(name = "loginComplete", type = "akdcl.application.ModelMicroBlog")]
	
	/// @eventType	akdcl.application.ModelMicroBlog.USER_COMPLETE
	[Event(name = "userComplete", type = "akdcl.application.ModelMicroBlog")]
	
	/// @eventType	akdcl.application.ModelMicroBlog.FRIEND_COMPLETE
	[Event(name = "FriendComplete", type = "akdcl.application.ModelMicroBlog")]
	
	public class SimpleMicroBlog extends UIEventDispatcher {
		public static const LOGIN_COMPLETE:String = "loginComplete";
		public static const USER_COMPLETE:String = "userComplete";
		public static const FRIEND_COMPLETE:String = "FriendComplete";

		private static const API_GET_UID:String = "2/account/get_uid";
		private static const API_SHOW:String = "2/users/show";
		private static const API_BILATERAL:String = "2/friendships/friends/bilateral";
		private static const API_FRIENDS:String = "2/friendships/friends";
		private static const API_LOLLOWERS:String = "2/friendships/followers";

		private static const UID_RESULT:String = "uidResult";
		private static const UID_ERROR:String = "uidError";
		private static const USER_RESULT:String = "showResult";
		private static const USER_ERROR:String = "showError";
		private static const BILATERAL_RESULT:String = "bilateralResult";
		private static const BILATERAL_ERROR:String = "bilateralError";
		private static const FRIENDS_RESULT:String = "friendsResult";
		private static const FRIENDS_ERROR:String = "friendsError";
		private static const FOLLOWERS_RESULT:String = "followersResult";
		private static const FOLLOWERS_ERROR:String = "followersError";

		private static const METHOD_GET:String = "GET";

		private static const PER_COUNT:uint = 200;
		
		private static const ALERT_LOGIN:String = "登录中，请稍后...";
		private static const ALERT_UPDATE:String = "分享中，请稍后...";
		private static const ALERT_UPDATE_SUCCESS:String = "分享成功！";

		private static const soM:ShareObjectManager = ShareObjectManager.getInstance();
		private static const lM:LoggerManager = LoggerManager.getInstance();
		
		//当前登录用户的数据
		public var user:Object;
		//当前登录用户的好友数据
		public var friendsData:Array;
		//当前登录用户的好友总数量
		public var friendTotal:int = -1;

		private var microBlog:MicroBlog;
		private var callAPIParams:Object;

		private var bilateralList:Array;
		private var friendsList:Array;
		private var followersList:Array;

		private var bilateralTotal:int = -1;
		private var friendsTotal:int = -1;
		private var followersTotal:int = -1;

		private var bilateralCount:int;
		private var friendsCount:int;
		private var followersCount:int;

		private var alertTemp:Alert;

		override protected function init():void {
			super.init();
			friendsData = [];
			bilateralList = [];
			friendsList = [];
			followersList = [];

			bilateralCount = 0;
			friendsCount = 0;
			followersCount = 0;

			callAPIParams = {count: PER_COUNT};
			microBlog = new MicroBlog();
		}
		
		//设置key等
		public function setMicroBlog(_key:String, _secret:String, _proxy:String):void {
			//"3975282871";
			//"40825d5a332fe44e01f5b8f9e570eb7c";
			//"http://akdcl.sinaapp.com/proxy.php";
			soM.setGroup(_key);
			microBlog.consumerKey = _key;
			microBlog.consumerSecret = _secret;
			microBlog.proxyURI = _proxy;
		}
		
		//登录
		public function login():void {
			var _accessToken:String = getAccessToken();
			if (_accessToken){
				microBlog.access_token = _accessToken;
				getUID();
				return;
			}
			if (alertTemp){
				alertTemp.remove();
			}
			alertTemp = Alert.show(ALERT_LOGIN);
			
			microBlog.addEventListener(MicroBlogEvent.LOGIN_RESULT, onLoginHandler);
			microBlog.addEventListener(MicroBlogErrorEvent.LOGIN_ERROR, onLoginHandler);
			microBlog.login();
		}
		
		//需要实现用户登出的方法
		public function unlogin():void {
			
		}

		//获取当前登录用户的详细信息
		public function getUser():void {
			microBlog.addEventListener(USER_RESULT, onUserHandler);
			microBlog.addEventListener(USER_ERROR, onUserHandler);
			microBlog.callWeiboAPI(API_SHOW, callAPIParams, METHOD_GET, USER_RESULT, USER_ERROR);
		}
		
		//获取好友列表
		public function loadFriends(_idOff:uint, _length:uint):void {
			if (friendTotal < 0) {
				getBilateral();
				return;
			}
			var _id:uint;
			var _friend:Object;
			for (var _i:uint = 0; _i < _length; _i++){
				_id = _idOff + _i;
				if (friendsData[_id]){
					continue;
				}
				do {
					if (_id < bilateralTotal){
						_friend = bilateralList.pop();
					} else if (_id < friendsTotal){
						_friend = friendsList.pop();
					} else {
						_friend = followersList.pop();
					}
				} while (containsFriends(_friend, friendsTotal));
				
				if (_friend) {
					friendsData[_id] = _friend;
				}
			}
			if (Math.ceil(bilateralTotal / PER_COUNT) < bilateralCount && bilateralList.length < PER_COUNT) {
				getBilateral();
			}
			if (Math.ceil(friendsTotal / PER_COUNT) < friendsCount && friendsList.length < PER_COUNT){
				getFriends();
			}
			if (Math.ceil(followersTotal / PER_COUNT) < followersCount && followersList.length < PER_COUNT){
				getFollowers();
			}
		}
		
		//发布微博
		public function updateStatus(_str:String, _image:BitmapData):void {
			microBlog.addEventListener(MicroBlogEvent.UPDATE_STATUS_RESULT, onUpdateStatusHandler);
			microBlog.addEventListener(MicroBlogErrorEvent.UPDATE_STATUS_ERROR, onUpdateStatusHandler);
			if (alertTemp){
				alertTemp.remove();
			}
			alertTemp = Alert.show(ALERT_UPDATE);
			microBlog.updateStatus(_str, JPEGEncoder.encode(_image));
		}

		private function onLoginHandler(_e:Event):void {
			microBlog.removeEventListener(MicroBlogEvent.LOGIN_RESULT, onLoginHandler);
			microBlog.removeEventListener(MicroBlogErrorEvent.LOGIN_ERROR, onLoginHandler);
			if (_e.type == MicroBlogEvent.LOGIN_RESULT){
				lM.info(microBlog, "loginResult====>>>>\n" + objectToString((_e as MicroBlogEvent).result));
				var _accessToken:String = (_e as MicroBlogEvent).result.access_token;
				microBlog.access_token = _accessToken;
				setAccessToken(_accessToken, (_e as MicroBlogEvent).result.expires_in);
				
				getUID();
			} else {
				if (alertTemp){
					alertTemp.remove();
					alertTemp = null;
				}
				Alert.show("登录失败！", "重试", login);
			}
		}
		
		//获取当前登录用户的UID，用户UID为新浪API的必选参数
		private function getUID():void {
			if (alertTemp){
				alertTemp.remove();
			}
			alertTemp = Alert.show(ALERT_LOGIN);
			microBlog.addEventListener(UID_RESULT, onUIDHandler);
			microBlog.addEventListener(UID_ERROR, onUIDHandler);
			microBlog.callWeiboAPI(API_GET_UID, null, METHOD_GET, UID_RESULT, UID_ERROR);
		}

		private function onUIDHandler(_e:Event):void {
			microBlog.removeEventListener(UID_RESULT, onUIDHandler);
			microBlog.removeEventListener(UID_ERROR, onUIDHandler);

			if (_e.type == UID_RESULT){
				lM.info(microBlog, "UIDResult====>>>>\n" + objectToString((_e as MicroBlogEvent).result));
				microBlog.addEventListener(BILATERAL_RESULT, onResultHandler);
				microBlog.addEventListener(BILATERAL_ERROR, onErrorHandler);
				microBlog.addEventListener(FRIENDS_RESULT, onResultHandler);
				microBlog.addEventListener(FRIENDS_ERROR, onErrorHandler);
				microBlog.addEventListener(FOLLOWERS_RESULT, onResultHandler);
				microBlog.addEventListener(FOLLOWERS_ERROR, onErrorHandler);

				callAPIParams.uid = (_e as MicroBlogEvent).result.uid;
				dispatchEvent(new Event(LOGIN_COMPLETE));
			} else {
				if (alertTemp){
					alertTemp.remove();
					alertTemp = null;
				}
				Alert.show("获取UID失败！", "重试", getUID);
			}
		}

		private function onUserHandler(_e:Event):void {
			microBlog.removeEventListener(USER_RESULT, onUserHandler);
			microBlog.removeEventListener(USER_ERROR, onUserHandler);

			if (_e.type == USER_RESULT){
				lM.info(microBlog, "showResult====>>>>\n" + objectToString((_e as MicroBlogEvent).result));
				user = (_e as MicroBlogEvent).result;
				dispatchEvent(new Event(USER_COMPLETE));
			} else {
				Alert.show("获取个人信息失败！", "重试", getUser);
			}
		}
		
		//获取互粉用户
		private function getBilateral():void {
			callAPIParams.page = bilateralCount + 1;
			microBlog.callWeiboAPI(API_BILATERAL, callAPIParams, METHOD_GET, BILATERAL_RESULT, BILATERAL_ERROR);
			bilateralCount++;
		}

		//获取关注用户
		private function getFriends():void {
			callAPIParams.cursor = friendsCount;
			microBlog.callWeiboAPI(API_FRIENDS, callAPIParams, METHOD_GET, FRIENDS_RESULT, FRIENDS_ERROR);
			friendsCount++;
		}

		//获取粉丝用户
		private function getFollowers():void {
			callAPIParams.cursor = followersCount;
			microBlog.callWeiboAPI(API_LOLLOWERS, callAPIParams, METHOD_GET, FOLLOWERS_RESULT, FOLLOWERS_ERROR);
			followersCount++;
		}

		private function onResultHandler(_e:MicroBlogEvent):void {
			lM.info(microBlog, _e.type + "====>>>>\n" + objectToString(_e.result));

			var _result:Object = _e.result;
			var _users:Array = _result.users;
			var _length:uint = _users.length;
			var _friend:Object;
			var _id:uint;
			var _idOff:uint;

			switch (_e.type){
				case BILATERAL_RESULT:
					bilateralList = bilateralList.concat(_users);
					if (bilateralTotal < 0){
						bilateralTotal = int(_result.total_number);
						getFriends();
					}
					break;
				case FRIENDS_RESULT:
					friendsList = friendsList.concat(_users);
					if (friendsTotal < 0){
						friendsTotal = int(_result.total_number);
						getFollowers();
					}
					break;
				case FOLLOWERS_RESULT:
					followersList = followersList.concat(_users);
					if (followersTotal < 0){
						followersTotal = int(_result.total_number);
						friendTotal = friendsTotal + followersTotal - bilateralTotal;
						//当把互粉的和关注的用户加载完毕后，就停止加载数据，当需要的时候再加载
						if (alertTemp){
							alertTemp.remove();
							alertTemp = null;
						}
						dispatchEvent(new Event(FRIEND_COMPLETE));
					}
					break;
			}
		}

		private function onUpdateStatusHandler(_e:Event):void {
			microBlog.removeEventListener(MicroBlogEvent.UPDATE_STATUS_RESULT, onUpdateStatusHandler);
			microBlog.removeEventListener(MicroBlogErrorEvent.UPDATE_STATUS_ERROR, onUpdateStatusHandler);
			if (alertTemp){
				alertTemp.remove();
				alertTemp = null;
			}
			if (_e.type == MicroBlogEvent.UPDATE_STATUS_RESULT){
				Alert.show(ALERT_UPDATE_SUCCESS);
			} else {
				Alert.show("微博分享失败！\n" + (_e as MicroBlogErrorEvent).message);
			}
		}

		private function onErrorHandler(_e:MicroBlogErrorEvent):void {
			lM.error(microBlog, _e.type + "___" + _e.message);
			switch (_e.type){
				case BILATERAL_ERROR:
					break;
				case FRIENDS_ERROR:
					break;
				case FOLLOWERS_ERROR:
					break;
			}
		}

		private function getAccessToken():String {
			var _accessToken:String = soM.getValue("accessToken") as String;
			if (_accessToken){
				if (new Date().time * 0.001 - int(soM.getValue("recordIn")) < int(soM.getValue("expiresIn"))){
					return _accessToken;
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
		
		private function containsFriends(_friend:Object, _length:uint):Boolean {
			if (!_friend) {
				return false;
			}
			var _friendHas:Object;
			for (var _i:uint = 0; _i < _length; _i++){
				_friendHas = friendsData[_i];
				if (_friendHas && _friendHas.id == _friend.id){
					return true;
				}
			}
			return false;
		}
	}
}