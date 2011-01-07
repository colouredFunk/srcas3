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