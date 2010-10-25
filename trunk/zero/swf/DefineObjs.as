/***
DefineObjs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月7日 04:05:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class DefineObjs{
		public static const SWF:String="swf";
		public static const IMG:String="img";
		public static const MP3:String="mp3";
		public static const DAT:String="dat";
		
		public static const DefineShape:String=SWF;
		public static const DefineBits:String=IMG;
		public static const DefineButton:String=DAT;
		public static const DefineFont:String=DAT;
		public static const DefineText:String=DAT;
		public static const DefineFontInfo:String=DAT;
		public static const DefineSound:String=DAT;
			//public static const DefineButtonSound:int=17;
		public static const DefineBitsLossless:String=IMG;
		public static const DefineBitsJPEG2:String=IMG;
		public static const DefineShape2:String=SWF;
			//public static const DefineButtonCxform:int=23;
		public static const DefineShape3:String=SWF;
		public static const DefineText2:String=DAT;
		public static const DefineButton2:String=DAT;
		public static const DefineBitsJPEG3:String=IMG;
		public static const DefineBitsLossless2:String=IMG;
		public static const DefineEditText:String=DAT;
		public static const DefineSprite:String=DAT;
		public static const DefineMorphShape:String=DAT;
		public static const DefineFont2:String=DAT;
		public static const DefineVideoStream:String=DAT;
		public static const DefineFontInfo2:String=DAT;
			//public static const DefineFontAlignZones:int=73;
		public static const DefineFont3:String=DAT;
			//public static const DefineScalingGrid:int=78;
		public static const DefineShape4:String=SWF;
		public static const DefineMorphShape2:String=DAT;
		public static const DefineBinaryData:String=DAT;
			//DefineFontName:String=DAT;//FontID UI16 ID for this font to which this refers 没看懂...宁可信其有，不可信其无(经证实是指向 DefineFont 的)
		public static const DefineBitsJPEG4:String=IMG;
		public static const DefineFont4:String=DAT;
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