/***
ImgLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月14日 14:26:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.utils.stopAll;
	
	public class ImgLoader extends Sprite{
		
		private var xml:XML;
		
		public var loader:Loader;
		private var container:Sprite;
		private var container2:Sprite;
		
		public var onLoadProgress:Function;
		public var onLoadComplete:Function;
		public var onLoadError:Function;
		public var onFadeComplete:Function;
		
		public var mask_mc:MovieClip;
		
		public function ImgLoader():void{
			container2=new Sprite();
			this.addChild(container2);
			container2.mouseEnabled=container2.mouseChildren=false;
			container=new Sprite();
			this.addChild(container);
		}
		public function clear():void{
			
			clearLoader();
			clearMaskMc();
			
			var i:int;
			
			i=container2.numChildren;
			while(--i>=0){
				container2.removeChildAt(i);
			}
			
			i=container.numChildren;
			while(--i>=0){
				container.removeChildAt(i);
			}
			
			this.removeEventListener(Event.ENTER_FRAME,showContainer_step);
			
			onLoadProgress=null;
			onLoadComplete=null;
			onLoadError=null;
			onFadeComplete=null;
		}
		public function clearLoader():void{
			if(loader){
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
				loader.unload();
				loader=null;
			}
		}
		public function clearMaskMc():void{
			if(mask_mc){
				mask_mc.stop();
				mask_mc.addFrameScript(mask_mc.totalFrames-1,null);
				if(mask_mc.parent==this){
					this.removeChild(mask_mc);
				}
				mask_mc=null;
			}
			container.cacheAsBitmap=false;
			container.mask=null;
		}
		
		public function load(data:*,_mask_mc:MovieClip=null):void{
			if(loader){
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
				stopAll(loader);
				container2.addChild(loader);
			}
			
			clearMaskMc();
			
			if(data is ByteArray){
				xml=<img/>;
			}else if(data is XML){
				xml=data;
			}else{
				xml=<img src={data}/>;
			}
			
			mask_mc=_mask_mc;
			if(mask_mc){
				this.addChild(mask_mc);
				mask_mc.gotoAndStop(1);
				mask_mc.addFrameScript(mask_mc.totalFrames-1,mask_mc_lastFrame);
				mask_mc.cacheAsBitmap=true;
				mask_mc.mouseEnabled=mask_mc.mouseChildren=false;
				container.cacheAsBitmap=true;
				container.mask=mask_mc;
			}
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
			if(xml.@src.toString()){
				loader.load(new URLRequest(xml.@src.toString()));
			}else{
				loader.loadBytes(data);
			}
		}
		private function loadProgress(event:ProgressEvent):void{
			if(onLoadProgress==null){
			}else{
				if(event.bytesTotal>0){
					onLoadProgress(event.bytesLoaded/event.bytesTotal);
				}
			}
		}
		private function loadComplete(event:Event):void{
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
			
			container.addChild(loader);
			
			if(mask_mc){
				container.alpha=1;
				mask_mc.gotoAndPlay(2);
			}else{
				container.alpha=0;
				this.addEventListener(Event.ENTER_FRAME,showContainer_step);
			}
			
			var align:String=xml.@align.toString();
			if(align){
				if(align.indexOf("top")>-1){
				}else if(align.indexOf("bottom")>-1){
					loader.y=-loader.contentLoaderInfo.height;
				}else{
					loader.y=-loader.contentLoaderInfo.height/2;
				}
				if(align.indexOf("left")>-1){
				}else if(align.indexOf("right")>-1){
					loader.x=-loader.contentLoaderInfo.width;
				}else{
					loader.x=-loader.contentLoaderInfo.width/2;
				}
			}
			
			if(xml.@smoothing.toString()=="true"){
				var bmp:Bitmap;
				try{
					bmp=loader.content as Bitmap;
				}catch(e:Error){
					bmp=null;
				}
				if(bmp){
					bmp.smoothing=true;
				}
			}
			
			if(onLoadComplete==null){
			}else{
				onLoadComplete();
			}
		}
		private function loadError(event:Event):void{
			trace(this+" 加载 "+xml.toXMLString()+" 失败");
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
			
			if(onLoadError==null){
			}else{
				onLoadError();
			}
		}
		private function mask_mc_lastFrame():void{
			clearMaskMc();
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
			var i:int=container2.numChildren;
			while(--i>=0){
				container2.removeChildAt(i);
			}
			if(onFadeComplete==null){
			}else{
				onFadeComplete();
			}
		}
	}
}