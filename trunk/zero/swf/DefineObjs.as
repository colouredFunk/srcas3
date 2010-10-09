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
		public static const DefineShape:Boolean=true;
		public static const DefineBits:Boolean=true;
		public static const DefineButton:Boolean=true;
		public static const DefineFont:Boolean=true;
		public static const DefineText:Boolean=true;
		public static const DefineFontInfo:Boolean=true;
		public static const DefineSound:Boolean=true;
			//public static const DefineButtonSound:int=17;
		public static const DefineBitsLossless:Boolean=true;
		public static const DefineBitsJPEG2:Boolean=true;
		public static const DefineShape2:Boolean=true;
			//public static const DefineButtonCxform:int=23;
		public static const DefineShape3:Boolean=true;
		public static const DefineText2:Boolean=true;
		public static const DefineButton2:Boolean=true;
		public static const DefineBitsJPEG3:Boolean=true;
		public static const DefineBitsLossless2:Boolean=true;
		public static const DefineEditText:Boolean=true;
		public static const DefineSprite:Boolean=true;
		public static const DefineMorphShape:Boolean=true;
		public static const DefineFont2:Boolean=true;
		public static const DefineVideoStream:Boolean=true;
		public static const DefineFontInfo2:Boolean=true;
			//public static const DefineFontAlignZones:int=73;
		public static const DefineFont3:Boolean=true;
			//public static const DefineScalingGrid:int=78;
		public static const DefineShape4:Boolean=true;
		public static const DefineMorphShape2:Boolean=true;
		public static const DefineBinaryData:Boolean=true;
			//DefineFontName:Boolean=true;//FontID UI16 ID for this font to which this refers 没看懂...宁可信其有，不可信其无(经证实是指向 DefineFont 的)
		public static const DefineBitsJPEG4:Boolean=true;
		public static const DefineFont4:Boolean=true;
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