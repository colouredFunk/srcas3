/***
TagType 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年1月4日 15:19:56
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.net.URLRequest;
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
			typeNameArr=[];
			typeNameArr[0]="End";
			End=0;
			typeNameArr[1]="ShowFrame";
			ShowFrame=1;
			typeNameArr[2]="DefineShape";
			DefineShape=2;
			typeNameArr[3]="";
			
			typeNameArr[4]="PlaceObject";
			PlaceObject=4;
			typeNameArr[5]="RemoveObject";
			RemoveObject=5;
			typeNameArr[6]="DefineBits";
			DefineBits=6;
			typeNameArr[7]="DefineButton";
			DefineButton=7;
			typeNameArr[8]="JPEGTables";
			JPEGTables=8;
			typeNameArr[9]="SetBackgroundColor";
			SetBackgroundColor=9;
			typeNameArr[10]="DefineFont";
			DefineFont=10;
			typeNameArr[11]="DefineText";
			DefineText=11;
			typeNameArr[12]="DoAction";
			DoAction=12;
			typeNameArr[13]="DefineFontInfo";
			DefineFontInfo=13;
			typeNameArr[14]="DefineSound";
			DefineSound=14;
			typeNameArr[15]="StartSound";
			StartSound=15;
			typeNameArr[16]="";
			
			typeNameArr[17]="DefineButtonSound";
			DefineButtonSound=17;
			typeNameArr[18]="SoundStreamHead";
			SoundStreamHead=18;
			typeNameArr[19]="SoundStreamBlock";
			SoundStreamBlock=19;
			typeNameArr[20]="DefineBitsLossless";
			DefineBitsLossless=20;
			typeNameArr[21]="DefineBitsJPEG2";
			DefineBitsJPEG2=21;
			typeNameArr[22]="DefineShape2";
			DefineShape2=22;
			typeNameArr[23]="DefineButtonCxform";
			DefineButtonCxform=23;
			typeNameArr[24]="Protect";
			Protect=24;
			typeNameArr[25]="";
			
			typeNameArr[26]="PlaceObject2";
			PlaceObject2=26;
			typeNameArr[27]="";
			
			typeNameArr[28]="RemoveObject2";
			RemoveObject2=28;
			typeNameArr[29]="";
			
			typeNameArr[30]="";
			
			typeNameArr[31]="";
			
			typeNameArr[32]="DefineShape3";
			DefineShape3=32;
			typeNameArr[33]="DefineText2";
			DefineText2=33;
			typeNameArr[34]="DefineButton2";
			DefineButton2=34;
			typeNameArr[35]="DefineBitsJPEG3";
			DefineBitsJPEG3=35;
			typeNameArr[36]="DefineBitsLossless2";
			DefineBitsLossless2=36;
			typeNameArr[37]="DefineEditText";
			DefineEditText=37;
			typeNameArr[38]="";
			
			typeNameArr[39]="DefineSprite";
			DefineSprite=39;
			typeNameArr[40]="";
			
			typeNameArr[41]="ProductInfo";
			ProductInfo=41;
			typeNameArr[42]="";
			
			typeNameArr[43]="FrameLabel";
			FrameLabel=43;
			typeNameArr[44]="";
			
			typeNameArr[45]="SoundStreamHead2";
			SoundStreamHead2=45;
			typeNameArr[46]="DefineMorphShape";
			DefineMorphShape=46;
			typeNameArr[47]="";
			
			typeNameArr[48]="DefineFont2";
			DefineFont2=48;
			typeNameArr[49]="";
			
			typeNameArr[50]="";
			
			typeNameArr[51]="";
			
			typeNameArr[52]="";
			
			typeNameArr[53]="";
			
			typeNameArr[54]="";
			
			typeNameArr[55]="";
			
			typeNameArr[56]="ExportAssets";
			ExportAssets=56;
			typeNameArr[57]="ImportAssets";
			ImportAssets=57;
			typeNameArr[58]="EnableDebugger";
			EnableDebugger=58;
			typeNameArr[59]="DoInitAction";
			DoInitAction=59;
			typeNameArr[60]="DefineVideoStream";
			DefineVideoStream=60;
			typeNameArr[61]="VideoFrame";
			VideoFrame=61;
			typeNameArr[62]="DefineFontInfo2";
			DefineFontInfo2=62;
			typeNameArr[63]="DebugID";
			DebugID=63;
			typeNameArr[64]="EnableDebugger2";
			EnableDebugger2=64;
			typeNameArr[65]="ScriptLimits";
			ScriptLimits=65;
			typeNameArr[66]="SetTabIndex";
			SetTabIndex=66;
			typeNameArr[67]="";
			
			typeNameArr[68]="";
			
			typeNameArr[69]="FileAttributes";
			FileAttributes=69;
			typeNameArr[70]="PlaceObject3";
			PlaceObject3=70;
			typeNameArr[71]="ImportAssets2";
			ImportAssets2=71;
			typeNameArr[72]="DoABCWithoutFlagsAndName";
			DoABCWithoutFlagsAndName=72;
			typeNameArr[73]="DefineFontAlignZones";
			DefineFontAlignZones=73;
			typeNameArr[74]="CSMTextSettings";
			CSMTextSettings=74;
			typeNameArr[75]="DefineFont3";
			DefineFont3=75;
			typeNameArr[76]="SymbolClass";
			SymbolClass=76;
			typeNameArr[77]="Metadata";
			Metadata=77;
			typeNameArr[78]="DefineScalingGrid";
			DefineScalingGrid=78;
			typeNameArr[79]="";
			
			typeNameArr[80]="";
			
			typeNameArr[81]="";
			
			typeNameArr[82]="DoABC";
			DoABC=82;
			typeNameArr[83]="DefineShape4";
			DefineShape4=83;
			typeNameArr[84]="DefineMorphShape2";
			DefineMorphShape2=84;
			typeNameArr[85]="";
			
			typeNameArr[86]="DefineSceneAndFrameLabelData";
			DefineSceneAndFrameLabelData=86;
			typeNameArr[87]="DefineBinaryData";
			DefineBinaryData=87;
			typeNameArr[88]="DefineFontName";
			DefineFontName=88;
			typeNameArr[89]="StartSound2";
			StartSound2=89;
			typeNameArr[90]="DefineBitsJPEG4";
			DefineBitsJPEG4=90;
			typeNameArr[91]="DefineFont4";
			DefineFont4=91;
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