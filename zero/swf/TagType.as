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
		public static var End:int;
		public static var ShowFrame:int;
		public static var DefineShape:int;
		//3
		public static var PlaceObject:int;
		public static var RemoveObject:int;
		public static var DefineBits:int;
		public static var DefineButton:int;
		public static var JPEGTables:int;
		public static var SetBackgroundColor:int;
		public static var DefineFont:int;
		public static var DefineText:int;
		public static var DoAction:int;
		public static var DefineFontInfo:int;
		public static var DefineSound:int;
		public static var StartSound:int;
		//16
		public static var DefineButtonSound:int;
		public static var SoundStreamHead:int;
		public static var SoundStreamBlock:int;
		public static var DefineBitsLossless:int;
		public static var DefineBitsJPEG2:int;
		public static var DefineShape2:int;
		public static var DefineButtonCxform:int;
		public static var Protect:int;
		//25
		public static var PlaceObject2:int;
		//27
		public static var RemoveObject2:int;
		//29
		//30
		//31
		public static var DefineShape3:int;
		public static var DefineText2:int;
		public static var DefineButton2:int;
		public static var DefineBitsJPEG3:int;
		public static var DefineBitsLossless2:int;
		public static var DefineEditText:int;
		//38
		public static var DefineSprite:int;
		//40
		public static var ProductInfo:int;
		//42
		public static var FrameLabel:int;
		//44
		public static var SoundStreamHead2:int;
		public static var DefineMorphShape:int;
		//47
		public static var DefineFont2:int;
		//49
		//50
		//51
		//52
		//53
		//54
		//55
		public static var ExportAssets:int;
		public static var ImportAssets:int;
		public static var EnableDebugger:int;
		public static var DoInitAction:int;
		public static var DefineVideoStream:int;
		public static var VideoFrame:int;
		public static var DefineFontInfo2:int;
		public static var DebugID:int;
		public static var EnableDebugger2:int;
		public static var ScriptLimits:int;
		public static var SetTabIndex:int;
		//67
		//68
		public static var FileAttributes:int;
		public static var PlaceObject3:int;
		public static var ImportAssets2:int;
		public static var DoABCWithoutFlagsAndName:int;
		public static var DefineFontAlignZones:int;
		public static var CSMTextSettings:int;
		public static var DefineFont3:int;
		public static var SymbolClass:int;
		public static var Metadata:int;
		public static var DefineScalingGrid:int;
		//79
		//80
		//81
		public static var DoABC:int;
		public static var DefineShape4:int;
		public static var DefineMorphShape2:int;
		//85
		public static var DefineSceneAndFrameLabelData:int;
		public static var DefineBinaryData:int;
		public static var DefineFontName:int;
		public static var StartSound2:int;
		public static var DefineBitsJPEG4:int;
		public static var DefineFont4:int;
		
		//
		//
		//
		//
		//
		//
		public static var typeNameArr:Array;
		
		private static const firstInitResult:*=function():void{
			typeNameArr=[
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
		var type:int=0;
		for each(var typeName:String in typeNameArr){
			if(typeName){
				TagType[typeName]=type;
			}
			type++;
		}
		}();
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value;//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/