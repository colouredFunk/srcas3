package com{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import flash.events.EventDispatcher;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
    import flash.external.ExternalInterface;
	
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
		public function isMoved():Boolean{
			return Boolean(mouseDragX*mouseDragY!=0);
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
			mouseDragX = 0;
			mouseDragY = 0;
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
		
		
		
		
        private static var mouseInStage:Boolean = false;
        private static var __mouseWheelEnabled:Boolean = true;
        public static function fixWheel(_stage:Stage):void {
            _stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMousIn);
            _stage.addEventListener(Event.MOUSE_LEAVE, handleMousOut);
        }

        /**
         * 取消校正。
         */
        public static function freeWheel(_stage:Stage):void {
            _stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMousIn);
            _stage.removeEventListener(Event.MOUSE_LEAVE, handleMousOut);
        }
        private static function handleMousIn(_evt:Event):void {
            if(!mouseInStage) {
                mouseInStage = true;
                mouseWheelEnabled = false;
            }
        }

        private static function handleMousOut(_evt:Event):void {
            if(mouseInStage) {
                mouseInStage = false;
                mouseWheelEnabled = true;
            }
        }

        /**
         * 获取/设置 window 的鼠标滚动是否可用，用此属性可用启用或者禁用 window 对鼠标滚轮的响应。
         */
        public static function set mouseWheelEnabled(_mouseWheelEnabled:Boolean):void {
            __mouseWheelEnabled = _mouseWheelEnabled;
            if(!__mouseWheelEnabled) {
                ExternalInterface.call("eval", "var _onFlashMousewheel = function(e){e = e || event;e.preventDefault && e.preventDefault();e.stopPropagation && e.stopPropagation();return e.returnValue = false;};if(window.addEventListener){var type = (document.getBoxObjectFor)?'DOMMouseScroll':'mousewheel';window.addEventListener(type, _onFlashMousewheel, false);}else{document.onmousewheel = _onFlashMousewheel;}");
            }else {
                ExternalInterface.call("eval", "if(window.removeEventListener){var type = (document.getBoxObjectFor)?'DOMMouseScroll':'mousewheel';window.removeEventListener(type, _onFlashMousewheel, false);}else{document.onmousewheel = null;}");                
            }
        }

        public static function get mouseWheelEnabled():Boolean {
            return __mouseWheelEnabled;
        }
	}
}