/***
TxtBtn 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年10月16日 11:09:09
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	public class TxtBtn extends Sprite{
		public var onClick:Function;
		public function TxtBtn(text:String,width:int=0){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			txt.autoSize=TextFieldAutoSize.CENTER;
			txt.mouseEnabled=false;
			txt.text=text;
			if(width>0){
				btn.width=width;
				txt.x=(width-txt.width)/2;
			}
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.addEventListener(MouseEvent.CLICK,click);
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.removeEventListener(MouseEvent.CLICK,click);
			onClick=null;
		}
		private function click(event:MouseEvent):void{
			onClick(txt.text);
		}
	}
}

