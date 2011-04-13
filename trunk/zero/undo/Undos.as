/***
Undos
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月6日 13:29:48
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
	import flash.ui.*;
	import flash.utils.*;
	
	import flashx.undo.IOperation;
	import flashx.undo.UndoManager;
	
	public class Undos{
		
		private var stage:Stage;
		
		private var undoManager:UndoManager;
		private var dict:Dictionary;
		
		public function Undos(stageOrDisplayObjectContainer:DisplayObjectContainer,deep:Boolean=true){
			
			trace("目前支持大部分 text 的 undo 和 redo");
			trace("未支持 ComboBox, CheckBox 等");
			trace("flashx.undo.UndoManager 好像不太行，需要自己写一个");
			
			if(stageOrDisplayObjectContainer is Stage){
				stage=stageOrDisplayObjectContainer as Stage;
			}else{
				stage=stageOrDisplayObjectContainer.stage;
			}
			if(stage){
				stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
				dict=new Dictionary();
				undoManager=new UndoManager();
				
				if(stageOrDisplayObjectContainer is Stage){
					//此时不会用到 deep 参数
				}else if(stageOrDisplayObjectContainer.hasOwnProperty("numElements")){
					autoAddElements(stageOrDisplayObjectContainer,deep);
				}else{
					autoAddChildren(stageOrDisplayObjectContainer,deep);
				}
			}else{
				throw new Error("Undos 需要 stage");
			}
		}
		public function clearAll():void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			stage=null;
			for(var target:* in dict){
				(dict[target] as BaseUndo).clear();
			}
			dict=null;
			undoManager.clearAll();
			undoManager=null;
		}
		private function keyDown(event:KeyboardEvent):void{
			if(event.ctrlKey){
				switch(event.keyCode){
					case "Y	".charCodeAt(0):
						//trace("redo");
						stage.focus=null;
						undoManager.redo();
					break;
					case "Z	".charCodeAt(0):
						//trace("undo");
						stage.focus=null;
						undoManager.undo();
					break;
				}
			}
		}
		public function autoAddElements(container:DisplayObjectContainer,deep:Boolean):void{
			if(container.hasOwnProperty("numElements")){
				var i:int=container["numElements"];
				while(--i>=0){
					var element:*=container["getElementAt"](i);
					if(getType(element)){
						trace("autoAddElements element="+element);
						autoAdd(element);
					}else{
						if(deep){
							autoAddElements(element,deep);
						}
					}
				}
			}
		}
		public function autoAddChildren(container:DisplayObjectContainer,deep:Boolean):void{
			var i:int=container.numChildren;
			while(--i>=0){
				var child:DisplayObject=container.getChildAt(i);
				if(getType(child)){
					trace("autoAddChildren child="+child);
					autoAdd(child);
				}else{
					if(deep){
						if(child is DisplayObjectContainer){
							autoAddChildren(child as DisplayObjectContainer,deep);
						}
					}
				}
			}
		}
		public function autoAdd(target:*):void{
			var type:String=getType(target);
			if(type){
				this["add_"+type](target);
			}else{
				throw new Error("未知分类："+type+"（可能是扩展过的类）。");
			}
		}
		private function getType(target:*):String{
			var name:String=getQualifiedClassName(target);
			switch(name){
				case "spark.components::TextInput":
				case "spark.components::TextArea":
				case "mx.controls::TextInput":
				case "mx.controls::TextArea":
				case "fl.controls::TextInput":
				case "fl.controls::TextArea":
				case "flash.text::TextField":
					return "txt";
				break;
				default:
					//
				break;
			}
			return null;
		}
		
		public function add_txt(target:*):void{
			target.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			dict[target]=new UndoTxt(target,addOperation,undo,redo);
		}
		public function clear(target:*):void{
			(dict[target] as BaseUndo).clear();
			delete dict[target];
		}
		
		private function removed(event:Event):void{
			var target:*=event.target;
			target.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			clear(target);
		}
		
		
		private function addOperation(operation:IOperation):void{
			undoManager.pushUndo(operation);
			undoManager.pushRedo(operation);
		}
		private function undo(target:*):void{
			//
		}
		private function redo(target:*):void{
			//
		}
	}
}