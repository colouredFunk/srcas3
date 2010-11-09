/***
Za7Za8 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月6日 14:35:33
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	
	import zero.swf.SWF2;
	import zero.swf.Tag;
	import zero.swf.TagType;
	
	public class Za7Za8{
		/*
		public static function mix(swf:SWF2,str0Arr:Array,strtArr:Array=null):void{
			if(strtArr){
				strtArr=strtArr.concat(RandomStrs.getRanArr(str0Arr.length-strtArr.length));
			}else{
				strtArr=RandomStrs.getRanArr(str0Arr.length);
			}
			ReplaceStrs.replace(
				swf,
				str0Arr,
				strtArr
			);
		}
		*/
		
		public static function getUsefulTags(tagV:Vector.<Tag>):Vector.<Tag>{
			//把 FileAttributes，DebugId 等不想要的去掉
			var usefulTagV:Vector.<Tag>=new Vector.<Tag>();
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagType.DefineShape:
					case TagType.PlaceObject:
					case TagType.RemoveObject:
					case TagType.DefineBits:
					case TagType.DefineButton:
					case TagType.DefineFont:
					case TagType.DefineText:
					case TagType.DefineFontInfo:
					case TagType.DefineSound:
					case TagType.StartSound:
					case TagType.DefineButtonSound:
					case TagType.SoundStreamHead:
					case TagType.SoundStreamBlock:
					case TagType.DefineBitsLossless:
					case TagType.DefineBitsJPEG2:
					case TagType.DefineShape2:
					case TagType.DefineButtonCxform:
					case TagType.PlaceObject2:
					case TagType.RemoveObject2:
					case TagType.DefineShape3:
					case TagType.DefineText2:
					case TagType.DefineButton2:
					case TagType.DefineBitsJPEG3:
					case TagType.DefineBitsLossless2:
					case TagType.DefineEditText:
					case TagType.DefineSprite:
					case TagType.SoundStreamHead2:
					case TagType.DefineMorphShape:
					case TagType.DefineFont2:
					case TagType.DefineVideoStream:
					case TagType.VideoFrame:
					case TagType.DefineFontInfo2:
					case TagType.SetTabIndex:
					case TagType.PlaceObject3:
					case TagType.ImportAssets2:
					case TagType.DoABCWithoutFlagsAndName:
					case TagType.DefineFontAlignZones:
					case TagType.CSMTextSettings:
					case TagType.DefineFont3:
					case TagType.SymbolClass:
					case TagType.DefineScalingGrid:
					case TagType.DoABC:
					case TagType.DefineShape4:
					case TagType.DefineMorphShape2:
					case TagType.DefineBinaryData:
					case TagType.DefineFontName:
					case TagType.StartSound2:
					case TagType.DefineBitsJPEG4:
					case TagType.DefineFont4:
						usefulTagV.push(tag);
					break;
				}
			}
			return usefulTagV;
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