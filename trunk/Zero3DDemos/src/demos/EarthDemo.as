/***
EarthDemo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月23日 22:57:35
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package demos{
	import bmds.EarthBmd;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import zero.zero3D.Camera3D;
	import zero.zero3D.Obj3DContainer;
	import zero.zero3D.Scene3D;
	import zero.zero3D.Sphere;
	
	public class EarthDemo extends Sprite{
		
		private var earthContainer:Sprite;
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var rotateZContainer:Obj3DContainer;
		private var earth:Sphere;
		
		private var rotateSpeedX:Number;
		private var rotateSpeedY:Number;
		private var oldMouseX:Number;
		private var oldMouseY:Number;
		
		public function EarthDemo(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		
		public function added(...args):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			
			this.addChild(earthContainer=new Sprite());
			
			var earthMask:Shape=new Shape();
			earthMask.graphics.clear();
			earthMask.graphics.beginFill(0x000000);
			earthMask.graphics.drawCircle(0,0,300);
			earthMask.graphics.endFill();
			this.addChild(earthMask);
			earthContainer.mask=earthMask;
			
			var txt:TextField=new TextField();
			this.addChild(txt);
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.mouseEnabled=false;
			txt.text="鼠标可拖动地球仪";
			txt.x=-txt.width/2;
			txt.y=-txt.height/2;
			txt.textColor=0xffffff;
			
			scene=new Scene3D();
			camera=new Camera3D(scene);
			camera.z=-camera.dScreen;
			scene.addChild(rotateZContainer=new Obj3DContainer());
			rotateZContainer.addChild(earth=new Sphere(300,12,new EarthBmd(),false,false));
			
			rotateSpeedX=1;
			rotateSpeedY=0;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			enterFrame();
			
		}
		
		public function clear():void{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			earthContainer=null;
			scene.clear();
			scene=null;
			camera.clear();
			camera=null;
			rotateZContainer=null;
			earth=null;
		}
		
		private function mouseDown(...args):void{
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			oldMouseX=this.mouseX;
			oldMouseY=this.mouseY;
			rotateSpeedX=0;
			rotateSpeedY=0;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
		}
		private function mouseMove(...args):void{
			rotateSpeedX=(this.mouseX-oldMouseX)*0.15;
			rotateSpeedY=(this.mouseY-oldMouseY)*0.15;
			rotate(rotateSpeedX,rotateSpeedY);
			oldMouseX=this.mouseX;
			oldMouseY=this.mouseY;
		}
		private function mouseUp(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		
		private function enterFrame(...args):void{
			rotate(rotateSpeedX,rotateSpeedY);
		}
		private function rotate(_rotateSpeedX:Number,_rotateSpeedY:Number):void{
			earth.appendRotation(-_rotateSpeedX,Vector3D.Y_AXIS);
			earth.appendRotation(_rotateSpeedY,Vector3D.X_AXIS);
			camera.output(earthContainer);
		}
		
	}
}