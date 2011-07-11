/***
SubmitScoreManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月17日 19:56:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import zero.*;
	
	public class SubmitScoreManager{
		public static var loader:Loader;
		public static var submitScore:Sprite;
		
		private static var initFinished:Function;
		
		public static function init(_initFinished:Function):void{
			initFinished=_initFinished;
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadSubmitScoreComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadSubmitScoreError);
			
			try{
				loader.load(new URLRequest(ZeroCommon.path_SubmitScore));
				//loader.load(new URLRequest(ZeroCommon.path_SubmitScore+"?"+Math.random()));trace("测试，添加随机数字");
			}catch(e:Error){}
		}
		private static function loadSubmitScoreComplete(event:Event):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadSubmitScoreComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadSubmitScoreError);
			
			loader.content.addEventListener(Event.ENTER_FRAME,checkInit);
		}
		private static function loadSubmitScoreError(event:IOErrorEvent):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadSubmitScoreComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadSubmitScoreError);
			if(initFinished==null){
			}else{
				initFinished(false);
				initFinished=null;
			}
		}
		private static function checkInit(event:Event):void{
			try{
				var SubmitScoreClass:*=loader.contentLoaderInfo.applicationDomain.getDefinition("SubmitScore");
			}catch(e:Error){
				//trace("e="+e);
				return;
			}
			try{
				submitScore=SubmitScoreClass.instance;
			}catch(e:Error){
				//trace("e="+e);
				return;
			}
			if(submitScore){
				loader.content.removeEventListener(Event.ENTER_FRAME,checkInit);
				if(initFinished==null){
				}else{
					initFinished(true);
					initFinished=null;
				}
			}
		}
	}
}

