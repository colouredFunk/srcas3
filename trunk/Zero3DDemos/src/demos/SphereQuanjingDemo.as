/***
SphereQuanjingDemo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月24日 16:20:35
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package demos{
	
	import bmds.Quanjing2_0Bmd;
	import bmds.Quanjing2_1Bmd;
	import bmds.Quanjing2_2Bmd;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import zero.zero3D.Camera3D;
	import zero.zero3D.Scene3D;
	import zero.zero3D.Sphere;
	
	public class SphereQuanjingDemo extends Sprite{
		
		private var container:Sprite;
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var cameraDScreen:Number;
		private var quanjing:Sphere;
		
		private var currBmdId:int;
		private var bmdArr:Array;
		
		public function SphereQuanjingDemo(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		
		public function added(...args):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			
			scene=new Scene3D();
			cameraDScreen=500;
			camera=new Camera3D(scene,cameraDScreen);
			currBmdId=0;
			bmdArr=[new Quanjing2_0Bmd(),new Quanjing2_1Bmd(),new Quanjing2_2Bmd()];
			scene.addChild(quanjing=new Sphere(2000,24,bmdArr[currBmdId],true,false));
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
			stage.addEventListener(MouseEvent.CLICK,click);
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			enterFrame();
			
		}
		
		public function clear():void{
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
			stage.removeEventListener(MouseEvent.CLICK,click);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			scene.clear();
			scene=null;
			camera.clear();
			camera=null;
			quanjing=null;
		}
		
		private function mouseWheel(event:MouseEvent):void{
			cameraDScreen+=event.delta*30;
			if(cameraDScreen<300){
				cameraDScreen=300;
			}else if(cameraDScreen>1000){
				cameraDScreen=1000;
			}
		}
		private function click(...args):void{
			if(++currBmdId>=bmdArr.length){
				currBmdId=0;
			}
			quanjing.bmd=bmdArr[currBmdId];
		}
		
		private function enterFrame(...args):void{
			camera.dScreen+=(cameraDScreen-camera.dScreen)*0.2;
			quanjing.outterRotationY+=(-this.mouseX*0.5-quanjing.outterRotationY)*0.2;
			quanjing.outterRotationX+=(this.mouseY*0.3-quanjing.outterRotationX)*0.2;
			camera.output(this);
			
			var txt:TextField=new TextField();
			this.addChild(txt);
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.mouseEnabled=false;
			txt.text="鼠标滚轮可前后移动摄像机\n鼠标点击切换图片";
			txt.x=-txt.width/2;
			txt.y=10;
			txt.textColor=0xffffff;
			
			this.graphics.lineStyle(2,0xff0000,0.5);
			this.graphics.moveTo(-10,0);
			this.graphics.lineTo(10,0);
			this.graphics.moveTo(0,-10);
			this.graphics.lineTo(0,10);
			
		}
		
	}
}