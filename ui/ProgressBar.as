package ui{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ProgressBar extends SimpleBtn {
		public var change:Function;
		
		public var txt:*;
		public var thumb:*;
		public var bar:*;
		public var maskClip:*;
		public var track:*;
		
		protected var offXThumb:int;
		protected var offWidthMaskClip:int;
		protected var offWidthTrack:int;
		
		private var __roundShow:Boolean;
		public function get roundShow():Boolean{
			return __roundShow;
		}
		public function set roundShow(_roundShow:Boolean):void{
			__roundShow = _roundShow;
			setStyle();
		}
		private var __length:uint;
		public function get length():uint {
			return __length;
		}
		public function set length(_length:uint):void {
			__length = _length;
			if (maskClip && bar) {
				maskClip.width = offWidthMaskClip +__length;
			}
			if (track) {
				track.width = offWidthTrack +__length - offXThumb * 2;
			}
			setStyle();
		}
		private var __value:Number = 0;
		public function get value():Number {
			return __value;
		}
		public function set value(_value:Number):void {
			_value = formatValue(_value);
			if (__value == _value) {
				return;
			}
			__value = _value;
			if (change != null) {
				change(__value);
			}
			setStyle();
		}
		override protected function init():void {
			super.init();
			if (track) {
				if (bar) {
					offWidthTrack = track.width - bar.width;
				}else {
					offWidthTrack = track.width - thumb.x;
				}
			}
			if (maskClip) {
				if (bar) {
					offWidthMaskClip = maskClip.width - bar.width;
					maskClip.cacheAsBitmap = true;
					bar.cacheAsBitmap = true;
					maskClip.mask = bar;
				}else {
					maskClip.cacheAsBitmap = true;
					thumb.cacheAsBitmap = true;
					thumb.mask = maskClip;
				}
			}
			if (thumb && bar) {
				offXThumb = thumb.x - bar.width - bar.x;
				length = (thumb.x - bar.x + offXThumb)  * scaleX;
			}else if (bar) {
				length = bar.width * scaleX;
			}else {
				length = thumb.x  * scaleX;
			}
			scaleX = 1;
			enabled = false;
		}
		override protected function onRemoveToStageHandler():void {
			super.onRemoveToStageHandler();
			change = null;
			txt = null;
			thumb = null;
			bar = null;
			maskClip = null;
			track = null;
		}
		protected function formatValue(_value:Number):Number {
			if (isNaN(_value)) {
				_value = 0;
			}
			if (_value < 0) {
				_value = 0;
			} else if (_value > 1) {
				_value = 1;
			}
			return _value;
		}
		protected function setStyle():void {
			setClips(value * length);
			setText();
		}
		protected function setClips(_value:Number):void {
			if (thumb && bar) {
				thumb.x = _value + bar.x - offXThumb;
				var _width:int = Math.round(_value - 2 * offXThumb);
				if (_width<0) {
					_width = 0;
				}
				bar.width = _width;
			}else if(bar){
				bar.width = _value;
			}else {
				thumb.x = _value;
			}
			if (roundShow) {
				if (thumb) {
					thumb.x = Math.round(thumb.x);
				}
				if (bar) {
					bar.x = Math.round(bar.x);
				}
			}
		}
		protected function setText():void {
			if (txt) {
				txt.text = Math.round(value * 100) + " %";
			}
		}
	}
}