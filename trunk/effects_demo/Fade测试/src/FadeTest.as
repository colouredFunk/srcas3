/***
FadeTest
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月12日 14:36:29
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.stage3Ds.Fade;
	import zero.stage3Ds.classic.Pixelate;
	
	public class FadeTest extends Sprite{
		
		private var imgLoader:Loader;
		private var outputBmd:BitmapData;
		
		public function FadeTest(){
			Fade.init(stage.stage3Ds[0],initFadeComlete);
		}
		private function initFadeComlete():void{
			this.scaleX=this.scaleY=0.5;
			imgLoader=new Loader();
			this.addChild(imgLoader);
			imgLoader.x=5;
			imgLoader.y=5;
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImgComplete);
			//imgLoader.load(new URLRequest("1.jpg"));
			//imgLoader.load(new URLRequest("1.png"));
			imgLoader.load(new URLRequest("lulu.jpg"));
		}
		private function loadImgComplete(...args):void{
			var outputBmp:Bitmap=new Bitmap(outputBmd=(imgLoader.content as Bitmap).bitmapData.clone());
			this.addChild(outputBmp);
			outputBmp.x=imgLoader.x;
			outputBmp.y=imgLoader.y+imgLoader.height+5;
			to();
		}
		private function to():void{
			Fade.fromTo((imgLoader.content as Bitmap).bitmapData,outputBmd,24,Pixelate,
				{dimension:1,useFrames:true,ease:200,delay:30,onComplete:from},
				{dimension:100}
			);
		}
		private function from():void{
			Fade.fromTo((imgLoader.content as Bitmap).bitmapData,outputBmd,24,Pixelate,
				{dimension:100,useFrames:true,ease:200,delay:30,onComplete:to},
				{dimension:1}
			);
		}
	}
}