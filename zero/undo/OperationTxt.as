/***
OperationTxt
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月6日 13:08:10
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.undo{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import flashx.undo.IOperation;
	
	public class OperationTxt extends BaseOperation implements IOperation{
		public function OperationTxt(
			_undo:Function,
			_undoValue:Object,
			_redo:Function,
			_redoValue:Object
		){
			super(_undo,_undoValue,_redo,_redoValue);
		}
	}
}
		