/***
   CameraPan 版本:v1.0
   简要说明:这家伙很懒什么都没写
   创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
   创建时间:2011年1月5日 23:04:53
   历次修改:未有修改
   用法举例:这家伙很懒什么都没写
 */

package zero.ui {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	import flash.system.*;

	import flash.media.*;

	public class CameraPan extends Sprite {
		private static const ERROR_NO_CAMERA:String = "请检查摄像头是否正常工作！";
		private static const ERROR_UNUSE_CAMERA:String = "用户拒绝使用摄像头！";

		private var video:Video;
		private var camera:Camera;
		private var ns:NetStream;
		private var checkBmd:BitmapData;
		private var delayTime:int;

		public var onOpen:Function;
		public var onFailed:Function;

		public function CameraPan(_wid:int = 320, _hei:int = 240){
			checkBmd = new BitmapData(_wid, _hei, true, 0x00000000);
			camera = Camera.getCamera();
			video = new Video(_wid, _hei);
			video.smoothing = true;
			addChild(video);
		}

		public function remove():void {
			if (camera){
				//camera.removeEventListener(Event.ACTIVATE,camera_activate);
				//camera.removeEventListener(Event.DEACTIVATE,camera_deactivate);
				//camera.removeEventListener(ActivityEvent.ACTIVITY,camera_activity);
				camera.removeEventListener(StatusEvent.STATUS, camera_status);
			}
			close();
			if (checkBmd){
				checkBmd.dispose();
			}
			if (video){
				removeChild(video);
			}

			video = null;
			camera = null;
			ns = null;
			checkBmd = null;

			onOpen = null;
			onFailed = null;
		}

		//testNoCameraFlvPath:可以用一个 flv 地址来代替摄像头
		public function open(testNoCameraFlvPath:String = null):void {
			close();
			if (camera || testNoCameraFlvPath){
				if (camera){
					//camera.addEventListener(Event.ACTIVATE,camera_activate);
					//camera.addEventListener(Event.DEACTIVATE,camera_deactivate);
					//camera.addEventListener(ActivityEvent.ACTIVITY,camera_activity);
					camera.addEventListener(StatusEvent.STATUS, camera_status);
					video.attachCamera(camera);
				} else {
					if (testNoCameraFlvPath){
						trace("在无摄像头的机器上测试有摄像头的情况：" + testNoCameraFlvPath);
					}
					var conn:NetConnection = new NetConnection();
					conn.connect(null);
					if (!ns){
						ns = new NetStream(conn);
						ns.checkPolicyFile = true;
						ns.client = {onMetaData: trace}; //否则报错：在 flash.net.NetStream 上找不到属性 onMetaData，且没有默认值
					}
					video.attachNetStream(ns);
					ns.play(testNoCameraFlvPath);
				}
				addEventListener(Event.ENTER_FRAME, checkOpen);
				delayTime = 10;
			} else {
				if (onFailed != null){
					onFailed(ERROR_NO_CAMERA);
				}
			}
		}

		public function pause():void {
			if (video){
				video.attachCamera(null);
				video.attachNetStream(null);
			}
		}

		public function resume():void {
			if (video){
				if (camera){
					video.attachCamera(camera);
				} else if (ns){
					video.attachNetStream(ns);
				}
			}
		}

		public function close():void {
			removeEventListener(Event.ENTER_FRAME, checkOpen);
			if (video){
				video.attachCamera(null);
				video.attachNetStream(null);
				video.clear();
			}
		}

		public function getBmd():BitmapData {
			if (video){
				var bmd:BitmapData = new BitmapData(video.width, video.height, false, 0xffffff);
				bmd.draw(video);
				return bmd;
			}
			return null;
		}

		private function checkOpen(event:Event):void {
			if (--delayTime == 0){
				//默认设置为未记住：
				//情况1：用户打开 swf，第一次尝试使用摄像头，将马上弹出第一个设置框，delayTime 完后 showSettings()，弹出第二个设置框，如果用户点击允许，将正常使用；如果点击拒绝，将关闭第二个设置框，用户需要继续点击第一个设置框 - -
				//情况2：用户第二次尝试使用摄像头，不论之前是允许或拒绝，将不会弹出第一个设置框；如果之前是允许，只要在 delayTime 完之前获取到图像，将不会弹出第二个设置框；如果之前是拒绝，delayTime 完后 showSettings()，弹出第二个设置框

				//默认设置为记住允许：
				//用户尝试使用摄像头，将不会弹出第一个设置框；只要在 delayTime 完之前获取到图像，将不会弹出第二个设置框

				//默认设置为记住拒绝：
				//用户尝试使用摄像头，将不会弹出第一个设置框；delayTime 完后 showSettings()，弹出第二个设置框

				Security.showSettings(SecurityPanel.PRIVACY);
			}
			checkBmd.fillRect(checkBmd.rect, 0x00000000);
			checkBmd.draw(video);
			if (checkBmd.rect.equals(checkBmd.getColorBoundsRect(0xffffffff, 0x00000000))){
				//如果整个都是透明的
			} else {
				removeEventListener(Event.ENTER_FRAME, checkOpen);
				if (onOpen != null){
					switch (onOpen.length){
						case 0:
							onOpen();
							break;
						case 1:
							onOpen(this);
							break;
					}
				}
			}
		}

		private function camera_status(event:StatusEvent):void {
			switch (event.code){
				case "Camera.Muted":
					if (onFailed != null){
						onFailed(ERROR_UNUSE_CAMERA);
					}
					break;
				default:
					trace("camera_status " + event);
					break;
			}
		}

		//private function camera_activate(event:Event):void{
		//	trace("camera_activate "+event);
		//}
		//private function camera_deactivate(event:Event):void{
		//播放器窗口失去焦点时亦会触发
		//trace("camera_deactivate "+event);
		//}
		//private function camera_activity(event:ActivityEvent):void{
		//	trace("camera_activity "+event);
		//}
	}
}

