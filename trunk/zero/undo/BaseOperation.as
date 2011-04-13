/***
BaseOperation
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月6日 14:19:07
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
	
	public class BaseOperation{
		public var undo:Function;
		public var redo:Function;
		public var undoValue:Object;
		public var redoValue:Object;
		
		public function BaseOperation(
			_undo:Function,
			_undoValue:Object,
			_redo:Function,
			_redoValue:Object
		){
			undo=_undo;
			undoValue=_undoValue;
			redo=_redo;
			redoValue=_redoValue;
		}
		public function clear():void{
			undo=null;
			undoValue=null;
			redo=null;
			redoValue=null;
		}
		public function performRedo():void{
			redo(this);
		}
		public function performUndo():void{
			undo(this);
		}
	}
}
		