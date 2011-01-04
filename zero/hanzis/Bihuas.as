/***
Bihuas 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年10月20日 09:10:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.hanzis{
	public class Bihuas{
		public static const bihuasObj:Object=getBihuasObj();
		private static function getBihuasObj():Object{
			var bihuasObj:Object=new Object();
			getBihuaObj(bihuasObj,"一","一asdfg16");
			getBihuaObj(bihuasObj,"丨","丨hjklm27");
			getBihuaObj(bihuasObj,"丿","丿qwert38");
			getBihuaObj(bihuasObj,"乀","乀yuiop49");
			getBihuaObj(bihuasObj,"乙","乙xcvbn50");
			return bihuasObj;
		}
		public static const bihuaNumsObj:Object={
			一:"1",
			丨:"2",
			丿:"3",
			乀:"4",
			乙:"5"
		}
		private static function getBihuaObj(bihuasObj:Object,bihua:String,values:String):void{
			var i:int=values.length;
			while(--i>=0){
				bihuasObj[values.charAt(i)]=bihua;
			}
		}
		public static function getBihua(value:*):String{
			return bihuasObj[value];
		}
		public static function getBihuas(values:String):String{
			var bihuas:String="";
			var L:int=values.length;
			for(var i:int=0;i<L;i++){
				var bihua:String=bihuasObj[values.charAt(i)];
				if(bihua){
					bihuas+=bihua;
				}
			}
			return bihuas;
		}
		public static function getBihuaNums(values:String):String{
			var bihuaNums:String="";
			var L:int=values.length;
			for(var i:int=0;i<L;i++){
				var bihuaNum:String=bihuaNumsObj[values.charAt(i)];
				if(bihuaNum){
					bihuaNums+=bihuaNum;
				}
			}
			return bihuaNums;
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