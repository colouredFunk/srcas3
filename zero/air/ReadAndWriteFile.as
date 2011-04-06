/***
ReadAndWriteFile 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年4月3日 15:50:52
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.air{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.filesystem.*;
	
	public class ReadAndWriteFile{
		//文件读写
		
		private static var fs:FileStream=new FileStream();
		
		public static function readDataFromFile(file:File):ByteArray{
			if(checkFile(file,true)){
				var data:ByteArray=new ByteArray();
				fs.open(file,FileMode.READ);
				fs.readBytes(data);
				fs.close();
				return data;
			}
			return null;
		}
		public static function writeDataToFile(data:ByteArray,file:File):void{
			if(checkFile(file,false)){
				fs.open(file,FileMode.WRITE);
				fs.writeBytes(data);
				fs.close();
			}
		}
		public static function readDataFromURL(url:String):ByteArray{
			if(checkURL(url)){
				return readDataFromFile(new File(url));
			}
			return null;
		}
		public static function writeDataToURL(data:ByteArray,url:String):void{
			if(checkURL(url)){
				writeDataToFile(data,new File(url));
			}
		}
		
		public static function readStrFromFile(file:File,charSet:String="utf-8"):String{
			if(checkFile(file,true)){
				//utf-8,unicode,gb2312
				fs.open(file,FileMode.READ);
				//var str:String=fs.readUTFBytes(fs.bytesAvailable);
				var str:String=fs.readMultiByte(fs.bytesAvailable,charSet);
				fs.close();
				return str;
			}
			return null;
		}
		public static function writeStrToFile(str:String,file:File,charSet:String="utf-8"):void{
			if(checkFile(file,false)){
				//utf-8,unicode,gb2312
				fs.open(file,FileMode.WRITE);
				fs.writeMultiByte(str,charSet);
				//fs.writeUTFBytes(str);
				fs.close();
			}
		}
		public static function readStrFromURL(url:String,charSet:String="utf-8"):String{
			if(checkURL(url)){
				return readStrFromFile(new File(url),charSet);
			}
			return null;
		}
		public static function writeStrToURL(str:String,url:String,charSet:String="utf-8"):void{
			if(checkURL(url)){
				writeStrToFile(str,new File(url),charSet);
			}
		}
		private static function checkFile(file:File,checkExists:Boolean):Boolean{
			if(file){
				if(file.exists||!checkExists){
					if(file.isDirectory){
						throw new Error(decodeURI(file.url)+" 是文件夹（而不是文件）");
					}else{
						return true;
					}
				}else{
					throw new Error(decodeURI(file.url)+" 不存在");
				}
			}else{
				throw new Error("file="+file+" 不能为空");
			}
			return false;
		}
		private static function checkURL(url:String):Boolean{
			if(url){
				try{
					new File(url);
				}catch(e:Error){
					trace("e="+e);
					throw new Error("url="+url+" 不是有效的路径");
					return false;
				}
			}else{
				throw new Error("url="+url+" 不能为空");
				return false;
			}
			return true;
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