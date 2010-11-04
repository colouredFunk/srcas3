/***
TagAndHeader 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月4日 10:34:02
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.utils.ByteArray;
	
	public class TagAndHeader{
		//在结构文档里搜索 RECORDHEADER (long) 可搜索得到
		private static const recordHeaderMustBeLongTypes:Object={
			//DefineButton:true,//测试完去掉
			//DefineButton2:true,//测试完去掉
			//DefineButtonCxform:true,//测试完去掉
			//DefineSceneAndFrameLabelData:true,//测试完去掉
			//DefineShape:true,//测试完去掉 Flash Builder 4 会把这个编译成短tag，Flash CS5 则会编译成长tag
			//DefineSprite:true,//测试完去掉
			//DoAction:true,//测试完去掉
			//ExportAssets:true,//测试完去掉
			//ImportAssets:true,//测试完去掉
			//JPEGTables:true,//测试完去掉
			//ScriptLimits:true,//测试完去掉 Flash Builder 4 会把这个编译成短tag，Flash CS5 则会编译成长tag
			//SymbolClass:true,//测试完去掉 Flash Builder 4 会把这个编译成短tag，Flash CS5 则会编译成长tag,
			//FrameLabel:true,//测试完去掉
			
			DefineBits:true,
			DefineBitsJPEG2:true,
			DefineBitsJPEG3:true,
			DefineBitsJPEG4:true,
			DefineBitsLossless:true,
			DefineBitsLossless2:true,
			SoundStreamBlock:true
			
		}//某天偶然发现的一些小图片变成短tag后出错(不知道还会不会有其它tag有这种现像)
		//public static function getHeaderData(type:int,bodyLength:int,test_isShort:Boolean):ByteArray{
		public static function getHeaderData(type:int,bodyLength:int):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=type<<6;
			data[1]=type>>>2;
			if(bodyLength>=0x3f||recordHeaderMustBeLongTypes[TagType.typeNameArr[type]]){//||!test_isShort
				//长tag
				data[0]|=0x3f;
				data[2]=bodyLength;
				data[3]=bodyLength>>8;
				data[4]=bodyLength>>16;
				data[5]=bodyLength>>24;
			}else{
				data[0]|=bodyLength;
			}
			return data;
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