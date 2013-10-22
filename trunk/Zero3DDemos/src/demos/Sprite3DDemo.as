/***
Sprite3DDemo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月24日 17:18:52
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package demos{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import zero.zero3D.Camera3D;
	import zero.zero3D.Obj3DContainer;
	import zero.zero3D.Scene3D;
	import zero.zero3D.Sprite3D;
	
	public class Sprite3DDemo extends Sprite{
		
		[Embed(source="movies/heromovie.swf")]
		private var HeroMovie:Class;
		
		private var container:Sprite;
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		
		private var movies:Obj3DContainer;
		
		public function Sprite3DDemo(){
			
			this.addChild(container=new Sprite());
			
			scene=new Scene3D();
			camera=new Camera3D(scene,500);
			camera.z=-camera.dScreen;
			scene.addChild(movies=new Obj3DContainer());
			
			for(var z:int=-800;z<=800;z+=200){
				for(var x:int=-800;x<=800;x+=200){
					var sprite3D:Sprite3D=new Sprite3D(new HeroMovie());
					movies.addChild(sprite3D);
					sprite3D.y=-100;
					sprite3D.x=x-100;
					sprite3D.z=z;
				}
			}
			
			movies.rotationX=30;
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			enterFrame();
			
		}
		
		public function clear():void{
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			scene.clear();
			scene=null;
			camera.clear();
			camera=null;
		}
		
		private function enterFrame(...args):void{
			camera.x=this.mouseX;
			camera.y=-400-this.mouseY;
			camera.z+=(-1000-this.mouseY*3-camera.z)*0.2;
			camera.output(container);
		}
		
	}
}