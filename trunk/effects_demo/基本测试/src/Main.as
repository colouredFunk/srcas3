/***
 Main
 创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
 创建时间：2012年12月14日 21:35:14
 简要说明：这家伙很懒什么都没写。
 用法举例：这家伙还是很懒什么都没写。
 */

package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import zero.stage3Ds.AGAL2Program;
	import flash.display3D.Context3DProgramType;

	public class Main extends Sprite{
		
		private var currId:int;
		private var TestClassV:Vector.<Class>;
		
		public function Main(){
			
			//trace("stage.stage3Ds="+stage.stage3Ds);
			TestClassV=new <Class>[ColorTest,UVTest,UVTest2,UVTest3,FRCTest];
			currId=-1;
			next();
			
			this.graphics.clear();
			this.graphics.lineStyle(6,0xff0000);
			for(var y:int=0;y<=stage.stageHeight;y+=50){
				this.graphics.moveTo(0,y);
				this.graphics.lineTo(stage.stageWidth,y);
			}
			for(var x:int=0;x<=stage.stageWidth;x+=50){
				this.graphics.moveTo(x,0);
				this.graphics.lineTo(x,stage.stageHeight);
			}
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
		}
		private function mouseDown(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			this.graphics.moveTo(this.mouseX,this.mouseY);
		}
		private function mouseMove(...args):void{
			this.graphics.lineTo(this.mouseX,this.mouseY);
		}
		private function mouseUp(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		private function next():void{
			if(++currId<TestClassV.length){
				new TestClassV[currId](stage.stage3Ds[0],output);
			}
		}
		private function output(bmd:BitmapData):void{
			var bmp:Bitmap=new Bitmap(bmd);
			this.addChild(bmp);
			bmp.x=4+(currId%3)*260;
			bmp.y=4+int(currId/3)*260;
			stage.stage3Ds[0].context3D.dispose();
			next();
		}
	}
}