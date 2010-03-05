package akdcl.pv3d{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.objects.DisplayObject3D;

	public class MouseDrager extends Sprite {

		private var camera:Camera3D;
		private var ob3d:DisplayObject3D;
		private var mouseDownX:Number;
		private var mouseDownY:Number;
		private var mouseNowX:Number;
		private var mouseNowY:Number;
		private var isMouseDown:Boolean = false;
		public var onPress:Function;
		public var onHold:Function;
		public var onDrag:Function;
		public var onRelease:Function;
		public function MouseDrager(_camera:Camera3D=null,_ob3d:DisplayObject3D=null) {
			reset(_camera,_ob3d);
		}
		public function reset(_camera:Camera3D=null,_ob3d:DisplayObject3D=null):void {
			camera=_camera;
			ob3d=_ob3d;
			cameraRadius=camera.distanceTo(ob3d);
		}
		private var obRY:Number;
		private var obRX:Number;
		private var cameraRadianDown:Number;
		private var cameraRadianNow:Number;
		private var __cameraRadius:Number;
		public var viewHuman:Boolean;
		public var lockY:Boolean;
		public var lock:Boolean;
		public function set cameraRadius(_r:Number):void {
			__cameraRadius=_r;
			var _radian:Number=Math.atan2(camera.y,camera.z);
			camera.z=Math.cos(_radian)*__cameraRadius;
			camera.y=Math.sin(_radian)*__cameraRadius;
		}
		public function get cameraRadius():Number {
			return __cameraRadius;
		}
		public function process(_evt:Event=null):Boolean {
			if (isMouseDown) {
				mouseNowX=mouseX;
				mouseNowY = lockY?0:mouseY;
				ob3d.rotationY += (obRY + (mouseDownX - mouseNowX) * 1 - ob3d.rotationY) * 0.5;
				if (viewHuman) {
					cameraRadianNow+=(cameraRadianDown+(mouseDownY - mouseNowY)*0.02-cameraRadianNow)*0.5;
					if (lock) {
						if (cameraRadianNow<Math.PI/2) {
							cameraRadianNow=Math.PI/2;
						} else if (cameraRadianNow>Math.PI) {
							cameraRadianNow=Math.PI;
						}
					}
					camera.z=Math.cos(cameraRadianNow)*cameraRadius;
					camera.y=Math.sin(cameraRadianNow)*cameraRadius;
				} else {
					ob3d.rotationX += (obRX - mouseDownY + mouseNowY - ob3d.rotationX) * 0.5;
				}
				if (onHold!=null) {
					onHold();
				}
			}
			return isMouseDown;
		}
		public function onMouseClick(evt:MouseEvent):void {
			if (evt.type == "mouseDown") {
				mouseDownX=mouseX;
				mouseDownY=lockY?0:mouseY;
				obRY=ob3d.rotationY;
				if (viewHuman) {
					cameraRadianDown=Math.atan2(camera.y,camera.z);
					cameraRadianNow=cameraRadianDown;
				} else {
					obRX=ob3d.rotationX;
				}
				if (!isMouseDown && onPress != null) {
					onPress();
				}
				isMouseDown=true;
			}else if (evt.type == "mouseUp") {
				if (isMouseDown && onRelease != null) {
					onRelease();
				}
				isMouseDown=false;
			}
		}
		public var zoomMax:Number=6000;
		public var zoomMin:Number=200;
		public var zoomSp:Number=50;
		public function onWheel_handle(evt:MouseEvent):void {
			if (evt.delta>0) {
				if (cameraRadius>zoomMin) {
					cameraRadius-=zoomSp;
				}
			} else {
				if (cameraRadius<zoomMax) {
					cameraRadius+=zoomSp;
				}
			}
		}
	}
}