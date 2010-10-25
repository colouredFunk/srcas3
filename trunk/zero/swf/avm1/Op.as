/***
Op 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年12月21日 09:50:57
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//An ACTIONRECORDHEADER has the following layout:
//Field 		Type 					Comment
//ActionCode 	UI8 					An action code
//Length 		If code >= 0x80, UI16 	The number of bytes in the ACTIONRECORDHEADER, not counting the ActionCode and Length fields.

package zero.swf.avm1{
	public class Op{
		public static const op$end:int=0x00;
		//0x01
		//0x02
		//0x03
		public static const op$nextFrame:int=0x04;
		public static const op$prevFrame:int=0x05;
		public static const op$play:int=0x06;
		public static const op$stop:int=0x07;
		public static const op$toggleQuality:int=0x08;
		public static const op$stopSounds:int=0x09;
		public static const op$oldAdd:int=0x0a;
		public static const op$subtract:int=0x0b;
		public static const op$multiply:int=0x0c;
		public static const op$divide:int=0x0d;
		public static const op$oldEquals:int=0x0e;
		public static const op$oldLessThan:int=0x0f;
		public static const op$and:int=0x10;
		public static const op$or:int=0x11;
		public static const op$not:int=0x12;
		public static const op$stringEq:int=0x13;
		public static const op$stringLength:int=0x14;
		public static const op$substring:int=0x15;
		//0x16
		public static const op$pop:int=0x17;
		public static const op$int:int=0x18;
		//0x19
		//0x1a
		//0x1b
		public static const op$getVariable:int=0x1c;
		public static const op$setVariable:int=0x1d;
		//0x1e
		//0x1f
		public static const op$setTargetExpr:int=0x20;
		public static const op$concat:int=0x21;
		public static const op$getProperty:int=0x22;
		public static const op$setProperty:int=0x23;
		public static const op$duplicateClip:int=0x24;
		public static const op$removeClip:int=0x25;
		public static const op$trace:int=0x26;
		public static const op$startDrag:int=0x27;
		public static const op$stopDrag:int=0x28;
		public static const op$stringLess:int=0x29;
		public static const op$throw:int=0x2a;
		public static const op$cast:int=0x2b;
		public static const op$implements:int=0x2c;
		public static const op$FSCommand2:int=0x2d;//undoc
		//0x2e
		//0x2f
		public static const op$random:int=0x30;
		public static const op$mBStringLength:int=0x31;
		public static const op$ord:int=0x32;
		public static const op$chr:int=0x33;
		public static const op$getTimer:int=0x34;
		public static const op$mbSubstring:int=0x35;
		public static const op$mbOrd:int=0x36;
		public static const op$mbChr:int=0x37;
		//0x38
		//0x39
		public static const op$delete:int=0x3a;
		public static const op$delete2:int=0x3b;
		public static const op$varEquals:int=0x3c;
		public static const op$callFunction:int=0x3d;
		public static const op$return:int=0x3e;
		public static const op$modulo:int=0x3f;
		public static const op$new:int=0x40;
		public static const op$var:int=0x41;
		public static const op$initArray:int=0x42;
		public static const op$initObject:int=0x43;
		public static const op$typeof:int=0x44;
		public static const op$targetPath:int=0x45;
		public static const op$enumerate:int=0x46;
		public static const op$add:int=0x47;
		public static const op$lessThan:int=0x48;
		public static const op$equals:int=0x49;
		public static const op$toNumber:int=0x4a;
		public static const op$toString:int=0x4b;
		public static const op$dup:int=0x4c;
		public static const op$swap:int=0x4d;
		public static const op$getMember:int=0x4e;
		public static const op$setMember:int=0x4f;
		public static const op$increment:int=0x50;
		public static const op$decrement:int=0x51;
		public static const op$callMethod:int=0x52;
		public static const op$newMethod:int=0x53;
		public static const op$instanceOf:int=0x54;
		public static const op$enumerateValue:int=0x55;
		//0x56
		//0x57
		//0x58
		//0x59
		//0x5a
		//0x5b
		//0x5c
		//0x5d
		//0x5e
		//0x5f
		public static const op$bitwiseAnd:int=0x60;
		public static const op$bitwiseOr:int=0x61;
		public static const op$bitwiseXor:int=0x62;
		public static const op$shiftLeft:int=0x63;
		public static const op$shiftRight:int=0x64;
		public static const op$shiftRight2:int=0x65;
		public static const op$strictEquals:int=0x66;
		public static const op$greaterThan:int=0x67;
		public static const op$stringGreater:int=0x68;
		public static const op$extends:int=0x69;
		//0x6a
		//0x6b
		//0x6c
		//0x6d
		//0x6e
		//0x6f
		//0x70
		//0x71
		//0x72
		//0x73
		//0x74
		//0x75
		//0x76
		//0x77
		//0x78
		//0x79
		//0x7a
		//0x7b
		//0x7c
		//0x7d
		//0x7e
		//0x7f
		//0x80
		public static const op$gotoFrame:int=0x81;
		//0x82
		public static const op$getURL:int=0x83;
		//0x84
		//0x85
		//0x86
		public static const op$setRegister:int=0x87;
		public static const op$constants:int=0x88;
		//0x89
		public static const op$ifFrameLoaded:int=0x8a;
		public static const op$setTarget:int=0x8b;
		public static const op$gotoLabel:int=0x8c;
		public static const op$ifFrameLoadedExpr:int=0x8d;
		public static const op$function2:int=0x8e;
		public static const op$try:int=0x8f;
		//0x90
		//0x91
		//0x92
		//0x93
		public static const op$with:int=0x94;
		//0x95
		public static const op$push:int=0x96;
		//0x97
		//0x98
		public static const op$branch:int=0x99;
		public static const op$getURL2:int=0x9a;
		public static const op$function:int=0x9b;
		//0x9c
		public static const op$branchIfTrue:int=0x9d;
		public static const op$callFrame:int=0x9e;
		public static const op$gotoFrame2:int=0x9f;
		//0xa0
		//0xa1
		//0xa2
		//0xa3
		//0xa4
		//0xa5
		//0xa6
		//0xa7
		//0xa8
		//0xa9
		//0xaa
		//0xab
		//0xac
		//0xad
		//0xae
		//0xaf
		//0xb0
		//0xb1
		//0xb2
		//0xb3
		//0xb4
		//0xb5
		//0xb6
		//0xb7
		//0xb8
		//0xb9
		//0xba
		//0xbb
		//0xbc
		//0xbd
		//0xbe
		//0xbf
		//0xc0
		//0xc1
		//0xc2
		//0xc3
		//0xc4
		//0xc5
		//0xc6
		//0xc7
		//0xc8
		//0xc9
		//0xca
		//0xcb
		//0xcc
		//0xcd
		//0xce
		//0xcf
		//0xd0
		//0xd1
		//0xd2
		//0xd3
		//0xd4
		//0xd5
		//0xd6
		//0xd7
		//0xd8
		//0xd9
		//0xda
		//0xdb
		//0xdc
		//0xdd
		//0xde
		//0xdf
		//0xe0
		//0xe1
		//0xe2
		//0xe3
		//0xe4
		//0xe5
		//0xe6
		//0xe7
		//0xe8
		//0xe9
		//0xea
		//0xeb
		//0xec
		//0xed
		//0xee
		//0xef
		//0xf0
		//0xf1
		//0xf2
		//0xf3
		//0xf4
		//0xf5
		//0xf6
		//0xf7
		//0xf8
		//0xf9
		//0xfa
		//0xfb
		//0xfc
		//0xfd
		//0xfe
		//0xff
		public static const op_v:Vector.<String>=Vector.<String>([	"end",	"",	"",	"",	"nextFrame",	"prevFrame",	"play",	"stop",	"toggleQuality",	"stopSounds",	"oldAdd",	"subtract",	"multiply",	"divide",	"oldEquals",	"oldLessThan",	"and",	"or",	"not",	"stringEq",	"stringLength",	"substring",	"",	"pop",	"int",	"",	"",	"",	"getVariable",	"setVariable",	"",	"",	"setTargetExpr",	"concat",	"getProperty",	"setProperty",	"duplicateClip",	"removeClip",	"trace",	"startDrag",	"stopDrag",	"stringLess",	"throw",	"cast",	"implements",	"FSCommand2",	"",	"",	"random",	"mBStringLength",	"ord",	"chr",	"getTimer",	"mbSubstring",	"mbOrd",	"mbChr",	"",	"",	"delete",	"delete2",	"varEquals",	"callFunction",	"return",	"modulo",	"new",	"var",	"initArray",	"initObject",	"typeof",	"targetPath",	"enumerate",	"add",	"lessThan",	"equals",	"toNumber",	"toString",	"dup",	"swap",	"getMember",	"setMember",	"increment",	"decrement",	"callMethod",	"newMethod",	"instanceOf",	"enumerateValue",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"bitwiseAnd",	"bitwiseOr",	"bitwiseXor",	"shiftLeft",	"shiftRight",	"shiftRight2",	"strictEquals",	"greaterThan",	"stringGreater",	"extends",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"gotoFrame",	"",	"getURL",	"",	"",	"",	"setRegister",	"constants",	"",	"ifFrameLoaded",	"setTarget",	"gotoLabel",	"ifFrameLoadedExpr",	"function2",	"try",	"",	"",	"",	"",	"with",	"",	"push",	"",	"",	"branch",	"getURL2",	"function",	"",	"branchIfTrue",	"callFrame",	"gotoFrame2",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	""]);
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