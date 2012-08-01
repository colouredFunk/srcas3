/***
StackMark
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月8日 06:32:33
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2.runners{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class StackMark{
		private var stack:Array;
		private var scopeStack:Array;
		public function StackMark(){
		}
		public function add(_stack:Array,_scopeStack:Array):Boolean{
			var stackId:int,value:*;
			
			if(stack){
				var valueAdd:Boolean=false;
				
				if(stack.length==_stack.length){
				}else{
					throw new Error("栈深度不对称 "+_stack.length+"!="+stack.length);
				}
				if(stack.length==_stack.length){
				}else{
					throw new Error("栈深度不对称 "+_scopeStack.length+"!="+scopeStack.length);
				}
				
				stackId=-1;
				for each(value in _stack){
					stackId++;
					if(addValue(stack[stackId],value)){
						valueAdd=true;
					}
				}
				stackId=-1;
				for each(value in _scopeStack){
					stackId++;
					if(addValue(scopeStack[stackId],value)){
						valueAdd=true;
					}
				}
				
				return valueAdd;
			}
			
			stackId=-1;
			stack=new Array();
			for each(value in _stack){
				stackId++;
				stack[stackId]=[value];
			}
			stackId=-1;
			scopeStack=new Array();
			for each(value in _scopeStack){
				stackId++;
				scopeStack[stackId]=[value];
			}
			
			return true;
		}
		private function addValue(stackValue0:Array,stackValue:*):Boolean{
			if(stackValue0.indexOf(stackValue)==-1){//如果 stackValue0 不包含 stackValue
				stackValue0.push(stackValue);
				return true;
			}
			return false;
		}
		public function toString():String{
			
			var stackString:String=stack.join("],[");
			if(stackString){
				stackString="["+stackString+"]";
			}
			
			var scopeStackString:String=scopeStack.join("],[");
			if(scopeStackString){
				scopeStackString="["+scopeStackString+"]";
			}
			
			return "[stackMark "+
					"["+stackString+"]"//+
					//"["+scopeStackString+"]"+
					"]";
		}
	}
}