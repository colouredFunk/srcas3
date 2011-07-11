/***
UIManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年2月23日 10:30:52
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	
	public class UIManager{
		public var target:DisplayObject;
		private var initUI:Function;
		private var loader:Loader;
		public function UIManager(
			_target:*,//可以是 swf 地址，或显示对象
			_initUI:Function
		){
			initUI=_initUI;
			if(_target is DisplayObject){
				target=_target;
				initUI(target);
			}else{
				loader=new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
				loader.load(new URLRequest(_target));
			}
		}
		public function clear():void{
			target=null;
			initUI=null;
			if(loader){
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				loader=null;
			}
		}
		private function loadComplete(event:Event):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
			target=loader.content;
			initUI();
			loader=null;
		}
		private function loadError(event:IOErrorEvent):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
			initUI();
		}
		
		/*
		public function ctrl(ctrlName:String,...args):*{
			switch(ctrlName){
				case "set text":
					target[args[1]].text=args[2];
				break;
			}
		}
		*/
	}
}

