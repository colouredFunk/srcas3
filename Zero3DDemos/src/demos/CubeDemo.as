/***
CubeDemo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月22日 11:26:48
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package demos{
	import bmds.CizhuanBmd;
	import bmds.Quanjing3_0Bmd;
	import bmds.Quanjing3_1Bmd;
	import bmds.Quanjing3_2Bmd;
	import bmds.Quanjing3_3Bmd;
	import bmds.Quanjing3_4Bmd;
	import bmds.Quanjing3_5Bmd;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import zero.zero3D.Camera3D;
	import zero.zero3D.Cube;
	import zero.zero3D.Obj3DContainer;
	import zero.zero3D.Scene3D;
	
	public class CubeDemo extends Sprite{
		
		private var container:Sprite;
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var cubes:Obj3DContainer;
		
		public function CubeDemo(){
			
			scene=new Scene3D();
			camera=new Camera3D(scene);
			camera.z=-camera.dScreen;
			scene.addChild(cubes=new Obj3DContainer());
			
			var cube:Cube;
			
			cubes.addChild(cube=new Cube(160,4,new CizhuanBmd()));
			cube.x=-165;
			
			cubes.addChild(cube=new Cube(160));
			
			var quanjingBmdArr:Array=[
				new Quanjing3_0Bmd(),
				new Quanjing3_1Bmd(),
				new Quanjing3_2Bmd(),
				new Quanjing3_3Bmd(),
				new Quanjing3_4Bmd(),
				new Quanjing3_5Bmd()
			];
			
			cubes.addChild(cube=new Cube(160,4,quanjingBmdArr));
			cube.x=165;
			
			cubes.addChild(cube=new Cube(2000,12,quanjingBmdArr,true,false));
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			render();
			
		}
		
		public function clear():void{
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			scene.clear();
			scene=null;
			camera.clear();
			camera=null;
			cubes=null;
		}
		
		private function enterFrame(...args):void{
			render();
		}
		private function render():void{
			cubes.rotationY+=(this.mouseX-cubes.rotationY)*0.2;
			cubes.rotationX+=(-this.mouseY-cubes.rotationX)*0.2;
			camera.output(this);
		}
		
	}
}