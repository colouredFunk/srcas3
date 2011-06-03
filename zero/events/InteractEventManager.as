/***
InteractEventManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月30日 15:05:22
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.events{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class InteractEventManager{
		/*
		private static var instance:InteractEventManager;
		public static function getInstance():InteractEventManager{
			if(instance){
			}else{
				instance=new InteractEventManager();
			}
			return instance;
		}
		*/
		
		public static function activate(interactEventSample:IInteractEventSample):void{
			InteractEvent.PRESS=interactEventSample.PRESS;
		}
			
		public static function addEventListener(
			eventDispatcher:EventDispatcher,
			type:String,
			listener:Function,
			useCapture:Boolean=false,
			priority:int=0,
			useWeakReference:Boolean=false
		):void{
			eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		public static function removeListener(
			eventDispatcher:EventDispatcher,
			type:String,
			listener:Function,
			useCapture:Boolean=false
		):void{
			eventDispatcher.removeEventListener(type,listener,useCapture);
		}
	}
}
		