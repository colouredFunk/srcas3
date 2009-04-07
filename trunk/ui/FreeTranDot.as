/***
FreeTranDot 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2009年2月4日 09:22:54
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class FreeTranDot extends Sprite{
		public var xId:int;
		public var yId:int;
		public function FreeTranDot(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			
			xId=int(this.name.charAt(4));
			yId=int(this.name.charAt(5));
			if(xId>0){
				xId=(xId-1.5)*2;
			}
			if(yId>0){
				yId=(yId-1.5)*2;
			}
			this.mouseChildren=false;
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.addEventListener(MouseEvent.MOUSE_OVER,(this.parent as FreeTran).rollOverDot);
			this.addEventListener(MouseEvent.MOUSE_OUT,(this.parent as FreeTran).rollOutArea);
			this.addEventListener(MouseEvent.MOUSE_DOWN,(this.parent as FreeTran).pressDot);
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.removeEventListener(MouseEvent.MOUSE_OVER,(this.parent as FreeTran).rollOverDot);
			this.removeEventListener(MouseEvent.MOUSE_OUT,(this.parent as FreeTran).rollOutArea);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,(this.parent as FreeTran).pressDot);
		}
	}
}
