/***
RawDatas2BmdOrLoaderAndDatas 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月10日 10:50:53
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.ApplicationDomain;
	import flash.utils.*;
	
	import mx.graphics.codec.PNGEncoder;
	
	import zero.FileTypes;
	import zero.encoder.BMPEncoder;
	import zero.swf.*;
	import zero.swf.funs.*;

	public class RawDatas2BmdOrLoaderAndDatas{
		private var rawDatas2BmdOrLoaderAndDatasFinished:Function;
		
		private var imgsSWFLoader:Loader;//所有的 jpg，png，gif 原数据将直接编码成 DefineBitsJPEG2 到一个 SWF 里，用于解决本地打开仅访问网络的 SWF 又访问 loader.content 时引起 SecurityError: Error #2148 的问题
		
		private var bmdOrLoaderArr:Array;	//处理完成后，jpg，png，gif，bmp 将会转成 BitmapData，swf 将会转成 Loader
		private var dataArr:Array;			//处理完成后，jpg，png，gif，swf 将取原数据，bmp 将转成 png 数据
		
		private var rest:int;//用来计算全部加载完成
		
		public function RawDatas2BmdOrLoaderAndDatas(_rawDatas2BmdOrLoaderAndDatasFinished:Function,...rawDatas){
			//new RawDatas2BmdOrLoaderAndDatas(trace,testData);
			//new RawDatas2BmdOrLoaderAndDatas(trace,testData1,testData2,testData3);
			//new RawDatas2BmdOrLoaderAndDatas(trace,[testData1,testData2,testData3]);
			rawDatas2BmdOrLoaderAndDatasFinished=_rawDatas2BmdOrLoaderAndDatasFinished;
			
			var swf:SWF2=new SWF2();
			swf.tagV.push(new Tag(TagType.ShowFrame));
			swf.tagV.push(new Tag(TagType.End));
			var resInserter:ResInserter=new ResInserter(swf.tagV);
			
			var i:int=-1;
			bmdOrLoaderArr=new Array();
			dataArr=new Array();
			for each(var rawData:ByteArray in getRawDataArr(rawDatas)){
				i++;
				switch(FileTypes.getType(rawData)){
					case FileTypes.JPG:
					case FileTypes.PNG:
					case FileTypes.GIF:
						bmdOrLoaderArr[i]="Bmd"+i;
						
						dataArr[i]=rawData;
						resInserter.insert(rawData,"Bmd"+i,ResInserter.BITMAP,-1,true);
						
					break;
					case FileTypes.SWF:
						var loader:Loader=new Loader();
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
						loader.loadBytes(rawData);
						rest++;
						bmdOrLoaderArr[i]=loader;
						
						dataArr[i]=rawData;
					break;
					case FileTypes.BMP:
						bmdOrLoaderArr[i]=BMPEncoder.decode(rawData);
						
						dataArr[i]=new PNGEncoder().encode(bmdOrLoaderArr[i]);
						
					break;
					default:
						i--;
					break;
				}
			}
			resInserter.getTagVAndReset();
			
			imgsSWFLoader=new Loader();
			imgsSWFLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			imgsSWFLoader.loadBytes(swf.toSWFData());
			rest++;
		}
		private function getRawDataArr(rawDatas:*):Array{
			var rawDataArr:Array=new Array();
			if(rawDatas is ByteArray){
				rawDataArr.push(rawDatas);
			}else{
				for each(var subRawDatas:* in rawDatas){
					rawDataArr=rawDataArr.concat(getRawDataArr(subRawDatas));
				}
			}
			return rawDataArr;
		}
		private function loadComplete(event:Event):void{
			var loaderInfo:LoaderInfo=event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			
			var bmdOrLoader:*;
			if(loaderInfo==imgsSWFLoader.contentLoaderInfo){
				var i:int=bmdOrLoaderArr.length;
				while(--i>=0){
					bmdOrLoader=bmdOrLoaderArr[i];
					if(bmdOrLoader is String){
						bmdOrLoaderArr[i]=new (loaderInfo.applicationDomain.getDefinition(bmdOrLoader))();
					}
				}
			}/*else{
				for each(bmdOrLoader in bmdOrLoaderArr){
					if(bmdOrLoader is Loader){
						trace(loaderInfo==bmdOrLoader.contentLoaderInfo);
					}
				}
			}
			*/
			//trace(bmdOrLoaderArr);
			
			if(--rest<=0){
				imgsSWFLoader=null;
				rawDatas2BmdOrLoaderAndDatasFinished(bmdOrLoaderArr,dataArr);
				rawDatas2BmdOrLoaderAndDatasFinished=null;
				bmdOrLoaderArr=null;
				dataArr=null;
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