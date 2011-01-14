/***
ZPLManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月12日 20:24:32
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	
	import zero.*;
	
	public class ZPLManager{
		private static var zpl:*;
		private static var loader:Loader;
		private static var container:Sprite;
		private static var onAddComplete:Function;
		private static var onAddError:Function;
		private static var initValues:Object;
		
		public static function init(_initValues:Object):void{
			initValues=_initValues;
			if(loader||zpl){
				return;
			}
			if(ZeroCommon.FileClass){
			}else{
				Security.allowDomain("*");
				Security.allowInsecureDomain("*");
			}
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadZPLComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadZPLError);
			loader.load(new URLRequest(ZeroCommon.path_ZeroPrevLoader));
			
			//trace("ZPLManager.init "+ZeroCommon.path_ZeroPrevLoader);
			
			//for(var initValueName:String in initValues){
			//	trace("ZPLManager.init initValues."+initValueName+"="+initValues[initValueName])
			//}
		}
		/*
		public static function clear():void{
			//一般不会调用
			if(loader){
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadZPLComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadZPLError);
				loader.unloadAndStop();
				loader=null;
			}
			onAddComplete=null;
			onAddError=null;
			initValues=null;
		}
		*/
		public static function showLoadGameProgress(bytesLoaded:int,bytesTotal:int):void{
			if(container&&zpl){
				zpl.cmd("loadGameProgress",bytesLoaded,bytesTotal);
			}
		}
		public static function showLoadGameComplete():Boolean{
			//trace("showLoadGameComplete");
			if(container&&zpl){
				if(zpl.cmd("loadGameComplete")){
					return true;
				}
			}
			return false;
		}
		public static function add(_container:Sprite,_onAddComplete:Function=null,_onAddError:Function=null):void{
			container=_container;
			onAddComplete=_onAddComplete;
			onAddError=_onAddError;
			//trace("zpl="+zpl);
			if(zpl){
				initZPL();
			}
		}
		public static function remove():void{
			if(zpl&&zpl.parent==container){
				zpl.cmd("remove");
			}
			container=null;
		}
		public static function resize(x:int,y:int,wid:int,hei:int):void{
			if(zpl){
				zpl.cmd("resize",x,y,wid,hei);
			}
		}
		private static function loadZPLComplete(event:Event):void{
			//trace("loadZPLComplete");
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadZPLComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadZPLError);
			zpl=(event.target as LoaderInfo).loader.content;
			loader=null;
			//trace("container="+container);
			if(container){
				initZPL();
			}
		}
		private static function loadZPLError(event:IOErrorEvent):void{
			//trace("loadZPLError");
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadZPLComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadZPLError);
			loader=null;
			
			var _onAddError:Function=onAddError;
			onAddComplete=null;
			onAddError=null;
			if(_onAddError==null){
			}else{
				_onAddError();
			}
		}
		private static function initZPL():void{
			if(zpl.parent is Sprite){
				return;
			}
			//for(var initValueName:String in initValues){
			//	trace("ZPLManager.initZPL initValues."+initValueName+"="+initValues[initValueName])
			//}
			zpl.cmd("add",container,GetAndSetValue,initValues);
			
			var _onAddComplete:Function=onAddComplete;
			onAddComplete=null;
			onAddError=null;
			if(_onAddComplete==null){
			}else{
				_onAddComplete();
			}
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