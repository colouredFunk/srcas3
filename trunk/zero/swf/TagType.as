/***
TagType 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年1月4日 15:19:56
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.utils.*;
	public class TagType{
		public static const UNKNOWN:String="UNKNOWN 未知";
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		
		//
		//
		//
		//
		//
		//
		//
		//
		//
		public static const End:int=0;
		public static const ShowFrame:int=1;
		public static const DefineShape:int=2;
		//3
		public static const PlaceObject:int=4;
		public static const RemoveObject:int=5;
		public static const DefineBits:int=6;
		public static const DefineButton:int=7;
		public static const JPEGTables:int=8;
		public static const SetBackgroundColor:int=9;
		public static const DefineFont:int=10;
		public static const DefineText:int=11;
		public static const DoAction:int=12;
		public static const DefineFontInfo:int=13;
		public static const DefineSound:int=14;
		public static const StartSound:int=15;
		//16
		public static const DefineButtonSound:int=17;
		public static const SoundStreamHead:int=18;
		public static const SoundStreamBlock:int=19;
		public static const DefineBitsLossless:int=20;
		public static const DefineBitsJPEG2:int=21;
		public static const DefineShape2:int=22;
		public static const DefineButtonCxform:int=23;
		public static const Protect:int=24;
		//25
		public static const PlaceObject2:int=26;
		//27
		public static const RemoveObject2:int=28;
		//29
		//30
		//31
		public static const DefineShape3:int=32;
		public static const DefineText2:int=33;
		public static const DefineButton2:int=34;
		public static const DefineBitsJPEG3:int=35;
		public static const DefineBitsLossless2:int=36;
		public static const DefineEditText:int=37;
		//38
		public static const DefineSprite:int=39;
		//40
		public static const ProductInfo:int=41;
		//42
		public static const FrameLabel:int=43;
		//44
		public static const SoundStreamHead2:int=45;
		public static const DefineMorphShape:int=46;
		//47
		public static const DefineFont2:int=48;
		//49
		//50
		//51
		//52
		//53
		//54
		//55
		public static const ExportAssets:int=56;
		public static const ImportAssets:int=57;
		public static const EnableDebugger:int=58;
		public static const DoInitAction:int=59;
		public static const DefineVideoStream:int=60;
		public static const VideoFrame:int=61;
		public static const DefineFontInfo2:int=62;
		public static const DebugID:int=63;
		public static const EnableDebugger2:int=64;
		public static const ScriptLimits:int=65;
		public static const SetTabIndex:int=66;
		//67
		//68
		public static const FileAttributes:int=69;
		public static const PlaceObject3:int=70;
		public static const ImportAssets2:int=71;
		public static const DoABCWithoutFlagsAndName:int=72;
		public static const DefineFontAlignZones:int=73;
		public static const CSMTextSettings:int=74;
		public static const DefineFont3:int=75;
		public static const SymbolClass:int=76;
		public static const Metadata:int=77;
		public static const DefineScalingGrid:int=78;
		//79
		//80
		//81
		public static const DoABC:int=82;
		public static const DefineShape4:int=83;
		public static const DefineMorphShape2:int=84;
		//85
		public static const DefineSceneAndFrameLabelData:int=86;
		public static const DefineBinaryData:int=87;
		public static const DefineFontName:int=88;
		public static const StartSound2:int=89;
		public static const DefineBitsJPEG4:int=90;
		public static const DefineFont4:int=91;
		
		//
		//
		//
		//
		//
		//
		public static const typeNameArr:Array=[
			"End",
			"ShowFrame",
			"DefineShape",
			"",
			"PlaceObject",
			"RemoveObject",
			"DefineBits",
			"DefineButton",
			"JPEGTables",
			"SetBackgroundColor",
			"DefineFont",
			"DefineText",
			"DoAction",
			"DefineFontInfo",
			"DefineSound",
			"StartSound",
			"",
			"DefineButtonSound",
			"SoundStreamHead",
			"SoundStreamBlock",
			"DefineBitsLossless",
			"DefineBitsJPEG2",
			"DefineShape2",
			"DefineButtonCxform",
			"Protect",
			"",
			"PlaceObject2",
			"",
			"RemoveObject2",
			"",
			"",
			"",
			"DefineShape3",
			"DefineText2",
			"DefineButton2",
			"DefineBitsJPEG3",
			"DefineBitsLossless2",
			"DefineEditText",
			"",
			"DefineSprite",
			"",
			"ProductInfo",
			"",
			"FrameLabel",
			"",
			"SoundStreamHead2",
			"DefineMorphShape",
			"",
			"DefineFont2",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"ExportAssets",
			"ImportAssets",
			"EnableDebugger",
			"DoInitAction",
			"DefineVideoStream",
			"VideoFrame",
			"DefineFontInfo2",
			"DebugID",
			"EnableDebugger2",
			"ScriptLimits",
			"SetTabIndex",
			"",
			"",
			"FileAttributes",
			"PlaceObject3",
			"ImportAssets2",
			"DoABCWithoutFlagsAndName",
			"DefineFontAlignZones",
			"CSMTextSettings",
			"DefineFont3",
			"SymbolClass",
			"Metadata",
			"DefineScalingGrid",
			"",
			"",
			"",
			"DoABC",
			"DefineShape4",
			"DefineMorphShape2",
			"",
			"DefineSceneAndFrameLabelData",
			"DefineBinaryData",
			"DefineFontName",
			"StartSound2",
			"DefineBitsJPEG4",
			"DefineFont4"
		];
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