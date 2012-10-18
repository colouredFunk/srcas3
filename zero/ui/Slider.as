/***
Slider
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月10日 14:22:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class Slider extends Sprite{
		
		private var __value:Number;
		
		public var bar:Btn;
		public var line:Sprite;
		public var thumb:Btn;
		
		public var onUpdate:Function;
		
		public function get value():Number{
			return __value;
		}
		public function set value(_value:Number):void{
			__value=_value;
			if(__value>=0&&__value<=1){
			}else if(__value>1){
				__value=1;
			}else{
				__value=0;
			}
			thumb.x=line.width=bar.width*__value;
		}
		
		public function Slider(){
			value=0;
			bar.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			line.mouseEnabled=line.mouseChildren=false;
		}
		public function clear():void{
			mouseUp();
			bar.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			thumb.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			onUpdate=null;
		}
		private function mouseDown(event:MouseEvent):void{
			if(event.target==thumb){
			}else{
				thumb.x=this.mouseX;
			}
			thumb.startDrag(false,new Rectangle(0,thumb.y,bar.width,0));
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			this.addEventListener(Event.ENTER_FRAME,update);
		}
		private function mouseUp(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			this.removeEventListener(Event.ENTER_FRAME,update);
			stopDrag();
		}
		private function update(...args):void{
			value=thumb.x/bar.width;
			if(onUpdate==null){
			}else{
				onUpdate();
			}
		}
	}
}