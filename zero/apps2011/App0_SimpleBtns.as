/***
App0_SimpleBtns
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月7日 16:57:33
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.apps2011{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class App0_SimpleBtns extends BaseApp{
		private var btns:Object;
		public function App0_SimpleBtns(){
			btns=new Object();
		}
		override public function addThingsToStage(thing:DisplayObject):void{
			/*
			switch(thing.constructor){
				case Shape:
				case Sprite:
				case MovieClip:
				case Video:
				break;
				default:
					trace(thing);
				break;
			}
			*/
			if(thing is Btn){
				var btnKey:String=getBtnKey(thing as Btn);
				btns[btnKey]=thing;
				if(settingXML){
					initBtn(btnKey);
				}
			}
		}
		override public function initSettingXMLFinished():void{
			for(var btnKey:String in btns){
				initBtn(btnKey);
			}
			
			//throw new Error("settingXML="+settingXML.toXMLString());
		}
		private function initBtn(btnKey:String):void{
			for each(var btnXML:XML in settingXML.btn){
				//trace("btnXML="+btnXML.toXMLString());
				if(btnXML.@key.toString()==btnKey){
					if(btns[btnKey]){
						btns[btnKey].hrefXML=btnXML;
					}else{
						throw new Error("btnKey="+btnKey+", 找不到 btn");
					}
				}
			}
		}
		private function getBtnKey(btn:Btn):String{
			if(btn.name){
				if(/^instance\d+$/.test(btn.name)){
					//一般就是没命名的，系统给自动命名成：instancexxx
				}else{
					return btn.name;
				}
			}
			return getQualifiedClassName(btn);
		}
	}
}










