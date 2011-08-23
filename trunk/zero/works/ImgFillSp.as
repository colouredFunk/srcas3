/***
ImgFillSp
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月20日 09:51:01
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import com.greensock.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ImgFillSp extends Sprite{
		private var xml:XML;
		private var loader:Loader;
		private var container:Sprite;
		private var onInitComplete:Function;
		public function ImgFillSp(xmlOrSrc:*=null,_onInitComplete:Function=null):void{
			
			container=new Sprite();
			this.addChild(container);
			
			loader=new Loader();
			
			if(xmlOrSrc){
				init(xmlOrSrc,_onInitComplete);
			}
		}
		public function init(xmlOrSrc:*,_onInitComplete:Function=null):void{
			
			clear();
			
			if(xmlOrSrc is XML){
				xml=xmlOrSrc;
			}else{
				xml=<img src={xmlOrSrc}/>;
			}
			onInitComplete=_onInitComplete;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			loader.load(new URLRequest(xml.@src.toString()));
		}
		public function clear():void{
			container.alpha=0;
			container.graphics.clear();
		}
		private function loadComplete(event:Event):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			container.graphics.clear();
			container.graphics.beginBitmapFill((loader.content as Bitmap).bitmapData,null,true);
			container.graphics.drawRect(int(xml.@x.toString()),int(xml.@y.toString()),int(xml.@width.toString())||loader.content.width,int(xml.@height.toString())||loader.content.height);
			switch(xml.@align.toString()){
				case "center":
					container.x=-container.width/2;
					container.y=-container.height/2;
				break;
			}
			TweenMax.to(container,0.5,{alpha:1,onComplete:initComplete});
		}
		private function initComplete():void{
			if(onInitComplete==null){
			}else{
				onInitComplete();
				onInitComplete=null;
			}
		}
	}
}