/***
ImgDatas2Bmds 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月10日 10:50:53
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.ApplicationDomain;
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.encoder.BMPEncoder;
	import mx.graphics.codec.PNGEncoder;

	public class ImgDatas2Bmds{
		private static var loader:Loader;
		private static var imgDatas2BmdsFinished:Function;
		
		public static function imgDatas2Bmds(imgDataV:Vector.<ByteArray>,_imgDatas2BmdsFinished:Function):void{
			if(loader){
				throw new Error("不支持同时进行两个 imgDatas2Bmds()");
			}
			
			imgDatas2BmdsFinished=_imgDatas2BmdsFinished;
			var i:int=0;
			var swf:SWF2=new SWF2();
			swf.tagV.push(new Tag(TagType.ShowFrame));
			swf.tagV.push(new Tag(TagType.End));
			var resInserter:ResInserter=new ResInserter(swf.tagV);
			for each(var imgData:ByteArray in imgDataV){
				if(imgData[0]==0x42&&imgData[1]==0x4d){//BM
					imgDataV[i]=imgData=new PNGEncoder().encode(BMPEncoder.decode(imgData));
				}
				resInserter.insert(imgData,"Bmd"+(i++),ResInserter.BITMAP,-1,true)
			}
			resInserter.getTagVAndReset();
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			loader.loadBytes(swf.toSWFData());
		}
		private static function loadComplete(event:Event):void{
			var bmdV:Vector.<BitmapData>=new Vector.<BitmapData>();
			var app:ApplicationDomain=loader.contentLoaderInfo.applicationDomain;
			var i:int=0;
			while(app.hasDefinition("Bmd"+i)){
				bmdV[i]=new ((app.getDefinition("Bmd"+i)))();
				i++;
			}
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			loader=null;
			imgDatas2BmdsFinished(bmdV);
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