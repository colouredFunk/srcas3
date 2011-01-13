/***
BaseChecker 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月29日 20:46:38
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.net.*;
	import flash.utils.*;
	
	public class BaseChecker extends Sprite{
		private static var firstSend:Boolean=true;
		public static function sendMsg(url:String,variables:Object):void{
			trace("sendMsg url="+url);
			var urlLoader:URLLoader=new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,sendMsgComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,sendMsgError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,trace);
			
			var urlVariables:URLVariables=new URLVariables();
			for(var varName:String in variables){
				urlVariables[varName]=variables[varName];
			}
			
			var urlRequest:URLRequest=new URLRequest(url);
			
			urlRequest.data=urlVariables;
			urlRequest.method=URLRequestMethod.POST;
			
			try{
				urlLoader.load(urlRequest);
			}catch(e:Error){
				//trace("e="+e);
			}
		}
		private static function sendMsgComplete(event:Event):void{
			var urlLoader:URLLoader=event.target as URLLoader;
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,sendMsgError);
			urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,trace);
		}
		private static function sendMsgError(event:IOErrorEvent):void{
			var urlLoader:URLLoader=event.target as URLLoader;
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,sendMsgError);
			urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,trace);
		}
		
		public function BaseChecker(){
		}
		
		public function getParentHasProperty(propertyName:String):DisplayObjectContainer{
			try{
				var _parent:DisplayObjectContainer=this.parent;
				while(_parent){
					//trace("_parent="+_parent,propertyName);
					if(_parent.hasOwnProperty(propertyName)){
						return _parent;
					}
					_parent=_parent.parent;
				}
			}catch(e:Error){
				//trace("e="+e);
			}
			
			return null;
		}
		
		public function getPageURL(getValueObj:*):String{
			var pageURL:String;
			try{
				pageURL=ExternalInterface.call("top.location.href.toString").toString();
				if(pageURL){
				}else{
					pageURL=ExternalInterface.call("window.location.href.toString").toString();
				}
			}catch(e:Error){
				//trace("e="+e);
			}
			
			if(pageURL){
			}else{
				try{
					//pageURL=JigsawPuzzle._this.loaderInfo.url;//有时会不准确 - -
					pageURL=getValueObj["getValue"]("loaderInfo.url",getValueObj);
					//trace("pageURL="+pageURL);
				}catch(e:Error){
					//trace("e="+e);
				}
			}
			
			if(pageURL){
				pageURL=decodeURI(pageURL);
				if(pageURL.indexOf("app:/")==0){
					//trace("Air应用程序：pageURL="+pageURL);
					pageURL=pageURL.replace("app:",getValueObj["getValue"]("flash.filesystem.File.applicationDirectory.nativePath"));
				}
				pageURL=pageURL.replace(/\\/g,"/");
				return pageURL;
			}
			
			return null;
		}
		
		public function getClass(getValueObj:*,className:String):Class{
			try{
				return getValueObj["getValue"](className);
			}catch(e:Error){
				//trace("e="+e);
			}
			return null;
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