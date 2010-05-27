package akdcl.application.flvPlayer
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ui_2.SimpleBtn;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class BtnSkin_0 extends SimpleBtn
	{
		public static var GLOW_COLOR:uint = 0x00ff00;
		public var glowClip:Sprite;
		private static var GLOW_HIGH:Object = { alpha:1, blurX:8, blurY:8, strength:2 };
		private static var GLOW_LOW:Object = { alpha:1, blurX:4, blurY:4, strength:1 };
		override protected function added(_evt:Event):void 
		{
			super.added(_evt);
			rollOver = function() {
				glowHith(glowClip);
			}
			rollOut = function() {
				glowLow(glowClip);
			}
			glowLow(glowClip);
		}
		public static function glowHith(_clip:Sprite):void {
			GLOW_HIGH.color = GLOW_COLOR;
			TweenMax.to(_clip, 1, { glowFilter: GLOW_HIGH, ease:Elastic.easeOut } );
		}
		public static function glowLow(_clip:Sprite):void {
			GLOW_LOW.color = GLOW_COLOR;
			TweenMax.to(_clip, 0.5, { glowFilter: GLOW_LOW } );
		}
	}
	
}