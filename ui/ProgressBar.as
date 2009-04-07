/***
ProgressBar 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2008年11月12日 09:26:56
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	public class ProgressBar extends Sprite {
		public function ProgressBar() {
			maxScale=int(bar.width)*0.01;
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function init():void {
		}
		private function added(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			value=0;
		}
		private function removed(event:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		private var maxScale:Number;
		private var __value:Number;
		public function get value():Number {
			return __value;
		}
		public function set value(_value:Number):void {
			bar.scaleX=(__value=_value>1?1:_value)*maxScale;
			txt.text=int(__value*100)+"%";
		}
	}
}