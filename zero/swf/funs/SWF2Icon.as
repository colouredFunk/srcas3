/***
SWF2Icon 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月8日 03:24:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.system.LoaderContext;
	import flash.utils.*;
	
	import mx.graphics.codec.PNGEncoder;
	
	import zero.Outputer;
	import zero.air.ReadAndWriteFile;
	
	public class SWF2Icon{
		private static var startTime:int=0;
		
		private static var fileV:Vector.<File>=new Vector.<File>();
		private static var currFile:File;
		private static var loader:Loader=initLoader();
		
		private static var wid:int;
		private static var hei:int;
		
		private static function initLoader():Loader{
			
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			return loader;
		}
		public static function swfFile2Icon(swfFile:File,_wid:int,_hei:int):void{
			wid=_wid;
			hei=_hei;
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
			loader.loadBytes(ReadAndWriteFile.readDataFromFile(currFile),loaderContext);
		}
		private static function loadComplete(event:Event):void{
			if(getTimer()-startTime>1000){
				startTime=getTimer();
				Outputer.output("swfFile2Icon 剩余: "+fileV.length);
			}
			var iconBmd:BitmapData=new BitmapData(loader.contentLoaderInfo.width,loader.contentLoaderInfo.height,true,0x00000000);
			iconBmd.draw(loader);
			var pngFileURL:String=currFile.url;
			pngFileURL=pngFileURL.substr(0,pngFileURL.lastIndexOf("."))+"_icon.png";
			ReadAndWriteFile.writeDataToURL(new PNGEncoder().encode(iconBmd),pngFileURL);
			currFile=null;
			if(fileV.length){
				load();
			}else{
				Outputer.output("swfFiles2Icon 完成","green");
			}
		}
		
		private static var intervalId:int=-1;
		private static var itemV:Vector.<Object>;
		private static var itemId:int;
		private static var resourceV:Vector.<Object>;
		private static var xmlFolderURL:String;
		public static function items2Icon(_itemV:Vector.<Object>,_resourceV:Vector.<Object>,_wid:int,_hei:int,_xmlFolderURL:String):void{
			wid=_wid;
			hei=_hei;
			
			itemV=_itemV;
			resourceV=_resourceV;
			xmlFolderURL=_xmlFolderURL;
			
			clearInterval(intervalId);
			itemId=-1;
			
			Outputer.output("items2Icon 开始, 共 "+itemV.length+" 个.","green");
			
			intervalId=setInterval(item2Icon,30);
		}
		private static function item2Icon():void{
			var t:int=getTimer();
			while(getTimer()-t<30){
				if(++itemId>=itemV.length){
					clearInterval(intervalId);
					Outputer.output("items2Icon 完成","green");
					return;
				}
				var iconBmd:BitmapData=new BitmapData(wid,hei,true,0x00000000);
				var item:*=itemV[itemId];
				var dspObj:DisplayObject;
				if(item is BitmapData){
					dspObj=new Bitmap(item);
				}else if(item is Sprite){
					dspObj=item;
				}else{
					throw new Error("暂不支持的 item: "+item);
				}
				var rect:Rectangle=dspObj.getBounds(dspObj);
				var scale:Number;
				if(wid*rect.height<rect.width*hei){
					scale=wid/rect.width;
				}else{
					scale=hei/rect.height;
				}
				
				iconBmd.draw(dspObj,new Matrix(scale,0,0,scale,-rect.x*scale+(wid-rect.width*scale)/2,-rect.y*scale+(hei-rect.height*scale)/2));
				
				var iconPath:String=xmlFolderURL+resourceV[itemId].bodyXML.@resource.toString();
				ReadAndWriteFile.writeDataToURL(new PNGEncoder().encode(iconBmd),iconPath=iconPath.substr(0,iconPath.lastIndexOf("."))+"_icon.png");
			}
			if(getTimer()-startTime>1000){
				startTime=getTimer();
				Outputer.output("items2Icon 剩余: "+(itemV.length-itemId));
			}
		}
		
		/*
		private static var mc:MovieClip;
		private static var resourceV:Vector.<Object>;
		private static var xmlFolderURL:String;
		public static function mc2Icon(_mc:MovieClip,_resourceV:Vector.<Object>,_wid:int,_hei:int,_xmlFolderURL:String):void{
			wid=_wid;
			hei=_hei;
			
			mc=_mc;
			resourceV=_resourceV;
			xmlFolderURL=_xmlFolderURL;
			
			mc.gotoAndStop(1);
			mc.play();
			mc2IconStep();
		}
		private static function mc2IconStep():void{
			var frameId:int=mc.currentFrame-1;
			//trace("frameId="+frameId);
			mc.addFrameScript(frameId,null);
			
			var sp:Sprite=mc.getChildAt(0) as Sprite;
			var child:DisplayObject=sp.getChildAt(0);
			var iconBmd:BitmapData=new BitmapData(wid,hei,true,0x00000000);
			
			var rect:Rectangle=sp.getBounds(sp);
			var scale:Number;
			if(wid*rect.height<rect.width*hei){
				scale=wid/rect.width;
			}else{
				scale=hei/rect.height;
			}
			
			iconBmd.draw(sp,new Matrix(scale,0,0,scale,-rect.x*scale+(wid-rect.width*scale)/2,-rect.y*scale+(hei-rect.height*scale)/2));
			
			var iconPath:String=xmlFolderURL+resourceV[frameId].bodyXML.@resource.toString();
			FileAndData.writeDataToURL(new PNGEncoder().encode(iconBmd),iconPath=iconPath.substr(0,iconPath.lastIndexOf("."))+"_icon.png");
			
			
			if(frameId+1<mc.totalFrames){
				mc.addFrameScript(frameId+1,mc2IconStep);
				
				if(getTimer()-startTime>1000){
					startTime=getTimer();
					Outputer.output("mc2Icon 剩余: "+(mc.totalFrames-frameId));
				}
			}else{
				Outputer.output("mc2Icon 完成","green");
			}
		}
		*/
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