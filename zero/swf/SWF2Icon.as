/***
SWF2Icon 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月8日 03:24:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.system.LoaderContext;
	import flash.utils.*;
	
	import zero.Outputer;
	import zero.air.FileAndData;
	import zero.encoder.PNGEncoder;
	
	public class SWF2Icon{
		private static var fileV:Vector.<File>=new Vector.<File>();
		private static var currFile:File;
		private static var id:int=0;
		private static var loader:Loader=initLoader();
		private static function initLoader():Loader{
			
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			return loader;
		}
		public static function swf2icon(swfFile:File):void{
			fileV.push(swfFile);
			if(currFile){
			}else{
				load();
			}
		}
		private static function load():void{
			currFile=fileV.shift();
			var loaderContext:LoaderContext=new LoaderContext();
			loaderContext.allowLoadBytesCodeExecution=true;
			loader.loadBytes(FileAndData.readDataFromFile(currFile),loaderContext);
		}
		private static function loadComplete(event:Event):void{
			if(++id>=20){
				id=0;
				Outputer.output("swf2icon剩余: "+fileV.length);
			}
			var iconBmd:BitmapData=new BitmapData(loader.contentLoaderInfo.width,loader.contentLoaderInfo.height,true,0x00000000);
			iconBmd.draw(loader);
			var pngFileURL:String=currFile.url;
			pngFileURL=pngFileURL.substr(0,pngFileURL.lastIndexOf("."))+".png";
			FileAndData.writeDataToURL(PNGEncoder.encode(iconBmd),pngFileURL);
			currFile=null;
			if(fileV.length){
				load();
			}else{
				Outputer.output("swf2icon完成","green");
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