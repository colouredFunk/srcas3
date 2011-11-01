﻿package ui {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class SliderBar extends UISprite {
		public var offY:int;
		private var offX:int;
		private var maximum:int;

		public var btnUp:*;
		public var btnDown:*;
		public var slider:*;
		public var maskArea:*;

		public var wheelInterval:uint = 40;
		public var headerHeight:uint = 0;
		public var footerHeight:uint = 20;

		public var autoSize:Boolean = true;

		public var isCacheAsBitmap:Boolean;

		public function get areaHeight():int {
			return maskArea.height;
		}

		public function set areaHeight(_areaHeight:int):void {
			maskArea.height = _areaHeight;
		}

		public function get value():Number {
			return slider.value;
		}

		public function set value(_value:Number):void {
			slider.value = _value;
		}
		private var __content:*;

		public function get content():* {
			return __content;
		}

		public function set content(_content:*):void {
			if (__content){
				__content.mask = null;
			}
			__content = _content;
			if (__content){
				__content.mask = maskArea;
			}
			if (__content && __content.height > maskArea.height){
				var _rect:Rectangle = __content.getBounds(__content.parent);
				offX = int(x + __content.x - _rect.x);
				offY = int(y + __content.y - _rect.y) + headerHeight;
				__content.x = offX;
				maskArea.width = __content.width + 5;
				if (isCacheAsBitmap){
					__content.cacheAsBitmap = true;
					maskArea.cacheAsBitmap = true;
				}

				maximum = __content.height - maskArea.height + headerHeight + footerHeight;
				slider.maximum = maximum;
				if (autoSize){
					slider.x = maskArea.width + 10;
					slider.length = maskArea.height - slider.y * 2;
				}

				setStyle();
				enabled = true;
				visible = true;
			} else {
				//if (__content) {
				//	__content.mask = null;
				//}
				enabled = false;
				visible = false;
			}
		}

		override protected function init():void {
			super.init();
			//slider.mouseWheelEnabled = false;
			slider.change = function(_value:Number):void {
				setStyle();
			};
			maskArea.visible = false;
			if (btnUp){
				//btn_up.press=goUp;
			}
			if (btnDown){
				//btn_down.press=goDown;
			}
			enabled = false;
		}

		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
		}

		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			content = null;

			btnUp = null;
			btnDown = null;
			slider = null;
			maskArea = null;
		}

		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			buttonMode = false;
		}

		protected function setStyle():void {
			if (!content){
				return;
			}
			content.y = offY - value;
		}

		protected function onMouseWheelHandler(_e:MouseEvent):void {
			slider.value += (_e.delta > 0 ? -1 : 1) * wheelInterval;
		}
	/*
	   private function goUp():void {
	   }
	   private function goDown():void {
	   }
	 */
	}
}