/***
BaseUndo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月6日 13:59:38
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.undo{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class BaseUndo{
		public var addOperation:Function;
		public var onUndo:Function;
		public var onRedo:Function;
		public function BaseUndo(_addOperation:Function,_onUndo:Function,_onRedo:Function){
			addOperation=_addOperation;
			onUndo=_onUndo;
			onRedo=_onRedo;
		}
		public function clear():void{
			addOperation=null;
			onUndo=null;
			onRedo=null;
		}
	}
}
		