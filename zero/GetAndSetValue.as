/***
GetAndSetValue 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月29日 20:39:50
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	//部分实现了 as2 的 eval 功能
	public class GetAndSetValue{
		public static function getValue(objName:String,thisObj:*=null):*{
			//GetAndSetValue.getValue("XML")//获取类
			//GetAndSetValue.getValue("XML.prettyIndent")//获取静态属性
			//GetAndSetValue.getValue("loaderInfo.url",this)//获取属性
			
			var objNameArr:Array=objName.split(".");
			if(objNameArr.length){
				var obj:Object;
				if(thisObj){
					obj=thisObj[objNameArr.shift()];
				}else{
					obj=getDefinitionByName(objNameArr.shift());
				}
				while(objNameArr.length){
					obj=obj[objNameArr.shift()];
				}
				return obj;
			}
			return null;
		}
		public static function setValue(objName:String,value:*,thisObj:*=null):void{
			//GetAndSetValue.setValue("XML.prettyIndent",1)//设置静态属性
			//GetAndSetValue.setValue("x",0,this)//设置静态属性
			
			var objNameArr:Array=objName.split(".");
			if(objNameArr.length){
				var obj:Object;
				if(thisObj){
					obj=thisObj[objNameArr.shift()];
				}else{
					obj=getDefinitionByName(objNameArr.shift());
				}
				while(objNameArr.length>1){
					obj=obj[objNameArr.shift()];
				}
				if(objNameArr.length){
					obj[objNameArr.shift()]=value;
				}
			}
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