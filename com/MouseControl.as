package com{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import flash.events.EventDispatcher;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MouseControl extends EventDispatcher {
		
		public var mouseDown:Boolean;
		public var mouseOver:Boolean;
		public var mouseX:Number = 0;
		public var mouseY:Number = 0;
		public var mouseOffsetX:Number = 0;
		public var mouseOffsetY:Number = 0;
		public var mouseDragX:Number = 0;
		public var mouseDragY:Number = 0;
		protected var mouseXY:Sprite;
		protected var mouseClip:Sprite;
		public var onPress:Function;
		public var onRelease:Function;
		public function MouseControl(_mouseClip:Sprite) {
			setClip(_mouseClip);
		}
		public function setClip(_mouseClip:Sprite):void{
			if(!_mouseClip){
				return;
			}else if(!_mouseClip.stage){
				throw new Error("失败：还未将 clip: "+(_mouseClip.name)+" 加入显示列表！");
				return;
			}
			if(!mouseXY){
				mouseXY=new Sprite();
			}
			if(mouseClip){
				//失去控制焦点
				mouseClip.removeEventListener(MouseEvent.MOUSE_DOWN, mousePress);
				mouseClip.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseRelease);
				mouseClip.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				mouseClip.stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeave);
			}
			mouseClip=_mouseClip;
			mouseClip.addEventListener(MouseEvent.MOUSE_DOWN, mousePress, false, 0, true);
			mouseClip.stage.addEventListener(MouseEvent.MOUSE_UP, mouseRelease, false, 0, true);
			mouseClip.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			mouseClip.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave, false, 0, true);
		}
		protected function mousePress(_evt:MouseEvent):void{
			mouseDown = true;
			mouseDragX = 0;
			mouseDragY = 0;
			if(onPress!=null){
				onPress();
			}
		}
		protected function mouseRelease(_evt:MouseEvent):void{
			mouseDown = false;
			if(onRelease!=null){
				onRelease();
			}
		}
		protected function mouseLeave(_evt:Event):void{
			//mouseDown = false;
		}
		protected function mouseMove(_evt:MouseEvent):void{
			mouseX = _evt.stageX - mouseClip.x;
			mouseY = _evt.stageY - mouseClip.y;
			mouseOffsetX = mouseX - mouseXY.x;
			mouseOffsetY = mouseY - mouseXY.y;
			if (mouseDown){
				mouseDragX += mouseOffsetX;
				mouseDragY += mouseOffsetY;
			}
			mouseXY.x = mouseX;
			mouseXY.y = mouseY;
		}
	}
}