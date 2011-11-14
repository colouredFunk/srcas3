package ui {
	import flash.events.Event;
	import ui.manager.ButtonManager;

	import akdcl.media.DisplayLoader;
	import akdcl.events.InteractionEvent;

	/**
	 * ...
	 * @author akdcl
	 */
	public class ScrollContainer extends DisplayLoader {
		private static const bM:ButtonManager = ButtonManager.getInstance();

		public var lockX:Boolean = true;
		public var lockY:Boolean;

		private var startScrollX:int = 0;
		private var startScrollY:int = 0;
		private var speedX:Number = 0;
		private var speedY:Number = 0;
		private var needMouseChildren:Boolean;

		public function ScrollContainer(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = -1):void {
			super(_rectWidth, _rectHeight, _bgColor);
		}

		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			addEventListener(InteractionEvent.PRESS, onPressHandler);
			addEventListener(InteractionEvent.DRAG_MOVE, onDragMoveHandler);
			addEventListener(InteractionEvent.RELEASE, onReleaseHandler);
			bM.addButton(this);
		}

		override public function updateRect():void {
			super.updateRect();
			scaleWidth = Math.max(scaleWidth, rect.width * 0.99999999);
			scaleHeight = Math.max(scaleHeight, rect.height * 0.99999999);
		}

		private function onPressHandler(_e:InteractionEvent):void {
			if (!lockX){
				startScrollX = scrollX;
			}
			if (!lockY){
				startScrollY = scrollY;
			}
			removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}

		private function onDragMoveHandler(_e:InteractionEvent):void {
			if (!lockX){
				var _dx:int = bM.lastX - bM.startX;
				scrollX = _dx + startScrollX;
			}

			if (!lockY){
				var _dy:int = bM.lastY - bM.startY;
				scrollY = _dy + startScrollY;
			}
			if (mouseChildren){
				needMouseChildren = true;
				mouseChildren = false;
			}
		}

		private function onReleaseHandler(_e:InteractionEvent):void {
			if (!lockX){
				speedX = bM.speedX * 2;
			}
			if (!lockY){
				speedY = bM.speedY * 2;
			}

			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}

		private function onEnterFrameHandler(_e:Event):void {
			if (needMouseChildren) {
				needMouseChildren = false;
				mouseChildren = true;
			}
			if (!lockX){
				scrollX += speedX;
				var _isOutX:Boolean = alignX < 0 || alignX > 1;
				if (_isOutX){
					speedX *= 0.5;
				} else {
					speedX *= 0.95;
				}
			}
			if (!lockY){
				scrollY += speedY;
				var _isOutY:Boolean = alignY < 0 || alignY > 1;
				if (_isOutY){
					speedY *= 0.5;
				} else {
					speedY *= 0.95;
				}
			}
			if (_isOutX || _isOutY){
			} else if (Math.abs(speedX) < 1 && Math.abs(speedY) < 1){
				speedX = 0;
				speedY = 0;
				removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			}
		}
	}

}