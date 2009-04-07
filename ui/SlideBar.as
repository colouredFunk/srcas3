/***
SlideBar 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2009年2月14日 16:57:50
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class SlideBar extends Sprite{
		private var isDragging:Boolean;
		private var top:Number;
		private var bottom:Number;
		public var onUpdate:Function;
		public function SlideBar(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			btn.addEventListener(MouseEvent.MOUSE_DOWN,_startDrag);
			btn1.addEventListener(MouseEvent.MOUSE_DOWN,f1);
			btn2.addEventListener(MouseEvent.MOUSE_DOWN,f2);
			top=btn.height/2;
			bottom=bar.height-btn.height/2;
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			btn.removeEventListener(MouseEvent.MOUSE_DOWN,_startDrag);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			btn1.removeEventListener(MouseEvent.MOUSE_DOWN,f1);
			btn2.removeEventListener(MouseEvent.MOUSE_DOWN,f2);
			onUpdate=null;
		}
		private function mouseUp(event:Event):void{
			if(isDragging){
				isDragging=false;
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			}
		}
		private function _startDrag(event:MouseEvent):void{
			isDragging=true;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		private function mouseMove(event:MouseEvent):void{
			if(isDragging){
				update(this.mouseY);
			}
		}
		private function f1(event:MouseEvent):void{
			update(btn.y-10);
		}
		private function f2(event:MouseEvent):void{
			update(btn.y+10);
		}
		private function update(y:Number):void{
			if(y<top){
				y=top;
			}else if(y>bottom){
				y=bottom;
			}
			btn.y=y;
			if(onUpdate!=null){
				onUpdate(1-(y-top)/(bottom-top));
			}
		}
		public function updateByScale(scale:Number):void{
			btn.y=(1-scale)*(bottom-top)+top;
		}
	}
}
