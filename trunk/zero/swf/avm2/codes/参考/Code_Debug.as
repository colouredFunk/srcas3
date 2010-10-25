/***
Code_Debug 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年7月11日 22:53:04
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2._classObj.IClassObj;
	import zero.swf.avm2._classObj.StrType;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.gettersetter.UGetterAndSetter;
	public class Code_Debug extends CodeObj implements ICodeObj,IClassObj{
		public var debug_type:int;
		public var string:String;
		public var reg:int;
		public var extra:int;
		//
		public function Code_Debug(){
			
		}
		public function initByInfo(_debug_type:int,stringId:int,_reg:int,_extra:int):void{
			debug_type=_debug_type;
			string=abcFile.constant_pool.string_v[stringId];
			reg=_reg;
			extra=_extra;
		}
		//
		public function toXML(xmlName:String):XML{
			var xml:XML=new XML("<"+Op.op_v[op]+"/>");
			xml.@debug_type=debug_type;
			if(string is String){
				xml.@string=string;
			}
			xml.@reg=reg;
			xml.@extra=extra;
			return xml;
		}
		override public function toString():String{
			return Op.op_v[op]+" "+debug_type+" \""+toXML("string").@string.toXMLString()+"\" "+reg+" "+extra;
		}
		public function getData(data:ByteArray):void{
			data[data.length]=op;
			data[data.length]=debug_type;
			if(string is String){
				UGetterAndSetter.setU(getStrId(string),data,data.length);
			}else{
				UGetterAndSetter.setU(0,data,data.length);
			}
			data[data.length]=reg;
			UGetterAndSetter.setU(extra,data,data.length);
		}
		public function putObjsInLists():void{}
		public function putMethodsInList():void{}
		public function putStrsInList():void{
			if(string is String){
				strVMark["~"+string]=string;//test_checkStr(string);
			}
		}
		public function doStrByType():void{
			doStrByTypeFun(this,"string",StrType.VALUE,string);
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