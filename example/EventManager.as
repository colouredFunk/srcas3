/***
EventManager 版本:v1.0
简要说明:addEventListener和removeEventListener的马甲
创建时间:2008年7月8日 13:08:41
初代旦那:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写

EventManager\.(addEvent|removeEvent)\((.*?),(.*?)\)\;
$2.$1Listener($3);
\n(\s*)([^/\n]*?)\.(addEvent|removeEvent)Listener\s*\(
\n$1EventManager.$3($2,
*/
package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	public class EventManager extends Sprite {
		public function EventManager() {
			trace("EventManager测试完请去掉否则会影响效率");
			trace("考虑EventDispatcher.prototype.addEventListener=xxxxxx");
			this.addEventListener(Event.ENTER_FRAME,showAllEvents);
		}
		private static var dictObjs:Object=new Object();
		public static function addEvent(obj:*,type:String,listener:Function,...args):void {
			var argsL:int=args.length;
			var useWeakReference:Boolean=argsL==3?args[2]:false;
			var priority:int=argsL>=2?args[1]:0;
			var useCapture:Boolean=argsL>=1?args[2]:false;
			obj.addEventListener(type,listener,useCapture,priority,useWeakReference);

			var dictObj:DictObj=dictObjs[type];
			if (dictObj==null) {
				dictObj=dictObjs[type]=new DictObj();
			}
			dictObj.addData(obj,listener);
		}
		public static function removeEvent(obj:*,type:String,listener:Function):void {
			obj.removeEventListener(type,listener);
			var dictObj:DictObj=dictObjs[type];
			if (dictObj==null) {
				//trace("还没add就remove的listener,obj="+obj+",type="+type+",listener="+listener);
				//基本上不会引起任何问题
				return;
			}
			dictObj.removeData(obj,listener);
			if (dictObj.total<=0) {
				delete dictObjs[type];
			}
		}
		private function showAllEvents(event:Event):void {
			var totalEvents:int=0;
			var str:String="";
			for (var type:String in dictObjs) {
				var subTotalEvents:int=0;
				var subStr:String="";
				var dictObj:DictObj=dictObjs[type];
				for (var obj:* in dictObj) {
					subStr+="  "+obj+"--";
					var dict:DictObjItem=dictObj[obj];
					subTotalEvents+=dict.total;
					totalEvents+=dict.total;
					var totalListener:int=0;
					for (var listener:* in dict) {
						totalListener++;
					}
					subStr+=totalListener+"\n";
				}
				str+=type+"--"+subTotalEvents+"\n"+subStr;
			}
			txt.text="共有事件个数:"+totalEvents+"\n"+str;
		}
		/*public static function removeAll():void{
		for(var type:String in dictObjs){
		var dictObj:DictObj=dictObjs[type];
		for(var obj:* in dictObj){
		var dict:DictObjItem=dictObj[obj];
		for (var listener:* in dict){
		removeEvent(obj,type,listener);//在遍历的同时删除,可能会出问题
		//obj.removeEventListener(type,listener);
		}
		}
		}
		}*/
	}
}
import flash.utils.*;
class DictObj extends Dictionary {
	public var total:int;
	public function DictObj() {
		//super(true);//如果true了有些东西会莫名其妙的没有了....(弱引用的问题)
		total=0;
	}
	public function addData(obj:*,listener:Function):void {
		var dict:DictObjItem=this[obj];
		if (dict==null) {
			dict=this[obj]=new DictObjItem();
			total++;
		}
		if (dict[listener]) {
			trace("重复添加:obj="+obj);
			return;
			/*
			例如
			stage.addEventListener(Event.ENTER_FRAME,mc1.run);
			然后又再次:
			stage.addEventListener(Event.ENTER_FRAME,mc1.run);
			虽然没错但不太推荐所以return掉了
			*/
		}
		dict[listener]=true;
		dict.total++;
	}
	public function removeData(obj:*,listener:Function):void {
		var dict:DictObjItem=this[obj];
		if (dict==null) {
			trace("找不到要删的:obj="+obj+"(多出现于\"为了安全起见而在没有的情况下还是删一删比较保险\"的情况)");
			//var k;
			//k.kk;
			return;
		}
		if (dict[listener]) {
			//trace("delete "+dict[listener]);
			delete dict[listener];
			if (--dict.total<=0) {
				delete this[obj];
				total--;
			}
		}
	}
}
//import flash.utils.*;
class DictObjItem extends Dictionary {
	public var total:int;//其实只是想total不被for...in到
	public function DictObjItem() {
		//super(true);//如果true了有些东西会莫名其妙的没有了....(弱引用的问题)
		total=0;
	}
}

/*
dictObjs(类型:Object)的可能结构:
dictObjs{
enterFrame:dictObj0,
keyDown:dictObj1,
keyUp:dictObj2,
....
}

dictObj0(类型:DictObj,也就是上面的dictObjs["enterFrame"])的可能结构:
dictObj0{
total:4,
stage:dict0,
mc1:dict1,
sp2:dict2,
obj3:dict3
}

dict0(类型:DictObjItem,也就是上面的dictObj0[stage])的可能结构:
dict0{
total:3,
aaa.run:"run",
bbb.run:"run",
ccc.run:"run"
}
*/