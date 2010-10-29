/***
SimpleDoABC 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月13日 21:36:05
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.BytesAndStr16;
	import zero.swf.*;
	
	public class SimpleDoABC{
		private static var classNameOffsetDict:Dictionary=new Dictionary();
		
		//ByteArray
		public static const datClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 06 00 09 42 79 74 65 41 72 72 61 79 0a 43 6c 61 73 73 31 32 33 34 35 06 4f 62 6a 65 63 74 0b 66 6c 61 73 68 2e 75 74 69 6c 73 04 18 03 16 01 16 05 00 04 07 02 03 07 03 02 07 02 04 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/ByteArray/Class12345_compilation.swf
		
		//BitmapData
		//public static const bmdClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 06 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0a 42 69 74 6d 61 70 44 61 74 61 06 4f 62 6a 65 63 74 04 16 01 16 03 18 02 00 04 07 01 02 07 02 04 07 01 05 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 03 00 01 00 00 00 01 02 01 01 04 01 00 03 00 01 01 04 05 03 d0 30 47 00 00 01 03 01 05 06 09 d0 30 d0 24 00 2a 49 02 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/BitmapData/Class12345_compilation.swf
		
		//BitmapData (...args): 貌似不加 ...args 会引起部分位图填充出问题
		public static const bmdClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 06 00 0a 42 69 74 6d 61 70 44 61 74 61 0a 43 6c 61 73 73 31 32 33 34 35 06 4f 62 6a 65 63 74 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 04 18 03 16 01 16 05 00 04 07 02 03 07 03 02 07 02 04 03 00 00 00 04 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 03 02 05 06 09 d0 30 d0 24 00 2a 49 02 47 00 00 01 01 01 04 05 03 d0 30 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/BitmapData/Class12345_compilation.swf
		
		//Shape (貌似失败了)
		//public static const shapeClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 09 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 06 4f 62 6a 65 63 74 05 53 68 61 70 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 07 16 08 00 06 07 02 02 07 03 06 07 02 05 07 04 04 07 03 03 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 07 1b d0 30 65 00 60 03 30 60 04 30 60 05 30 60 02 30 60 02 58 00 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/Shape/Class12345_compilation.swf
		
		//Sprite
		//public static const spClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0b 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 09 16 0a 00 08 07 02 02 07 03 08 07 02 07 07 04 05 07 03 03 07 03 06 07 03 04 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 09 0a 06 d0 30 d0 49 00 47 00 00 01 01 01 08 09 03 d0 30 47 00 00 02 02 01 01 08 23 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/Sprite/Class12345_compilation.swf
		
		//Sprite dynamic: 如果不加 dynamic 那么当此 sprite 里放有带实例名的元件时将出问题
		public static const spClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0b 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 09 16 0a 00 08 07 02 02 07 03 08 07 02 07 07 04 05 07 03 03 07 03 06 07 03 04 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 08 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 09 0a 06 d0 30 d0 49 00 47 00 00 01 01 01 08 09 03 d0 30 47 00 00 02 02 01 01 08 23 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/Sprite/Class12345_compilation.swf
		
		//MovieClip
		//public static const mcClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0c 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 09 4d 6f 76 69 65 43 6c 69 70 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 0a 16 0b 00 09 07 02 02 07 03 07 07 02 08 07 04 05 07 03 03 07 03 06 07 03 04 07 03 09 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 09 27 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 08 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/MovieClip/Class12345_compilation.swf
		
		//MovieClip dynamic: 如果不加 dynamic 那么当此 movieclip 里放有带实例名的元件时将出问题
		public static const mcClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0c 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 09 4d 6f 76 69 65 43 6c 69 70 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 0a 16 0b 00 09 07 02 02 07 03 07 07 02 08 07 04 05 07 03 03 07 03 06 07 03 04 07 03 09 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 08 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 09 27 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 08 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/MovieClip/Class12345_compilation.swf
		
		private static function getClassData(str16:String):ByteArray{
			var classNameOffset:int=str16.indexOf("0a 43 6c 61 73 73 31 32 33 34 35 ")/3;
			if(classNameOffset>0){
				var classData:ByteArray=BytesAndStr16.str162bytes(str16);
				classNameOffsetDict[classData]=classNameOffset;
			}else{
				throw new Error("找不到 className: Class12345");
			}
			
			return classData;
		}
		public static function getDoABCTag(className:String,typeOrclassData:*):Tag{
			var classData:ByteArray;
			if(typeOrclassData is ByteArray){
				classData=typeOrclassData;
			}else{
				classData=SimpleDoABC[typeOrclassData+"ClassData"];
			}
			if(classData){
				var classNameOffset:int=classNameOffsetDict[classData];
				if(classNameOffset>0){
					//trace("classNameOffset="+classNameOffset);
					var doABCData:ByteArray=new ByteArray();
					doABCData.writeBytes(classData,0,classNameOffset);
					doABCData[classNameOffset]=0x00;
					doABCData.position=classNameOffset+1;
					doABCData.writeUTFBytes(className);
					var strSize:int=doABCData.length-classNameOffset-1;
					if(strSize>0x7f){
						throw new Error("暂不支持长度超过 0x7f 的 className: "+className);
					}
					doABCData[classNameOffset]=strSize;
					doABCData.writeBytes(classData,classNameOffset+11);
					//trace(BytesAndStr16.bytes2str16(doABCData,0,doABCData.length));
					var tag:Tag=new Tag();
					tag.type=TagType.DoABC;
					tag.bodyData=doABCData;
					return tag;
				}
				throw new Error("classNameOffset="+classNameOffset);
			}else{
				throw new Error("classData="+classData);
			}
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