/***
NativeWindowManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月6日 17:52:10
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.air{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.net.So;
	
	public class NativeWindowManager{
		//只限于 air 使用
		
		private var nativeWindow:NativeWindow;
		
		public var xml:XML;
		private var so:So;
		private var so_key:String;
		
		private var onClose:Function;
		
		public function NativeWindowManager(_nativeWindow:NativeWindow,_so:So,_so_key:String=null,_onClose:Function=null){
			nativeWindow=_nativeWindow;
			onClose=_onClose;
			initSo(_so,_so_key);
			
			nativeWindow.addEventListener(Event.CLOSING,closingWindow);
		}
		public function initSo(_so:So,_so_key:String=null):void{
			so=_so;
			so_key=_so_key||"nativeWindow";
			xml=so.getXML(so_key,<nativeWindow/>);
			
			var str:String;
			
			str=xml.@x.toString();
			if(str&&int(str).toString()==str){
				nativeWindow.x=int(str);
			}
			
			str=xml.@y.toString();
			if(str&&int(str).toString()==str){
				nativeWindow.y=int(str);
			}
			
			str=xml.@width.toString();
			if(str&&int(str).toString()==str){
				nativeWindow.width=int(str);
			}
			
			str=xml.@height.toString();
			if(str&&int(str).toString()==str){
				nativeWindow.height=int(str);
			}
		}
		private function closingWindow(event:Event):void{
			
			if(onClose==null){
			}else{
				onClose();
				onClose=null;
			}
			
			nativeWindow.restore();
			nativeWindow.removeEventListener(Event.CLOSING,closingWindow);
			xml.@x=nativeWindow.x;
			xml.@y=nativeWindow.y;
			xml.@width=nativeWindow.width;
			xml.@height=nativeWindow.height;
			
			so.setXML("nativeWindow",xml);
			
			nativeWindow=null;
			
			so=null;
			xml=null;
		}
	}
}
		