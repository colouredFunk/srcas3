/***
FileTypes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月11日 14:06:57
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	//尝试通过分析 ByteArray 的前 2 个字节获取文件类型
	public class FileTypes{
		//public static const UNKNOWN:String="unknown";
		public static const JPG:String="jpg";
		public static const PNG:String="png";
		public static const GIF:String="gif";
		public static const BMP:String="bmp";
		public static const SWF:String="swf";
		public static const MP3:String="mp3";
		public static const FLV:String="flv";
		public static const WAV:String="wav";
		public static const MID:String="mid";
		public static const RAR:String="rar";
		public static const EXE:String="exe";
		
		public static const typeMark:Object={
			_255216:JPG,
			_13780:PNG,
			_7173:GIF,
			_6677:BMP,
			_6787:SWF,
			_7087:SWF,
			_7368:MP3,
			_255250:MP3,
			_7076:FLV,
			_8273:WAV,
			_7784:MID,
			_8297:RAR,
			_7790:EXE
		}
		
		public static function getType(fileData:ByteArray,fileName:String=null,offset:int=0):String{
			var type:String=typeMark["_"+fileData[offset]+fileData[offset+1]];
			if(type){
				return type;
			}
			
			trace("无法仅通过分析 fileData 获取文件类型");
			if(fileName){
				var dotId:int=fileName.indexOf(".")+1;
				if(dotId>0){
					trace("获取文件后缀作为文件类型");
					return fileName.substr(dotId).toLowerCase();
				}
			}
			
			trace("无法获取文件类型");
			return null;
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