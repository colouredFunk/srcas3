/***
FreeTranDot 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2009年2月4日 09:22:54
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package ui_2{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class FreeTranDot extends Sprite{
		public var xId:int;
		public var yId:int;
		public function FreeTranDot(){
			addEventListener(Event.ADDED_TO_STAGE,added);
			
			xId=int(name.charAt(4));
			yId=int(name.charAt(5));
			if(xId>0){
				xId=(xId-1.5)*2;
			}
			if(yId>0){
				yId=(yId-1.5)*2;
			}
			mouseChildren=false;
		}
		private function added(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,added);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
			addEventListener(MouseEvent.MOUSE_OVER,(parent as FreeTran).rollOverDot);
			addEventListener(MouseEvent.MOUSE_OUT,(parent as FreeTran).rollOutArea);
			addEventListener(MouseEvent.MOUSE_DOWN,(parent as FreeTran).pressDot);
		}
		private function removed(event:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			removeEventListener(MouseEvent.MOUSE_OVER,(parent as FreeTran).rollOverDot);
			removeEventListener(MouseEvent.MOUSE_OUT,(parent as FreeTran).rollOutArea);
			removeEventListener(MouseEvent.MOUSE_DOWN,(parent as FreeTran).pressDot);
		}
	}
}
