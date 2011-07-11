/***
ImgFileSelecterManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月10日 16:58:33
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.FileTypes;
	
	import zero.net.RawDatas2BmdOrLoaderAndDatas;
	
	public class ImgFileSelecterManager extends FileSelecterManager{
		public var onLoadImgsFinished:Function;
		public var bmdV:Vector.<BitmapData>;
		
		public function ImgFileSelecterManager(){
			onLoadDatas=loadImgDataV;
		}
		public function defaultInit():void{
			init(
				"选择一张图片",
				"jpg,png,gif,bmp",
				FileSelecterManager.OPEN
			);
		}
		public function defaultInitMultiple():void{
			init(
				"框选或Ctrl+单击可选择多张图片",
				"jpg,png,gif,bmp",
				FileSelecterManager.OPEN_MULTIPLE
			);
		}
		override public function clear():void{super.clear();
			onLoadImgsFinished=null;
		}
		
		private function loadImgDataV():void{
			var i:int=dataV.length;
			while(--i>=0){
				switch((FileTypes.getType(dataV[i]))){
					case FileTypes.JPG:
					case FileTypes.PNG:
					case FileTypes.GIF:
					case FileTypes.BMP:
					break;
					default:
						fileList.splice(i,1);
						dataV.splice(i,1);
					break;
				}
			}
			new RawDatas2BmdOrLoaderAndDatas(imgDatas2BmdsFinished,dataV);
		}
		private function imgDatas2BmdsFinished(bmdArr:Array,dataArr:Array):void{
			bmdV=Vector.<BitmapData>(bmdArr);
			(onLoadImgsFinished==null)||onLoadImgsFinished();
		}
	}
}

