/***
ImgUploader 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月2日 11:12:12
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.photodiys{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.utils.*;
	
	import mx.graphics.codec.*;
	
	import zero.*;
	import zero.net.*;
	public class ImgUploader{
		
		private var uploader:PHPXMLLoader;
		private var onUploadComplete:Function;
		
		public function ImgUploader(
			bmd:BitmapData,
			imgData:ByteArray,
			name:String,
			folderId:int,
			_onUploadComplete:Function
		){
			onUploadComplete=_onUploadComplete;
			var uploadURL:String=ZeroCommon.path_photodiy_album_uploadFile+"?name="+escape(name);
			
			//uploader=new PHPXMLLoader(progressBar.setProgress,uploadComplete);
			uploader=new PHPXMLLoader(trace,uploadComplete);
			
			
			var iconWid:int=40;
			var iconHei:int=40;
			var iconBmd:BitmapData=new BitmapData(iconWid,iconHei,false,0xffffff);
			iconBmd.draw(
				new Bitmap(bmd),
				new Matrix(iconWid/bmd.width,0,0,iconHei/bmd.height)
			);
			
			var data:ByteArray=new ByteArray();
			switch((FileTypes.getType(imgData))){
				case FileTypes.JPG:
				case FileTypes.PNG:
				case FileTypes.GIF:
					data.writeBytes(imgData);
				break;
				case FileTypes.BMP:
					data.writeBytes(new PNGEncoder().encode(bmd));
					uploadURL+=".png";
				break;
				default:
					throw new Error("不支持的文件类型");
				break;
			}
			
			if(folderId>0){
				uploadURL+="&folderId="+folderId;
			}
			
			uploadURL+="&iconPos="+data.length;
			uploadURL+="&iconName=icon.jpg";
			data.writeBytes(new JPEGEncoder().encode(iconBmd));//缩略图
			
			uploader.loadData(
				uploadURL,
				data,
				URLLoaderDataFormat.TEXT
			);
		}
		
		private function uploadComplete(info:String):void{
			if(info==RequestLoader.SUCCESS){
				//trace("uploader.xml="+uploader.xml.toXMLString());
				if(uploader.xml){
					onUploadComplete(uploader.xml);
					
					stop();
					
					return;
				}
			}
			onUploadComplete(null);
			
			stop();
			
			return;
		}
		
		public function stop():void{
			uploader.clear();
			onUploadComplete=null;
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