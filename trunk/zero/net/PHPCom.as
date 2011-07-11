/***
PHPCom 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月18日 17:06:04
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.utils.*;
	
	public class PHPCom{
		public static var GetAndSetValue:Class;
		public static var gameMainClassName:String;
		public static var gameMainClass:Class;
		
		public static function init(_GetAndSetValue:Class,_gameMainClassName:String):void{
			GetAndSetValue=_GetAndSetValue;
			gameMainClassName=_gameMainClassName;
			gameMainClass=PHPCom.GetAndSetValue["getValue"](gameMainClassName);
		}
		
		public static function getPageURL(dspObj:DisplayObject):String{
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
					//pageURL=bottomBarContainer.loaderInfo.url;//有时会不准确 - -
					pageURL=GetAndSetValue["getValue"]("loaderInfo.url",dspObj);
				}catch(e:Error){
					//trace("e="+e);
				}
			}
			
			if(pageURL){
				pageURL=decodeURI(pageURL);
				if(pageURL.indexOf("app:/")==0){
					//trace("Air应用程序：pageURL="+pageURL);
					pageURL=pageURL.replace("app:","file:///"+GetAndSetValue["getValue"]("flash.filesystem.File.applicationDirectory.nativePath"));
				}
				pageURL=pageURL.replace(/\\/g,"/");
				return pageURL;
			}
			
			return null;
		}
	}
}

