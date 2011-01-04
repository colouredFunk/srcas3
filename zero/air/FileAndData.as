package zero.air{
	import flash.filesystem.*;
	import flash.utils.*;
	public class FileAndData{
		private static var fs:FileStream=new FileStream();
		public static function readDataFromFile(file:File):ByteArray{
			var data:ByteArray=new ByteArray();
			fs.open(file,FileMode.READ);
			fs.readBytes(data);
			fs.close();
			return data;
		}
		public static function writeDataToFile(data:ByteArray,file:File):void{
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(data);
			fs.close();
		}
		public static function readDataFromURL(url:String):ByteArray{
			return readDataFromFile(new File(url));
		}
		public static function writeDataToURL(data:ByteArray,url:String):void{
			writeDataToFile(data,new File(url));
		}
	}
}