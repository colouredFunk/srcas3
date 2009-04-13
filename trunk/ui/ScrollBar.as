/***
ScrollBar 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2008年12月10日 14:49:54
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	public class ScrollBar extends Sprite {

		//组件定义时启用
		/*[Inspectable(defaultValue="")]
		public function set scrollTargetName(_scrollTargetName:String):void{
		}*/


		private var currObj:DisplayObject;
		private var dragRect:Rectangle;

		private var objYMin:Number;
		private var objMoveDy:Number;
		private var dir:int;

		public function ScrollBar() {
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			dragRect=new Rectangle(0,btnUp.y+btn.height*0.5,0,btnDown.y-btnUp.y-btn.height);
			setEnabled(false);
		}
		private function added(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);

			btn.press=press;
			btnUp.press=goUp;
			btnDown.press=goDown;

			btn.rollOverSnd=btn.pressSnd=null;
			btnUp.rollOverSnd=btnUp.pressSnd=null;
			btnDown.rollOverSnd=btnDown.pressSnd=null;

			stage.addEventListener(MouseEvent.MOUSE_UP,release);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,wheel);
		}
		private function removed(event:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.removeEventListener(MouseEvent.MOUSE_UP,release);
			this.removeEventListener(Event.ENTER_FRAME,updateCurrObj);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL,wheel);
			currObj=null;
			dragRect=null;
		}
		[Inspectable(defaultValue="")];
		public function set scrollTargetName(_scrollTargetName:String):void {
			if (currObj) {
				//currObj.y=objYMin;
			}
			currObj=this.parent.getChildByName(_scrollTargetName);
			if (currObj) {
				if(currObj.height<rect.height){
					setEnabled(false);
					return;
				}
				var b:Rectangle=currObj.getBounds(this.parent);
				//b.height+=10;//底部留10个像素的空白
				objYMin=int(this.y+currObj.y-b.y);
				objMoveDy=rect.height-b.height;
				currObj.mask=rect;
				updateCurrObj(null);
				setEnabled(true);
			} else {
				setEnabled(false);
			}
		}
		public function setEnabled(_b:Boolean):void{
			btn.setEnabled(_b);
			btnUp.setEnabled(_b);
			btnDown.setEnabled(_b);
			mouseEnabled=_b;
		}
		public function reset():void{
			btn.y=dragRect.y;
			dir=0;
			scrollTargetName=currObj.name;
		}
		private function goUp():void {
			dir=-1;
			this.addEventListener(Event.ENTER_FRAME,updateCurrObj);
		}
		private function goDown():void {
			dir=1;
			this.addEventListener(Event.ENTER_FRAME,updateCurrObj);
		}
		private function wheel(event:MouseEvent):void{
			dir=event.delta>0?-1:1;
			updateCurrObj(null);
		}
		private function press():void {
			dir=0;
			btn.startDrag(false,dragRect);
			this.addEventListener(Event.ENTER_FRAME,updateCurrObj);
		}
		private function release(event:MouseEvent):void {
			stopDrag();
			this.removeEventListener(Event.ENTER_FRAME,updateCurrObj);
		}
		private function updateCurrObj(event:Event):void {
			if(!mouseEnabled){
				return;
			}
			if (dir>0) {
				btn.y+=10;
				if (btn.y>dragRect.y+dragRect.height) {
					btn.y=dragRect.y+dragRect.height;
				}
			} else if (dir<0) {
				btn.y-=10;
				if (btn.y<dragRect.y) {
					btn.y=dragRect.y;
				}
			}
			currObj.y=objYMin+int(objMoveDy*(btn.y-dragRect.y)/dragRect.height);
			trace(currObj.y+"___"+objYMin);
		}
	}
}