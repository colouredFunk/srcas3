/***
PHPXMLLoader 版本:v1.0
简要说明:加载 php 生成的 xml
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月1日 12:58:04
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class PHPXMLLoader extends DataLoader{
		
		public var xml:XML;
		public var onLoadFinished:Function;
		
		public function PHPXMLLoader(_onLoadProgress:Function,_onLoadFinished:Function){
			onLoadFinished=_onLoadFinished;
			super(_onLoadProgress,loadPHPXMLFinished);
		}
		override public function clear():void{super.clear();
			xml=null;
			onLoadFinished=null;
		}
		public function loadPHPXMLFinished(info:String):void{
			//trace("info="+info);
			//trace("this.data="+this.data);
			if(info==RequestLoader.SUCCESS){
				try{
					xml=new XML(this.data);
					//trace("PHPXMLLoader xml=\n"+xml.toXMLString());
				}catch(e:Error){
					trace("不是有效的 xml 数据");
					trace(this.data);
					onLoadFinished(RequestLoader.ERROR);
					return;
				}
				onLoadFinished(info);
				return;
			}
			onLoadFinished(info);
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