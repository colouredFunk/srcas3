package akdcl.game.collision
{
	import akdcl.game.collision.Collision;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Tile extends Sprite
	{
		public static var tileWidth:Number = 40;
		public static var tileHeight:Number = 40;
		
		public static var acceleration:Number = 2;
		public static var isVertical:Boolean = true;
		
		public var clip:MovieClip;
		
		public var lineX:int;
		public var lineY:int;
		private var isFall:Boolean;
		private var isRemove:Boolean;
		private var speed:Number = 0;
		public var onFallBegin:Function;
		public var onFallEnd:Function;
		public var onRemove:Function;
		public var onRemoveFallBegin:Function;
		public function Tile() {
			clip.stop();
			width = tileWidth;
			height = tileHeight;
		}
		public function setLine(_lineX:int,_lineY:int):void {
			lineX = _lineX;
			lineY = _lineY;
			setRoundXY();
		}
		private var __value:int;
		public function set value(_value:int):void {
			__value = _value;
			clip.gotoAndStop(__value);
		}
		public function get value():int {
			return __value;
		}
		private var removeSpx:Number;
		private var removeSpy:Number;
		private var removeSpr:Number;
		public function remove():void {
			isRemove = true;
			if (onRemove != null) {
				onRemove();
			}
			TweenMax.to(this, 0.2, {colorMatrixFilter:{brightness:3}});
			TweenMax.to(this, 0.2, {colorMatrixFilter:{remove:true},delay:0.2,onComplete:remmoveFallBegin});
		}
		private function remmoveFallBegin():void {
			var _power:Number = Math.random() * 10+5;
			var _radian:Number = Math.random() * Math.PI * 0.5 - Math.PI * 0.75;
			removeSpx = _power*Math.cos(_radian);
			removeSpy = _power * Math.sin(_radian);
			removeSpr = Math.random()*_power*0.5;
			this.addEventListener(Event.ENTER_FRAME, removeFalling);
			if (onRemoveFallBegin != null) {
				onRemoveFallBegin();
			}
		}
		private function removeFalling(_evt:Event):void {
			x += removeSpx;
			y += removeSpy;
			removeSpy += acceleration;
			clip.rotation += removeSpr;
			alpha -= 0.04;
			if (alpha<0) {
				removeRightNow();
			}
		}
		public function removeRightNow():void {
			this.removeEventListener(Event.ENTER_FRAME, falling);
			this.removeEventListener(Event.ENTER_FRAME, removeFalling);
			parent.removeChild(this);
			onFallBegin = null;
			onFallEnd = null;
			onRemove = null;
			onRemoveFallBegin = null;
			
			removeChild(clip);
			clip = null;
		}
		public function findPrev():Array {
			var _lineX:int = lineX;
			var _lineY:int = lineY;
			if (isVertical) {
				_lineY += acceleration > 0? -1:1;
			}else {
				_lineX += acceleration > 0? -1:1;
			}
			return [_lineX,_lineY];
		}
		public function fallBegin():void {
			if (isRemove) {
				return;
			}
			speed = 0;
			this.addEventListener(Event.ENTER_FRAME, falling);
			if (onFallBegin != null) {
				onFallBegin();
			}
		}
		private function falling(_evt:Event):void {
			var _n:int = vpNum(speed+acceleration);
			speed += acceleration;
			//速度不能超过一个tile
			adjustLine();
			if (Collision.instance.isHit(lineX + (isVertical ? 0 : _n), lineY + (isVertical ? _n : 0))) {
				fallEnd();
			} else {
				if (isVertical) {
					y += speed;
				} else {
					x += speed;
				}
			}
		}
		private function fallEnd():void {
			this.removeEventListener(Event.ENTER_FRAME, falling);
			speed = 0;
			setRoundXY();
			if (onFallEnd != null) {
				onFallEnd();
			}
		}
		private function setRoundXY():void {
			x = tileWidth * lineX;
			y = tileHeight * lineY;
		}
		private function adjustLine():void {
			if (isVertical) {
				lineY = (y+speed) / tileHeight;
				lineY = acceleration > 0 ? Math.floor(lineY) : Math.ceil(lineY);
			} else {
				lineX = (x+speed) / tileWidth;
				lineX = acceleration > 0 ? Math.floor(lineX) : Math.ceil(lineX);
			}
		}
		private static function vpNum(_n:Number, _t:Number=1):Number {
			if (_n == 0) {
				return 0;
			} else if (_n>0) {
				return _t;
			} else {
				return -_t;
			}
		}
	}
	
}