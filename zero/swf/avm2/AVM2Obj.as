/***
AVM2Obj 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月16日 21:07:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2{
	import flash.utils.getQualifiedClassName;
	import flash.utils.ByteArray;
	
	public class AVM2Obj{
		private static const ABCClassNameV:Vector.<String>=Vector.<String>([
			"ABCFileWithSimpleConstant_pool",
			"ABCFile",
			"ABCFileAdvance"
		]);
		
		public static var decodeLevel:int=ABCClassNameV.length-1;//0,1,2
		
		private static var abcClassV:Vector.<Class>=new Vector.<Class>(ABCClassNameV.length);
		public static function activateClass(ABCClass:Class):void{
			abcClassV[getClassIdByClassName(getQualifiedClassName(ABCClass))]=ABCClass;
		}
		private static function getClassIdByClassName(className:String):int{
			var classId:int=ABCClassNameV.indexOf(className.replace("zero.swf.avm2::",""));
			if(classId==-1){
				throw new Error("不支持的 ABCClass: "+className+", 请使用以下的 ABCClass: zero.swf.avm2::"+ABCClassNameV.join("zero.swf.avm2::"));
			}
			return classId;
		}
		
		public static function getClassByClassId(classId:int):Class{
			if(classId>=0&&classId<abcClassV.length){
				if(abcClassV[classId]){
					return abcClassV[classId];
				}
				throw new Error("请先调用 zero.swf.avm2.AVM2Obj.activateClass(zero.swf.avm2."+ABCClassNameV[classId]+")");
			}else{
				throw new Error("classId="+classId+", 超出范围: 0~"+(abcClassV.length-1));
			}
			return null;
		}
		public static function getClassByClassName(className:String):Class{
			return abcClassV[getClassIdByClassName(className)];
		}
		
		
		public function AVM2Obj(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			return -1;
		}
		public function toData():ByteArray{
			return null;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			return null;
		}
		public function initByXML(xml:XML):void{
		}
		}//end of CONFIG::toXMLAndInitByXML
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