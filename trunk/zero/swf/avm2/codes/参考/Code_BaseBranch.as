/***
Code_BaseBranch 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年7月13日 01:44:17
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class Code_BaseBranch extends CodeObj{
		public var pos:int;
		public var pos_offset:int;
		//
		public function getPosAndPutFFFFFFInData(data:ByteArray):int{
			var jump_offset_pos:int=data.length;
			data[jump_offset_pos]=0xff;
			data[jump_offset_pos+1]=0xff;
			data[jump_offset_pos+2]=0xff;//由 Codes.toInfo() 设置
			return jump_offset_pos;
		}
		public function writeOffsetToPos(
			data:ByteArray,
			labelMark:LabelMark,
			jump_offset_pos:int
		):void{
			var jump_offset:int=labelMark.pos-(pos+pos_offset);
			//Branch 是从 s24 后面算起,pos_offset==4
			//Lookupswitch 是从 op 前面算起,pos_offset==0
			data[jump_offset_pos]=jump_offset;
			data[jump_offset_pos+1]=jump_offset>>8;
			data[jump_offset_pos+2]=jump_offset>>16;
		}
		public function writeOffsetsToPos(data:ByteArray):void{
			throw new Error("请 override 来使用");
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