/***
SBtn 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2008年11月12日 10:09:21
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.filters.*;
	import flash.geom.*;
	public class SBtn extends MovieClip{
		private static const cmf:ColorMatrixFilter=new ColorMatrixFilter([0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0,0,0,1,0]);
		private static const upId:int=1;
		private static const overId:int=2;
		private var downId:int;
		private var selectedId:int;
		public function SBtn(){
			this.buttonMode=true;
			this.mouseChildren=false;
			this.stop();
			switch(this.totalFrames){
				case 2:
					downId=1;
					selectedId=2;
				break;
				case 3:
					downId=3;
					selectedId=2;
				break;
				case 4:
					downId=3;
					selectedId=4;
				break;
			}
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		
		public var rollOver:Function;
		//public var rollOut:Function;
		public var press:Function;
		public var release:Function;
		
		private function haveStr(str0:String,str:String):Boolean{
			str0.replace(/\ /g,"");
			str0=str0.toLowerCase();
			str=str.toLowerCase();
			return str0.indexOf(str)>=0;
		}
		
		public function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);//如果从显示列表中移除再加入按钮将不再有效
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.addEventListener(MouseEvent.MOUSE_OVER,$onRollOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,$onRollOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN,$onPress);
			this.addEventListener(MouseEvent.MOUSE_UP,$onRelease);
		}
		private function removed(event:Event):void{
			this.removeEventListener(MouseEvent.MOUSE_OVER,$onRollOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT,$onRollOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,$onPress);
			this.removeEventListener(MouseEvent.MOUSE_UP,$onRelease);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			//rollOver=null;
			//rollOut=null;
			//press=null;
			release=null;
			
			if(stage.focus==this){
				//否则会引起一些按键不能动作
				stage.focus=null;
			}
		}
		private function $onRollOver(event:MouseEvent):void{
			this.gotoAndStop(overId);
			if(rollOver!=null){
				rollOver();
			}
		}
		private function $onRollOut(event:MouseEvent):void{
			this.gotoAndStop(upId);
			//rollOut();
		}
		
		private function $onPress(event:MouseEvent):void{
			this.gotoAndStop(downId);
			if(press!=null){
				press();
			}
		}
		
		private function $onRelease(event:MouseEvent):void{
			this.gotoAndStop(overId);
			if(release!=null){
				release();
			}/*else{
				trace("未设置 release");
			}*/
		}
		
		public function setEnabled(value:Boolean):void{
			if(value){
				this.filters=null;
				this.mouseEnabled=this.buttonMode=true;
			}else{
				this.filters=[cmf];
				this.mouseEnabled=this.buttonMode=false;
			}
		}
	}
}
