/***
HighScoresContainer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月26日 10:21:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import zero.*;
	
	public class HighScoresContainer extends Sprite{
		public static var instance:HighScoresContainer;
		
		public var loader:Loader;
		public var highScores:Sprite;
		
		private var initFinished:Function;
		
		public function HighScoresContainer(){
			instance=this;
			this.visible=false;
		}
		
		public function init(_initFinished:Function):void{
			initFinished=_initFinished;
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadHighScoresComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadHighScoresError);
			
			try{
				//loader.load(new URLRequest(ZeroCommon.path_HighScores));
				loader.load(new URLRequest(ZeroCommon.path_HighScores+"?"+Math.random()));trace("测试，添加随机数字");
			}catch(e:Error){}
			
			this.addChild(loader);
		}
		private function loadHighScoresComplete(event:Event):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadHighScoresComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadHighScoresError);
			
			loader.content.addEventListener(Event.ENTER_FRAME,checkInit);
		}
		private function loadHighScoresError(event:IOErrorEvent):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadHighScoresComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadHighScoresError);
			if(initFinished==null){
			}else{
				initFinished(false);
				initFinished=null;
			}
		}
		private function checkInit(event:Event):void{
			try{
				var HighScoresClass:*=loader.contentLoaderInfo.applicationDomain.getDefinition("HighScores");
			}catch(e:Error){
				//trace("e="+e);
				return;
			}
			try{
				highScores=HighScoresClass.instance;
			}catch(e:Error){
				//trace("e="+e);
				return;
			}
			if(highScores){
				loader.content.removeEventListener(Event.ENTER_FRAME,checkInit);
				if(initFinished==null){
				}else{
					initFinished(true);
					initFinished=null;
				}
			}
		}
		
		private var onClose:Function;
		public function show(values:Object):void{
			if(highScores){
				onClose=values.onClose;
				values.onClose=close;
				highScores["init"](values);
				this.visible=true;
			}
		}
		private function close():void{
			this.visible=false;
			if(onClose==null){
			}else{
				onClose();
			}
		}
	}
}
		