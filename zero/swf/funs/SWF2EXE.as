/***
SWF2EXE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年4月21日 14:42:55
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class SWF2EXE{
		private static var urlLoader:URLLoader;
		public static var playerData:ByteArray;
		public static var swfData:ByteArray;
		private static var swf2exeProgress:Function;
		private static var swf2exeFinished:Function;
		private static var isSelf:Boolean;
		
		public static function stop():void{
			try{
				urlLoader.close();
			}catch(e:Error){}
			clearURLLoader();
		}
		public static function loadPlayer(playerURL:String="http://zero.flashwing.net/common/FlashPlayer.exe.compress"):void{
			urlLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(ProgressEvent.PROGRESS,loadPlayerProgress);
			urlLoader.addEventListener(Event.COMPLETE,loadPlayerComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,loadPlayerError);
			urlLoader.load(new URLRequest(playerURL));
		}
		private static function loadPlayerProgress(event:ProgressEvent):void{
			swf2exeProgress(event.bytesLoaded,event.bytesTotal);
		}
		private static function loadPlayerComplete(event:Event):void{
			if(isSelf){
				var selfData:ByteArray=urlLoader.data;
				var offset:int=selfData.length;
				var swfDataSize:int=
					(selfData[--offset]<<24)|
					(selfData[--offset]<<16)|
					(selfData[--offset]<<8)|
					selfData[--offset]
				;
				offset-=4+swfDataSize;
				playerData=new ByteArray();
				playerData.writeBytes(selfData,0,offset);
			}else{
				playerData=urlLoader.data;
				playerData.uncompress();
			}
			if(swf2exeFinished!=null){
				_swf2exe();
			}
			clearURLLoader();
		}
		private static function loadPlayerError(event:IOErrorEvent):void{
			clearURLLoader();
			swf2exeFinished(null);
		}
		private static function clearURLLoader():void{
			if(urlLoader){
				urlLoader.removeEventListener(ProgressEvent.PROGRESS,loadPlayerProgress);
				urlLoader.removeEventListener(Event.COMPLETE,loadPlayerComplete);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadPlayerError);
				urlLoader=null;
			}
		}
		
		public static function self2exe(
			selfURL:String,
			_swfData:ByteArray,
			_swf2exeProgress:Function,
			_swf2exeFinished:Function
		):void{
			isSelf=true;
			swf2exeProgress=_swf2exeProgress;
			swf2exeFinished=_swf2exeFinished;
			swfData=_swfData;
			loadPlayer(selfURL);
		}
		public static function swf2exe(
			_swfData:ByteArray,
			_swf2exeProgress:Function,
			_swf2exeFinished:Function
		):void{
			isSelf=false;
			swf2exeProgress=_swf2exeProgress;
			swf2exeFinished=_swf2exeFinished;
			swfData=_swfData;
			if(playerData){
				_swf2exe();
			}else{
				loadPlayer();
			}
		}
		private static function _swf2exe():void{
			var data:ByteArray=new ByteArray();
			data.writeBytes(playerData);
			data.writeBytes(swfData);
			
			data[data.length]=0x56;
			data[data.length]=0x34;
			data[data.length]=0x12;
			data[data.length]=0xfa;//不知道啥意思...
			
			var swfDataSize:int=swfData.length;
			data[data.length]=swfDataSize;
			data[data.length]=swfDataSize>>8;
			data[data.length]=swfDataSize>>16;
			data[data.length]=swfDataSize>>24;
			
			swf2exeFinished(data);
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