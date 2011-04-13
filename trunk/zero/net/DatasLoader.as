/***
DatasLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月9日 17:34:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class DatasLoader{
		
		private var urlId:int;
		private var urlArr:Array;
		private var dataArr:Array;
		private var onLoadFinished:Function;
		
		private var dataLoader:DataLoader;
		private var dataFormat:String;
		public function DatasLoader(
			_urlArr:Array,
			_onLoadProgress:Function,
			_onLoadFinished:Function,
			_dataFormat:String=null
		){
			urlArr=_urlArr;
			onLoadFinished=_onLoadFinished;
			dataFormat=_dataFormat;
			dataLoader=new DataLoader(_onLoadProgress,loadOneFinished);
			urlId=-1;
			dataArr=new Array();
			loadNext();
		}
		public function clear():void{
			urlArr=null;
			dataArr=null;
			onLoadFinished=null;
			if(dataLoader){
				dataLoader.clear();
				dataLoader=null;
			}
		}
		
		private function loadNext():void{
			if(++urlId>=urlArr.length){
				onLoadFinished(urlArr,dataArr);
				clear();
				return;
			}
			dataLoader.loadData(urlArr[urlId],null,dataFormat);
		}
		
		private function loadOneFinished(info:String):void{
			if(info==RequestLoader.SUCCESS){
				dataArr[urlId]=dataLoader.data;
			}
			loadNext();
		}
	}
}
		