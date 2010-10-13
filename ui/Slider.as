package ui {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Slider extends ProgressBar {
		public var change:Function;
		
		protected var timeHolded:uint;
		protected var scale:Number;
		
		private var __maximum:Number = 100;
		public function get maximum():Number {
			return __maximum;
		}
		public function set maximum(_maximum:Number):void {
			__maximum = _maximum;
			setStyle();
		}
		private var __minimum:Number = 0;
		public function get minimum():Number {
			return __minimum;
		}
		public function set minimum(_minimum:Number):void {
			__minimum = _minimum;
			setStyle();
		}
		private var __snapInterval:Number = 1;
		public function get snapInterval():Number {
			return __snapInterval;
		}
		public function set snapInterval(_snapInterval:Number):void {
			__snapInterval = _snapInterval;
			setStyle();
		}
		override protected function init():void {
			$rollOut();
			isReferenceFromThumb = true;
			super.init();
		}
		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			enabled = true;
		}
		internal function $rollOver():void {
			ButtonManager.setButtonClipPlay(thumb, true);
			ButtonManager.setButtonClipPlay(bar, true);
			ButtonManager.setButtonClipPlay(track, true);
		}
		internal function $rollOut():void {
			ButtonManager.setButtonClipPlay(thumb, false);
			ButtonManager.setButtonClipPlay(bar, false);
			ButtonManager.setButtonClipPlay(track, false);
		}
		internal function $press():void {
			timeHolded = 0;
			onHoldingHandler(null);
			addEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}
		internal function $release():void {
			timeHolded = 0;
			removeEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}
		internal function $wheel(_delta:int):void {
			if (timeHolded == 0) {
				value += _delta > 0?snapInterval: -snapInterval;
			}
		}
		protected function onHoldingHandler(_evt:Event):void {
			if (thumb) {
				value = Math.round(mouseX / scale / snapInterval) * snapInterval + minimum;
			}else {
				value = Math.round((mouseX-bar.x) / scale / snapInterval) * snapInterval + minimum;
			}
			timeHolded++;
		}
		override protected function formatValue(_value:Number):Number {
			if (_value<minimum) {
				_value=minimum;
			} else if (_value>maximum) {
				_value=maximum;
			}
			return _value;
		}
		override protected function setStyle():void {
			scale = length/(maximum-minimum);
			var _x:uint = Math.round((value-minimum) * scale);
			
			if (isReferenceFromThumb?!thumb:bar) {
				bar.width = _x;
				if (roundShow) {
					bar.width = Math.round(bar.width);
				}
				if (thumb) {
					thumb.x = bar.width + bar.x + offXThumb;
				}
			}else {
				thumb.x = _x;
				if (roundShow) {
					thumb.x = Math.round(thumb.x);
				}
				if (bar) {
					var _width:int = Math.round(thumb.x - bar.x - offXThumb);
					if (_width<0) {
						_width = 0;
					}
					bar.width = _width;
				}
			}
			if (txt) {
				txt.text = value;
			}
		}
	}
}