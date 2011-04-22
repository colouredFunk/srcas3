/***
ActionButtonManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月13日 09:17:50
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ActionButtonManager{
		private var btn:*;
		
		private var label0:String;
		public var onClick:Function;
		
		private var __flag:Boolean;
		public function get flag():Boolean{
			return __flag;
		}
		public function set flag(_flag:Boolean):void{
			__flag=_flag;
			if(__flag){
				btn.label="取消";
			}else{
				btn.label=label0;
			}
		}
		
		public function ActionButtonManager(_btn:*){
			btn=_btn;
			btn.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			btn.addEventListener(MouseEvent.CLICK,click);
			
			label0=btn.label;
			flag=false;
		}
		
		private function removed(event:Event):void{
			clear();
		}
		public function clear():void{
			if(btn){
				btn.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
				btn.removeEventListener(MouseEvent.CLICK,click);
			}
			btn=null;
			onClick=null;
		}
		public function reset():void{
			flag=false;
		}
		private function click(event:Event):void{
			flag=!flag;
			if(onClick==null){
			}else{
				onClick(flag);
			}
		}
		public function setProgress(value:int,total:int):void{
			//btn.label="取消("+value+"/"+total+")";
			btn.label="取消 "+int(value/total*100)+"%";
		}
	}
}
		