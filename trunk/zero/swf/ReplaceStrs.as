/***
ReplaceStrs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年7月20日 09:04:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package swf_encode_and_decode{
	import _swf._record.TagAndName;
	import _swf._tag._body.SymbolClass;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class ReplaceStrs{
		public static function replace(
			data:ByteArray,
			tagV:Vector.<Tag>,
			str0Arr:Array,
			strtArr:Array,
			symbolClassNameIdArr:Array//,
			//restCanBeSame:Boolean=false
		):ByteArray{
			/*
			if(restCanBeSame){
				var restName:String=strtArr[int(Math.random()*strtArr.length)];
				while(strtArr.length<str0Arr.length){
					strtArr[strtArr.length]=restName;
				}
			}else{*/
				while(strtArr.length<str0Arr.length){
					strtArr[strtArr.length]=RandomStrs.getRan();
				}
			//}
			var newData:ByteArray=new ByteArray();
			var symbolClassNameMark:Object=new Object();
			for each(var symbolClassNameId:int in symbolClassNameIdArr){
				symbolClassNameMark[str0Arr[symbolClassNameId]]=strtArr[symbolClassNameId];
			}
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var doABCStrsEditor:DoABCStrsEditor=new DoABCStrsEditor();
						doABCStrsEditor.initByData(data,tag);
						doABCStrsEditor.replaceStrs(str0Arr,strtArr);
						newData.writeBytes(
							Tag.toData_typeAndBodyData(tag.type,doABCStrsEditor.toData())
						);
					break;
					case TagType.SymbolClass:
						var sc:SymbolClass=new SymbolClass();
						sc.initByDataNow(data,tag.bodyOffset);
						for each(var tagAndName:TagAndName in sc.tagAndNameV){
							if(symbolClassNameMark[tagAndName.Name]){
								tagAndName.Name=symbolClassNameMark[tagAndName.Name];
							}
						}
						newData.writeBytes(
							Tag.toData_typeAndBodyData(TagType.SymbolClass,sc.toDataNow())
						);
					break;
					default:
						newData.writeBytes(data,tag.headOffset,tag.bodyOffset-tag.headOffset+tag.bodyLength);
					break;
				}
			}
			return newData;
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