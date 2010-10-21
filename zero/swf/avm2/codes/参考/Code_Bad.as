/***
Code_Bad 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月13日 20:29:32
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2._classObj.IClassObj;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Code_Bad extends Code_u30 implements ICodeObj,IClassObj{
		public var info:String;
		public function Code_Bad(){
		}
		//
		public function toXML(xmlName:String):XML{
			return <bad info={info}/>;
		}
		override public function toString():String{
			return "//bad \""+toXML(null).@info.toXMLString()+"\"";
		}
		
		public function initAsBadOp(op:int):void{
			var opStr:String=op.toString(16);
			if(opStr.length<2){
				opStr="0"+opStr;
			}
			info="不合法的 op: 0x"+opStr;
		}
		public function initAsBad_u30_index(index:int,restInfo:String):void{
			info="不合法的 index: "+index+" "+restInfo;
		}
		public function initAsBad_u30_u30_index_args(index:int,args:int,restInfo:String):void{
			info="不合法的 index_args: "+index+","+args+" "+restInfo;
		}
		override public function getData(data:ByteArray):void{}
		public function putObjsInLists():void{}
		public function putMethodsInList():void{}
		public function putStrsInList():void{}
		public function doStrByType():void{}
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