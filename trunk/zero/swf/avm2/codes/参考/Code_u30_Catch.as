/***
Code_u30_Catch 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年7月13日 04:46:35
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2.Exception_info;
	import zero.swf.avm2._classObj.ClassObj_Exception_info;
	import zero.swf.avm2._classObj.IClassObj;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class Code_u30_Catch extends Code_u30 implements ICodeObj,IClassObj{
		public var catch_:ClassObj_Exception_info;
		//
		public function Code_u30_Catch(){
			
		}
		public function initByInfo(
			_id:int,
			exception_info:Exception_info,
			_from:ExceptionPosMark,
			_to:ExceptionPosMark,
			_target:ExceptionPosMark
		):void{
			catch_=new ClassObj_Exception_info(
				_id,
				exception_info,
				_from,
				_to,
				_target
			);
		}
		//
		public function toXML(xmlName:String):XML{
			var xml:XML=new XML("<"+Op.op_v[op]+"/>");
			xml.appendChild(catch_.toXML("catch_"));
			return xml;
		}
		override public function toString():String{
			return Op.op_v[op]+" exception_infoId("+catch_.id+") from("+catch_.from.toString()+") to("+catch_.to.toString()+") target("+catch_.target.toString()+")";
		}
		override public function getData(data:ByteArray):void{
			u30=catch_.id;
			super.getData(data);
		}
		public function putObjsInLists():void{}
		public function putMethodsInList():void{}
		public function putStrsInList():void{}
		public function doStrByType():void{}
		//
		override public function forEachRunFun(funName:String):void{
			super.forEachRunFun(funName);
			catch_.forEachRunFun(funName);
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