/***
TextureTest
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月10日 23:41:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	import zero.stage3Ds.Fade;
	import zero.stage3Ds.effects.*;
	
	public class TextureTest extends Sprite{
		
		private var imgLoader:Loader;
		private var bmd:BitmapData;
		
		private var outputBmd:BitmapData;
		
		//private var test:Test;
		//private var argb:ARGB;
		private var pixelate:Pixelate;
		
		public function TextureTest(){
			
			imgLoader=new Loader();
			//this.addChild(imgLoader);
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImgComplete);
			imgLoader.load(new URLRequest("1.jpg"));
			//imgLoader.load(new URLRequest("zero.gif"));
		}
		private function loadImgComplete(...args):void{
			
			bmd=(imgLoader.content as Bitmap).bitmapData;
			imgLoader.unloadAndStop();
			
			this.addChild(new Bitmap(outputBmd=new BitmapData(bmd.width,bmd.height,true,0x00000000)));
			
			Fade.init(stage.stage3Ds[0],initComplete);
		}
		private function initComplete():void{
			//Fade.initEffect(bmd,test=new Test());
			//Fade.initEffect(bmd,argb=new ARGB());
			Fade.initEffect(bmd,pixelate=new Pixelate());
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			enterFrame();
		}
		public function enterFrame(...args):void{
			
			//Fade.update(outputBmd);
			
			//if((argb.red-=0.05)<0){
			//	argb.red=0;
			//}
			//if((argb.green-=0.05)<0){
			//	argb.green=0;
			//}
			//if((argb.blue-=0.05)<0){
			//	argb.blue=0;
			//}
			//if((argb.alpha-=0.01)<0){
			//	argb.alpha=0;
			//}
			//argb.alpha=1;
			//argb.alpha=0.75;
			//argb.alpha=0.5;
			//Fade.update(outputBmd);
			//trace("#"+outputBmd.getPixel32(0,0).toString(16));
			//argb.alpha=1;		#ff0c0c09
			//argb.alpha=0.75;	#ff0c0c09
			//argb.alpha=0.5;	#7f0c0c08
			
			pixelate.dimension++;
			//pixelate.dimension=100;
			Fade.update(outputBmd);
		}
	}
}