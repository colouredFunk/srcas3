/***
BottomBarContainer 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月12日 00:38:55
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
			////
			import flash.display.*;
			import flash.events.*;
			import flash.utils.*;
			import flash.net.*;
			
			import zero.GetAndSetValue;
			import zero.ZeroCommon;
			////
			
	public class BottomBarContainer extends Sprite{
			
			////
			private var container:Sprite;
			private var loader:Loader;
			
			public var gameMainClassName:String;
			public var onShowBottomBar:Function;
			////
			
			public var wid:int;
			public var hei:int;
			
		public function BottomBarContainer(
			_gameMainClassName:String=null,
			_wid:int=0,
			_hei:int=0,
			_onShowBottomBar:Function=null
			){
			gameMainClassName=_gameMainClassName;
			if(_wid>0){
				wid=_wid;
			}else{
				wid=this.width;
			}
			if(_hei>0){
				hei=_hei;
			}else{
				hei=this.height;
			}
			onShowBottomBar=_onShowBottomBar;
			
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			////
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadBottomBarComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
			
			try{
				loader.load(new URLRequest(ZeroCommon.path_BottomBar));
				//loader.load(new URLRequest(ZeroCommon.path_BottomBar+"?"+Math.random()));trace("测试，添加随机数字");
			}catch(e:Error){}
			////
			
			this.addChild(loader);
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,removed);
			
			////
			if(loader){
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadBottomBarComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
				loader=null;
			}
			this.removeEventListener(Event.ENTER_FRAME,checkInit);
			////
		}
		private function loadBottomBarComplete(event:Event):void{
			////
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadBottomBarComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
			this.addEventListener(Event.ENTER_FRAME,checkInit);
			////
		}
		private function checkInit(event:Event):void{
			if(gameMainClassName&&this.parent&&this.root&&this.loaderInfo){
			}else{
				return;
			}
			loader.content["show"](this,GetAndSetValue,gameMainClassName,wid,hei);
			this.removeEventListener(Event.ENTER_FRAME,checkInit);
		}
		private function loadBottomBarError(event:IOErrorEvent):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadBottomBarComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/