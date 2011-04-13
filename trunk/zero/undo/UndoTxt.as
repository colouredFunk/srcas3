/***
UndoTxt
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月6日 13:56:43
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
	
	public class UndoTxt extends BaseUndo{
		public var txt:*;
		private var currOperationTxt:OperationTxt;
		public function UndoTxt(_txt:*,_addOperation:Function,_onUndo:Function,_onRedo:Function){
			super(_addOperation,_onUndo,_onRedo);
			txt=_txt;
			txt.addEventListener(TextEvent.TEXT_INPUT,inputTxt);
			txt.addEventListener(Event.CHANGE,changeTxt);
			//trace("UndoTxt txt="+txt);
			addOperation=_addOperation;
		}
		override public function clear():void{super.clear();
			//trace("UndoTxt clear txt="+txt);
			txt.removeEventListener(TextEvent.TEXT_INPUT,inputTxt);
			txt.removeEventListener(Event.CHANGE,changeTxt);
			txt=null;
			currOperationTxt=null;
		}
		private function inputTxt(event:TextEvent):void{
			//trace(event);
			//trace("inputTxt event.text="+event.text+", txt.text="+txt.text);
			addOperation(currOperationTxt=new OperationTxt(
				undo,
				txt.text,
				redo,
				event.text
			));
		}
		private function changeTxt(event:Event):void{
			if(currOperationTxt){
				//trace("changeTxt");
				currOperationTxt.redoValue=txt.text;
				currOperationTxt=null;
			}
		}
		private function undo(operation:OperationTxt):void{
			//trace("operation.undoValue="+operation.undoValue);
			//txt.stage.focus=null;
			txt.text=operation.undoValue;
			//txt.stage.focus=txt;
			onUndo(txt);
		}
		private function redo(operation:OperationTxt):void{
			//trace("operation.redoValue="+operation.redoValue);
			//txt.stage.focus=null;
			txt.text=operation.redoValue;
			//txt.stage.focus=txt;
			onRedo(txt);
		}
	}
}
		