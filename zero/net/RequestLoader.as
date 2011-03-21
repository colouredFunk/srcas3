/***
RequestLoader 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月2日 13:03:42
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class RequestLoader{
		public static const SUCCESS:String="success";
		public static const URL_NOT_FOUND:String="url not found";
		public static const UNKNOWN_TYPE:String="unknown type";
		public static const ERROR:String="error";
		
		/*public static const notTextTypeV:Vector.<String>=Vector.<String>([
			".jpg",
			".png",
			".gif",
			".bmp",
			".swf",
			".mp3",
			".wav",
			".zip",
			".rar",
			".exe"
		]);*/
		public static const notTextTypeV:Array=[
			".jpg",
			".png",
			".gif",
			".bmp",
			".swf",
			".mp3",
			".wav",
			".zip",
			".rar",
			".exe"
		];
		public static function getType(url:String):String{
			return url.substr(url.lastIndexOf(".")).toLowerCase();
		}
		public static function isText(url:String):Boolean{
			return notTextTypeV.indexOf(getType(url))==-1;
		}
		
		private static const httpResponseStatus:String=HTTPStatusEvent["HTTP_RESPONSE_STATUS"];//非 air 时为 null
		
		private var target:EventDispatcher;
		public var responseURL:String;
		public var currURL:String;
		private var onLoadProgress:Function;
		private var onLoadFinished:Function;
		
		public function RequestLoader(_target:EventDispatcher,_onLoadProgress:Function,_onLoadFinished:Function){
			target=_target;
			onLoadProgress=_onLoadProgress;
			onLoadFinished=_onLoadFinished;
			if(httpResponseStatus){
				target.addEventListener(httpResponseStatus,loadStatus);
			}
			target.addEventListener(Event.COMPLETE,loadComplete);
			target.addEventListener(IOErrorEvent.IO_ERROR,loadError);
		}
		public function clear():void{
			if(httpResponseStatus){
				target.removeEventListener(httpResponseStatus,loadStatus);
			}
			target.removeEventListener(Event.COMPLETE,loadComplete);
			target.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
			if(onLoadProgress!=null){
				target.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			}
			
			target=null;
			onLoadProgress=null;
			onLoadFinished=null;
		}
		public function load(url:String,variables:Object=null,method:String=null):URLRequest{
			if(onLoadProgress!=null){
				target.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
				target.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			}
			responseURL=null;
			currURL=url;
			return RequestLoader.getRequest(currURL,variables,method);
		}
		public static function getRequest(url:String,variables:Object=null,method:String=null):URLRequest{
			var urlRequest:URLRequest=new URLRequest(url);
			if(variables){
				var urlVariables:URLVariables=new URLVariables();
				urlRequest.method=method?method:URLRequestMethod.POST;
				if(variables is ByteArray){
					//trace("ByteArray variables.length="+variables.length);
					urlRequest.data=variables;
					urlRequest.contentType="application/octet-stream";
				}else if(variables is FormVariables){
					urlRequest.data=(variables as FormVariables).data;
					urlRequest.contentType=(variables as FormVariables).contentType;
				}else{
					for(var varName:String in variables){
						urlVariables[varName]=variables[varName];
					}
					urlRequest.data=urlVariables;
				}
			}
			return urlRequest;
		}
		private function loadStatus(event:HTTPStatusEvent):void{
			if(httpResponseStatus){
				responseURL=event["responseURL"];
			}
		}
		private function loadComplete(event:Event):void{
			if(onLoadProgress!=null){
				target.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			}
			if(!responseURL){
				responseURL=getRealURL("",currURL);
			}
			onLoadFinished(SUCCESS);
		}
		private function loadError(event:IOErrorEvent):void{
			if(onLoadProgress!=null){
				target.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			}
			//trace("event="+event);
			switch(event.text.substr(7,4)){
				case "2035":
					trace("找不到 URL");
					onLoadFinished(URL_NOT_FOUND);
				break;
				case "2124":
					trace("加载的文件为未知类型");
					onLoadFinished(UNKNOWN_TYPE);
				break;
				default:
					trace("loadError event="+event);
					onLoadFinished(ERROR);
				break;
			}
		}
		
		public static function getRealURL(responseURL:String,url:String):String{
			//把相对地址 url 和 responseURL 合起来返回一个绝对地址
			//例如 	responseURL=="http://www.daodao.net/zero/"
			//		url=="../test.htm"
			//返回	"http://www.daodao.net/test.htm"
			
			var id:int=url.indexOf(":");
			if(id>0){
				if(url.indexOf("/")==id+1){
					return url;
				}
				//trace("出错的 url: "+url);
				return null;
			}
			if(url.indexOf("./")==0){
				url=url.substr(2);
			}
			if(url.indexOf("/")==0){
				if(responseURL){
					var headArr:Array=responseURL.match(/.*?:\/{2,3}/);
					if(headArr){
						var head:String=headArr[0];
						var host:String=responseURL.substr(head.length);
						host=host.substr(0,host.indexOf("/"));
						return head+host+url;
					}
				}
				//trace("出错的 url: "+url);
				return null;
			}
			if(responseURL){
				var folderURL:String=responseURL.substr(0,responseURL.lastIndexOf("/"));
				while(url.indexOf("../")==0){
					url=url.substr(3);
					folderURL=folderURL.substr(0,folderURL.lastIndexOf("/"));
				}
				return folderURL+"/"+url;
			}
			//trace("出错的 url: "+url);
			return url;
		}
		
		//转至 _air.AirFile.url2File
		//public static function url2File(rootFolder:String,url:String):File{}
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