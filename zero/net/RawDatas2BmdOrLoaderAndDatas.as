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
	import flash.system.LoaderContext;
	import flash.utils.*;
	
	import mx.graphics.codec.PNGEncoder;
	
	import zero.FileTypes;
	import zero.encoder.BMPEncoder;
	import zero.swf.funs.ImgDatas2SWFData;

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
			
			var imgDataArr:Array=new Array();
			var classNameArr:Array=new Array();
			
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
						imgDataArr.push(rawData);
						classNameArr.push("Bmd"+i);
						
					break;
					case FileTypes.SWF:
						var loader:Loader=new Loader();
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
						loader.loadBytes(rawData,getLoaderContext());
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
			
			imgsSWFLoader=new Loader();
			imgsSWFLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			imgsSWFLoader.loadBytes(ImgDatas2SWFData.imgDatas2SWFData(imgDataArr,classNameArr),getLoaderContext());
			rest++;
		}
		private function getLoaderContext():LoaderContext{
			var loaderContext:LoaderContext=new LoaderContext();
			if(loaderContext.hasOwnProperty("allowCodeImport")){
				loaderContext["allowCodeImport"]=true;
				return loaderContext;
			}
			return null;
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

