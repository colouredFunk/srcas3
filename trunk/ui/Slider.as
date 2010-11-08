package ui {
	import flash.events.Event;
	import ui.manager.ButtonManager;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Slider extends ProgressBar {
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
		public function get isHold():Boolean {
			return timeHolded > 0;
		}
		override protected function init():void {
			super.init();
			enabled = true;
		}
		public function $setStyle(_isActive:Boolean):void {
			if (_isActive) {
				ButtonManager.setButtonClipPlay(thumb, true);
				ButtonManager.setButtonClipPlay(bar, true);
				ButtonManager.setButtonClipPlay(track, true);
			}else {
				ButtonManager.setButtonClipPlay(thumb, false);
				ButtonManager.setButtonClipPlay(bar, false);
				ButtonManager.setButtonClipPlay(track, false);
			}
		}
		public function $press():void {
			timeHolded = 0;
			onHoldingHandler(null);
			addEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}
		public function $release():void {
			timeHolded = 0;
			removeEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}
		public function $wheel(_delta:int):void {
			if (timeHolded == 0) {
				value += _delta * snapInterval;
			}
		}
		protected function onHoldingHandler(_evt:Event):void {
			if (bar) {
				value = Math.round((mouseX - bar.x + offXThumb) / scale / snapInterval) * snapInterval + minimum;
			}else {
				value = Math.round(mouseX / scale / snapInterval) * snapInterval + minimum;
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
			setClips(Math.round((value-minimum) * scale));
			if (txt) {
				txt.text = (labelFunction!=null)?labelFunction(value):setLabel(value);
			}
		}
		override protected function setLabel(_value:Number):String {
			return String(value);
		}
	}
}