/***
HanziData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年11月16日 10:08:17
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.hanzis{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class HanziData{
		[Bindable]
		[Embed(source="datas/hanziData.dat",mimeType="application/octet-stream")]
		private static var HanziDataClass:Class ;
		
		public static var hanziDatas:Object;
		
		public static var pinyinTable:Array;
		public static var pinyinTexts:Object;
		
		public static var gdPinyinTable:Array;
		public static var gdPinyinTexts:Object;
		
		public static var bushouTable:Array;
		public static var bushouTexts:Object;
		
		public static var bihuaTable:Array;
		
		public static var wordArr:Array;
		
		public static function init():void{
			var t:int=getTimer();
			
			var obj:Object=ByteArray(new HanziDataClass()).readObject();
			hanziDatas=obj.hanziDatas;
			
			pinyinTable=obj.pinyinTable;
			pinyinTexts=obj.pinyinTexts;
			
			gdPinyinTable=obj.gdPinyinTable;
			gdPinyinTexts=obj.gdPinyinTexts;
			
			bushouTable=obj.bushouTable;
			bushouTexts=obj.bushouTexts;
			
			bihuaTable=obj.bihuaTable;
			
			wordArr=obj.wordArr;
			
			trace("HanziData.init 耗时:"+(getTimer()-t)+"毫秒");
		}
		public static function getHanziData(text:String):Object{
			return hanziDatas[text.charCodeAt(0)-0x4e00];
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