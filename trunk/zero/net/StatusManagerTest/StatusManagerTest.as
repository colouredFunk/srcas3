/***
StatusManagerTest 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 09:22:26
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import ui.*;
	
	import zero.net.StatusManager;
	import zero.ui.BaseLoadURLPoj;
	
	public class StatusManagerTest extends BaseLoadURLPoj{
		public function StatusManagerTest(){
		}
		public function init():void{
			//trace("xml="+xml.toXMLString());
			
			Alert.init(this,Alert_1);
			
			StatusManager.onInit=StatusManager.loadStatus;
			StatusManager.msgPopUp=function(msg:String,btnLabel:String):Alert{
				return Alert.show(msg);
			}
			StatusManager.onStatus=onStatus;
			
			StatusManager.init(xml,"11");//会触发 onInit，也就是上面赋值的 loadStatus，通常用于游戏一打开就向服务器加载数据，如果想点击按钮才向服务器加载数据，则要把 StatusManager.init(xml) 写到按钮里
		}
		
		private function onStatus(currXML:XML,statusCount:int):void{
			trace("currXML="+currXML.toXMLString());
		}
	}
}

