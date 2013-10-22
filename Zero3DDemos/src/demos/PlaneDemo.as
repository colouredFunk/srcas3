/***
PlaneDemo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月24日 10:53:52
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package demos{
	import bmds.CizhuanBmd;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import zero.zero3D.Camera3D;
	import zero.zero3D.Plane;
	import zero.zero3D.Scene3D;
	
	public class PlaneDemo extends Sprite{
		
		private var container:Sprite;
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		
		public function PlaneDemo(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		
		public function added(...args):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			
			this.addChild(container=new Sprite());
			
			var txt:TextField=new TextField();
			this.addChild(txt);
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.mouseEnabled=false;
			txt.text="鼠标滚轮可前后移动摄像机";
			txt.x=-txt.width/2;
			txt.y=-txt.height/2;
			txt.textColor=0xffffff;
			
			scene=new Scene3D();
			camera=new Camera3D(scene,200);
			camera.z=-camera.dScreen;
			
			var plane:Plane;
			
			scene.addChild(plane=new Plane(300,200,1,1));
			plane.y=-100;
			plane.rotationX=-10;
			
			scene.addChild(plane=new Plane(300,200,1,1,new CizhuanBmd()));
			plane.y=100;
			plane.rotationX=-10;
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
			
			enterFrame();
			
		}
		
		public function clear():void{
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
			scene.clear();
			scene=null;
			camera.clear();
			camera=null;
		}
		
		private function mouseWheel(event:MouseEvent):void{
			camera.z+=event.delta*30;
		}
		private function enterFrame(...args):void{
			camera.x=this.mouseX*0.2;
			camera.y=this.mouseY*0.2;
			camera.output(container);
		}
		
	}
}