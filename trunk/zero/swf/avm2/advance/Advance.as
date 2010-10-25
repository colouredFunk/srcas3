/***
Advance 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月23日 19:10:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advance{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.avm2.ABCFile;
	import zero.swf.avm2.AVM2Obj;
	
	public class Advance{
		public static var abcFile:ABCFile;
		public static var currAdvanceABCFile:AdvanceABCFile;
		public static var stringMark:Object;
		/*
		public static function getInfo(id:int,name:String,startId:int=0):*{
			if(v<startId){
				return null;
			}
			var v:*=abcFile[name+"V"];
			if(id<v.length){
				return v[id];
			}
			throw new Error("id="+id+" 超出范围, abcFile."+name+"V.length="+v.length);
			return null;
		}
		
		public function Advance(){
		}
		
		public function getString(parentInfo:AVM2Obj,name:String):void{
			this[name]=getInfo(parentInfo[name],"string",1);
		}
		public function getAdvance(parentInfo:AVM2Obj,name:String,advanceClass:*):void{
			this[name]=advanceClass.getAdvanceById(parentInfo[name]);
		}
		public function getAdvancesByIds(parentInfo:AVM2Obj,name:String,advanceClass:*,advanceVClass:*):void{
			var v:Vector.<int>=parentInfo[name+"V"];
			if(v&&v.length){
				var advanceV:*=this[name+"V"]=new advanceVClass();
				var i:int=-1;
				for each(var id:int in v){
					i++;
					advanceV[i]=advanceClass.getAdvanceById(id);
				}
			}
		}
		public function getAdvancesByInfos(parentInfo:AVM2Obj,name:String,advanceClass:*,advanceVClass:*):void{
			var v:*=parentInfo[name+"V"];
			if(v&&v.length){
				var advanceV:*=this[name+"V"]=new advanceVClass();
				var i:int=-1;
				for each(var info:AVM2Obj in v){
					i++;
					advanceV[i]=advanceClass.getAdvanceByInfo(info);
				}
			}
		}
		*/
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