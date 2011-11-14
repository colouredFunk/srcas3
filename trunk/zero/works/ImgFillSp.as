/***
ImgFillSp
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月20日 09:51:01
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ImgFillSp extends Sprite{
		private var bmd:BitmapData;
		private var xml:XML;
		private var loader:Loader;
		private var container:Sprite;
		private var container2:Sprite;
		private var onLoadComplete:Function;
		private var onFadeComplete:Function;
		private var mask_mc:MovieClip;
		public function ImgFillSp(xmlOrSrc:*=null,_onLoadComplete:Function=null,_onFadeComplete:Function=null,_mask_mc:MovieClip=null):void{
			
			container2=new Sprite();
			this.addChild(container2);
			container=new Sprite();
			this.addChild(container);
			
			loader=new Loader();
			
			if(xmlOrSrc){
				init(xmlOrSrc,_onLoadComplete,_onFadeComplete,_mask_mc);
			}
		}
		public function init(xmlOrSrc:*,_onLoadComplete:Function=null,_onFadeComplete:Function=null,_mask_mc:MovieClip=null):void{
			
			clear();
			
			draw(container2);
			
			if(xmlOrSrc is XML){
				xml=xmlOrSrc;
			}else{
				xml=<img src={xmlOrSrc}/>;
			}
			onLoadComplete=_onLoadComplete;
			onFadeComplete=_onFadeComplete;
			mask_mc=_mask_mc;
			if(mask_mc){
				this.addChild(mask_mc);
				mask_mc.gotoAndStop(1);
				mask_mc.addFrameScript(mask_mc.totalFrames-1,mask_mc_lastFrame);
				mask_mc.cacheAsBitmap=true;
				container.cacheAsBitmap=true;
				container.mask=mask_mc;
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			loader.load(new URLRequest(xml.@src.toString()));
		}
		public function clearBmd():void{
			if(bmd){
				bmd.dispose();
				bmd=null;
			}
		}
		public function clear():void{
			onLoadComplete=null;
			onFadeComplete=null;
			this.removeEventListener(Event.ENTER_FRAME,showContainer_step);
			container.graphics.clear();
			if(mask_mc){
				mask_mc.stop();
				mask_mc.addFrameScript(mask_mc.totalFrames-1,null);
				this.removeChild(mask_mc);
				mask_mc=null;
			}
		}
		private function loadComplete(event:Event):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			bmd=(loader.content as Bitmap).bitmapData;
			draw(container);
			
			if(onLoadComplete==null){
			}else{
				onLoadComplete();
				onLoadComplete=null;
			}
			
			if(mask_mc){
				container.alpha=1;
				mask_mc.gotoAndPlay(2);
			}else{
				container.alpha=0;
				this.addEventListener(Event.ENTER_FRAME,showContainer_step);
			}
		}
		private function mask_mc_lastFrame():void{
			mask_mc.stop();
			fadeComplete();
		}
		private function showContainer_step(event:Event):void{
			if((container.alpha+=0.2)>0.95){
				container.alpha=1;
				this.removeEventListener(Event.ENTER_FRAME,showContainer_step);
				fadeComplete();
			}
		}
		private function fadeComplete():void{
			if(onFadeComplete==null){
			}else{
				onFadeComplete();
				onFadeComplete=null;
			}
		}
		private function draw(_container:Sprite):void{
			_container.graphics.clear();
			if(bmd){
				_container.graphics.beginBitmapFill(bmd,null,true);
				_container.graphics.drawRect(int(xml.@x.toString()),int(xml.@y.toString()),int(xml.@width.toString())||loader.content.width,int(xml.@height.toString())||loader.content.height);
				switch(xml.@align.toString()){
					case "center":
						_container.x=-_container.width/2;
						_container.y=-_container.height/2;
					break;
				}
				if(xml.@smoothing.toString()=="true"){
					(loader.content as Bitmap).smoothing=true;
				}
			}
		}
	}
}