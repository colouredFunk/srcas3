/***
StrGetter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月23日 09:23:32
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.gettersetter{
	import flash.utils.*;
	public class StrGetter{好像写的不好
		public static var len:int;
		public static function getStr1(data:ByteArray,offset:int,endOffset:int):String{
			if(offset>=endOffset){
				Outputer.output("offset>=endOffset offset="+offset+",endOffset="+endOffset,"brown");
				len=0;
				return "";
			}
			len=1;
			if(data[offset]){
				while(data[offset+(len++)]){}
				if(offset+len>=endOffset){
					len=endOffset-offset;
				}
				
				data.position=offset;
				return data.readUTFBytes(len);
			}
			return "";
		}
		
		private static const replaceCs:Object=getReplaceCs();
		private static function getReplaceCs():Object{
			var replaceCs:Object=new Object();
			replaceCs["\\"]="\\\\";
			replaceCs["\b"]="\\b";
			replaceCs["\n"]="\\n";
			replaceCs["\r"]="\\r";
			replaceCs["\t"]="\\t";
			//replaceCs["\v"]="\\v";
			//replaceCs["\a"]="\\a";
			replaceCs["\f"]="\\f";
			replaceCs["\'"]="\\'";
			//replaceCs["\""]="\\\"";
			//replaceCs["\?"]="\\?";
			return replaceCs;
		}
		public static function getStr2(data:ByteArray,offset:int,endOffset:int):String{
			if(offset>=endOffset){
				Outputer.output("offset>=endOffset offset="+offset+",endOffset="+endOffset,"brown");
				len=0;
				return "";
			}
			len=1;
			if(data[offset]){
				while(data[offset+(len++)]){}
				if(offset+len>=endOffset){
					len=endOffset-offset;
				}
				
				data.position=offset;
				return str12str2(data.readUTFBytes(len));
				/*var reg:RegExp=/[\']/;
				var id:int;
				while((id=str.search(reg))>=0){
				var c:String=str.charAt(id);
				trace("c="+c);
				str=str.replace(c,replaceCs[c]);
				}*/
				/*if(str.search(/[\n\r\']/)>=0){
				trace("match");
				str=str."]=\\/g,"\\\\").
				replace(/\b/g,"\\b").
				replace(/\o/g,"\\o").
				replace(/\n/g,"\\n").
				replace(/\r/g,"\\r").
				replace(/\t/g,"\\t").
				//replace(/\v/g,"\\v").
				//replace(/\a/g,"\\a").
				replace(/\f/g,"\\f").
				replace(/\'/g,"\\'").
				replace(/\"/g,"\\\"").
				replace(/\?/g,"\\?");
				}
				return "'"+str+"'";*/
			}
			return "''";
		}
		public static function str12str2(str1:String):String{
			var L:int=str1.length;
			var str2:String="";
			for(var i:int=0;i<L;i++){
				var c:String=str1.charAt(i);
				var replaceC:String=replaceCs[c];
				str2+=replaceC?replaceC:c;
			}
			return "'"+str2+"'";
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