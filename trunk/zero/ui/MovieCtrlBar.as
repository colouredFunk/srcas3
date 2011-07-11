/***
MovieCtrlBar 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月1日 13:18:15
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class MovieCtrlBar extends Sprite{
		private var movie:MovieClip;
		public function MovieCtrlBar(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			movie=this.parent as MovieClip;
			hitShape.addEventListener(MouseEvent.CLICK,click);
			hitShape.buttonMode=true;
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			bar.mouseEnabled=bar.mouseChildren=false;
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			movie=null;
			hitShape.removeEventListener(MouseEvent.CLICK,click);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			bar.scaleX=movie.currentFrame/movie.totalFrames;
		}
		private function click(event:MouseEvent):void{
			bar.width=this.mouseX;
			var frame:int=int(bar.scaleX*movie.totalFrames)+1;
			if(movie.currentFrame!=frame){
				movie.gotoAndPlay(frame);
			}
		}
		public function setProgressEvent(event:ProgressEvent):void{
			hitShape.scaleX=movie.framesLoaded/movie.totalFrames;
		}
	}
}

