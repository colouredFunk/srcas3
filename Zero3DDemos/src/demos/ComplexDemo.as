/***
ComplexDemo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月23日 16:25:48
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package demos{
	import bmds.CizhuanBmd;
	import bmds.EarthBmd;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import zero.zero3D.Axiss;
	import zero.zero3D.Camera3D;
	import zero.zero3D.Cube;
	import zero.zero3D.Obj3DContainer;
	import zero.zero3D.Scene3D;
	import zero.zero3D.Sphere;
	import zero.zero3D.Sprite3D;
	
	public class ComplexDemo extends Sprite{
		
		private var container:Sprite;
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var room:Obj3DContainer;
		private var spheres:Obj3DContainer;
		
		public function ComplexDemo(){
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
			txt.y=100;
			txt.textColor=0xffffff;
			
			scene=new Scene3D();
			camera=new Camera3D(scene);
			camera.z=-camera.dScreen;
			scene.addChild(room=new Obj3DContainer());
			
			for(var z:int=-75;z<=75;z+=25){
				for(var y:int=-75;y<=75;y+=25){
					for(var x:int=-75;x<=75;x+=25){
						var sp:Sprite=new Sprite();
						sp.graphics.clear();
						sp.graphics.beginFill(int(0x1000000*Math.random()));
						sp.graphics.drawRect(-10,-10,20,20);
						sp.graphics.endFill();
						var sprite3D:Sprite3D=new Sprite3D(sp);
						room.addChild(sprite3D);
						sprite3D.x=x;
						sprite3D.y=y;
						sprite3D.z=z;
					}
				}
			}
			
			var axiss:Axiss;
			
			room.addChild(axiss=new Axiss(10));
			axiss.y=-100;
			
			room.addChild(axiss=new Axiss(10));
			axiss.z=-100;
			
			room.addChild(axiss=new Axiss(10));
			axiss.x=100;
			
			room.addChild(axiss=new Axiss(10));
			axiss.z=100;
			
			room.addChild(axiss=new Axiss(10));
			axiss.x=-100;
			
			room.addChild(axiss=new Axiss(10));
			axiss.y=100;
			
			var cubeBmd:BitmapData=new CizhuanBmd();
			var cube:Cube=new Cube(400,4,cubeBmd,true,false);
			room.addChild(cube);
			
			room.addChild(spheres=new Obj3DContainer());
			var sphereBmd:BitmapData=new EarthBmd();
			for(y=-100;y<=100;y+=50){
				for(z=-100;z<=100;z+=200){
					for(x=-100;x<=100;x+=200){
						var sphere:Sphere=new Sphere(20,12,sphereBmd);
						spheres.addChild(sphere);
						sphere.x=x;
						sphere.y=y;
						sphere.z=z;
					}
				}
			}
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
			render();
			
		}
		
		public function clear():void{
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
			scene.clear();
			scene=null;
			camera.clear();
			camera=null;
			room=null;
			spheres=null;
		}
		
		private function mouseWheel(event:MouseEvent):void{
			camera.z+=event.delta*30;
		}
		private function enterFrame(...args):void{
			render();
		}
		private function render():void{
			room.rotationY+=(this.mouseX-room.rotationY)*0.2;
			room.rotationX+=(-this.mouseY-room.rotationX)*0.2;
			spheres.rotationY+=2;
			camera.output(container);
		}
		
	}
}