package zero._air{
	import flash.filesystem.*;
	import flash.utils.*;
	public class FileAndStr{
		//文件读写
		private static var fs:FileStream=new FileStream();
		public static function readStrFromFile(file:File,charSet:String="utf-8"):String{
			//utf-8,unicode,gb2312
			fs.open(file,FileMode.READ);
			//var str:String=fs.readUTFBytes(fs.bytesAvailable);
			var str:String=fs.readMultiByte(fs.bytesAvailable,charSet);
			fs.close();
			return str;
		}
		public static function writeStrToFile(str:String,file:File,charSet:String="utf-8"):void{
			//utf-8,unicode,gb2312
			fs.open(file,FileMode.WRITE);
			fs.writeMultiByte(str,charSet);
			//fs.writeUTFBytes(str);
			fs.close();
		}
		public static function readStrFromURL(url:String,charSet:String="utf-8"):String{
			var file:File=new File(url);
			//utf-8,unicode,gb2312
			fs.open(file,FileMode.READ);
			//var str:String=fs.readUTFBytes(fs.bytesAvailable);
			var str:String=fs.readMultiByte(fs.bytesAvailable,charSet);
			fs.close();
			return str;
		}
		public static function writeStrToURL(str:String,url:String,charSet:String="utf-8"):void{
			var file:File=new File(url);
			//utf-8,unicode,gb2312
			fs.open(file,FileMode.WRITE);
			fs.writeMultiByte(str,charSet);
			//fs.writeUTFBytes(str);
			fs.close();
		}
	}
}